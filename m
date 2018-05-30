Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4130476-1527697613-2-2271245313561581574
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527697613; b=MZnPf7BScNOIz+kM901yBnD+dh7zNWbfe19m7J5kIXvRJq8iQ3
    FfG299yO3lpOTVTn4K4TPWYG/aPe+78vj8LKVWFwu7YsVv6PIT/Kz4zo5vsA9isk
    AjmyfcexigWNILr967ioTsriADz2hAl2QeAjrrw6gPL/xjy6mRCi9KYH/csnyjv4
    tAyX1knk7PHuDAgoZ1sBDu8m5p93kamPNzALPpzfwIzAYk7XvZeDXgHuq/mcePJk
    xkrZHAukfKQbAQE8etFGZUuCVOGR0UMzrAXSlgpdJtNDTjFn5Hxz0zPzHkJxUw6V
    eB/Jn2QOtonh9eW1dXoMXF2nDTCmoxowNx2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527697613; bh=PB3MjwK72GupI3NPdxDFpmlfRwa4zZ
    TZzVSg89MdAyU=; b=M47J4Hmozrb4TzLKLQOCynqfdQQUrWpembnd5j/vRPZ824
    CuS7fwf4fI4cBqhh//oDaF5AGDN+gc4+mYR2REVjBTuJitD1zC/+njyY7vmkMdd5
    lzfdjL3SJRQ/iNswkTtgl6bkMhtlYCwVu8ZFaBuCiO9KqKJIgSjYXaJYLGD5t7Yk
    bayU7UJDz+6F1Ptd50jujEtPhN50q2iMaMSpDxn0oGkoFh06oNbFogDyZPN6pLny
    fVFYUbgRxlXAldDZ9r7PRudAp3SEjKDEgvkt8Yhc1rxtbDTDZUMHaObAY0WcFnIR
    9bDF8IXhOK5Jr67vRkCL0winwhQkYfDozT1C5qqA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=gni/DJ6M
    header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=f16CRPKc;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=gni/DJ6M
      header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=f16CRPKc;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHsr8pPDOYR6j9sDiMzCRdnDNakKcPyAU/mG4T6m2CM3w6lzIbKEb7NUpqy9DdeMDH2Ti9Y9pIJwPdEw+gxxRLLn1q9CBkIHJ7hhOTrv3KgadzfVBtEi
    DZ0sr0pTgfh7zgkW9jRdOsR940dDAZuVZF17ta2XXzykRHlDMOetnR8fAQfhyoKlemZuIsSrZqNiFBqVy73Jyx1w2yUNqWc2ucegepvvpXJZuvOBdrmeJi6/
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=e7LMkGNAV0ZGsfzclBYA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753900AbeE3Q0t (ORCPT <rfc822;linux@kroah.com>);
        Wed, 30 May 2018 12:26:49 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:36063 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753534AbeE3Q0d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 May 2018 12:26:33 -0400
X-Google-Smtp-Source: ADUXVKIDSLmqHVYt2TeadEiFP+Ng65u8f4Tav+IZ6JN1jogHeo97ojgg7/5plXnsgNt8p51tY0q0nQ==
Date: Wed, 30 May 2018 09:26:29 -0700
From: Tejun Heo <tj@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH 06/13] blkcg: add generic throttling mechanism
Message-ID: <20180530162629.GN1351649@devbig577.frc2.facebook.com>
References: <20180529211724.4531-1-josef@toxicpanda.com>
 <20180529211724.4531-7-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529211724.4531-7-josef@toxicpanda.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

On Tue, May 29, 2018 at 05:17:17PM -0400, Josef Bacik wrote:
> +static void blkcg_scale_delay(struct blkcg_gq *blkg, u64 now)
> +{
> +	u64 old = atomic64_read(&blkg->delay_start);
> +
> +	if (old + NSEC_PER_SEC <= now &&

Maybe time_before64()?

> +	    atomic64_cmpxchg(&blkg->delay_start, old, now) == old) {
> +		u64 cur = atomic64_read(&blkg->delay_nsec);
> +		u64 sub = min_t(u64, blkg->last_delay, now - old);
> +		int cur_use = atomic_read(&blkg->use_delay);
> +
> +		if (cur_use < blkg->last_use)
> +			sub = max_t(u64, sub, blkg->last_delay >> 1);
> +
> +		/* This shouldn't happen, but handle it anyway. */
> +		if (unlikely(cur < sub)) {
> +			atomic64_set(&blkg->delay_nsec, 0);
> +			blkg->last_delay = 0;
> +		} else {
> +			atomic64_sub(sub, &blkg->delay_nsec);
> +			blkg->last_delay = cur - sub;
> +		}
> +		blkg->last_use = cur_use;

Can you please add some comments explaining the above?  It's a lot of
logic.

> +static void blkcg_maybe_throttle_blkg(struct blkcg_gq *blkg, bool use_memdelay)
> +{

Maybe add a comment explaining that this is a cold path?

> +	u64 now = ktime_to_ns(ktime_get());
> +	u64 exp;
> +	u64 delay_nsec = 0;
> +	int tok;
> +
> +	while (blkg->parent) {
> +		if (atomic_read(&blkg->use_delay)) {
> +			blkcg_scale_delay(blkg, now);
> +			delay_nsec = max_t(u64, delay_nsec,
> +					   atomic64_read(&blkg->delay_nsec));
> +		}
> +		blkg = blkg->parent;
> +	}

Cuz the above may look too much otherwise.

...
> +void blkcg_maybe_throttle_current(void)
> +{
> +	struct request_queue *q = current->throttle_queue;
> +	struct cgroup_subsys_state *css;
> +	struct blkcg *blkcg;
> +	struct blkcg_gq *blkg;
> +	bool use_memdelay = current->use_memdelay;
> +
> +	if (!q)
> +		return;

The above would be the path taken in most cases, right?

> +
> +	current->throttle_queue = NULL;
> +	current->use_memdelay = false;

So, we only wait once, capped to 1s per blkcg_schedule_throttle()?
It'd be great to document the rationales.

> +	rcu_read_lock();
> +	css = kthread_blkcg();
> +	if (css)
> +		blkcg = css_to_blkcg(css);
> +	else
> +		blkcg = css_to_blkcg(task_css(current, io_cgrp_id));
> +
> +	if (!blkcg)
> +		goto out;
> +	blkg = blkg_lookup(blkcg, q);
> +	if (!blkg)
> +		goto out;
> +	blkg_get(blkg);

I don't think we can do blkg_get() on a blkg which is only protected
by rcu.  We probably need blkg_tryget() here.

> +	rcu_read_unlock();
> +	blk_put_queue(q);
> +
> +	blkcg_maybe_throttle_blkg(blkg, use_memdelay);
> +	blkg_put(blkg);
> +	return;
> +out:
> +	rcu_read_unlock();
> +	blk_put_queue(q);
> +}
> +EXPORT_SYMBOL_GPL(blkcg_maybe_throttle_current);
> +
> +void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay)
> +{
> +	if (unlikely(current->flags & PF_KTHREAD))
> +		return;
> +
> +	if (!blk_get_queue(q))
> +		return;
> +
> +	if (current->throttle_queue)
> +		blk_put_queue(current->throttle_queue);
> +	current->throttle_queue = q;

Can't we set current->throttle_blkg directly?

> +static inline int blkcg_unuse_delay(struct blkcg_gq *blkg)
> +{
> +	int old = atomic_read(&blkg->use_delay);
> +
> +	if (old == 0)
> +		return 0;
> +
> +	while (old) {
> +		int cur = atomic_cmpxchg(&blkg->use_delay, old, old - 1);

Can we use atomic_dec_return() here?

> +		if (cur == old)
> +			break;
> +		cur = old;
> +	}
> +
> +	if (old == 0)
> +		return 0;
> +	if (old == 1)
> +		atomic_dec(&blkg->blkcg->css.cgroup->congestion_count);
> +	return 1;
> +}
> +
> +static inline void blkcg_clear_delay(struct blkcg_gq *blkg)
> +{
> +	int old = atomic_read(&blkg->use_delay);
> +	if (!old)
> +		return;
> +	if (atomic_cmpxchg(&blkg->use_delay, old, 0) == old)
> +		atomic_dec(&blkg->blkcg->css.cgroup->congestion_count);

atomic_add_unless()?

Thanks.

-- 
tejun
