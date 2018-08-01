Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C715AC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816AE20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GYtxnYz/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 816AE20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404829AbeHATEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:04:37 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45761 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403856AbeHATEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:04:36 -0400
Received: by mail-pl0-f67.google.com with SMTP id j8-v6so9099727pll.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 10:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=yxDH+vG3K2xURUduqGx8hL5wgeSxZJvgPWA5WlqlVSg=;
        b=GYtxnYz/8S5DUBHSf18O2ZwzeWnAUZq/F+szNCRhPejQFGRJKcXaKJay0ucb/13ccR
         cysKPqNxZ0uRuvpb7R0i2ahPAL2OCKWMq1WCfKJXja5x2L1utGdiEqWKplIZ1WYM6o/5
         oSIhBm8nmM2B57a5L+id7XJefiz5TIX93SkKckcJzF31x7ctxkYX1KU1OobAIvtMUjqV
         mvI7g8JCSf5mkizreOe+E818mPFkTtZ3ICZnguI+S0xMq4ASrHMWtukgz2uOrCIv+7T+
         IOL3NAHOSQqfTbLKVzE5fhaBNc4jjQUMa+LGF3TvEfumwP4YvLb5ljnnVEwxkGa5x0Vq
         8c5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=yxDH+vG3K2xURUduqGx8hL5wgeSxZJvgPWA5WlqlVSg=;
        b=WW0W/3840+J02Z4xaC78zwGX80HHuJFV8MKlxkDXfJAOuAHXPum99EmPpgtB48BF4p
         uBk2BOH05/GbbvP5Yvrmskywi+YJu0rVtsIpT0dwuSNnXTsKGkleQFB/B5lW3Jzwb4xP
         4mbl5TBXbSO4K/ySTQcONKajhp/Rc8yLGSDYPfoSZZJSyk1ebK5l3ioOdDlf3dGkb9uY
         c8hZwjm9t7Y3DZ0BeRnh2iQS2k5Gg84qMvqRCU85KH3Nfc6oDH1lne2Q40hphYwdYDvY
         gyFwrqPOmfeNFck3Jjov8GQ6Xid+tjSq4YLB2I3lGdPmOVX0X6/g4HVG299QWFMamjsT
         KnxQ==
X-Gm-Message-State: AOUpUlGPkEu2m1RGz4XwtYwnXo2G3xG9Rf4PL1VLKDJn4KDJrN5QZgaI
        bQloQ1P/NIAfbZNo+I7CI112aA==
X-Google-Smtp-Source: AAOMgpfds26+8gb7CJZVfiHdUwQbejiDBfYMfKcJuj4SPiDK7t6/+8kw0It2iMWkQ8sLyMaZ3Ab8QA==
X-Received: by 2002:a17:902:7e43:: with SMTP id a3-v6mr25484147pln.151.1533143875548;
        Wed, 01 Aug 2018 10:17:55 -0700 (PDT)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cb:201:549c:c572:5008:d36f])
        by smtp.gmail.com with ESMTPSA id y86-v6sm43450621pfk.84.2018.08.01.10.17.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 10:17:53 -0700 (PDT)
From:   bsegall@google.com
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Ben Segall <bsegall@google.com>,
        Xunlei Pang <xlpang@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched/fair: sync expires_seq in distribute_cfs_runtime()
References: <20180728002409.5781-1-xiyou.wangcong@gmail.com>
        <ef0e1185-51d6-0707-cda4-6f2ea987b651@linux.alibaba.com>
        <CAM_iQpVeK2VQDuahreZC2-L4eEzx0WtD8Bz=oHH68VSAiMqLGQ@mail.gmail.com>
        <fad5ebe6-ec49-c67b-7b4f-78a413723aa8@linux.alibaba.com>
        <xm26ftzz8h0r.fsf@bsegall-linux.svl.corp.google.com>
        <CAM_iQpXGCqo9AAp2kpSKk9sHx0ZRK7JU_c07sWh4vR9kFQ+LxA@mail.gmail.com>
Date:   Wed, 01 Aug 2018 10:17:52 -0700
In-Reply-To: <CAM_iQpXGCqo9AAp2kpSKk9sHx0ZRK7JU_c07sWh4vR9kFQ+LxA@mail.gmail.com>
        (Cong Wang's message of "Tue, 31 Jul 2018 13:55:23 -0700")
Message-ID: <xm267ela80qn.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cong Wang <xiyou.wangcong@gmail.com> writes:

> On Tue, Jul 31, 2018 at 10:13 AM <bsegall@google.com> wrote:
>>
>> Xunlei Pang <xlpang@linux.alibaba.com> writes:
>>
>> > On 7/31/18 1:55 AM, Cong Wang wrote:
>> >> On Sun, Jul 29, 2018 at 10:29 PM Xunlei Pang <xlpang@linux.alibaba.com> wrote:
>> >>>
>> >>> Hi Cong,
>> >>>
>> >>> On 7/28/18 8:24 AM, Cong Wang wrote:
>> >>>> Each time we sync cfs_rq->runtime_expires with cfs_b->runtime_expires,
>> >>>> we should sync its ->expires_seq too. However it is missing
>> >>>> for distribute_cfs_runtime(), especially the slack timer call path.
>> >>>
>> >>> I don't think it's a problem, as expires_seq will get synced in
>> >>> assign_cfs_rq_runtime().
>> >>
>> >> Sure, but there is a small window during which they are not synced.
>> >> Why do you want to wait until the next assign_cfs_rq_runtime() when
>> >> you already know runtime_expires is synced?
>> >>
>> >> Also, expire_cfs_rq_runtime() is called before assign_cfs_rq_runtime()
>> >> inside __account_cfs_rq_runtime(), which means the check of
>> >> cfs_rq->expires_seq is not accurate for unthrottling case if the clock
>> >> drift happens soon enough?
>> >>
>> >
>> > expire_cfs_rq_runtime():
>> >     if (cfs_rq->expires_seq == cfs_b->expires_seq) {
>> >         /* extend local deadline, drift is bounded above by 2 ticks */
>> >         cfs_rq->runtime_expires += TICK_NSEC;
>> >     } else {
>> >         /* global deadline is ahead, expiration has passed */
>> >         cfs_rq->runtime_remaining = 0;
>> >     }
>> >
>> > So if clock drift happens soon, then expires_seq decides the correct
>> > thing we should do: if cfs_b->expires_seq advanced, then clear the stale
>> > cfs_rq->runtime_remaining from the slack timer of the past period, then
>> > assign_cfs_rq_runtime() will refresh them afterwards, otherwise it is a
>> > real clock drift. I am still not getting where the race is?
>
> But expires_seq is supposed to be the same here, after
> distribute_cfs_runtime(), therefore runtime_remaining is not supposed
> to be cleared.
>
> Which part do I misunderstand? expires_seq should not be same here?
> Or you are saying a wrongly clear of runtime_remaning is fine?
>
>
>>
>> Nothing /important/ goes wrong because distribute_cfs_runtime only fills
>> runtime_remaining up to 1, not a real amount.
>
> No, runtime_remaining is updated right before expire_cfs_rq_runtime():
>
> static void __account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec)
> {
>         /* dock delta_exec before expiring quota (as it could span periods) */
>         cfs_rq->runtime_remaining -= delta_exec;
>         expire_cfs_rq_runtime(cfs_rq);
>
> so almost certainly it can't be 1.

Yes, in practice what's actually going to happen is that the
runtime_remaining will be put to 1 by distribute, the cfs_rq will be
unthrottled, and then when it runs it will go negative immediately and
hit the negative check in expires, so expires_seq being wrong will not
actually matter. In addition, the worst thing that will happen if one of
the account_cfs_rq_runtime(cfs_rq, 0) paths is hit first is that it will
lose 1ns of quota, which also doesn't really matter.
