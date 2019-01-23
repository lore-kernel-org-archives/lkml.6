Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134A0C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFBD421855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8xI0QB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfAWSFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:05:47 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45142 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfAWSFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 13:05:46 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so1533216plm.12;
        Wed, 23 Jan 2019 10:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TVLr370wVQEq/+xLWf71Sn3PgQoIIdaTqQOjWzZbyw4=;
        b=T8xI0QB6OWd2eYRNKOLF0NmB66eG5xCLtTeh4icUXGYHBjnqmcRAwUd7ng+9RfYAmu
         IXky1KlgCSpO53nzjgma9a7kRwe7BmRryP4mXF5wxWSXHsUrjbc0lZzzcuqeJG8BDc9A
         3bgbwBnXodvbS3Kq5QBccQoDE0Uv6dbfBGSW/cp6Ib4NHHEiYs/Iho/R+EWEoejKUzII
         0jK6G36ei8/kJfQlnlSwORB8DuovZFvQZ1SJfYYyq4VNT1T1v2Yj5V1eLdigVFhSHOGt
         BWRDkdZimfTtiA9ulK+1xTWOsdTiBRjSZU/GUT7dhdtKCT3h4zbv44plBT68ifhCvXli
         RvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TVLr370wVQEq/+xLWf71Sn3PgQoIIdaTqQOjWzZbyw4=;
        b=PW9ZNsPgIq09qhmnjewpEBZOFCN1qfH10/FZzXC9zSjmxWkf0btMKXYu01nB7yFAyP
         pocCnu3Z2fP4kqz8YaIRNeJnkY01p1hkrwv0syJKprVcHn53gttBYbeZAVrH3pWewAg1
         QfsTMFWZ6w3tUwqz3DxRfajP/STT1q/D1Gj2FrMgFy/R/v88gMfIeuG0J6iNBVbqtuRD
         OvPK/I7yQp4UZylxZJ7CMVdYIdmIPED3eIGeEw2Sg5hWEp8ywvNlmRroNH5gdgoKEFGB
         PsujkcXxVWpYZl9t8Zy/Kl1eV6mZeKmEVl8BZEfRSCC0e84ovE49DxYvJ0hBp1mlsbwC
         ZI1A==
X-Gm-Message-State: AJcUukeOp3Bne1itG5Cs7gAX++/HWB1yqSCTzIhpJ8H8nKm5rw1aARIb
        v8zG7ZSbiIO7QzD0+PDf+sK6F4e9
X-Google-Smtp-Source: ALg8bN7tlhvROdImwV8f7YiTdHHTXYAO672CrFHzzL/TxkDrzpBR09lGFcC3Eahfpm99cWh0EI3dCQ==
X-Received: by 2002:a17:902:8306:: with SMTP id bd6mr3227914plb.217.1548266746208;
        Wed, 23 Jan 2019 10:05:46 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c72sm39919454pfb.107.2019.01.23.10.05.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 10:05:45 -0800 (PST)
Date:   Wed, 23 Jan 2019 10:05:44 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     wim@linux-watchdog.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH -next] watchdog: pika_wdt: drop pointless static
 qualifier in pikawdt_init
Message-ID: <20190123180544.GC9781@roeck-us.net>
References: <20190123090524.13320-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123090524.13320-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 05:05:24PM +0800, YueHaibing wrote:
> There is no need to have the 'post1' variable static since
> new value always be assigned before use it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Is anyone still using this driver ? If yes it might make sense to convert
it to use the watchdog subsystem.

Guenter

> ---
>  drivers/watchdog/pika_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/pika_wdt.c b/drivers/watchdog/pika_wdt.c
> index e0a6f8c..bb97f5b 100644
> --- a/drivers/watchdog/pika_wdt.c
> +++ b/drivers/watchdog/pika_wdt.c
> @@ -225,7 +225,7 @@ static int __init pikawdt_init(void)
>  {
>  	struct device_node *np;
>  	void __iomem *fpga;
> -	static u32 post1;
> +	u32 post1;
>  	int ret;
>  
>  	np = of_find_compatible_node(NULL, NULL, "pika,fpga");
> -- 
> 2.7.0
> 
> 
