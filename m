Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D61C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F11AA208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+L/Kbbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F11AA208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeHPCSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 22:18:21 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:40404 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbeHPCSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 22:18:21 -0400
Received: by mail-qt0-f195.google.com with SMTP id h4-v6so3218271qtj.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 16:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fC4HEfFbrMnrfHtbmOLlTjLWpA3cjQqQZxsYQYckMFg=;
        b=O+L/KbblnFkHLsBBgJj/ex+sPc6c3r7OYYjxu/SDUXHMiL4Dub19/qkjH7ZHEXxHfB
         NtMlHE+n6EHn4s80XlsIbJNGlHvum8qNCkgIGxw4Ki01CCaRBSvfc3Q/JEEd3R2j2IdZ
         Bd34NOqcMsOL6Rsz3kqyGIVSDhbbXX3DSL6fLjdezdJWMy1tNjQWcC6Y8s8m57ewMD0P
         J3CMcc4kxHJCFGnnP5fJjhlqKiS6ma3+zQ9iGd844P20INYEY1jvyGeRLx+JuPpEiMh/
         6kLvJZtDQIrnGBHn9gA4qHIk++qrD5rn42sHggzH2NkDvm4pvU4XLEPTBNz0PC76Nv2r
         N6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fC4HEfFbrMnrfHtbmOLlTjLWpA3cjQqQZxsYQYckMFg=;
        b=pp0JvuEYEm2QR90ntvB9dYrJP84RMrkAsxyi0eckXi5Qkv8FcbFNgsA2Ky3838XtvI
         K8B+TiiEbRih+jfKTimYQRLP5LeMpND8/iF10iXs4yYOVK6cOoKJswLNdgLiLevG/glx
         cuUO44IWwY+ElT4enoIDheoEb3TiMfIWcIzSOHICwR4qUrWRv/zwmIiPfNxqsC+VovpM
         lzyhm5mzuP18BOASYsVgslWnuUG8vXsLqKagk9Go6qM1H3bIbk/xLJ3L2v6TwIhRdGTL
         ebgyN3qAwST6UKpG8lnZ/iSbw+6i5SGlZFZptAyu9+LGurGPqqpLQS3Ueag5G9RZr9Xy
         o20Q==
X-Gm-Message-State: AOUpUlET96FT00GNwxGpmaNj4y1uNA7XdcCWfEXkLEEwfFYD6Pky+G6s
        C71T5miQ+96rX+/BUywLe9+vQoi1
X-Google-Smtp-Source: AA+uWPw17JHJQ3pqUsAHGzfpOYo6ZhYcW1cx5/IxKgUubTgcAxlNGRuIAmlKF7XVbmAx1qnJ3BmCLw==
X-Received: by 2002:ac8:6c8:: with SMTP id j8-v6mr26484763qth.314.1534375438959;
        Wed, 15 Aug 2018 16:23:58 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id 187-v6sm70483qki.19.2018.08.15.16.23.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 16:23:57 -0700 (PDT)
Subject: Re: [PATCH 1/2] phy:phy-brcm-us: Use PTR_ERR_OR_ZERO to replace the
 open code
To:     zhong jiang <zhongjiang@huawei.com>, alcooperx@gmail.com,
        kishon@ti.com, robh@kernel.org, hauke@hauke-m.de,
        ralf@linux-mips.org
Cc:     linux-kernel@vger.kernel.org
References: <1534159486-25008-1-git-send-email-zhongjiang@huawei.com>
 <1534159486-25008-2-git-send-email-zhongjiang@huawei.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <7ba3b0be-4538-87a1-15f4-f2cbc6e12e66@gmail.com>
Date:   Wed, 15 Aug 2018 16:23:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1534159486-25008-2-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/13/2018 04:24 AM, zhong jiang wrote:
> PTR_ERR_OR_ZERO has implemented the if(IS_ERR(...)) + PTR_ERR, So
> just replace them rather than duplicating its implement.

Subject should be:

phy: phy-brcm-usb: Use PTR_ERR_OR_ZERO to replace open coded version

Thank you

> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/phy/broadcom/phy-brcm-usb.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/phy-brcm-usb.c
> index d1dab36..f59b1dc 100644
> --- a/drivers/phy/broadcom/phy-brcm-usb.c
> +++ b/drivers/phy/broadcom/phy-brcm-usb.c
> @@ -372,10 +372,8 @@ static int brcm_usb_phy_probe(struct platform_device *pdev)
>  	clk_disable(priv->usb_30_clk);
>  
>  	phy_provider = devm_of_phy_provider_register(dev, brcm_usb_phy_xlate);
> -	if (IS_ERR(phy_provider))
> -		return PTR_ERR(phy_provider);
>  
> -	return 0;
> +	return PTR_ERR_OR_ZERO(phy_provider);
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> 


-- 
Florian
