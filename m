Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2ED9C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858382075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EMCLb5kS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858382075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936026AbeFRSos (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 14:44:48 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:32942 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935744AbeFRSoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 14:44:46 -0400
Received: by mail-pl0-f65.google.com with SMTP id 6-v6so8963842plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 11:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qclJu/pTz22JNcqCiGeWjj6iuINZnY6hTV8iHyLrdbI=;
        b=EMCLb5kSN4Pu6sH+5JMGS3aUvWsqYShWw+0bvtV+dKshHPy84jpZpRLIVVT+Q5v/2A
         MHQSIdY9s45qglIUz0rIpjm1Fw6hHwPHwjjlY4eGIZn9qpluKfAM5U6fLGeEchgpO17e
         MQebkDxGatbvQVjToR6qQswoGh1torkwJCHbyInzsY133IjN4fIizL+1zBD8hjDaH3NM
         B2Envt6YYqMZTw3Ca/j/QnCIXYllt5+geSH2IzkYPBALfmpa0srP8oPgYBPZDWyVliRK
         LOCgoVOO99qG5R559Evl5u5OkghDinAa0qAD0MPO5KmtA+JS+2FjuVDdhsSMvoqb8fJi
         McIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=qclJu/pTz22JNcqCiGeWjj6iuINZnY6hTV8iHyLrdbI=;
        b=g/Pk4CvGfbthd78tMOfM3dY2deMxVYiCFfvShxyV5PTuzE9VmK7qTSrrQXc4LX64xu
         8zCk2bfjp0zs+O3fSACzbIU2UfUPn3uu5X4Bn225WM1ptmUshYd16WHB1bgzUXJDUQJx
         KyAVOhtzTBOckaOjLMq298lFC4dBOMcdOgt3JNyHcIh3N3TESUuAt5X/tH1S5CfzCDlx
         YmQq0exfENbfvPu5ueaSAi2Qlcacfc/89fScpeOVcGJlZfctwO/Y2J0e8btDe3dQ429j
         Xfde8UpSK8l4J01N0PubgIjAB5grm0JEtij0bGr/CcY5TZI4g8Gxi25fmir4/eKbfxp/
         jRFg==
X-Gm-Message-State: APt69E1g4JB6wrw/p98oonShhuS+6/fEBTw0XBgJSyGy6nVu6DGlj7rv
        5cwxteYQHJmc1DgGTB9DSTmtEAAs5ho=
X-Google-Smtp-Source: ADUXVKJy2yjop7JEwIhqERtHFZ/ZRWFDZEtb8zOH/v1BrJHxL905mlgokqNNK+Jc+9p+hw/6EZ/1XQ==
X-Received: by 2002:a17:902:2884:: with SMTP id f4-v6mr15335099plb.204.1529347485459;
        Mon, 18 Jun 2018 11:44:45 -0700 (PDT)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cb:201:549c:c572:5008:d36f])
        by smtp.gmail.com with ESMTPSA id n70-v6sm33907689pfh.140.2018.06.18.11.44.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 11:44:43 -0700 (PDT)
From:   bsegall@google.com
To:     Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ben Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/fair: Fix bandwidth timer clock drift condition
References: <20180618091618.21480-1-xlpang@linux.alibaba.com>
Date:   Mon, 18 Jun 2018 11:44:42 -0700
In-Reply-To: <20180618091618.21480-1-xlpang@linux.alibaba.com> (Xunlei Pang's
        message of "Mon, 18 Jun 2018 17:16:17 +0800")
Message-ID: <xm26sh5korxh.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xunlei Pang <xlpang@linux.alibaba.com> writes:

> The current condition to judge clock drift in expire_cfs_rq_runtime()
> is wrong, the two runtime_expires are actually the same when clock
> drift happens, so this condtion can never hit. The orginal design was
> correctly done by commit a9cf55b28610 ("sched: Expire invalid runtime"),
> but was changed to be the current one due to its locking issue.
>
> This patch introduces another way, it adds a new field in both structure
> cfs_rq and cfs_bandwidth to record the expiration update sequence, and
> use them to figure out if clock drift happens(true if they equal).

It might just be simplest to revert the comparison change - if we read a
torn value, the worst that happens is we extend incorrectly, and that
is exactly what happens if we just read the old value.

An extra int isn't exactly the worst thing though, so whichever.

>
> This fix is also needed by the following patch.
>
> Fixes: 51f2176d74ac ("sched/fair: Fix unlocked reads of some cfs_b->quota/period")
> Cc: Ben Segall <bsegall@google.com>
> Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
> ---
>  kernel/sched/fair.c  | 14 ++++++++------
>  kernel/sched/sched.h |  6 ++++--
>  2 files changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e497c05aab7f..9f384264e832 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4590,6 +4590,7 @@ void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
>  	now = sched_clock_cpu(smp_processor_id());
>  	cfs_b->runtime = cfs_b->quota;
>  	cfs_b->runtime_expires = now + ktime_to_ns(cfs_b->period);
> +	cfs_b->expires_seq++;
>  }
>  
>  static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
> @@ -4612,6 +4613,7 @@ static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>  	struct task_group *tg = cfs_rq->tg;
>  	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(tg);
>  	u64 amount = 0, min_amount, expires;
> +	int expires_seq;
>  
>  	/* note: this is a positive sum as runtime_remaining <= 0 */
>  	min_amount = sched_cfs_bandwidth_slice() - cfs_rq->runtime_remaining;
> @@ -4629,6 +4631,7 @@ static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>  		}
>  	}
>  	expires = cfs_b->runtime_expires;
> +	expires_seq = cfs_b->expires_seq;
>  	raw_spin_unlock(&cfs_b->lock);
>  
>  	cfs_rq->runtime_remaining += amount;
> @@ -4637,8 +4640,10 @@ static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>  	 * spread between our sched_clock and the one on which runtime was
>  	 * issued.
>  	 */
> -	if ((s64)(expires - cfs_rq->runtime_expires) > 0)
> +	if ((s64)(expires - cfs_rq->runtime_expires) > 0) {
>  		cfs_rq->runtime_expires = expires;
> +		cfs_rq->expires_seq = expires_seq;
> +	}
>  
>  	return cfs_rq->runtime_remaining > 0;
>  }
> @@ -4664,12 +4669,9 @@ static void expire_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>  	 * has not truly expired.
>  	 *
>  	 * Fortunately we can check determine whether this the case by checking
> -	 * whether the global deadline has advanced. It is valid to compare
> -	 * cfs_b->runtime_expires without any locks since we only care about
> -	 * exact equality, so a partial write will still work.
> +	 * whether the global deadline(cfs_b->expires_seq) has advanced.
>  	 */
> -
> -	if (cfs_rq->runtime_expires != cfs_b->runtime_expires) {
> +	if (cfs_rq->expires_seq == cfs_b->expires_seq) {
>  		/* extend local deadline, drift is bounded above by 2 ticks */
>  		cfs_rq->runtime_expires += TICK_NSEC;
>  	} else {
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 6601baf2361c..e977e04f8daf 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -334,9 +334,10 @@ struct cfs_bandwidth {
>  	u64			runtime;
>  	s64			hierarchical_quota;
>  	u64			runtime_expires;
> +	int			expires_seq;
>  
> -	int			idle;
> -	int			period_active;
> +	short			idle;
> +	short			period_active;
>  	struct hrtimer		period_timer;
>  	struct hrtimer		slack_timer;
>  	struct list_head	throttled_cfs_rq;
> @@ -551,6 +552,7 @@ struct cfs_rq {
>  
>  #ifdef CONFIG_CFS_BANDWIDTH
>  	int			runtime_enabled;
> +	int			expires_seq;
>  	u64			runtime_expires;
>  	s64			runtime_remaining;
