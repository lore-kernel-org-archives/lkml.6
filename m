Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F62BC433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 15:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1567221763
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 15:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vzvFCJOE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1567221763
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbeHYTUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 15:20:35 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:37475 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbeHYTUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 15:20:34 -0400
Received: by mail-io0-f193.google.com with SMTP id v14-v6so9482455iob.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Aug 2018 08:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W2LM7AHAcF0+WBi86iaCWs1/P7J0q42YaQ7anygxAgE=;
        b=vzvFCJOEA39JtEmP0GJpAawrmivOhsgOw6EC1mwpvz3BstHo367oPrtGBkn5A/r7In
         nndE0HlTeUsHeW8WhbUJmjAtNbzx82C7EOhXV9eR1W31M//Vn04sL68LuGmTOJpYu9G8
         q0YU6tsaURuazQjoJNOmYTDFDCjVmnvVdPcabU3D4q5z+E/P20cQqRJS8rPxZ1pa/sBh
         5Xcc/FrgITSCcuPxO5BilDFaMPtyM8MXGeeTc3GWGBMLGxfgM6nrX8NpH3Fe+H8i3WPk
         0MO8oFmel+4YJQzbmnGNlnm9N/MqljceVxFrJ0Jwv9yPDN0+V83Du2X/gttjn+2bJIT0
         gh3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W2LM7AHAcF0+WBi86iaCWs1/P7J0q42YaQ7anygxAgE=;
        b=Olf+in9/AVgSZD8UvVrW1O7UAwXUgMsIfXnBqSRdeac+aiqRFs2iLfq4kFIk+clOmN
         ZKRURxp4j/ZCpavnWKlnw65g2JCv3JMEO4MU4O1Joasba5OPcswHU9tjzFJH41l/3F86
         X6m8c+3vuOIKA9G/TNTSoLPkQFkSBC3sAstqDp/bLBZwKsmCiEMofQ6WDDhHyEqHuwNG
         mekiUI3K35zMo+uR1tvlPcMP+2QyfvXtc10jpUaZYOfEfrcW93z5KkfMTgdewnwR2OV+
         yd0l1+PX8iW8+UdF3fA3cttac4YCEDBcILF0fYiQFmXtAmttGraYgx2yGcXyygymwo0V
         MbKg==
X-Gm-Message-State: APzg51COnXlTDfVyM6zTPp5uU3naSefYrp9DPf0sVcOsdiSWIQ3/Jiuk
        14LtbzxSlLkRRg6ffGlQViqFlYiauZc=
X-Google-Smtp-Source: ANB0VdbdehluHVEe3rWdvQwDhCaberuXf0BP401T4fQKnbJT9UdxiROoX6j4416Lh2swFPSLL4wwUg==
X-Received: by 2002:a6b:1644:: with SMTP id 65-v6mr4768578iow.137.1535211672799;
        Sat, 25 Aug 2018 08:41:12 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.22.static.utbb.net. [107.191.0.22])
        by smtp.gmail.com with ESMTPSA id 80-v6sm1938624itk.14.2018.08.25.08.41.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Aug 2018 08:41:11 -0700 (PDT)
Subject: Re: [PATCH] blk-wbt: get back the missed wakeup from __wbt_done
From:   Jens Axboe <axboe@kernel.dk>
To:     Anchal Agarwal <anchalag@amzn.com>
Cc:     fllinden@amazon.com, Jianchao Wang <jianchao.w.wang@oracle.com>,
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
Message-ID: <2fecf2f2-f00b-f6ba-710a-54ceaacfedbb@kernel.dk>
Date:   Sat, 25 Aug 2018 09:41:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <dc734449-7cd8-3a8e-9fdc-d7d854393900@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/18 2:41 PM, Jens Axboe wrote:
> On 8/24/18 2:33 PM, Anchal Agarwal wrote:
>> On Fri, Aug 24, 2018 at 12:50:44PM -0600, Jens Axboe wrote:
>>> On 8/24/18 12:12 PM, Anchal Agarwal wrote:
>>>> That's totally fair. As compared to before the patch it was way too high
>>>> and my test case wasn't even running due to the thunderign herd issues and
>>>> queue re-ordering. Anyways as I also mentioned before 10 times 
>>>> contention is not too bad since its not really affecting much the number of
>>>> files read in my applciation. Also, you are right waking up N tasks seems 
>>>> plausible. 
>>>
>>> OK, I'm going to take that as a positive response. I'm going to propose
>>> the last patch as the final addition in this round, since it does fix a
>>> gap in the previous. And I do think that we need to wake as many tasks
>>> as can make progress, otherwise we're deliberately running the device at
>>> a lower load than we should.
>>>
>>>> My application is somewhat similar to database workload. It does uses fsync 
>>>> internally also. So what it does is it creates files of random sizes with 
>>>> random contents. It stores the hash of those files in memory. During the 
>>>> test it reads those files back from storage and checks their hashes. 
>>>
>>> How many tasks are running for your test?
>>>
>>> -- 
>>> Jens Axboe
>>>
>>>
>>
>> So there are 128 Concurrent reads/writes happening. Max files written before
>> reads start is 16384 and each file is of size 512KB. Does that answer your
>> question?
> 
> Yes it does, thanks. That's not a crazy amount of tasks or threads.
> 
>> BTW, I still have to test the last patch you send but by looking at the patch 
>> I assumed it will work anyways!
> 
> Thanks for the vote of confidence, I'd appreciate if you would give it a
> whirl. Your workload seems nastier than what I test with, so would be
> great to have someone else test it too.

This is what I have come up with, this actually survives some torture
testing. We do need to have the wait as a loop, since we can't rely on
just being woken from the ->func handler we set. It also handles the
prep token get race.


diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 84507d3e9a98..2442b2b141b8 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -123,16 +123,11 @@ static void rwb_wake_all(struct rq_wb *rwb)
 	}
 }
 
-static void __wbt_done(struct rq_qos *rqos, enum wbt_flags wb_acct)
+static void wbt_rqw_done(struct rq_wb *rwb, struct rq_wait *rqw,
+			 enum wbt_flags wb_acct)
 {
-	struct rq_wb *rwb = RQWB(rqos);
-	struct rq_wait *rqw;
 	int inflight, limit;
 
-	if (!(wb_acct & WBT_TRACKED))
-		return;
-
-	rqw = get_rq_wait(rwb, wb_acct);
 	inflight = atomic_dec_return(&rqw->inflight);
 
 	/*
@@ -166,8 +161,21 @@ static void __wbt_done(struct rq_qos *rqos, enum wbt_flags wb_acct)
 		int diff = limit - inflight;
 
 		if (!inflight || diff >= rwb->wb_background / 2)
-			wake_up(&rqw->wait);
+			wake_up_all(&rqw->wait);
 	}
+
+}
+
+static void __wbt_done(struct rq_qos *rqos, enum wbt_flags wb_acct)
+{
+	struct rq_wb *rwb = RQWB(rqos);
+	struct rq_wait *rqw;
+
+	if (!(wb_acct & WBT_TRACKED))
+		return;
+
+	rqw = get_rq_wait(rwb, wb_acct);
+	wbt_rqw_done(rwb, rqw, wb_acct);
 }
 
 /*
@@ -481,6 +489,33 @@ static inline unsigned int get_limit(struct rq_wb *rwb, unsigned long rw)
 	return limit;
 }
 
+struct wbt_wait_data {
+	struct wait_queue_entry wq;
+	struct task_struct *curr;
+	struct rq_wb *rwb;
+	struct rq_wait *rqw;
+	unsigned long rw;
+	unsigned long flags;
+};
+
+static int wbt_wake_function(struct wait_queue_entry *curr, unsigned int mode,
+			     int wake_flags, void *key)
+{
+	struct wbt_wait_data *data = container_of(curr, struct wbt_wait_data, wq);
+
+	/*
+	 * If we fail to get a budget, return -1 to interrupt the wake up
+	 * loop in __wake_up_common.
+	 */
+	if (!rq_wait_inc_below(data->rqw, get_limit(data->rwb, data->rw)))
+		return -1;
+
+	set_bit(0, &data->flags);
+	wake_up_process(data->curr);
+	list_del_init(&curr->entry);
+	return 1;
+}
+
 /*
  * Block if we will exceed our limit, or if we are currently waiting for
  * the timer to kick off queuing again.
@@ -491,19 +526,42 @@ static void __wbt_wait(struct rq_wb *rwb, enum wbt_flags wb_acct,
 	__acquires(lock)
 {
 	struct rq_wait *rqw = get_rq_wait(rwb, wb_acct);
-	DECLARE_WAITQUEUE(wait, current);
+	struct wbt_wait_data data = {
+		.wq = {
+			.func	= wbt_wake_function,
+			.entry	= LIST_HEAD_INIT(data.wq.entry),
+		},
+		.curr = current,
+		.rwb = rwb,
+		.rqw = rqw,
+		.rw = rw,
+	};
 	bool has_sleeper;
 
 	has_sleeper = wq_has_sleeper(&rqw->wait);
 	if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))
 		return;
 
-	add_wait_queue_exclusive(&rqw->wait, &wait);
+	prepare_to_wait_exclusive(&rqw->wait, &data.wq, TASK_UNINTERRUPTIBLE);
 	do {
-		set_current_state(TASK_UNINTERRUPTIBLE);
+		if (test_bit(0, &data.flags))
+			break;
 
-		if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))
+		WARN_ON_ONCE(list_empty(&data.wq.entry));
+
+		if (!has_sleeper &&
+		    rq_wait_inc_below(rqw, get_limit(rwb, rw))) {
+			finish_wait(&rqw->wait, &data.wq);
+
+			/*
+			 * We raced with wbt_wake_function() getting a token,
+			 * which means we now have two. Put ours and wake
+			 * anyone else potentially waiting for one.
+			 */
+			if (test_bit(0, &data.flags))
+				wbt_rqw_done(rwb, rqw, wb_acct);
 			break;
+		}
 
 		if (lock) {
 			spin_unlock_irq(lock);
@@ -511,11 +569,11 @@ static void __wbt_wait(struct rq_wb *rwb, enum wbt_flags wb_acct,
 			spin_lock_irq(lock);
 		} else
 			io_schedule();
+
 		has_sleeper = false;
 	} while (1);
 
-	__set_current_state(TASK_RUNNING);
-	remove_wait_queue(&rqw->wait, &wait);
+	finish_wait(&rqw->wait, &data.wq);
 }
 
 static inline bool wbt_should_throttle(struct rq_wb *rwb, struct bio *bio)

-- 
Jens Axboe

