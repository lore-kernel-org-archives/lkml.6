Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42467C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA53920658
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JouH+mZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA53920658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbeHXUTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 16:19:52 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:53758 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeHXUTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 16:19:52 -0400
Received: by mail-it0-f65.google.com with SMTP id k188-v6so2948762itk.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 09:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mQzpNYc8zDNJff8fBN0aJvjxf2fNbN6T0t68juMZGQQ=;
        b=JouH+mZuu4SPAd/5QpGRMTTnah/yD9n37sYSdSe6z1Pzq6GPNWkb1aio9gZe8ZwM/P
         A93DNEKaRVafdvXsQAGeT1zslXxD64z9eS7vVo5PfEszClv//TONby9YXC8ro9i2+h7h
         XPzpWPsvLBKn+Z1Q8L2y1jaZ/Nx2hPOLAkOADjE5IDuHQHTLzle9jAC3qmxfh6L5qDfN
         CUpqu9myEh1mWze90tjMMJOPgABSPtqH3cQxyxzpn2Ca2VA6FRx44sjxHXe81SM4haEh
         fxVxtOJaPJIXSMhALAMxP0WjMD4OWmr6sH6qansQUHIFo5PLPzvNgZbHs7z0ep7hmt8k
         ynbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mQzpNYc8zDNJff8fBN0aJvjxf2fNbN6T0t68juMZGQQ=;
        b=QP8sgOW3clkH5lP9GK9PtjRMtYnlEv/HB6hk5J86XChQv4KTEF1Byx4AlfZvfLO5Lx
         ob0kdGInRv4ioUTYMN7Q5V4yxQzrJfE3exaj0rXWoMcPTv/Hfix7OcrEN0RBlyC2ggCR
         YK154mlefeb3W0NCp5QNIPrIYNQiNcpBIZwmEUQxwmKfxPU3GSWzQMlsDTVy6w+Dv308
         QDVlaAaUb0Tc3VwT4D96Wb/eVAnrV4eUmcXVt/TNW7tWEljSGT1QoyqSIQrGsjKbYZp9
         2FI28AUr6as8bxuT6pGJTs6IkWeYlorN8QWQy/BXYVqnjWLaXkI5RyX1NSaUwGeRdfAd
         14sg==
X-Gm-Message-State: APzg51Cvzf8QLcYg9470OTEWAWFKkIsfZaAqi0fHu/FFM2bSLpP4V3oX
        5F9Bm4UbdgjRuviJJCYVGLwx5QuxqnM=
X-Google-Smtp-Source: ANB0Vda4YcKgY5Qs9UijJsgjEKzbfBEHS5eUJEQSYc2t/tX2g6g4zhq2OhhTT1v+DBs2bm/qY9nTPQ==
X-Received: by 2002:a24:2911:: with SMTP id p17-v6mr2003804itp.134.1535129064652;
        Fri, 24 Aug 2018 09:44:24 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id a11-v6sm745434ita.21.2018.08.24.09.44.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 09:44:23 -0700 (PDT)
Subject: Re: [PATCH] blk-wbt: get back the missed wakeup from __wbt_done
To:     "van der Linden, Frank" <fllinden@amazon.com>,
        "jianchao.wang" <jianchao.w.wang@oracle.com>,
        Anchal Agarwal <anchalag@amzn.com>
Cc:     "mlinux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1535029718-17259-1-git-send-email-jianchao.w.wang@oracle.com>
 <bd84ff08-b75a-0a2f-6b37-07a104452bff@kernel.dk>
 <da9458c632cb4c4695660664bf7c3fb3@EX13D13UWB002.ant.amazon.com>
 <20180823210144.GB5624@kaos-source-ops-60001.pdx1.amazon.com>
 <3eaa20ce-0599-c405-d979-87d91ea331d2@kernel.dk>
 <969389e7-b1bc-0559-6cc9-9461b034a24f@kernel.dk>
 <8af76974-08b2-f4ef-91b9-7bd42291b8d9@oracle.com>
 <347a7a07dc5f4122a37afd703ef2a3d0@EX13D13UWB002.ant.amazon.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c2e96743-11a1-3e7e-0563-9789c5443f41@kernel.dk>
Date:   Fri, 24 Aug 2018 10:44:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <347a7a07dc5f4122a37afd703ef2a3d0@EX13D13UWB002.ant.amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/18 10:40 AM, van der Linden, Frank wrote:
> On 8/23/18 10:56 PM, jianchao.wang wrote:
>>
>> On 08/24/2018 07:14 AM, Jens Axboe wrote:
>>> On 8/23/18 5:03 PM, Jens Axboe wrote:
>>>>> Hi Jens, This patch looks much cleaner for sure as Frank pointed out
>>>>> too. Basically this looks similar to wake_up_nr only making sure that
>>>>> those woken up requests won't get reordered. This does solves the
>>>>> thundering herd issue. However, I tested the patch against my
>>>>> application and lock contention numbers rose to around 10 times from
>>>>> what I had from your last 3 patches.  Again this did add to drop in
>>>>> of total files read by 0.12% and rate at which they were read by
>>>>> 0.02% but this is not a very significant drop. Is lock contention
>>>>> worth the tradeoff?  I also added missing
>>>>> __set_current_state(TASK_RUNNING) to the patch for testing.
>>>> Can you try this variant? I don't think we need a
>>>> __set_current_state() after io_schedule(), should be fine as-is.
>>>>
>>>> I'm not surprised this will raise contention a bit, since we're now
>>>> waking N tasks potentially, if N can queue. With the initial change,
>>>> we'd always just wake one.  That is arguably incorrect. You say it's
>>>> 10 times higher contention, how does that compare to before your
>>>> patch?
>>>>
>>>> Is it possible to run something that looks like your workload?
>>> Additionally, is the contention you are seeing the wait queue, or the
>>> atomic counter? When you say lock contention, I'm inclined to think it's
>>> the rqw->wait.lock.
>>>
>> I guess the increased lock contend is due to:
>> when the wake up is ongoing with wait head lock is held, there is still waiter
>> on wait queue, and __wbt_wait will go to wait and try to require the wait head lock.
>> This is necessary to keep the order on the rqw->wait queue.
>>
>> The attachment does following thing to try to avoid the scenario above.
>> "
>> Introduce wait queue rqw->delayed. Try to lock rqw->wait.lock firstly, if fails, add
>> the waiter on rqw->delayed. __wbt_done will pick the waiters on rqw->delayed up and
>> queue them on the tail of rqw->wait before it do wake up operation.
>> "
>>
> Hmm, I am not sure about this one. Sure, it will reduce lock contention
> for the waitq lock, but it also introduces more complexity.
> 
> It's expected that there will be more contention if the waitq lock is
> held longer. That's the tradeoff for waking up more throttled tasks and
> making progress faster. Is this added complexity worth the gains? My
> first inclination would be to say no.
> 
> If lock contention on a wait queue is an issue, then either the wait
> queue mechanism itself should be improved, or the code that uses the
> wait queue should be fixed. Also, the contention is still a lot lower
> than it used to be.

Hard to disagree with that. If you look at the blk-mq tagging code, it
spreads out the wait queues exactly because of this.

-- 
Jens Axboe

