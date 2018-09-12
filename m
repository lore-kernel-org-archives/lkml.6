Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36AAC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431CE20833
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:39:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431CE20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbeIMQsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 12:48:06 -0400
Received: from smtprelay0065.hostedemail.com ([216.40.44.65]:36490 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726879AbeIMQsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 12:48:06 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave05.hostedemail.com (Postfix) with ESMTP id 3F96F18016BDA;
        Thu, 13 Sep 2018 11:18:33 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 2B99D83FF;
        Thu, 13 Sep 2018 11:11:38 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: crowd41_be574425f55b
X-Filterd-Recvd-Size: 2202
Received: from XPS-9350 (mec5036d0.tmodns.net [208.54.80.236])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Thu, 13 Sep 2018 11:11:20 +0000 (UTC)
Message-ID: <b97d7ccc921572ca5d783584eea1de04341ab02f.camel@perches.com>
Subject: Re: [PATCH v3 1/2] ARM: s3c24xx: formatting cleanup in
 mach-mini2440.c
From:   Joe Perches <joe@perches.com>
To:     Cedric Roux <sed@free.fr>, kgene@kernel.org, krzk@kernel.org,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20180907215446.15160-1-sed@free.fr>
References: <20180907215446.15160-1-sed@free.fr>
Content-Type: text/plain; charset="ISO-8859-1"
Date:   Wed, 12 Sep 2018 12:21:37 -0700
Mime-Version: 1.0
X-Mailer: Evolution 3.28.1-2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-09-07 at 23:54 +0200, Cedric Roux wrote:
> Running:
>     scripts/checkpatch.pl -f arch/arm/mach-s3c24xx/mach-mini2440.c
> revealed several errors and warnings.
> 
> They were all removed, except one which is an #if 0 around the declaration
> of a gpio pin. This needs some more investigation and I prefer to let it
> here. This is not some dead code.
[]
> diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c b/arch/arm/mach-s3c24xx/mach-mini2440.c
[]
> @@ -674,17 +680,17 @@ static void __init mini2440_init(void)
>  		mini2440_fb_info.displays =
>  			&mini2440_lcd_cfg[features.lcd_index];
>  
> -		printk(KERN_INFO "MINI2440: LCD");
> +		pr_info("MINI2440: LCD");

OK

>  		for (li = 0; li < ARRAY_SIZE(mini2440_lcd_cfg); li++)
>  			if (li == features.lcd_index)
> -				printk(" [%d:%dx%d]", li,
> +				pr_info(" [%d:%dx%d]", li,
>  					mini2440_lcd_cfg[li].width,
>  					mini2440_lcd_cfg[li].height);

pr_cont

>  			else
> -				printk(" %d:%dx%d", li,
> +				pr_info(" %d:%dx%d", li,

pr_cont

>  					mini2440_lcd_cfg[li].width,
>  					mini2440_lcd_cfg[li].height);
> -		printk("\n");
> +		pr_info("\n");

pr_cont

So only the first printk should use pr_info().
The subsequent printk uses should use pr_cont()

>  		s3c24xx_fb_set_platdata(&mini2440_fb_info);
>  	}
>  
