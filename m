Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55662C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AAE32082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sBMSivPi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AAE32082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbeLDRAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:00:24 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33860 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbeLDRAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 12:00:24 -0500
Received: by mail-pg1-f194.google.com with SMTP id 17so7657376pgg.1;
        Tue, 04 Dec 2018 09:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sR0TgLSraf/UZAXXmBG1OI11HyL+qKw4RPckxaJIRdE=;
        b=sBMSivPiK5GZI0BeGzc44iId1c4JIgsyILwB9FLuTa+wI/Sgf9OtTp4YhElvsGnC48
         e/snpYCel8GxD9uGYkJXYG7Vd5fLB5YHyVUzPCj54K8dNElSF7DL3vdqvn/6uir6iWxm
         TONCBP9SrWJ5cQnTMDZNNvDHYwEyXKL3GDX/2gwPgP5YWpUcrib6m1nNSKa0tKLWzqSx
         17L0nChOsb8eAyYpVOi85BgjiuFNLSlF1W/LKnOQGY+cySUS3dlMxmMF4oZjsU8BgQqm
         lVZlalTtpUTyYTOEtAZUVQ4xKc7cVt3lUKl+OBathrDjAjjp+9V8srFALcHuvDc3Ofdm
         J/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sR0TgLSraf/UZAXXmBG1OI11HyL+qKw4RPckxaJIRdE=;
        b=FXta8xjM3IzxKpVmjR8Rf6ESMLZev29BwRP4w2GrQ7PP3bX9iCa8Oson8EgdB9emN5
         T2nZI5qoV4iXT84uq/j86BGowp+svkqUygM1ykFoKu86Fby/ux243R692TA08esWCTKN
         xPoSnS27Iob5wjjqdBGEYE6hD5YIhR14Jsjog7VfxmeEIWqQ3Ftq0RtJKO8TCKPLIrJ5
         v485SCuzAQRrlkGahm61oUUdLHc1n/KQCzcok1IRIXyTwaLty3yzuUQL7vykDjAAnzQe
         y6piD/a23WWkCwwSgSNRQNPEvQ02qEHQJlizJuvK+D/AhuTYvuZwpvGCo7ez1Cr/WFEu
         AAOw==
X-Gm-Message-State: AA+aEWYDoJgKcB1phVFcPWUug6iZeKvKmzYLQkRZ1DyW6gj6qbvudSUI
        6L9KdVPO0iuxiu173n1/ix9tVgYt
X-Google-Smtp-Source: AFSGD/VnyCNh9GXS5ZR/pHYJ4nUxsxK3VXG6s0WYDCpk5Tnwk/JLacMflsE/L2a2AqQGdI5aljNqFg==
X-Received: by 2002:a62:1212:: with SMTP id a18mr21431397pfj.217.1543942823234;
        Tue, 04 Dec 2018 09:00:23 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 64sm21569427pff.101.2018.12.04.09.00.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 09:00:22 -0800 (PST)
Subject: Re: [PATCH 2/2] watchdog: convert to DEFINE_SHOW_ATTRIBUTE
To:     Yangtao Li <tiny.windzz@gmail.com>, wim@linux-watchdog.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181201145140.8088-1-tiny.windzz@gmail.com>
 <20181201145140.8088-3-tiny.windzz@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <585a9e90-297a-3cc9-2a54-49eb82b82adf@roeck-us.net>
Date:   Tue, 4 Dec 2018 09:00:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181201145140.8088-3-tiny.windzz@gmail.com>
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
>   drivers/watchdog/ie6xx_wdt.c | 16 +++-------------
>   1 file changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/watchdog/ie6xx_wdt.c b/drivers/watchdog/ie6xx_wdt.c
> index 78c2541f5d52..8de9fb1ed371 100644
> --- a/drivers/watchdog/ie6xx_wdt.c
> +++ b/drivers/watchdog/ie6xx_wdt.c
> @@ -193,7 +193,7 @@ static struct watchdog_device ie6xx_wdt_dev = {
>   
>   #ifdef CONFIG_DEBUG_FS
>   
> -static int ie6xx_wdt_dbg_show(struct seq_file *s, void *unused)
> +static int ie6xx_wdt_show(struct seq_file *s, void *unused)
>   {
>   	seq_printf(s, "PV1   = 0x%08x\n",
>   		inl(ie6xx_wdt_data.sch_wdtba + PV1));
> @@ -212,23 +212,13 @@ static int ie6xx_wdt_dbg_show(struct seq_file *s, void *unused)
>   	return 0;
>   }
>   
> -static int ie6xx_wdt_dbg_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, ie6xx_wdt_dbg_show, NULL);
> -}
> -
> -static const struct file_operations ie6xx_wdt_dbg_operations = {
> -	.open		= ie6xx_wdt_dbg_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(ie6xx_wdt);
>   
>   static void ie6xx_wdt_debugfs_init(void)
>   {
>   	/* /sys/kernel/debug/ie6xx_wdt */
>   	ie6xx_wdt_data.debugfs = debugfs_create_file("ie6xx_wdt",
> -		S_IFREG | S_IRUGO, NULL, NULL, &ie6xx_wdt_dbg_operations);
> +		S_IFREG | S_IRUGO, NULL, NULL, &ie6xx_wdt_fops);
>   }
>   
>   static void ie6xx_wdt_debugfs_exit(void)
> 

