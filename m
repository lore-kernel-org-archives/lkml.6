Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547ACC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 22:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C8B20651
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 22:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nexus-software-ie.20150623.gappssmtp.com header.i=@nexus-software-ie.20150623.gappssmtp.com header.b="Hxddd8EM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09C8B20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nexus-software.ie
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbeJXGz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 02:55:28 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33544 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbeJXGz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 02:55:27 -0400
Received: by mail-ed1-f67.google.com with SMTP id r25-v6so3178507edy.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 15:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1ZSThoxr/5yKNDqTDJb+4Y4XkW0eCUJMikD5tMDFPBE=;
        b=Hxddd8EMaVLDkSzRhweAavMKpscTv7ad3QXCfqVjzufIeF8O1vv55UHgoN/7yqDUst
         Oq1ETJOnZmFXwDGx+U7QBOZVKfDOs9pFm8g3vUSDeQ6tKgqaWK2/2U0tZz6HlW8I/tCO
         36FVcZ1+EJv9HZrfJ/tBy1O4G8vujBmzFhFmW7bV4p0/y2mbjxtdKTaQzgfs+PWHe2GF
         LwUcCRib0M3WmRxJG51EVzsO/35NcZ7eklB3KExBnmWXWqbOZzhEVQfV1QyzUFc1vvHe
         3RypmHdIThRZF9evYIHnSsPTKe/Z7LWuXOhg7DzLdZHOZ22S8zFU/Yx/6y83fe8U5EkF
         fHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1ZSThoxr/5yKNDqTDJb+4Y4XkW0eCUJMikD5tMDFPBE=;
        b=CAe8JHpvzATfuTvsU955NAyXeuNhu3o3ImTiHox76Te/xHKziYBZPfH3QIb8yyBTtZ
         IaLdMksMg426znz+A0wAN/M1cDHyL0BTZ6mXCbb0694cnsS7fqUflejWJOYnM2ZGNb1R
         4Vz9joptiGVwh70oaRW2Q/hmqJI9WpR3M32R93dnmDMWfsmPpjrPiN1GubqpJ5aQJFYp
         tpAl0zSo83q9qhofkoPSOxrnJk75QnAxreSBvQ7nTVPxIkI1V/0Pqi+MW/bg3P3OQxg5
         ie7tGdlO1UVSko3xIMbGxim++p5xreXD9OMDgv649nXhoup9yf1M1u2t4kydXaoMo9R5
         Jigg==
X-Gm-Message-State: AGRZ1gIrphPUkrO+8873+zsox8zrqXctG7USLYHN270616DiMy5iVVBJ
        UZbM9f7P8P6EMUlVDW4tDMPkKwOErmE=
X-Google-Smtp-Source: AJdET5foq21adI1RquFCddjX2TcJY0TVn8aiWmILI3AKK4Nnl4OfWPpqNotzy9MsEp7GNrOE+eSeEw==
X-Received: by 2002:a17:906:41d1:: with SMTP id g17-v6mr50766ejl.58.1540333803549;
        Tue, 23 Oct 2018 15:30:03 -0700 (PDT)
Received: from [192.168.192.38] ([80.111.179.123])
        by smtp.gmail.com with ESMTPSA id 1-v6sm612967ejv.65.2018.10.23.15.30.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 15:30:02 -0700 (PDT)
Subject: Re: [PATCH 2/3] staging: greybus: loopback.c: do insertion in O(n)
 instead of O(n lg n)
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20181005142826.26108-1-linux@rasmusvillemoes.dk>
 <20181005142826.26108-2-linux@rasmusvillemoes.dk>
 <b59cc4bf-3c43-8d35-8d1c-0700f6b4c604@nexus-software.ie>
 <8578bb51-70b4-08c2-99b0-4cb95e3dd832@rasmusvillemoes.dk>
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
Message-ID: <2f90c2c7-6419-c4d1-0688-7cb84963281c@nexus-software.ie>
Date:   Tue, 23 Oct 2018 23:30:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <8578bb51-70b4-08c2-99b0-4cb95e3dd832@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/2018 17:20, Rasmus Villemoes wrote:
> On 2018-10-11 01:03, Bryan O'Donoghue wrote:
>> On 05/10/2018 15:28, Rasmus Villemoes wrote:
>>> Signed-off-by: Rasmus Villemoes<linux@rasmusvillemoes.dk>
>>> ---
>>> I have no idea if the performance matters (it probably doesn't). Feel
>>> free to ignore this and the followup cleanup.
>>
>> What's the problem you're fixing here ?
>>
>> Is it tested ?
> 
> I got curious why one would want to keep a linked list sorted in the
> first place (it can't be for doing binary searches). But it seems that
> gb_loopback_device::list is unused, along with the list_op_async. Given
> that the below compiles, doesn't that prove that the code is
> dead/unused, or what am I missing?
> 
> diff --git a/drivers/staging/greybus/loopback.c
> b/drivers/staging/greybus/loopback.c
> index 7080294f705c..e4d42c1dc284 100644
> --- a/drivers/staging/greybus/loopback.c
> +++ b/drivers/staging/greybus/loopback.c
> @@ -47,8 +47,6 @@ struct gb_loopback_device {
> 
>   	/* We need to take a lock in atomic context */
>   	spinlock_t lock;
> -	struct list_head list;
> -	struct list_head list_op_async;
>   	wait_queue_head_t wq;
>   };
> 
> @@ -68,7 +66,6 @@ struct gb_loopback {
>   	struct kfifo kfifo_lat;
>   	struct mutex mutex;
>   	struct task_struct *task;
> -	struct list_head entry;
>   	struct device *dev;
>   	wait_queue_head_t wq;
>   	wait_queue_head_t wq_completion;
> @@ -987,37 +984,6 @@ static const struct file_operations
> gb_loopback_debugfs_latency_ops = {
>   	.release	= single_release,
>   };
> 
> -static int gb_loopback_bus_id_compare(void *priv, struct list_head *lha,
> -				      struct list_head *lhb)
> -{
> -	struct gb_loopback *a = list_entry(lha, struct gb_loopback, entry);
> -	struct gb_loopback *b = list_entry(lhb, struct gb_loopback, entry);
> -	struct gb_connection *ca = a->connection;
> -	struct gb_connection *cb = b->connection;
> -
> -	if (ca->bundle->intf->interface_id < cb->bundle->intf->interface_id)
> -		return -1;
> -	if (cb->bundle->intf->interface_id < ca->bundle->intf->interface_id)
> -		return 1;
> -	if (ca->bundle->id < cb->bundle->id)
> -		return -1;
> -	if (cb->bundle->id < ca->bundle->id)
> -		return 1;
> -	if (ca->intf_cport_id < cb->intf_cport_id)
> -		return -1;
> -	else if (cb->intf_cport_id < ca->intf_cport_id)
> -		return 1;
> -
> -	return 0;
> -}
> -
> -static void gb_loopback_insert_id(struct gb_loopback *gb)
> -{
> -	/* perform an insertion sort */
> -	list_add_tail(&gb->entry, &gb_dev.list);
> -	list_sort(NULL, &gb_dev.list, gb_loopback_bus_id_compare);
> -}
> -
>   #define DEBUGFS_NAMELEN 32
> 
>   static int gb_loopback_probe(struct gb_bundle *bundle,
> @@ -1113,7 +1079,6 @@ static int gb_loopback_probe(struct gb_bundle *bundle,
>   	}
> 
>   	spin_lock_irqsave(&gb_dev.lock, flags);
> -	gb_loopback_insert_id(gb);
>   	gb_dev.count++;
>   	spin_unlock_irqrestore(&gb_dev.lock, flags);
> 
> @@ -1169,7 +1134,6 @@ static void gb_loopback_disconnect(struct
> gb_bundle *bundle)
> 
>   	spin_lock_irqsave(&gb_dev.lock, flags);
>   	gb_dev.count--;
> -	list_del(&gb->entry);
>   	spin_unlock_irqrestore(&gb_dev.lock, flags);
> 
>   	device_unregister(gb->dev);
> @@ -1196,8 +1160,6 @@ static int loopback_init(void)
>   {
>   	int retval;
> 
> -	INIT_LIST_HEAD(&gb_dev.list);
> -	INIT_LIST_HEAD(&gb_dev.list_op_async);
>   	spin_lock_init(&gb_dev.lock);
>   	gb_dev.root = debugfs_create_dir("gb_loopback", NULL);
> 

Looks like dead code alright.

Reviewed-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
