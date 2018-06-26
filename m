Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F6EC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D43326C51
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4NOpsNJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D43326C51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752337AbeFZPpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:45:55 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39514 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751576AbeFZPpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:45:54 -0400
Received: by mail-oi0-f66.google.com with SMTP id 18-v6so6944960oiq.6;
        Tue, 26 Jun 2018 08:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oGmUuxdq+2wGziMG4Cz3y/A2Y98rbJF8Sf4UYLKJ7Mk=;
        b=B4NOpsNJnfYub22jnq6mAIcyXPIuDQJOy4COLQjXU6bBkAe4aM4XKl7DLL0nYd9yjs
         TD6BTgLH8EiAuvWvk0//bvNHWx0NKlmDRghBlhcsRICzXsUC0FSUs256N1GcNLuKLU7f
         +R8IF2JBzOTapcmMsOAqPWSn3gNIw7Atga5i9+PuAeFX8gLMp3LQbmWHyHjj7VVS2nuI
         d4QSFrfy5e/H6uJmLJfSqvYx+RahVjZStM+GncX7VEf3Vxxb5ECShNtze85A033wcjut
         UQ54rDSS3fHyD/9f+RBH6XAssYYLxtdKb0x8AGWXeFdbHe4ZNG002S/zod11K7YCDJjt
         YH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oGmUuxdq+2wGziMG4Cz3y/A2Y98rbJF8Sf4UYLKJ7Mk=;
        b=gwTDR0Odo5QpAJ5r7J3BguQQE+bIs+pqTuEnXHv3ncyDHfX4xqt4VgaBWFPec2iI0j
         hGnJ3GJaQDPFmeSL33NFlwrMuv/QfeNhiHLbTCx+x3X7fXrrC6dSqdOwGHpkKlp+3TVh
         VgcmhVeiKl2LV3PwH+8MeLxRIz/NaeWpfb2/Ea7sJMr491SxLYfBhNI/fnImk3ZYx/ul
         meRFRGhShdj8NGlrY7RQKVC15wraNOpRIRwsAA1gmTWzukGh38KPL+PYuFsXnKJyWX2V
         nChN8YACcK1yAMetHszZbsJgEoOOq8lv73AqAY9vf2x/VKcfbkTEvgmP1obThwrWLKW0
         hbNg==
X-Gm-Message-State: APt69E2JtJskUNhYcN37zSB6Wx9fG64rFs62arzHHHgr56uD61E62CEl
        Qg9KOF+R5U9VC9nLCjTbeEWpDN0q3n4wGN8zvmWaQA==
X-Google-Smtp-Source: AAOMgpdqLxu7osCya/4yAq0K3PQ0xaWGxemvv+cYdUQTIqon81U5z8jwEHhLlQl0XizGlt6RRjfRSkMgwqXH465YjUs=
X-Received: by 2002:aca:b3c5:: with SMTP id c188-v6mr1217307oif.9.1530027953350;
 Tue, 26 Jun 2018 08:45:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 08:45:52
 -0700 (PDT)
In-Reply-To: <1529603100-31958-3-git-send-email-andrey.gusakov@cogentembedded.com>
References: <1529603100-31958-1-git-send-email-andrey.gusakov@cogentembedded.com>
 <1529603100-31958-3-git-send-email-andrey.gusakov@cogentembedded.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 26 Jun 2018 12:45:52 -0300
Message-ID: <CAOMZO5C7mnYYCO1KWkUuqM+c3JOReO=pACRAZ6+LG84AxK0nmQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: dts: imx: add ZII SCU2 ESB board
To:     Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chris Healy <cphealy@gmail.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 2:44 PM, Andrey Gusakov
<andrey.gusakov@cogentembedded.com> wrote:
> This adds support for the Zodiac Inflight Innovations SCU2 Ethernet
> Switch Board, which is based on the i.MX51.
>
> Signed-off-by: Andrey Gusakov <andrey.gusakov@cogentembedded.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
