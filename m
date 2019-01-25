Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69ACC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B1B1217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKcMJVPY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfAYJCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:02:36 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46235 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfAYJCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 04:02:36 -0500
Received: by mail-pf1-f196.google.com with SMTP id c73so4439480pfe.13;
        Fri, 25 Jan 2019 01:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=88xVhSy7MEuibVBgcnfkB+gaLEeJpkHmfvynvn+iaDk=;
        b=LKcMJVPYQ711R28tbmSojEbIVSBd4aZpTCvV5KX+q3CeSea9bEFuPBcL44LKMQzKDt
         8vvmcSpKCTCZJfk+2MGJBm0CiHyGQPHuDTU8Hc/HY+2m55O87xQHC2D2stvquy3LzD/P
         Yb2zXBH8sn3t41KNzOCBgwftcueIKxdknJu0GJprK7Lenuj6PHmGWIYcrE9VUcfX0CX0
         Vigcxd2DdDT3h8Q2IkBH9W5X9Iuhpwy3AiJpuV0xGbqgUERcvQpqLxTBUgKdjQJ1kcn1
         wDGkjLynrQJmojV890BZGH7hyde6nl5EhSgVtb9OzEA1ct7xfRJSlc7t7nWY2Ty6H1uY
         +sfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=88xVhSy7MEuibVBgcnfkB+gaLEeJpkHmfvynvn+iaDk=;
        b=m7JJqqjsLTU7c8g5IPv6v3Q+/5Mk2dIDG3ZbifkYYnVSLDqXG2XRh1OvY8OYO5jW+2
         en7s6Zk6glhxEl59XtJgiLTB5TuzKUd4Vjxb5vgqPXJzQiEFaQRD+8g2cuUvOhluZxxs
         JVVS2rqbnta/VeUOa+bcF7qWAjUXNqgvL/9HZ40Lyfv5E3kRgOAtuWSY/oEhYNWYogeT
         4P/I3JX9Pz7dco32Wezmpbhvj6bjZhr99l2EDNjrdwkIrecQzqYOtFuCYbFRZMRlpsoT
         DwuzG6qF3bzVAnbd+d4ZloK3S5fV6Kk6W4dy77JVmYKubfuoGhxy/BuRoCDBMi19mWzG
         sJ+w==
X-Gm-Message-State: AJcUukdJ4vAN0OZ4UPz5n/ygMrDAyc+0CQ9nLBNni/6bc10AgDQUNsNy
        tEB5CAOH7KNpFUFgBKKNX32vpZPh
X-Google-Smtp-Source: ALg8bN7T15BrMLp4+y+HJs+zC9cCFzvUq+sQRCOYByGuujW0Q/n2588ttePzg27IpsNYYexh7x0Oxg==
X-Received: by 2002:a62:9f1b:: with SMTP id g27mr9799605pfe.87.1548406955462;
        Fri, 25 Jan 2019 01:02:35 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u6sm26980785pgr.79.2019.01.25.01.02.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 01:02:34 -0800 (PST)
Subject: Re: [PATCH] watchdog: dw: remove useless pr_fmt
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190125155138.2f914f5c@xhacker.debian>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <c866bacf-1866-bebd-b1c1-43fb4f9f8047@roeck-us.net>
Date:   Fri, 25 Jan 2019 01:02:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190125155138.2f914f5c@xhacker.debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/19 11:57 PM, Jisheng Zhang wrote:
> When switch to watchdog infrastructure, pr_* usage is removed, so
> there's no any users of the pr_fmt, remove it.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/dw_wdt.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> index c053c2de5c2f..0ce8fa5cfbf4 100644
> --- a/drivers/watchdog/dw_wdt.c
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -16,8 +16,6 @@
>    * heartbeat requests after the watchdog device has been closed.
>    */
>   
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
>   #include <linux/bitops.h>
>   #include <linux/clk.h>
>   #include <linux/delay.h>
> 

