Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4E1ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 07:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C8E20875
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 07:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="sSlmSDRW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C8E20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbeGVIuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 04:50:25 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38075 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbeGVIuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 04:50:25 -0400
Received: by mail-lf1-f65.google.com with SMTP id a4-v6so4371347lff.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 00:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PlccDaF23w0x4ujRW8eBdWZBHtRJgy04PTOeBwuCwBs=;
        b=sSlmSDRWCOd3ptak10XqhaLKhVTf3DN7GdClFvZvwZhgZiN8cUJzuwsiAEurM/XzFl
         uJ6Zl+SNrnRZVozFOEukrtkzHQYplOJZH2j6NzVQZHdmcRnTlw3vi16zra5WVjhe/2Hn
         fgY3GXQCW/cAlokyhzqOW19kEl56cSWPEbk7brlbwlxYbCSoNF6lfE7RAno7Ldgvcb0F
         n88rWsW1sXBUaISlnTiUjlyfKAZGXC9h3y5zk6LjxPjhu05n/c/dsgrMSZGrPJaV6sYN
         A49JXfDnEWzQthnLFiu9xnLLO7BLkO3Xw1imvbvOFm3dcEJtZFcpHYjtvgx+plhIWZFO
         wVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PlccDaF23w0x4ujRW8eBdWZBHtRJgy04PTOeBwuCwBs=;
        b=QnFK0Gsj0hvSlDb3oCStjCCxJ85M8dYZBEOLKivDYWhMzVUTihIj0VMKQjktcwfaGL
         9s5tERMZymwawbGxSt43bLiMGvNmyipR4w2RVFDpHIecYJ3aJvvzl5xXTX3aIEJQSasx
         UiFZH9IhUIC9GVNCY6+F0qPXtZv2JGWvOQGh+zeyX31diB4ADMEVdinE/xBCbokZuFFa
         KSCsTfPortaKbklva8v6jYWDaBy1Fru0EVkttHpy8CBb0HYcNHzc71ZzHHHmXhkftjfh
         AYiB/stB1ZSZgSrjHGaF+Th9yYMzgYS6JIK/Ns8QmY+QcRCyt9U+0wVVyLyU0P+uHJ0Y
         KR2g==
X-Gm-Message-State: AOUpUlGKHtyFTcaQlDjfbRnd5yYNcjicUuclqUjDtVAVixUcGNuqW8xK
        dakUInHBvCiJNgQNolyoeq8Ezg==
X-Google-Smtp-Source: AAOMgpd9Vw134QYGklyEFysVKKEsEmeol/dR4FheD02YFnXUilO3cQelTrQAWXKhtjVuWoF8Rxu0sw==
X-Received: by 2002:a19:a2d5:: with SMTP id l204-v6mr4982448lfe.65.1532246074945;
        Sun, 22 Jul 2018 00:54:34 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.83.165])
        by smtp.gmail.com with ESMTPSA id k10-v6sm1246184ljh.5.2018.07.22.00.54.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 00:54:33 -0700 (PDT)
Subject: Re: [PATCH] mtd: solutionengine.c: fix printk format warnings
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
References: <02694f68-7994-d91d-6556-4f29eb284268@infradead.org>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <ca2c8276-2106-6fb1-de8e-ab680f49cab9@cogentembedded.com>
Date:   Sun, 22 Jul 2018 10:54:34 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <02694f68-7994-d91d-6556-4f29eb284268@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 7/21/2018 10:37 PM, Randy Dunlap wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix 2 printk format warnings (this driver is currently SUPERH only)
> by using "%pap" instead of "%lx".
> (or we could just cast the physical addresses to unsigned int)
> 
> Fixes these build warnings:
> 
> ../drivers/mtd/maps/solutionengine.c: In function 'init_soleng_maps':
> ../include/linux/kern_levels.h:5:18: warning: format '%lx' expects argument of type 'long unsigned int', but argument 2 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
> ../drivers/mtd/maps/solutionengine.c:62:54: note: format string is defined here
>    printk(KERN_NOTICE "Solution Engine: Flash at 0x%08lx, EPROM at 0x%08lx\n",
>                                                    ~~~~^
>                                                    %08x
> ../include/linux/kern_levels.h:5:18: warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
> ../drivers/mtd/maps/solutionengine.c:62:72: note: format string is defined here
>    printk(KERN_NOTICE "Solution Engine: Flash at 0x%08lx, EPROM at 0x%08lx\n",
>                                                                      ~~~~^
>                                                                      %08x
> 
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Brian Norris <computersforpeace@gmail.com>
> Cc: Boris Brezillon <boris.brezillon@bootlin.com>
> Cc: Marek Vasut <marek.vasut@gmail.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: linux-mtd@lists.infradead.org
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: linux-sh@vger.kernel.org
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
>   drivers/mtd/maps/solutionengine.c |   10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> --- linux-next-20180720.orig/drivers/mtd/maps/solutionengine.c
> +++ linux-next-20180720/drivers/mtd/maps/solutionengine.c
> @@ -59,9 +59,13 @@ static int __init init_soleng_maps(void)
>   			return -ENXIO;
>   		}
>   	}
> -	printk(KERN_NOTICE "Solution Engine: Flash at 0x%08lx, EPROM at 0x%08lx\n",
> -	       soleng_flash_map.phys & 0x1fffffff,
> -	       soleng_eprom_map.phys & 0x1fffffff);
> +	{
> +	resource_size_t fl_phys = soleng_flash_map.phys & 0x1fffffff;
> +	resource_size_t ep_phys = soleng_eprom_map.phys & 0x1fffffff;
> +
> +	printk(KERN_NOTICE "Solution Engine: Flash at 0x%pap, EPROM at 0x%pap\n",
> +	       &fl_phys, &ep_phys);

    Er, what about the indentation?

> +	}
>   	flash_mtd->owner = THIS_MODULE;
>   
>   	eprom_mtd = do_map_probe("map_rom", &soleng_eprom_map);
[...]

MBR, Sergei
