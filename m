Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F102C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5350620861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="NqHGPz13"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5350620861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbeIGNsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 09:48:31 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33481 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbeIGNsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 09:48:31 -0400
Received: by mail-lj1-f194.google.com with SMTP id s12-v6so11712819ljj.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 02:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S6ksY+JgxvRu27FYNP4ougPia55cCaLuq3qHA7AI/Mw=;
        b=NqHGPz13d/ZyQfcXYnWJ/ad1YmCuiY0E43LfbKAzjImAMoL9uldBmxGC/tt6iUMKfn
         DFIy1Ll8uHFSo2sQSFA90hjtP/YA7p8zLmqRx+XZgdbPjh7UYihfNKJJKyOKVIzqyfaL
         oB3GduJATEeY7krTRBSK5W9J0Vsf+n6hZfS4yOmVHoifbpDS5qjlVhUFUiR7bzEFJD0U
         4HmmSU4PTdzuZCoSHNCOVwH3zAg91peUqMauhGdiUnb+Zqpulz6Tzc6b9wAhh26qoby/
         2VCSjIwI4zw+hRp0wkDjTrXhsCX9PJgTdwUwBJWqp6HziJUj1p9qDYGaGXeUF5boE4ai
         4e0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S6ksY+JgxvRu27FYNP4ougPia55cCaLuq3qHA7AI/Mw=;
        b=XBcD6S4+QD5ZXMQC0OQWLu9HPGyZwsTFIpkpF4qGW/OZWncJHv5KRvAF+jrZGa/EIW
         zNuBx3Jj2Pr+DxIF8Lzz4Ujw/FX9CiQiDynvxSHBkHAoIcdn0vmJnq8t0wbI0uROkd3e
         85Vw+qM064O4qB2uGk9whEk2sza7GCO06TlNJviJRyKMTX//JGXw6d7s3TaOL/8yh1+x
         mwvDYDiUQO3KJ9qhut6yV0F6GWM8nr5msoyzabDtyLWfKrHHydAZ5uN+V3KPj+2PSJl8
         oj0VI10BkqIuKHKMESbinTPs7ZO2SoUlJTLrFScQ2SAwh6l4EMx09PGwG8j0eJE3BDHS
         uQew==
X-Gm-Message-State: APzg51BzwtN/aDcefGqrAlSb8YRBRvntQ+RuCPmIsuJlBKYUIR1iTbIs
        AZJQtxXdNF0oQAkK3sfB9BYQiQ==
X-Google-Smtp-Source: ANB0VdZ/NBicuQoL/7npiEBLyA5Quv5ObHheQSvLNWStgesQCAC1aYTvOIrrRzLdXO1iOHDG8TlzIg==
X-Received: by 2002:a2e:750d:: with SMTP id q13-v6mr4121068ljc.148.1536311309917;
        Fri, 07 Sep 2018 02:08:29 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.85.38])
        by smtp.gmail.com with ESMTPSA id p74-v6sm1207104lfg.88.2018.09.07.02.08.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 02:08:28 -0700 (PDT)
Subject: Re: [PATCH] phy: renesas: convert to SPDX identifiers
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Simon Horman <horms+renesas@verge.net.au>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <87zhwuoykl.wl-kuninori.morimoto.gx@renesas.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <b35ae4e1-2905-3587-6ffe-0f8886ba0968@cogentembedded.com>
Date:   Fri, 7 Sep 2018 12:08:28 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87zhwuoykl.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/2018 5:08 AM, Kuninori Morimoto wrote:

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch updates license to use SPDX-License-Identifier
> instead of verbose license text.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   drivers/phy/renesas/Kconfig              | 1 +
>   drivers/phy/renesas/Makefile             | 1 +
>   drivers/phy/renesas/phy-rcar-gen2.c      | 5 +----
>   drivers/phy/renesas/phy-rcar-gen3-usb2.c | 5 +----
>   drivers/phy/renesas/phy-rcar-gen3-usb3.c | 5 +----
>   5 files changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/phy/renesas/Kconfig b/drivers/phy/renesas/Kconfig
> index 4bd390c..e340a92 100644
> --- a/drivers/phy/renesas/Kconfig
> +++ b/drivers/phy/renesas/Kconfig
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   #
>   # Phy drivers for Renesas platforms
>   #

    Again, there was no license on that file...

> diff --git a/drivers/phy/renesas/Makefile b/drivers/phy/renesas/Makefile
> index 4b76fc4..b599ff8 100644
> --- a/drivers/phy/renesas/Makefile
> +++ b/drivers/phy/renesas/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_PHY_RCAR_GEN2)		+= phy-rcar-gen2.o
>   obj-$(CONFIG_PHY_RCAR_GEN3_PCIE)	+= phy-rcar-gen3-pcie.o
>   obj-$(CONFIG_PHY_RCAR_GEN3_USB2)	+= phy-rcar-gen3-usb2.o

    ... on this file as well.

     Otherwise looked valid.

MBR, Sergei
