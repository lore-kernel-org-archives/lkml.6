Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D70C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 20:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9738620C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 20:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9738620C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbeINBfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 21:35:55 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:61189 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbeINBfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 21:35:55 -0400
Received: from [IPv6:2a01:cb1d:1a3:2a00:dacb:8aff:fef1:ed46] (unknown [IPv6:2a01:cb1d:1a3:2a00:dacb:8aff:fef1:ed46])
        (Authenticated sender: sed)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 628452003C6;
        Thu, 13 Sep 2018 22:24:31 +0200 (CEST)
Subject: Re: [PATCH v3 1/2] ARM: s3c24xx: formatting cleanup in
 mach-mini2440.c
To:     Joe Perches <joe@perches.com>, kgene@kernel.org, krzk@kernel.org,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180907215446.15160-1-sed@free.fr>
 <b97d7ccc921572ca5d783584eea1de04341ab02f.camel@perches.com>
From:   Cedric Roux <sed@free.fr>
Message-ID: <4cf38559-b00d-ede4-def5-7cd832d8a506@free.fr>
Date:   Thu, 13 Sep 2018 22:26:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b97d7ccc921572ca5d783584eea1de04341ab02f.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09/12/2018 09:21 PM, Joe Perches wrote:
> On Fri, 2018-09-07 at 23:54 +0200, Cedric Roux wrote:
>> Running:
>>     scripts/checkpatch.pl -f arch/arm/mach-s3c24xx/mach-mini2440.c
>> revealed several errors and warnings.
>>
>> They were all removed, except one which is an #if 0 around the declaration
>> of a gpio pin. This needs some more investigation and I prefer to let it
>> here. This is not some dead code.
> []
>> diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c b/arch/arm/mach-s3c24xx/mach-mini2440.c
> []
>> @@ -674,17 +680,17 @@ static void __init mini2440_init(void)
>>  		mini2440_fb_info.displays =
>>  			&mini2440_lcd_cfg[features.lcd_index];
>>  
>> -		printk(KERN_INFO "MINI2440: LCD");
>> +		pr_info("MINI2440: LCD");
> 
> OK
> 
>>  		for (li = 0; li < ARRAY_SIZE(mini2440_lcd_cfg); li++)
>>  			if (li == features.lcd_index)
>> -				printk(" [%d:%dx%d]", li,
>> +				pr_info(" [%d:%dx%d]", li,
>>  					mini2440_lcd_cfg[li].width,
>>  					mini2440_lcd_cfg[li].height);
> 
> pr_cont
> 
>>  			else
>> -				printk(" %d:%dx%d", li,
>> +				pr_info(" %d:%dx%d", li,
> 
> pr_cont
> 
>>  					mini2440_lcd_cfg[li].width,
>>  					mini2440_lcd_cfg[li].height);
>> -		printk("\n");
>> +		pr_info("\n");
> 
> pr_cont
> 
> So only the first printk should use pr_info().
> The subsequent printk uses should use pr_cont()

at this point, I don't know what to do.

Should I resubmit the patches? Or is it in the hands of
Krzysztof (krzk@kernel.org)? I would say a git rebase -i
is enough to edit the patch and this rebase is obviously
not to be done by me, but I don't know the process.

Regards,
Cédric.



> 
>>  		s3c24xx_fb_set_platdata(&mini2440_fb_info);
>>  	}
>>  

