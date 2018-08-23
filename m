Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C89DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E6C208FE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WU5mLr/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E6C208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbeHWTMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 15:12:16 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:52488 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbeHWTMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 15:12:16 -0400
Received: by mail-it0-f65.google.com with SMTP id g18-v6so2861401itg.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 08:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+RrZ37o6/2EMiGrtHbPykmEFJEg7YKlgJtb/5wgtGHU=;
        b=WU5mLr/6MYOHXmqEa3FRo935CQvg89Kg7VA1FvwWETwA+bphQD3Peykq5QO1o3u77t
         I72N2PFaUnmWdrqQn5qHj7c0ZY3a8u2b4cjxxkcSf3vmYM9OfP6QEP52r7kkToen4WML
         Shr2928RKWMXSij4K/PlBKd3GeX0Jn4ErhqlEUrmkaVZD5Pn1MiWUdPUrJq9w6PMi6V+
         UlgstDqGgsu18l459n3uxkPSGEADI6SSlO79FQzuQzlMXeWJTWk7DlUFSA2wQd96twSG
         nFXFH6Lzg2sQD2drZcPRdFQFr79IGNDdcRes0WFNVKzssyPA+OcWxF7wE3lntooW9jhz
         CIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+RrZ37o6/2EMiGrtHbPykmEFJEg7YKlgJtb/5wgtGHU=;
        b=ltD/oqVeRqsEZyOyDs00ze3/RFGzlao0R8wzyj0j17bnkM/C/N9ZSzlUxi722mRsAY
         VmyuBWoYinR6Cj2YzZ3UposDYPJOlzE2wIWNjSf6mFq3vsLVA4UvOxCx1sqseCJ6s05D
         ZMtDez0vS5KNdKmZVjYed5OcRZIui1zZKaH/9ab/QHZ4BtNZjdM6M6k9LktTJEq0cksH
         DTb9bPrxwd5FNa8sP7utBVEmF7F8lgAGY/g1mF5VvjLOM1sQREKcBVt+ugtkHf/V+24Q
         5xyVfWVu3uExUMVqLGQ/lUciWGi6DinXbwodP2zKeu2s8O0jaYJqJlB7fabeN3r0+3gU
         0vZQ==
X-Gm-Message-State: APzg51APgEco81HqQiWVIfV6u72XsQbytFItuOcqunJpnZV8Wpl8biWK
        SeVHQFsDkhm33N4X9+q/nFEICKIPx1Q=
X-Google-Smtp-Source: ANB0VdYwGAaeU6CLOXKrznnzWHadebjhVuo8dukpI5GjVFhO+OuFtrLWKaCx/dJLEAcGuZk75JZg/g==
X-Received: by 2002:a24:3948:: with SMTP id l69-v6mr6639161ita.153.1535038923245;
        Thu, 23 Aug 2018 08:42:03 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m126-v6sm1767747ioa.79.2018.08.23.08.42.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 08:42:02 -0700 (PDT)
Subject: Re: [PATCH] blk-wbt: get back the missed wakeup from __wbt_done
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1535029718-17259-1-git-send-email-jianchao.w.wang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <809b2243-7a76-3d8a-5d1b-b6b9d9712f41@kernel.dk>
Date:   Thu, 23 Aug 2018 09:42:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1535029718-17259-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/18 7:08 AM, Jianchao Wang wrote:
> @@ -491,31 +525,27 @@ static void __wbt_wait(struct rq_wb *rwb, enum wbt_flags wb_acct,
>  	__acquires(lock)
>  {
>  	struct rq_wait *rqw = get_rq_wait(rwb, wb_acct);
> -	DECLARE_WAITQUEUE(wait, current);
> -	bool has_sleeper;
> -
> -	has_sleeper = wq_has_sleeper(&rqw->wait);
> -	if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))
> +	struct wait_queue_entry wait;
> +	struct wbt_wait_data data = {
> +		.curr = current,
> +		.rwb = rwb,
> +		.rqw = rqw,
> +		.rw = rw,
> +	};
> +
> +	if (!wq_has_sleeper(&rqw->wait) &&
> +			rq_wait_inc_below(rqw, get_limit(rwb, rw)))
>  		return;
>  
> -	add_wait_queue_exclusive(&rqw->wait, &wait);
> -	do {
> -		set_current_state(TASK_UNINTERRUPTIBLE);
> -
> -		if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))
> -			break;
> -
> -		if (lock) {
> -			spin_unlock_irq(lock);
> -			io_schedule();
> -			spin_lock_irq(lock);
> -		} else
> -			io_schedule();
> -		has_sleeper = false;
> -	} while (1);
> -
> -	__set_current_state(TASK_RUNNING);
> -	remove_wait_queue(&rqw->wait, &wait);
> +	wbt_init_wait(&wait, &data);
> +	prepare_to_wait_exclusive(&rqw->wait, &wait,
> +			TASK_UNINTERRUPTIBLE);
> +	if (lock) {
> +		spin_unlock_irq(lock);
> +		io_schedule();
> +		spin_lock_irq(lock);
> +	} else
> +		io_schedule();

Aren't we still missing a get-token attempt after adding to the
waitqueue? For the case where someone frees the token after your initial
check, but before you add yourself to the waitqueue.

-- 
Jens Axboe

