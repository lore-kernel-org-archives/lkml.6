Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD21C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466B72177E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="CpEa7SGj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfA1Wir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 17:38:47 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:34278 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfA1Wir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 17:38:47 -0500
Received: by mail-yb1-f193.google.com with SMTP id k9so6895860ybg.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 14:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A1upOkaWMQBc69Pk9tvw3kG4e6WzymuPYYEdtnmzIMU=;
        b=CpEa7SGjXaMysKQKZkwDjYy6JxxRrPTWy1f74E1kdhaZu2l+D/MQ0y1QrXplR+chMY
         yAhgQd09pbra6kT8vQaXEnhGJioI2ELLrJNBxTmEXPXs2FOQF18kjRah3pEBZul1OBW8
         zT1g35ljfOr2PpPFhhQKQpSbLx/SFwaHe3hRMUzZwjAGxUQUqNkJqux7Df0Uk9Wyr3V+
         BhstShLBYp8JKHofT3n/UuU6+wUV+tTV6NRqymp+UTxmLIuOm+reAgRj38OiDmJdTm+R
         bhmYRIOpaApCgKkYFkrTxWihdQjMRQP60BAnUuZDgX99+5pDiufG6mOvZ2e0DxQyn2TG
         /5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A1upOkaWMQBc69Pk9tvw3kG4e6WzymuPYYEdtnmzIMU=;
        b=rqMLlSO8J42kr+QlPYX2Us5Cx57OLiqyvNtKnrXv06g7tVwlxcFAKnOj7c1EYFAueg
         wVZuAOYslYL/qJdRelv/qTl5ctqT4nr6prvwG3ZFBnS3JMVEfHKwsgtAHs/eXg505Cn+
         tNiW6RvCCnUBVa2ONopTXdOjiEEatQ0Ir0WNrCubK2CbumHonkezxg4whNDcTfLb1fRq
         M9AKDi9f/Du0di8Rhk6JmOs9doUFqKBt5Q8/EL8pViOamvwiw8i5TZdGF/XG1iEURqHF
         C6m8uZYbcTt46iZ7oFliPupKKhmH8r38yUJaCL7Xx5EbEX+sTZxi5A/0kBrVLl4/CfI8
         Xk9A==
X-Gm-Message-State: AJcUukfN4cmqhXtxZ5y6J/FqX1Tf49VIlUtP96nyngQlylrTrCp8msKY
        YLTbAgYYneaIKPLe0IMjehEB/hSE+Ms=
X-Google-Smtp-Source: ALg8bN6A2FRGILPFRkMCSz7uY9womFBt0jKDB4h8RuqCR5GNcixwW65d56JrrjkIEPR7S/TM+DtvDQ==
X-Received: by 2002:a25:3805:: with SMTP id f5mr22747846yba.361.1548715126072;
        Mon, 28 Jan 2019 14:38:46 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::5:42c8])
        by smtp.gmail.com with ESMTPSA id f10sm19602768ywb.26.2019.01.28.14.38.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 14:38:44 -0800 (PST)
Date:   Mon, 28 Jan 2019 17:38:43 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] psi: fix aggregation idle shut-off
Message-ID: <20190128223843.GA2593@cmpxchg.org>
References: <20190116193501.1910-1-hannes@cmpxchg.org>
 <20190128140336.25854cb97c25924f4bfc26c7@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128140336.25854cb97c25924f4bfc26c7@linux-foundation.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 02:03:36PM -0800, Andrew Morton wrote:
> On Wed, 16 Jan 2019 14:35:01 -0500 Johannes Weiner <hannes@cmpxchg.org> wrote:
> > +/**
> > + * wq_worker_last_func - retrieve worker's last work function
> > + *
> > + * Determine the last function a worker executed. This is called from
> > + * the scheduler to get a worker's last known identity.
> > + *
> > + * CONTEXT:
> > + * spin_lock_irq(rq->lock)
> > + *
> > + * Return:
> > + * The last work function %current executed as a worker, NULL if it
> > + * hasn't executed any work yet.
> > + */
> > +work_func_t wq_worker_last_func(struct task_struct *task)
> > +{
> > +	struct worker *worker = kthread_data(task);
> > +
> > +	return worker->last_func;
> > +}
> 
> The semantics are troublesome.  What guarantees that worker->last_func
> won't change under the caller's feet?  The caller should hold some lock
> (presumably worker->pool->lock) in order to stabilize the
> wq_worker_last_func() return value?
> 
> Also, the comment isn't really true - this is called from PSI, which is
> hardly "the scheduler"?

psi isn't scheduler core, but it only works from a scheduler context.

The psi task change hook already requires being called under the
rq->lock while the task in question cannot change its scheduling
state, to record it and start the clock on the new state.

That same context ensures wq_worker_last_func() is safe. We're using
it from where the worker is inside the scheduler and going to *sleep*
(not just preemption), so couldn't possibly be changing last_func.

So IMO it makes sense to keep this last_func thing a part of the
private API between scheduler context and the workqueue code.
