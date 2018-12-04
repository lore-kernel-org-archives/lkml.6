Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F0BC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD7020659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVAoR+e9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DD7020659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbeLDQ7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:59:33 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40619 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbeLDQ7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:59:32 -0500
Received: by mail-pf1-f193.google.com with SMTP id i12so8502484pfo.7;
        Tue, 04 Dec 2018 08:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YQEYR4JchBD2U45/7O3rRPMlb87cDi34sr6MwEw8m8c=;
        b=ZVAoR+e9j/OneJigg1MFVXmtel4ZQ4SZTQOICqCfPGm6mMUvn74ybH7UIW+X8joj8s
         JsBAr1qnZEJbuvwHX1X0QHdW8lIH/8+bZ6oQFX7sKA23gB4mnbNPaTcqYXCkKZKlZGXR
         ExcuslzEmrsq+JJI9Q34Dy0jGmhvo0Rr4w07740tprU7N6qukj9OE2wyp9FGd+iQs8Kt
         MmrNZvjZFCtLJPNpYqqUMfU8W0qqNaWdOe03k9LwHEvPfgf+v2Ry8U1cNp8lLjRnso4Y
         dFF8Hv4dIwhhHHzNlR4snM55pHNDIH4Nhi7PHqgUL3HHC4eALJwtGgQnebPAu4Y9XpIY
         JNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YQEYR4JchBD2U45/7O3rRPMlb87cDi34sr6MwEw8m8c=;
        b=mjf3S/rcxHUUHJL7+KLYNWQi1mHwvy4etpRHAth3G2zR0bJ0nr8sI+Lw7Jl3CadzdW
         5wUQGNsVF7K7OpzlkYZ2atPxgM8J+2gozOdNj8e81tVtQLCszmmVpdrfZNufY3B0ajOJ
         z8h9oC+KLukHr48i2QDtR58m+DsjLTJ4fLd+NLsJv7DS/2jDGvrKbWS7MsL4GGj78PJA
         EG7quEivcDaQissy4Qph1WLsizPpidUA/Yc/HGAShrW1mgIemsPH/6kniFhhpJopw2ZV
         /+vQFQPP16qNQI1BjnJWe0Nu8/JkcECj7trXKqJADr5zx8B+0AQu2XgGPR23uPrnSzWZ
         j8OA==
X-Gm-Message-State: AA+aEWYVXgujaNNCL6r0Wpcu6jv4Sp4HYq92MZaPBn++IDIqMIrSTMzY
        WRE2wW0H/wfEFTdMkAuDW9U17gyl
X-Google-Smtp-Source: AFSGD/X677dniDkupN2kVEgoRJ1+gaLsBYLjSoQhoUi676aO8IH7FY1LQbL7HigEhztJyPuGChtTkQ==
X-Received: by 2002:a65:6491:: with SMTP id e17mr17213345pgv.418.1543942771429;
        Tue, 04 Dec 2018 08:59:31 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l85sm46701567pfg.161.2018.12.04.08.59.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 08:59:30 -0800 (PST)
Subject: Re: [PATCH 1/2] watchdog: bcm281xx: convert to DEFINE_SHOW_ATTRIBUTE
To:     Yangtao Li <tiny.windzz@gmail.com>, wim@linux-watchdog.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181201145140.8088-1-tiny.windzz@gmail.com>
 <20181201145140.8088-2-tiny.windzz@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <b041b3a1-124a-ac48-5366-718a7dea5b9d@roeck-us.net>
Date:   Tue, 4 Dec 2018 08:59:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181201145140.8088-2-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/18 6:51 AM, Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/bcm_kona_wdt.c | 16 +++-------------
>   1 file changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/watchdog/bcm_kona_wdt.c b/drivers/watchdog/bcm_kona_wdt.c
> index 1462be9e6fc5..4249b47902bd 100644
> --- a/drivers/watchdog/bcm_kona_wdt.c
> +++ b/drivers/watchdog/bcm_kona_wdt.c
> @@ -90,7 +90,7 @@ static int secure_register_read(struct bcm_kona_wdt *wdt, uint32_t offset)
>   
>   #ifdef CONFIG_BCM_KONA_WDT_DEBUG
>   
> -static int bcm_kona_wdt_dbg_show(struct seq_file *s, void *data)
> +static int bcm_kona_show(struct seq_file *s, void *data)
>   {
>   	int ctl_val, cur_val;
>   	unsigned long flags;
> @@ -130,17 +130,7 @@ static int bcm_kona_wdt_dbg_show(struct seq_file *s, void *data)
>   	return 0;
>   }
>   
> -static int bcm_kona_dbg_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, bcm_kona_wdt_dbg_show, inode->i_private);
> -}
> -
> -static const struct file_operations bcm_kona_dbg_operations = {
> -	.open		= bcm_kona_dbg_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(bcm_kona);
>   
>   static void bcm_kona_wdt_debug_init(struct platform_device *pdev)
>   {
> @@ -157,7 +147,7 @@ static void bcm_kona_wdt_debug_init(struct platform_device *pdev)
>   		return;
>   
>   	if (debugfs_create_file("info", S_IFREG | S_IRUGO, dir, wdt,
> -				&bcm_kona_dbg_operations))
> +				&bcm_kona_fops))
>   		wdt->debugfs = dir;
>   	else
>   		debugfs_remove_recursive(dir);
> 

