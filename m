Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1D1C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A7420836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AQbdpZtt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A7420836
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936133AbeFRS6f (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 14:58:35 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46161 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935828AbeFRS6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 14:58:34 -0400
Received: by mail-pl0-f65.google.com with SMTP id 30-v6so9508788pld.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 11:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lnRTBJpovA7QwXK7hp8JqymvNFz/yn4lpYMVqSF/Npg=;
        b=AQbdpZttr6lVUelGCk+hG5txqJGgldtwHzgUKeahCMEUJoNRwQTvloRElY9EfvH0H/
         IiBzlwNewfUtyAgYydj0nvzyE3YmRvAYMSGyxH3EojmDosbK7DhmpoDf5EL55jn0+aWD
         mPa5jsD5bImfLUc/f8f7E9rmN1oZ0v/09OtYP+7uOgbyKZG2v37gvpDgxN4bxTywxue2
         x7R5aCZ9FV2Y2aBhkZF72IEoSjhzCxeitz2F1w809bGqaUiRKTizSvk9XurEvuxbFJZO
         lI0uTUi1FXutFXRMY/yHBlLAuT7n0c3eKpdGlo7qLXl1wufYPJdIhHe2AOl29Wnh46/8
         8/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=lnRTBJpovA7QwXK7hp8JqymvNFz/yn4lpYMVqSF/Npg=;
        b=X7lCnLDq9EPit993SMGLpyAGAH1vITYE7Tx0KP1S5DUi0yGCkgsjeURIn1TvW9fb81
         R/UC9z8NaIBfJFqQsRHzOkf504jZqZ935D7A3iMr1GfpUwIgu8wNc6K/5DXNuy1C8bQ/
         pqQicQdzD4yIcevwwn4ZTSf7b1jOS8rwm0fNWgYoPw4Ch1iPfDv+2dTsp/rTdp5oePCz
         SLxNTyTWJdfTHSQGYXsC9cyf0hPvDJol0/PgJRjEihEPzV7x39x0Sg9GXBwR2RbHVIc4
         uixYLsSYEc2kIGu1GT0jkoYzMzLtXGwZWqX5EfdvsB6q4YwWujGHFso6j91BHR7Bo8h2
         TgSw==
X-Gm-Message-State: APt69E0JeyfVroVspWVQSP6q8nN1Cdpvg/83uVuwpAK613vpVtHF5x+5
        e6vGaahRwH3JifDzIMPhV9Bnkqn6qwg=
X-Google-Smtp-Source: ADUXVKKGGGxXp4A9QD4H4iWxmt6DQRaVgXh8V4GiNlkUtK7GA/zbdr2UhBd8jSx1pthzJN4Mhzq+tQ==
X-Received: by 2002:a17:902:8306:: with SMTP id bd6-v6mr15466628plb.120.1529348313035;
        Mon, 18 Jun 2018 11:58:33 -0700 (PDT)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cb:201:549c:c572:5008:d36f])
        by smtp.gmail.com with ESMTPSA id w7-v6sm21644692pgr.82.2018.06.18.11.58.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 11:58:31 -0700 (PDT)
From:   bsegall@google.com
To:     Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ben Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/fair: Advance global expiration when period timer is restarted
References: <20180618091657.21939-1-xlpang@linux.alibaba.com>
Date:   Mon, 18 Jun 2018 11:58:30 -0700
In-Reply-To: <20180618091657.21939-1-xlpang@linux.alibaba.com> (Xunlei Pang's
        message of "Mon, 18 Jun 2018 17:16:57 +0800")
Message-ID: <xm26o9g7q5ux.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xunlei Pang <xlpang@linux.alibaba.com> writes:

> I noticed the group frequently got throttled even it consumed
> low cpu usage, this caused some jitters on the response time
> to some of our business containers enabling cpu quota.
>
> It's very easy to reproduce:
> mkdir /sys/fs/cgroup/cpu/test
> cd /sys/fs/cgroup/cpu/test
> echo 100000 > cpu.cfs_quota_us
> echo $$ > tasks
> then repeat:
> cat cpu.stat |grep nr_throttled  // nr_throttled will increase
>
> After some analysis, we found that cfs_rq::runtime_remaining will
> be cleared by expire_cfs_rq_runtime() due to two equal but stale
> "cfs_{b|q}->runtime_expires" after period timer is re-armed.

If this is after the first patch, then this is no longer what should
happen, and instead it would incorrectly /keep/ old local cfs_rq
runtime, and not __refill global runtime until the period.


>
> The global expiration should be advanced accordingly when the
> bandwidth period timer is restarted.
>
> Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
> ---
>  kernel/sched/fair.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9f384264e832..bb006e671609 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5204,13 +5204,18 @@ static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>  
>  void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
>  {
> +	u64 overrun;
> +
>  	lockdep_assert_held(&cfs_b->lock);
>  
> -	if (!cfs_b->period_active) {
> -		cfs_b->period_active = 1;
> -		hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
> -		hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
> -	}
> +	if (cfs_b->period_active)
> +		return;
> +
> +	cfs_b->period_active = 1;
> +	overrun = hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
> +	cfs_b->runtime_expires += (overrun + 1) * ktime_to_ns(cfs_b->period);

I think we actually want if (overrun) __refill_cfs_bandwidth_runtime(),
much like tg_set_cfs_bandwidth

> +	cfs_b->expires_seq++;
> +	hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
>  }
>  
>  static void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
