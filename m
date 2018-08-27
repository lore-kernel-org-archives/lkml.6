Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD8BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260522087A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="C/YD+zWT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 260522087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbeH0Siq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 14:38:46 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:33677 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbeH0Sip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 14:38:45 -0400
Received: by mail-io0-f194.google.com with SMTP id r196-v6so13025761iod.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 07:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ubieNScTlVV2JQ/P+is6pxj4jL7v7P+YPMpJZtxBN3U=;
        b=C/YD+zWTFiCoKwYDWIbGvsvpMOoVGQ4//EK8tOtdLnaXVj329Aknd7R7ydFaDGSd1/
         6Xb6/wbbfM9B4vuhL3x1mNabuDg4xp6q4gR3WXG7n6rgTiw5C/LtKXZsruIZZ41ZuCDg
         JE7Vit6wt4DKo7yWNAgdhjlSoVvIS0m2w0EnTb9ROdYfezwLcnwhmHwmw4fXozeR5iGy
         MOX/gIsj24uS5OrRiwUfvcZoPwLe6QpL9QGcB/AKuwsOwwi3S+A5f1UGxVhexwhx67SJ
         NiReTfRPbOtynnSl70TpTZXvarhZjS5hAuIfHhPVoO96ZpYXMIJVaJjbanALSny3xssR
         Yd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ubieNScTlVV2JQ/P+is6pxj4jL7v7P+YPMpJZtxBN3U=;
        b=EWzrioaj5HQHpHi9rcVas6Dpkom8TVjLtMZ/c4frFaB0sWXcvfHdIjGiAH4G6tSNys
         7kE6VpfTh2zwV/FtKkNPA7S91TdI8r8lPNcDlGOnEvaWW+mN395YrVCBPfIv2Y7rzov8
         0RpBvd9fjpM3wfW751+6/oLpzf1Xz3iCJsEHsjpOf/gm8LXaahM9ubzhXmGxIgeotJdO
         O+1bs1UKZ7bnZY3/GzdGi9oVsPTP2kThq1fOvhmP6Fp65WDnzFEpsOW8aLOG1vrgGFh0
         lNBmobFyzx/hEL+82kevbYiLIm3NBvV0z2K2hTwiERR7F1fkVmQcetBRPLFgMe1nJ+FK
         Ct6A==
X-Gm-Message-State: APzg51Ct9e4P5HKztfV/nf4nHSCX8kpD8iUKRVkpP7uPdHvz0BlqYp0A
        Da3GfrflMe8JSNlO81Cexw61y4V0A3k=
X-Google-Smtp-Source: ANB0VdbAnkDvQfl74oIjU4tAFJ02SizmxCR7PJ1uPBjbbwr36fhjX6SrJsnnEa7quYbseUb4FXamSw==
X-Received: by 2002:a6b:2cc1:: with SMTP id s184-v6mr11065887ios.23.1535381507215;
        Mon, 27 Aug 2018 07:51:47 -0700 (PDT)
Received: from ?IPv6:2620:10d:c081:1131::1175? ([2620:10d:c090:180::1:98ca])
        by smtp.gmail.com with ESMTPSA id q196-v6sm6055853iod.23.2018.08.27.07.51.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 07:51:45 -0700 (PDT)
Subject: Re: [PATCH] blk-wbt: get back the missed wakeup from __wbt_done
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>,
        Anchal Agarwal <anchalag@amzn.com>
Cc:     fllinden@amazon.com,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1535029718-17259-1-git-send-email-jianchao.w.wang@oracle.com>
 <bd84ff08-b75a-0a2f-6b37-07a104452bff@kernel.dk>
 <da9458c632cb4c4695660664bf7c3fb3@EX13D13UWB002.ant.amazon.com>
 <20180823210144.GB5624@kaos-source-ops-60001.pdx1.amazon.com>
 <3eaa20ce-0599-c405-d979-87d91ea331d2@kernel.dk>
 <20180824181223.GA9049@kaos-source-ops-60001.pdx1.amazon.com>
 <677c8648-63fd-601c-b906-40a8502f9782@kernel.dk>
 <20180824203305.GA4690@kaos-source-ops-60001.pdx1.amazon.com>
 <dc734449-7cd8-3a8e-9fdc-d7d854393900@kernel.dk>
 <2fecf2f2-f00b-f6ba-710a-54ceaacfedbb@kernel.dk>
 <00445460-d826-4d85-c5f4-fa565892da01@oracle.com>
 <3876c36c-fec6-6586-435f-dc177dc38c76@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f88cd48d-e140-fa61-76f7-8985ca2c2e08@kernel.dk>
Date:   Mon, 27 Aug 2018 08:51:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <3876c36c-fec6-6586-435f-dc177dc38c76@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/18 12:15 AM, jianchao.wang wrote:
> 
> 
> On 08/27/2018 11:52 AM, jianchao.wang wrote:
>> Hi Jens
>>
>> On 08/25/2018 11:41 PM, Jens Axboe wrote:
>>>  	do {
>>> -		set_current_state(TASK_UNINTERRUPTIBLE);
>>> +		if (test_bit(0, &data.flags))
>>> +			break;
>>>  
>>> -		if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))
>>> +		WARN_ON_ONCE(list_empty(&data.wq.entry));
>>> +
>>> +		if (!has_sleeper &&
>>> +		    rq_wait_inc_below(rqw, get_limit(rwb, rw))) {
>>> +			finish_wait(&rqw->wait, &data.wq);
>>> +
>>> +			/*
>>> +			 * We raced with wbt_wake_function() getting a token,
>>> +			 * which means we now have two. Put ours and wake
>>> +			 * anyone else potentially waiting for one.
>>> +			 */
>>> +			if (test_bit(0, &data.flags))
>>> +				wbt_rqw_done(rwb, rqw, wb_acct);
>>>  			break;
>>
>> Just use 'bool' variable should be OK 
>> After finish_wait, no one could race with us here.
>>
>>> +		}
>>>  
>>>  		if (lock) {
>>>  			spin_unlock_irq(lock);
>>> @@ -511,11 +569,11 @@ static void __wbt_wait(struct rq_wb *rwb, enum wbt_flags wb_acct,
>>>  			spin_lock_irq(lock);
>>>  		} else
>>>  			io_schedule();
>>> +
>>>  		has_sleeper = false;
>>>  	} while (1);
>>
>> I cannot get the point of "since we can't rely on just being woken from the ->func handler
>> we set".
>> Do you mean there could be someone else could wake up this task ?

Yeah, you don't know for a fact that the wbt wait queue is the only
guy waking us up. Any sleep like this needs a loop. It was quite
easy to reproduce for me, and as expected, you'll get list corruption
on the wait queue since we leave it on the list and the stack goes
away.

> If we do need a recheck after the io_schedule, we could do as following:
> 
> static void __wbt_wait(struct rq_wb *rwb, enum wbt_flags wb_acct,
> 		       unsigned long rw, spinlock_t *lock)
> 	__releases(lock)
> 	__acquires(lock)
> {
> 	struct rq_wait *rqw = get_rq_wait(rwb, wb_acct);
> 	struct wbt_wait_data data = {
> 		.wq = {
> 			.func	= wbt_wake_function,
> 			.entry	= LIST_HEAD_INIT(data.wq.entry),
> 		},
> 		.curr = current,
> 		.rwb = rwb,
> 		.rqw = rqw,
> 		.rw = rw,
> 	};
> 	bool has_sleeper;
> 	bool got = false;
> 
> retry:
> 	has_sleeper = wq_has_sleeper(&rqw->wait);
> 	if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))
> 		return;
> 
> 	prepare_to_wait_exclusive(&rqw->wait, &data.wq, TASK_UNINTERRUPTIBLE);
> 
> 	if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw))) {
> 		got = true;
> 		goto out;
> 	}
> 
> 	if (lock) {
> 		spin_unlock_irq(lock);
> 		io_schedule();
> 		spin_lock_irq(lock);
> 	} else
> 		io_schedule();
> 
> out:
> 	finish_wait(&rqw->wait, &data.wq);
> 
> 	/*
> 	 * We raced with wbt_wake_function() getting a token,
> 	 * which means we now have two. Put ours and wake
> 	 * anyone else potentially waiting for one.
> 	 */
> 	if (data.got && got)
> 		wbt_rqw_done(rwb, rqw, wb_acct);
> 	else if (!data.got && !got)
> 		goto retry;

I think the other variant is cleaner and easier to read. This is just
a natural loop, I don't think we need to use goto's here.

FWIW, I split it into two patches, current version is here:

http://git.kernel.dk/cgit/linux-block/log/?h=for-linus

-- 
Jens Axboe

