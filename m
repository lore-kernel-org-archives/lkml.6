Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04298C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E4426D4D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gx7zZQcY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E4426D4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752458AbeFZPqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:46:25 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37233 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752433AbeFZPqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:46:23 -0400
Received: by mail-oi0-f66.google.com with SMTP id k81-v6so2399142oib.4;
        Tue, 26 Jun 2018 08:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GrI5Z9bFre9jbA8INCWljOlGuTwBGKontONDlJAoMCo=;
        b=Gx7zZQcYlzawmUJfeGXdEcBK/+V02DWNm5cSKslE8Yrn13LyxD6qegZvLaQb5lczsH
         M+uLwrWsyxiBSJLzV/D0hF3nqNcf8vxj5U2J1yW3f6hhOQyJGPzHZy2wpT0yQZpNWRhF
         TSDAOqo3pOqLSVZMLUPc7zcgbu/phtiZbewTjq8e/B8KDBtW97HnT1HaQ0XV2Sjr0h1n
         SvYHgdPSWlqMvvTLIHCldFh/y/KdiYki6mOQdDMHBPIRpTqMUnJfILMSAw2epQmC88Cf
         4wgFUzspn3gzj2l/bLCkO/po8oJl4SFZv7+zYArYOq2o8u5TclDS7Jv0Zo/+CDigEg8A
         HLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GrI5Z9bFre9jbA8INCWljOlGuTwBGKontONDlJAoMCo=;
        b=lU0o/uC/KevrOB9RDl7CiprYw5EFT32N1pytWefL3D6eg2+P3j7UZr/xkt+/7WXxRr
         akZl1djS0DNVvzgzRD1KDtMjuW8OL/2McAnwv4vPNcbsPeQpcmfJ78EG13VzUWvp0Ibv
         3MMH/Xw8UrcNihO1mABroj9HgfX4Dd21Zh/uXwf4nkHe6tn5OaAj6cohEf5wdYbvkfHG
         ofpm2HgUmVpNzxksG2vZelyTy1Ekh7vO2plurTkYQ+fxbqv+nAH4KBf9ch0mWNyMO/IZ
         gvHv58jN0xHbjJfKkNGWJClFpBDPgzQn/O9cLTpD5gYs4HkEKCFyj1wGxMXhgUlddNtN
         3/pg==
X-Gm-Message-State: APt69E1OVeq8slLO++oBVny6XeexA14ftsr1qLboa/lb02RQID7qnZ85
        BiBXo4qj9DDs1hxy0Q0dZlrxUEvG2RxMCacaKvk=
X-Google-Smtp-Source: AAOMgpdOS4l4aXoQoEr5ZxT5yWhMJ7htAMNkwoDrUO55n+leJnAfYnCDrA3hCw214TXbJ1cVnwbfBvSaWB+m4AUmlIM=
X-Received: by 2002:aca:400b:: with SMTP id n11-v6mr1236000oia.44.1530027982533;
 Tue, 26 Jun 2018 08:46:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 08:46:22
 -0700 (PDT)
In-Reply-To: <1529603100-31958-4-git-send-email-andrey.gusakov@cogentembedded.com>
References: <1529603100-31958-1-git-send-email-andrey.gusakov@cogentembedded.com>
 <1529603100-31958-4-git-send-email-andrey.gusakov@cogentembedded.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 26 Jun 2018 12:46:22 -0300
Message-ID: <CAOMZO5DeJ8oCShX_FH+xqTF9fEaiYMO8pOqgLngqoXWDa5UPYQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: imx: add ZII SCU2 Mezz board
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

On Thu, Jun 21, 2018 at 2:45 PM, Andrey Gusakov
<andrey.gusakov@cogentembedded.com> wrote:
> This adds support for the Zodiac Inflight Innovations SCU2 Mezz
> board, which is based on the i.MX51.
>
> Signed-off-by: Andrey Gusakov <andrey.gusakov@cogentembedded.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
