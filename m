Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679CCC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1323825DDC
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="gLV2i8Pi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1323825DDC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754885AbeF0TUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 15:20:52 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:43511 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754324AbeF0TUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 15:20:50 -0400
Received: by mail-qk0-f196.google.com with SMTP id z74-v6so1668099qkb.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 12:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fE5lJSNUjKnVYyY1naFjNnPQnB/sH6zjDe0xubKK9gU=;
        b=gLV2i8Piz1bsrLlxJawMdKBRJdGJwhpxTMSXzljm+nQGZzUr7zrh6xs6cSkIW0nGf9
         AloU2yYI1e7XgcJMB/2ZzxACxZPd14Kwd6Y9EfizGJtnX8skxpVcCSSRZJYxUGok267j
         rkYDExvF8/rEbdfIIxsMKGkK/HQGW0zcRlEwoByiiKQL0e1Lj++z3tNIU5M0/fy4Y3ed
         4AkQY83PRNCvCP7ztnxCGYqoyxCRBJAelTVfH8vDZK0OFU3SZim0+jrZe0+fodAizaz3
         XgsBN9HOtRwpBa9rRjU4PQ/uMQNkFAjXBXiigfAdtPS3jemwpU5aeXfYgWLlbojpDLY3
         08fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fE5lJSNUjKnVYyY1naFjNnPQnB/sH6zjDe0xubKK9gU=;
        b=RFewyG2awAGbbWLBjR2/JEYGu4Ky7oM6w23nTxG/eE8IRIROGUnSiKpcTjfXvDfiis
         oWof9CAINOO8K8M4v4aOb3052suFPFT758XqDx2UrYlv1CZPyFg4wfa8ceDNCQlheXXz
         K9noGSSFDyVXeo2YZHxFBeYoqbEibBB1rcp8UwnP4cGIk+wQwZY/IklpDfIYXoUnZn4A
         JZxfIlx3n/eP9u0tCa51D7RSn48moV+qPsWD+v3TFliD1dwbI6bwgFl88bbC6bZwmPD5
         huRiWxYw1hHn1MubiHHM6xNbixDMppnHA05BUW2tQcgJxgV9tJWN667yKo6vETxYp2BJ
         8evA==
X-Gm-Message-State: APt69E1ohO/iYsnErS4XNeM8OKAdJJPPSabKgB6xeoU3BMuiBcIJZzG2
        sUIP5DU/JXxvSwvmm6tUakpUoA==
X-Google-Smtp-Source: AAOMgpfAk6gwVaKkm7MFSESENeBcrKhW++DhTv2eXKGX7kcqON48st4n/QDcdPSv1IxqRkd/om+LuA==
X-Received: by 2002:ae9:e004:: with SMTP id m4-v6mr6345142qkk.436.1530127249526;
        Wed, 27 Jun 2018 12:20:49 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id v88-v6sm3423904qkl.57.2018.06.27.12.20.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 12:20:48 -0700 (PDT)
Date:   Wed, 27 Jun 2018 15:20:48 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
        kernel-team@fb.com, akpm@linux-foundation.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org, Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH 12/15] block: introduce blk-iolatency io controller
Message-ID: <20180627192046.ieqncfl6ioy37mof@destiny>
References: <20180625151243.2132-1-josef@toxicpanda.com>
 <20180625151243.2132-13-josef@toxicpanda.com>
 <05a581ed-8f21-9d89-a813-a03d802d3469@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05a581ed-8f21-9d89-a813-a03d802d3469@kernel.dk>
User-Agent: NeoMutt/20170714 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 01:06:31PM -0600, Jens Axboe wrote:
> On 6/25/18 9:12 AM, Josef Bacik wrote:
> > +static void __blkcg_iolatency_throttle(struct rq_qos *rqos,
> > +				       struct iolatency_grp *iolat,
> > +				       spinlock_t *lock, bool issue_as_root,
> > +				       bool use_memdelay)
> > +	__releases(lock)
> > +	__acquires(lock)
> > +{
> > +	struct rq_wait *rqw = &iolat->rq_wait;
> > +	unsigned use_delay = atomic_read(&lat_to_blkg(iolat)->use_delay);
> > +	DEFINE_WAIT(wait);
> > +	bool first_block = true;
> > +
> > +	if (use_delay)
> > +		blkcg_schedule_throttle(rqos->q, use_memdelay);
> > +
> > +	/*
> > +	 * To avoid priority inversions we want to just take a slot if we are
> > +	 * issuing as root.  If we're being killed off there's no point in
> > +	 * delaying things, we may have been killed by OOM so throttling may
> > +	 * make recovery take even longer, so just let the IO's through so the
> > +	 * task can go away.
> > +	 */
> > +	if (issue_as_root || fatal_signal_pending(current)) {
> > +		atomic_inc(&rqw->inflight);
> > +		return;
> > +	}
> > +
> > +	if (iolatency_may_queue(iolat, &wait, first_block))
> > +		return;
> > +
> > +	do {
> > +		prepare_to_wait_exclusive(&rqw->wait, &wait,
> > +					  TASK_UNINTERRUPTIBLE);
> > +
> > +		iolatency_may_queue(iolat, &wait, first_block);
> > +		first_block = false;
> > +
> > +		if (lock) {
> > +			spin_unlock_irq(lock);
> > +			io_schedule();
> > +			spin_lock_irq(lock);
> > +		} else {
> > +			io_schedule();
> > +		}
> > +	} while (1);
> 
> So how does this wait loop ever exit?
>

Sigh, I cleaned this up from what we're using in production and did it poorly,
I'll fix it up.  Thanks,

Josef 
