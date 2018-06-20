Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31564C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C490320836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pqtN7+qO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C490320836
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932571AbeFTRBz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:01:55 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33462 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932153AbeFTRBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:01:54 -0400
Received: by mail-pg0-f67.google.com with SMTP id e11-v6so103967pgq.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 10:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gTp3IhUXy9v4Rk8aqbfUQg9FWVoo26fseoMMk09oBDY=;
        b=pqtN7+qOYyXujN0t6tUpLX8owohg/nOT6GWsnoILVAmkbBVdsIt/QN533G1xwvambQ
         yVSvtsrc/i1BQA8z58IQL9ObykhHDKS74XZul15jHiiAhZml6IjP5h3zk7I/YkmKcmS3
         YOwWrMDHNWFZKhTB1OZEFLKrIjoLkoZ/nSMUgmwGXEDyBLwV6ywTsVrsTgoSyB1l1k0g
         /NxjMvVHThXmjX0jIeZ2AKu5jS04Bd98st60usEM4hVPeCvhj/B4LXA2gdQxb6jBi1q4
         ki49P+tYL1F+w0IHHPvhQWblXTF8SOyc7Hur7qqBu8+JVHzraZsVD+v1pILFXDpnoR5j
         GTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=gTp3IhUXy9v4Rk8aqbfUQg9FWVoo26fseoMMk09oBDY=;
        b=PzFGEeIZcy3QjPv6CgsW5Pt+kP240pfXnIi2jGQRwp1AiSuGg62SPB64wLTBudocpG
         xrAgN9Ih7CRqWatlbvMOVhRYzQNOseFfXIuwmU9j49i9QU3F44YIYiRe4xDeakyiW3cP
         xUuCRHqtHiVupvjAJqmhYPNsjjgl549vbwL7b0XtJFN1OeBlFw+HOCKqiA9ZepG2RxOM
         8zYMbKB5YSAmcmVUaAnWtd8fZSowWyBM4SkOFek0MmvvRz8C9u7abR/41meId08NUPjY
         CBtjV2+2F+ZktXCXS7xfvu9hcW+J3zp26yQtf0SVrEEcnqyigumTF6sQ+kbAHyvz3Gly
         zMjg==
X-Gm-Message-State: APt69E1llwJcH06YbMBAAQP4XDgIMU/jtJtx35FqJK1Dl3OxdwI52EF9
        VAJ4t+spr9eIiZlmeA944uWiusDkm0Q=
X-Google-Smtp-Source: ADUXVKLLxkHt4XmDuZblcVMf5EBXsjOgPG2T61FeesIVCfezst4PFPRZrf/iAy1NIuI5HJWFcKBpug==
X-Received: by 2002:a63:700e:: with SMTP id l14-v6mr19516532pgc.206.1529514111339;
        Wed, 20 Jun 2018 10:01:51 -0700 (PDT)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cb:201:549c:c572:5008:d36f])
        by smtp.gmail.com with ESMTPSA id b15-v6sm3642389pgu.54.2018.06.20.10.01.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 10:01:49 -0700 (PDT)
From:   bsegall@google.com
To:     Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ben Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] sched/fair: Fix bandwidth timer clock drift condition
References: <20180620101834.24455-1-xlpang@linux.alibaba.com>
Date:   Wed, 20 Jun 2018 10:01:48 -0700
In-Reply-To: <20180620101834.24455-1-xlpang@linux.alibaba.com> (Xunlei Pang's
        message of "Wed, 20 Jun 2018 18:18:33 +0800")
Message-ID: <xm26fu1hpf2b.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xunlei Pang <xlpang@linux.alibaba.com> writes:

> I noticed the group constantly got throttled even it consumed
> low cpu usage, this caused some jitters on the response time
> to some of our business containers enabling cpu quota.
>
> It's very simple to reproduce:
>   mkdir /sys/fs/cgroup/cpu/test
>   cd /sys/fs/cgroup/cpu/test
>   echo 100000 > cpu.cfs_quota_us
>   echo $$ > tasks
> then repeat:
>   cat cpu.stat |grep nr_throttled  // nr_throttled will increase
>
> After some analysis, we found that cfs_rq::runtime_remaining will
> be cleared by expire_cfs_rq_runtime() due to two equal but stale
> "cfs_{b|q}->runtime_expires" after period timer is re-armed.
>
> The current condition to judge clock drift in expire_cfs_rq_runtime()
> is wrong, the two runtime_expires are actually the same when clock
> drift happens, so this condtion can never hit. The orginal design was
> correctly done by commit a9cf55b28610 ("sched: Expire invalid runtime"),
> but was changed to be the current one due to its locking issue.
>
> This patch introduces another way, it adds a new field in both structures
> cfs_rq and cfs_bandwidth to record the expiration update sequence, and
> use them to figure out if clock drift happens(true if they equal).
>
> Fixes: 51f2176d74ac ("sched/fair: Fix unlocked reads of some cfs_b->quota/period")
> Cc: Ben Segall <bsegall@google.com>

Reviewed-By: Ben Segall <bsegall@google.com>

> Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
> ---
>  kernel/sched/fair.c  | 14 ++++++++------
>  kernel/sched/sched.h |  6 ++++--
>  2 files changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e497c05aab7f..e6bb68d52962 100644
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
> @@ -4628,6 +4630,7 @@ static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>  			cfs_b->idle = 0;
>  		}
>  	}
> +	expires_seq = cfs_b->expires_seq;
>  	expires = cfs_b->runtime_expires;
>  	raw_spin_unlock(&cfs_b->lock);
>  
> @@ -4637,8 +4640,10 @@ static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>  	 * spread between our sched_clock and the one on which runtime was
>  	 * issued.
>  	 */
> -	if ((s64)(expires - cfs_rq->runtime_expires) > 0)
> +	if (cfs_rq->expires_seq != expires_seq) {
> +		cfs_rq->expires_seq = expires_seq;
>  		cfs_rq->runtime_expires = expires;
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
