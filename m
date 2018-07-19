Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC64DECDFB4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 03:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69BA720673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 03:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jea1lfUP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69BA720673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbeGSEYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 00:24:23 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:44066 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725739AbeGSEYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 00:24:23 -0400
Received: by mail-io0-f193.google.com with SMTP id q19-v6so5924215ioh.11;
        Wed, 18 Jul 2018 20:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qb8jQk27eVIMBU+02Ne81Yi5oNEbhn6KeTw/YxDIdLk=;
        b=Jea1lfUPcILKdGP/wDp2Tg6ucy6CXuOcLYJN4YoDOE2J4zn4h+TTB6ZaYkf11k2jAH
         A8mSNDrIOwiacfbbnATPLho79sixmXi5ENoYAaWsQm1jJQniO5SCZ9ssUe9yyCBEOsrU
         /CMEeb05iAEWuaxNxPtWK/DQZBLw2fKAb9JWV1amCVdEgkq3YIpcsQ/9AOXc7fjE6uCh
         O2I3luo1XsODCjjeCdrOlIuS7VamFFlIo27C9tHKsCGXjntAvU6rK346AN+yaL+esfmz
         NkiDfIorAFDmpqHFiOLY6A+JRCqlt9/u2Id3RonXw/uLKwbuhn4b2cwaEUZwDRm5LEEP
         LnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qb8jQk27eVIMBU+02Ne81Yi5oNEbhn6KeTw/YxDIdLk=;
        b=oKJxRJMS34ZCgn22DA4OHXklieFXPc1LsROG2XgdeO2HQUV5JASQnjQ+wduyiVVD48
         4qbWRLpGWhAtpkoCkgmcDp1CFGW1O+/Cw98Pz3k7AICC4KLgRrqx6MQmteVOLZtK86F3
         fR4SAnJinrvaG7FT/Hpwnw2LB06TyT/8ETH5VoiBV3j4RvZxhEvFGlTn968zeFFtgNvE
         ts06ZpZw+pk9WDmqhbgazL1bdG0A1CJiN44oBhf9EA6epXfITbf1Af5dw90OZp8Iii45
         u6g/ZnuNg58P72wR8HpwaidNxG78yiywZnovUJZY7c91QliC5+6+8u2osMD9ny9dRKLz
         6bcg==
X-Gm-Message-State: AOUpUlFk64qcyZ/3sEol0BbZ/gPot3QNGCw48G5YmoYUvZIu+12G4+ju
        pWxn1irG5VsgExR7ZzhQF43JGHcnW57mhbaQDCo=
X-Google-Smtp-Source: AAOMgpeAeEZtyrf8YPfRPDCAErH5Q3iCOI2VrSUATbNd3qw0axmrV2nN9lFQZ5wjEexqBhBC74Sa/+EUNPNENm8AbBo=
X-Received: by 2002:a6b:bc41:: with SMTP id m62-v6mr7588737iof.64.1531971803619;
 Wed, 18 Jul 2018 20:43:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:d00d:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 20:43:23
 -0700 (PDT)
In-Reply-To: <20180719005941.10458-1-andrew.smirnov@gmail.com>
References: <20180719005941.10458-1-andrew.smirnov@gmail.com>
From:   Chris Healy <cphealy@gmail.com>
Date:   Wed, 18 Jul 2018 20:43:23 -0700
Message-ID: <CAFXsbZrb6_EmkMEhCT064LgjdWPq4t7hBYGg_UM9WLXW2WbZaA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: vf610: Add ZII CFU1 board
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Add support for the Zodiac Inflight Innovations CFU1
> board (VF610-based).
>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: cphealy@gmail.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>
> Shawn:
>
> Currently this patch is rebase on top of [spu3], if that is
> problematic, let me know and I'll update it accordingly
>
> Thanks,
> Andrey Smirnov
>
> [spu3] lkml.kernel.org/r/20180717040651.641-1-andrew.smirnov@gmail.com
>
>  arch/arm/boot/dts/Makefile           |   1 +
>  arch/arm/boot/dts/vf610-zii-cfu1.dts | 307 +++++++++++++++++++++++++++
>  2 files changed, 308 insertions(+)
>  create mode 100644 arch/arm/boot/dts/vf610-zii-cfu1.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index e331b2c16539..85797819fdd9 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -569,6 +569,7 @@ dtb-$(CONFIG_SOC_VF610) += \
>         vf610-cosmic.dtb \
>         vf610m4-cosmic.dtb \
>         vf610-twr.dtb \
> +       vf610-zii-cfu1.dtb \
>         vf610-zii-dev-rev-b.dtb \


Tested-by: Chris Healy <cphealy@gmail.com>
