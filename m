Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806D6C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 481EB2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTSjJ0jw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 481EB2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeJZAae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:30:34 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39704 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbeJZAae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:30:34 -0400
Received: by mail-oi1-f194.google.com with SMTP id e3-v6so1096911oiy.6;
        Thu, 25 Oct 2018 08:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RfTA4iwdDROAstXdFyRIF8Pn13Ug9CTlTUDGatoMSu8=;
        b=NTSjJ0jwUpm0rjupT2qP17IzWmGWQsc20fgpelmMf0XpLSU0lLKVNEuyyHR5Mhftp9
         xwlClS89UzQCfkmXWcrP5qAyKbDCOOpCHI83QzpgjmCy/2Dc29f/0QjiHpxtZzk5kzK2
         5Vr/VxpU3XeqL231qR3wQmE1ejeOpfaRmgXJfDzS2RynFtoogxKjzpWB811j6bZalICa
         BLc5KezuMxxQQMseatZTHijJnMkqJgEuORR1dLpgay6bh4nq5PvvPbRZH1XTagX6x56G
         cxFNARNBH3KHJRQtCS47OP3YdqMuA1xHZ8KHnoD5yk/HqfEDHhoTe7AXnHiomLMFCYag
         /2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RfTA4iwdDROAstXdFyRIF8Pn13Ug9CTlTUDGatoMSu8=;
        b=FhDyARQIHJfGUffXa+4XatvtNYfSdRqJurNSP6m0vgipSKoj4domBg8/2u7rYMilV0
         pUe3BUZnIVNWxpzDTxHcGcW3D5pzkt1I7seaMb3ib9LC0fAVmiRZmUhDlS5LbK1r9MPi
         oan+O3ql7dbT/+GdCPely9PlP1rpdnJS9MLinwyWZP2Li/cAhrjuiHpgHfm8Xu9e4hNj
         witB37HzgSHgmjPZXR7+nc6efKMmGWYywZlCuCqCObcAOU3Y1uelSwGeNZ1VyalmONUz
         IiGF4ElO5FC82WsWDTyvP337YkFzh0M5rOYUkSlQm/ShUknkAM4TlXiTFXf92+unPIz6
         4t1g==
X-Gm-Message-State: AGRZ1gKpaOrqbZpWlklCQ5nb7/UfRgBw8DTRLvQfpTX3MqSkzV9pdIK2
        oajdIvEfJAjSedfkJ1m0d0OYtqMlMP15LjQjlw4=
X-Google-Smtp-Source: AJdET5dU09kQfPTp7FOpOfpjWkPUBCEhpxffbkGrGBcVn9csPqUKa41xJgSaF3w/gbtKAhwoBcaSAqTQK2KzRGoNOiQ=
X-Received: by 2002:aca:b357:: with SMTP id c84-v6mr863535oif.266.1540483030995;
 Thu, 25 Oct 2018 08:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <1540480173-12009-1-git-send-email-alex.gonzalez@digi.com> <1540480173-12009-4-git-send-email-alex.gonzalez@digi.com>
In-Reply-To: <1540480173-12009-4-git-send-email-alex.gonzalez@digi.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 25 Oct 2018 12:57:11 -0300
Message-ID: <CAOMZO5C_4_LEv_jEyhF6EMnob_+qR0Qa9BMc5s+S0Xd8-tUbpw@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] ARM: imx_v6_v7_defconfig: Select TOUCHSCREEN_GOODIX
To:     "Gonzalez, Alex" <alex.gonzalez@digi.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 12:11 PM Alex Gonzalez <alex.gonzalez@digi.com> wrote:
>
> Select CONFIG_TOUCHSCREEN_GOODIX so that we can have functional touch
> screen by default on Digi International's AUO/Goodix LCD accessory kit used
> with the ConnectCore 6UL SBC Pro (ccimx6ulsbcpro) board.
>
> Signed-off-by: Alex Gonzalez <alex.gonzalez@digi.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
