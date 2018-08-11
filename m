Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3ABC4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 02:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA4522426
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 02:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0/Fof96"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA4522426
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbeHKFXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 01:23:12 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35599 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbeHKFXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 01:23:12 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10-v6so5192213pgv.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 19:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=K5XlKV/QAHihOIEviQfcDoonh6RnTobjHNUXGks71RU=;
        b=X0/Fof96bvaFUKCMg1x1xkgMhSNVFxtSvY26VlT1YoUIBFznVXsl2WNoXa7LwwGG8u
         kuDvd9Bn/v6oi0lctMoh5NXngV+6Z9Evkb0qgtZgIN7vpuXCde92oNxJ57VkJI4EJsf9
         bHiXjQ60+1zNwSfRmwf7E9Mo9QDKvjFaNIOhnhsQNdPtiOV+RYxAhmylPu6MfeeRnFWX
         ydhfsPDUx1DCTg62B3jzAAQozFk2McwIR76jaN0YuQkL9ZVEGPBfVpW2DS4Xs07ZysuW
         qTjsmpsJYnHHy232QRJ7zdOmTyoMtXy3I0ayh3QVkKAuc3IeFkAvmq4ylTFy5wahQUry
         VgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=K5XlKV/QAHihOIEviQfcDoonh6RnTobjHNUXGks71RU=;
        b=VCYfgdS6+E4rOR/ejEknpibAWe139meD7kMXngkHjVEBCr5rJ+MMMQ59P1RL1yNx66
         XIGFQHuximELEdahAaJrUO7gBIqJin39utOupjDZYzu2cDZxAS+oVmd2oWrScRCl6vmr
         lR/pma0zUQBjfCdZo0pIDWB8nK4cYHbcA90haB/7fuAHDzRxSDnmdmKVzzcof0NZai4D
         Y+3e4LuimBQIychXGpmqW04/4mCESW/08lnCdjCWUkW+M95epZ/8MRdS5x3gkpwl8g/F
         aXvRcz0/XRSjGFTfAQrB0Qp8ECMLUqi9id1M24+nlBWLJu+CfpJO6o4uSl1dW+9fdPRX
         qYXQ==
X-Gm-Message-State: AOUpUlGqM5uU1RwrfnIikjBcsjrKOT4l6vVLl5YkB06zRKUkppjplCaq
        jLLkpspwk4n7CzzuwiVgvmvgsC16
X-Google-Smtp-Source: AA+uWPxg6soYn+rFPQcYRPUGUYfou6/RNk2yB1HWhiGWfjz4YY2DCPBetKENrxEUgslvi8JcDg0cKA==
X-Received: by 2002:a63:4106:: with SMTP id o6-v6mr8851346pga.453.1533955839469;
        Fri, 10 Aug 2018 19:50:39 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.51? ([2402:f000:1:1501:200:5efe:a66f:4733])
        by smtp.gmail.com with ESMTPSA id o21-v6sm18807773pfa.54.2018.08.10.19.50.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 19:50:38 -0700 (PDT)
Subject: Re: [PATCH] kernel: locking: rtmutex: Fix a possible
 sleep-in-atomic-context bug in rt_mutex_handle_deadlock()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org
References: <20180811023524.13845-1-baijiaju1990@gmail.com>
 <20180811024456.ykccnkbdrac4nbem@home.goodmis.org>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <edcc6397-6cf9-a629-56bd-8f3bd779d1bd@gmail.com>
Date:   Sat, 11 Aug 2018 10:50:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180811024456.ykccnkbdrac4nbem@home.goodmis.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/8/11 10:44, Steven Rostedt wrote:
> On Sat, Aug 11, 2018 at 10:35:24AM +0800, Jia-Ju Bai wrote:
>> The driver may sleep with holding a spinlock.
>>
>> The function call paths (from bottom to top) in Linux-4.16 are:
>>
>> [FUNC] schedule
>> kernel/locking/rtmutex.c, 1223:
>> 	schedule in rt_mutex_handle_deadlock
>> kernel/locking/rtmutex.c, 1273:
>> 	rt_mutex_handle_deadlock in rt_mutex_slowlock
>> kernel/locking/rtmutex.c, 1249:
>> 	_raw_spin_lock_irqsave in rt_mutex_slowlock
>>
>> To fix the bug, the spinlock is released before schedule() and then acquired again.
>> This is found by my static analysis tool (DSAC).
>>
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> ---
>>   kernel/locking/rtmutex.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
>> index 2823d4163a37..af03e162f812 100644
>> --- a/kernel/locking/rtmutex.c
>> +++ b/kernel/locking/rtmutex.c
>> @@ -1205,7 +1205,7 @@ __rt_mutex_slowlock(struct rt_mutex *lock, int state,
>>   }
>>   
>>   static void rt_mutex_handle_deadlock(int res, int detect_deadlock,
>> -				     struct rt_mutex_waiter *w)
>> +				     struct rt_mutex_waiter *w, struct rt_mutex *lock)
>>   {
>>   	/*
>>   	 * If the result is not -EDEADLOCK or the caller requested
>> @@ -1219,8 +1219,10 @@ static void rt_mutex_handle_deadlock(int res, int detect_deadlock,
>>   	 */
>>   	rt_mutex_print_deadlock(w);
>>   	while (1) {
>> +		raw_spin_unlock_irq(&lock->wait_lock);
>>   		set_current_state(TASK_INTERRUPTIBLE);
>>   		schedule();
>> +		raw_spin_lock_irq(&lock->wait_lock);
>>   	}
> If you look at the code you will notice that it stops the task and never lets
> it continue. Ever.
>
> If we hit this path, it means we are in a deadlock scenario and will not make
> any forward progress.
>
> If anything, it should simply be:
>
> 	rt_mutex_print_deadlock(w);
> +	/* We're not going anywhere, release the wait_lock */
> +	raw_spin_unlock_irq(&lock->wait_lock);
> 	while (1) {
> 		set_current_state(TASK_INTERRUPTIBLE);
> 		schedule();
> 	}

Thanks for your reply :)

Okay, I will send a V2 patch.


Best wishes,
Jia-Ju Bai

