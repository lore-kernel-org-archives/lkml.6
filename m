Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6C5C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277292743D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="x7EXYNzG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277292743D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965995AbeF1N0x (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:26:53 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:39352 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964921AbeF1N0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 09:26:51 -0400
Received: by mail-qk0-f194.google.com with SMTP id f3-v6so2932524qkd.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 06:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u03ZkRe8Mnpsyj14RVd3xZTzCqY+k0jjh5X27jQjsDc=;
        b=x7EXYNzGV0vTfIyZgyjmw274iGVd/fdRo9MvfpDb8Q3Yy9KQRpIzw+LOvUxJpaakdO
         aH4ugelK+aJeyggiRRBnYqRnXEhaAb2PBpEwt5h4pGD4Wgymt4w8wLLTK4AQDNTTMKBo
         AbH4wOSqMNu3GgLLjW7IQrs4TqkSj1zap0Phy66UI9SR4lNiUtFgK3mE42bdxLW5m52l
         solnKnZ9lev+b54ucV8Mo9LaLifr9GhmmKjlAU6rHwhaYVIlOodwf+LLT3EyweJEyuro
         hBaj9g7C8kdeNNrQ91V1sDiuvxFdhLoOlzQ68ZTCGNz5yAv6shrmzYfwesNU88xg9kdz
         fClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u03ZkRe8Mnpsyj14RVd3xZTzCqY+k0jjh5X27jQjsDc=;
        b=suXT2eWa7cWcn1j9y2IJhxdCfwwH/B6YWIAoWXFvBZzCHX/mjUwA0wj7cmbR1iEGcp
         aI9nlLhw+CfILqCYuRIpxYWntlikkUigKfBqDisuLPbGI/zPpsS0MrrvF9KyWRMRZWJT
         bqWsANJvxQPEwoUJYGv8bftmFWOsv+vdBeSz2xVxkihBy6rPWz8q1mBMKczzClv2gPxH
         SZ4lvDD0zDLx0Fbuf0EhaDqSbQV729aXTV0vswsDkQzbxEdsz71GZ18LcaocYf3iYf1I
         5stgjiL/0TfW3YU4hePbF/l6fy6U17lF9arSYmXwBNQaAk/7B3QGrqeclmxIL+PvWjQO
         ePBA==
X-Gm-Message-State: APt69E2TqHLje1Bdoj+jAN3pLDMxsNLdtxyj/86pGiNVI2UUobJxcGIk
        4DkxP/KH60XMHhkmmKtFWw5MmQ==
X-Google-Smtp-Source: AAOMgpf62L7Ls9NvOGseIXwdgJPPkZsI/e747smUYIkGXr7+17Ucg9ChnVfOPlbCD/FY9IHutTMRDA==
X-Received: by 2002:a37:b91:: with SMTP id 139-v6mr8875422qkl.429.1530192410995;
        Thu, 28 Jun 2018 06:26:50 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id f9-v6sm4330111qkb.43.2018.06.28.06.26.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 06:26:50 -0700 (PDT)
Date:   Thu, 28 Jun 2018 09:26:49 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
        kernel-team@fb.com, akpm@linux-foundation.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org, Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH 12/15] block: introduce blk-iolatency io controller
Message-ID: <20180628132648.wytk67ascubysqun@destiny>
References: <20180625151243.2132-1-josef@toxicpanda.com>
 <20180625151243.2132-13-josef@toxicpanda.com>
 <05a581ed-8f21-9d89-a813-a03d802d3469@kernel.dk>
 <20180627192046.ieqncfl6ioy37mof@destiny>
 <784f0862-0441-5ed2-1beb-3effa82b3438@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <784f0862-0441-5ed2-1beb-3effa82b3438@kernel.dk>
User-Agent: NeoMutt/20170714 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 01:24:55PM -0600, Jens Axboe wrote:
> On 6/27/18 1:20 PM, Josef Bacik wrote:
> > On Wed, Jun 27, 2018 at 01:06:31PM -0600, Jens Axboe wrote:
> >> On 6/25/18 9:12 AM, Josef Bacik wrote:
> >>> +static void __blkcg_iolatency_throttle(struct rq_qos *rqos,
> >>> +				       struct iolatency_grp *iolat,
> >>> +				       spinlock_t *lock, bool issue_as_root,
> >>> +				       bool use_memdelay)
> >>> +	__releases(lock)
> >>> +	__acquires(lock)
> >>> +{
> >>> +	struct rq_wait *rqw = &iolat->rq_wait;
> >>> +	unsigned use_delay = atomic_read(&lat_to_blkg(iolat)->use_delay);
> >>> +	DEFINE_WAIT(wait);
> >>> +	bool first_block = true;
> >>> +
> >>> +	if (use_delay)
> >>> +		blkcg_schedule_throttle(rqos->q, use_memdelay);
> >>> +
> >>> +	/*
> >>> +	 * To avoid priority inversions we want to just take a slot if we are
> >>> +	 * issuing as root.  If we're being killed off there's no point in
> >>> +	 * delaying things, we may have been killed by OOM so throttling may
> >>> +	 * make recovery take even longer, so just let the IO's through so the
> >>> +	 * task can go away.
> >>> +	 */
> >>> +	if (issue_as_root || fatal_signal_pending(current)) {
> >>> +		atomic_inc(&rqw->inflight);
> >>> +		return;
> >>> +	}
> >>> +
> >>> +	if (iolatency_may_queue(iolat, &wait, first_block))
> >>> +		return;
> >>> +
> >>> +	do {
> >>> +		prepare_to_wait_exclusive(&rqw->wait, &wait,
> >>> +					  TASK_UNINTERRUPTIBLE);
> >>> +
> >>> +		iolatency_may_queue(iolat, &wait, first_block);
> >>> +		first_block = false;
> >>> +
> >>> +		if (lock) {
> >>> +			spin_unlock_irq(lock);
> >>> +			io_schedule();
> >>> +			spin_lock_irq(lock);
> >>> +		} else {
> >>> +			io_schedule();
> >>> +		}
> >>> +	} while (1);
> >>
> >> So how does this wait loop ever exit?
> >>
> > 
> > Sigh, I cleaned this up from what we're using in production and did it poorly,
> > I'll fix it up.  Thanks,
> 
> Also may want to consider NOT using exclusive add if first_block == false, as
> you'll end up at the tail of the waitqueue after sleeping and being denied.
> This is similar to the wbt change I posted last week.
> 

This isn't how it works though.  You aren't removed from the list until you do
finish_wait(), so you don't lose your spot on the list.  We only get added to
the end of the list if

        if (list_empty(&wq_entry->entry))

otherwise nothing changes.

> For may_queue(), your wq_has_sleeper() is also going to be always true
> inside your loop, since you call it after doing the prepare_to_wait()
> which adds you to the queue. That's why wbt does the list checks, but
> it'd be nicer to have a wq_has_other_sleepers() for that. So your
> first iolatency_may_queue() inside the loop will always be false.

Ah yeah that's a good point, I'll go back to using what you had to catch that
case.  Thanks,

Josef
