Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92D3C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 852342082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 852342082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbeJ2RSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 13:18:13 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34460 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbeJ2RSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 13:18:13 -0400
Received: by mail-lj1-f194.google.com with SMTP id g8-v6so4001625ljk.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 01:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Vv6ytH6ycJEU89LDmU3nW1CmSFUJAaunoB7ZV3maOGM=;
        b=grKJPotvGrhy5FpM2lr/5nef4sLgxwblDOzSUfSzO8iMXl9kYqXOPTgChEK6Wv1vES
         8M3ZqytEuQQKEtygh8uvCMUoq9hd4nWCsQc0eA3FffqQ2X/ibk3g4cDGLzMZzT1HO8q/
         85VDqQwaJzMb7sqnS+lgVcXwZJ/nixQ5cNLo12LaUT6Y3XxcALnK5xMqYI4Ik+klcaqp
         tJBmr1qtdRn+CZHt3BwqqzrEMQQv/8yrwoc9lTO4wVV48VNjAytgOfEDuq3ooznJrW+i
         MHPSrAfIx/B9sBDcUHTVZwbSQu+Og+m93nPYS47BGNG5Ila54RVrDRYObmPLuDWWJ7Jj
         bBBA==
X-Gm-Message-State: AGRZ1gIDL5dryVHZ9YFgrYHWh0Q4mhYbh8GzxXENoU3vdgh9S7JwkWTF
        V+3Yz9FmaKd3Upw4btrTU1c=
X-Google-Smtp-Source: AJdET5dDthD3NQv/vLyXU2sSoe/kXvBS6WMNSZF7PJMN3p2TjplciqVBB2vO9UrsTroZBR8okTTk3Q==
X-Received: by 2002:a2e:215a:: with SMTP id h87-v6mr9469150ljh.102.1540801834573;
        Mon, 29 Oct 2018 01:30:34 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id g92-v6sm2978518lji.24.2018.10.29.01.30.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 01:30:33 -0700 (PDT)
Date:   Mon, 29 Oct 2018 10:30:25 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: bd718x7: Remove double indirection for
 bd718xx_pmic_inits.rdatas
Message-ID: <20181029083025.GA20774@localhost.localdomain>
References: <20181028160922.24618-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181028160922.24618-1-geert@linux-m68k.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, Oct 28, 2018 at 05:09:22PM +0100, Geert Uytterhoeven wrote:
> With gcc 4.1:
> 
>     drivers/regulator/bd718x7-regulator.c: In function ‘bd718xx_probe’:
>     drivers/regulator/bd718x7-regulator.c:1020: warning: initialization from incompatible pointer type
>     drivers/regulator/bd718x7-regulator.c:1024: warning: initialization from incompatible pointer type
> 
> Apparently this old compiler can't handle the obscure double
> indirection.

That was surprizing for me. Besides I don't see why this is obscure ;)

> However, there is no need for a double indirection.  Just store a
> pointer to the array instead, like other drivers tend to do.

But that's _exactly_ what we have here. A pointer to an array of
structs, not pointer to a struct - or pointer to the first member of an
array =)

But this is one of the cases where practicality should be preferred. And
you are correct. It is easier to understand when we have simple pointer
to a struct - and moreover it should work on all compilers, right?
So this looks good to me.

> Fixes: 494edd266b945f36 ("regulator/mfd: Support ROHM BD71847 power management IC")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Compile-tested only.
> ---
>  drivers/regulator/bd718x7-regulator.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
> index 3a47e0372e77c812..fff5bc4faa2c99aa 100644
> --- a/drivers/regulator/bd718x7-regulator.c
> +++ b/drivers/regulator/bd718x7-regulator.c
> @@ -1007,7 +1007,7 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
>  };
>  
>  struct bd718xx_pmic_inits {
> -	const struct bd718xx_regulator_data (*r_datas)[];
> +	const struct bd718xx_regulator_data *r_datas;
>  	unsigned int r_amount;
>  };
>  
> @@ -1017,11 +1017,11 @@ static int bd718xx_probe(struct platform_device *pdev)
>  	struct regulator_config config = { 0 };
>  	struct bd718xx_pmic_inits pmic_regulators[] = {
>  		[BD718XX_TYPE_BD71837] = {
> -			.r_datas = &bd71837_regulators,
> +			.r_datas = bd71837_regulators,
>  			.r_amount = ARRAY_SIZE(bd71837_regulators),
>  		},
>  		[BD718XX_TYPE_BD71847] = {
> -			.r_datas = &bd71847_regulators,
> +			.r_datas = bd71847_regulators,
>  			.r_amount = ARRAY_SIZE(bd71847_regulators),
>  		},
>  	};
> @@ -1059,7 +1059,7 @@ static int bd718xx_probe(struct platform_device *pdev)
>  		struct regulator_dev *rdev;
>  		const struct bd718xx_regulator_data *r;
>  
> -		r = &(*pmic_regulators[mfd->chip_type].r_datas)[i];
> +		r = &pmic_regulators[mfd->chip_type].r_datas[i];
>  		desc = &r->desc;
>  
>  		config.dev = pdev->dev.parent;
> -- 
> 2.17.1
> 

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
