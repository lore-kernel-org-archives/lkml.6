Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658C9C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1290125025
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHY3fX7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1290125025
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753692AbeGBVr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:47:59 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35105 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753544AbeGBVrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:47:55 -0400
Received: by mail-yw0-f194.google.com with SMTP id t18-v6so7191997ywg.2;
        Mon, 02 Jul 2018 14:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OUMl5xkrsyh5CVpAJeuoHopjyWF7v/Ol1acC98e6r1c=;
        b=YHY3fX7lpoITl8ibvkokbtDVWXrLWe3idzXNbwS3yjwaMiirYztIMkZA1JqpSvDENg
         87SKpiY1fZaTXtfuDR2Ioshf/LeDCJe2cvvLRqt4eBLm1BRmIq2+xS9n4eZ5rpT1uvze
         h66PBLA/tZOCBXzbdR3zpRSgetl8OmB4ll9uz96f3sD9qQkIh30OYrUoeshGdbbrinw0
         VK9+722bQKzekpi7UQCebYMmEK/dCYJjvvYs/q7RTQkPYzbGAEiAVXEnfUuc6VQzSsXy
         JdMYuYtYv4B9PrEdEtC3no+Dpx54JmJJ5trJEQaY/rHypoLXJlxQo3FXe+pIOzpQxGnx
         WPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OUMl5xkrsyh5CVpAJeuoHopjyWF7v/Ol1acC98e6r1c=;
        b=aZey51A56nTrKpeWHbKkIU79k853MuVZK2efqne7P/2mvbpEEF+jHdChmARLk3I9DV
         gGzUxQTpE3HPVCvi4x4Qx263/5q00AeLKwLsaVklZeTxRd6rb8SkbyyJcuLmLaq9W9ez
         kxpt2rGqdzpC9n3MeAIBRe4yfB1WHbQjxvH4e8d0o3V1FZ55ER8XwSKXLrOWpGjVZNlr
         7F0ixwElxb6HgTy17m6sSIWp7Z33v1gIzE90S9e/vZ5A/VcLGS70KJgrvGeXINeRbCKT
         DtKZzD32K98IpnD2OaoANXGtNvc8ZfNywzPNz4HqIy12RkIxfJHsFhBPKKEsLLhYcZWt
         rQlQ==
X-Gm-Message-State: APt69E3+7KhjATa7C2jNhsCIVoFlxznYOWaYczEfYF7+uAqeWaY5SFVD
        UI6xvK7mUvmn2DXYWt8oP8RAAPia
X-Google-Smtp-Source: AAOMgpd1t2i3ueSJOVUvor2+E+yPwR86A/46XvrE5AlxXVdiPxvXnTyDSJfhc0eHE63fa++uxNCaXg==
X-Received: by 2002:a0d:fc05:: with SMTP id m5-v6mr13432615ywf.494.1530568073514;
        Mon, 02 Jul 2018 14:47:53 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2b6f])
        by smtp.gmail.com with ESMTPSA id g190-v6sm7180780ywh.83.2018.07.02.14.47.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 14:47:52 -0700 (PDT)
Date:   Mon, 2 Jul 2018 14:47:51 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH 12/14] block: introduce blk-iolatency io controller
Message-ID: <20180702214751.GO533219@devbig577.frc2.facebook.com>
References: <20180629192542.26649-1-josef@toxicpanda.com>
 <20180629192542.26649-13-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629192542.26649-13-josef@toxicpanda.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 03:25:40PM -0400, Josef Bacik wrote:
> From: Josef Bacik <jbacik@fb.com>
> 
> Current IO controllers for the block layer are less than ideal for our
> use case.  The io.max controller is great at hard limiting, but it is
> not work conserving.  This patch introduces io.latency.  You provide a
> latency target for your group and we monitor the io in short windows to
> make sure we are not exceeding those latency targets.  This makes use of
> the rq-qos infrastructure and works much like the wbt stuff.  There are
> a few differences from wbt
> 
>  - It's bio based, so the latency covers the whole block layer in addition to
>    the actual io.
>  - We will throttle all IO types that comes in here if we need to.
>  - We use the mean latency over the 100ms window.  This is because writes can
>    be particularly fast, which could give us a false sense of the impact of
>    other workloads on our protected workload.
>  - By default there's no throttling, we set the queue_depth to INT_MAX so that
>    we can have as many outstanding bio's as we're allowed to.  Only at
>    throttle time do we pay attention to the actual queue depth.
>  - We backcharge cgroups for root cg issued IO and induce artificial
>    delays in order to deal with cases like metadata only or swap heavy
>    workloads.
> 
> In testing this has worked out relatively well.  Protected workloads
> will throttle noisy workloads down to 1 io at time if they are doing
> normal IO on their own, or induce up to a 1 second delay per syscall if
> they are doing a lot of root issued IO (metadata/swap IO).
> 
> Our testing has revolved mostly around our production web servers where
> we have hhvm (the web server application) in a protected group and
> everything else in another group.  We see slightly higher requests per
> second (RPS) on the test tier vs the control tier, and much more stable
> RPS across all machines in the test tier vs the control tier.
> 
> Another test we run is a slow memory allocator in the unprotected group.
> Before this would eventually push us into swap and cause the whole box
> to die and not recover at all.  With these patches we see slight RPS
> drops (usually 10-15%) before the memory consumer is properly killed and
> things recover within seconds.
> 
> Signed-off-by: Josef Bacik <jbacik@fb.com>
...
> +static inline bool iolatency_may_queue(struct iolatency_grp *iolat,
> +				       wait_queue_entry_t *wait,
> +				       bool first_block)
> +{
> +	struct rq_wait *rqw = &iolat->rq_wait;
> +
> +	if (first_block && waitqueue_active(&rqw->wait) &&
> +	    rqw->wait.head.next != &wait->entry)
> +		return false;

This optimization seems a bit scary to me, so we want to block if
there are others already trying to block, at least for the first time
around.  IIUC, this is safe because at least the first waiter is
guaranteed to bypass this condition and thus will always do the actual
condition, right?  It'd be great to explain this a bit.  If this is a
meaningful optimization to protect against everyone banging on the
same thing post wake up, in the longer term, maybe it'd make sense to
add a waitqueue helper for this?

> +/*
> + * We scale the qd down faster than we scale up, so we need to use this helper
> + * to adjust the scale_cookie accordingly so we don't prematurely get
> + * scale_cookie at DEFAULT_SCALE_COOKIE and unthrottle too much.
> + */
> +static void scale_cookie_change(struct blk_iolatency *blkiolat,
> +				struct child_latency_info *lat_info,
> +				bool up)
> +{
> +	unsigned long qd = blk_queue_depth(blkiolat->rqos.q);
> +	unsigned long scale = scale_amount(qd, up);
> +	unsigned long old = atomic_read(&lat_info->scale_cookie);
> +	unsigned long max_scale = qd << 1;
> +	unsigned long diff = 0;
> +
> +	if (old < DEFAULT_SCALE_COOKIE)
> +		diff = DEFAULT_SCALE_COOKIE - old;
> +
> +	if (up) {
> +		if (scale + old > DEFAULT_SCALE_COOKIE)
> +			atomic_set(&lat_info->scale_cookie,
> +				   DEFAULT_SCALE_COOKIE);
> +		else if (diff > qd)
> +			atomic_inc(&lat_info->scale_cookie);
> +		else
> +			atomic_add(scale, &lat_info->scale_cookie);
> +	} else {
> +		/*
> +		 * We don't want to dig a hole so deep that it takes us hours to
> +		 * dig out of it.  Just enough that we don't throttle/unthrottle
> +		 * with jagged workloads but can still unthrottle once pressure
> +		 * has sufficiently dissipated.
> +		 */
> +		if (diff > qd) {
> +			if (diff < max_scale)
> +				atomic_dec(&lat_info->scale_cookie);
> +		} else {
> +			atomic_sub(scale, &lat_info->scale_cookie);
> +		}
> +	}
> +}

So, once understood, the scale_cookie thing is pretty straight-forward
but I think it'd be help a lot to have an overview explanation of how
it works to elect the failing group with the lowest target and how
scale_cookie is used to communicate to tell others to throttle up or
down.

> +/* Check our parent and see if the scale cookie has changed. */
> +static void check_scale_change(struct iolatency_grp *iolat)
> +{
...
> +	if (direction < 0 && iolat->min_lat_nsec) {
> +		u64 samples_thresh;
> +
> +		if (!scale_lat || iolat->min_lat_nsec <= scale_lat)
> +			return;
> +
> +		/*
> +		 * Sometimes high priority groups are their own worst enemy, so
> +		 * instead of taking it out on some poor other group that did 5%
> +		 * or less of the IO's for the last summation just skip this
> +		 * scale down event.
> +		 */
> +		samples_thresh = lat_info->nr_samples * 5;
> +		samples_thresh = div64_u64(samples_thresh, 100);
> +		if (iolat->nr_samples <= samples_thresh)
> +			return;

Not that this needs changes right now but I wonder whether it'd be
better to limit the other way around - ie. if a group is >
(1-sample_thres), don't let it win.  It'd be the same effect but
likely a bit more robust.

> +static size_t iolatency_pd_stat(struct blkg_policy_data *pd, char *buf,
> +				size_t size)
> +{
> +	struct iolatency_grp *iolat = pd_to_lat(pd);
> +	unsigned long long avg_lat = div64_u64(iolat->total_lat_avg, NSEC_PER_USEC);
> +
> +	if (iolat->rq_depth.max_depth == (u64)-1)
> +		return scnprintf(buf, size, " depth=max avg_lat=%llu",
> +				 avg_lat);
> +
> +	return scnprintf(buf, size, " depth=%u avg_lat=%llu",
> +			 iolat->rq_depth.max_depth, avg_lat);

I wonder whether providing a reasonable decaying running avg would be
better than reporting whole avg - e.g. something which decays mostly
in a minute or so.  After all, the throttling action is based on
pretty short timeframe, so reporting something more current might be
more helpful.

Other than the above nitpicks, seems generally good to me, at least on
skimming the code.  It's a whole new feature and we can fix it as we
go along.

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
