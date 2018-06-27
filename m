Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA0DC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4620025C9D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="et/GJTr1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4620025C9D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966144AbeF0TGj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 15:06:39 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:52267 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966048AbeF0TGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 15:06:35 -0400
Received: by mail-it0-f66.google.com with SMTP id p4-v6so1703987itf.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 12:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M0vNw8hmsAb6woA7xPJKQ//mSQledytLWdurKhmDrhs=;
        b=et/GJTr1OakugLIieB/apoJiCY/9+S1+biKxT2o6yW/VtQxnIhjgXJlJDYs5YYFJIw
         3B2f/bU0g7cIyLSLIDHnKDo5lpCoSjJ/qjQbbmIVMOhaYFscp3NcvpXww8r3fh8YhOmI
         wvppK28hgyeMhziCvGP/tDS4mTd77HD/SFQogs0AU/HQ8Jv5s28YwYtpfBYzcHphNJKq
         VumED3RFye2/vkhDaU0Xjmtmc349TDVtX11VENeMLxMDL4L0NivkNoX7lfuc1AyU/6c4
         QzxgLLgoGqF+Tzc2zU8Y0TkQfTprEJXPgznYHLpifmol8O4pCWcolkvnw1DNv56ztxrK
         YoEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M0vNw8hmsAb6woA7xPJKQ//mSQledytLWdurKhmDrhs=;
        b=nW9y6RjzMxhYBuy2ItIdrrTQ9DpnDfeO7IkQ6hCwXaihdpymqoQ6Pyemt9zaUxZ3PB
         F8hv891IDbskyNtkcliTqQboqBoUtsUc4AgktwjNLDJLQqd5rV3uqFiZSZGvBEFZsG2G
         WWklq7lNxQgOj47t0egEbQPzTm02YI19uEfQ5kukyK5Bp0b89522ckz6jxMbARSkD1wv
         WWHjaHHkZjf5GM7nl5/t6CdXTH7XDkWUrIDG4CWSE1GWpiP3Fd1pK10Ci58FXhbsCkIT
         YvUoOVmIeXu3lUMynMHFCNk0Ptm9dKqJ0LoP69WB1pjhZO4dTpdYXCWG0pLuFffH7xPX
         mKaA==
X-Gm-Message-State: APt69E1qMTEupFEymqw0yd1lxNu/X29kTejHeywM9bY5dq6KpMQY8tbr
        tG2Hso68cffKoS8spDrRcr45JYuNMKs=
X-Google-Smtp-Source: AAOMgpefpFV5K2p5p4S2a7F/IevOe7f5b68pwl/lJ8sD3i1bqH4/eo8JKVK6IpALHy4hCVPPjdYexg==
X-Received: by 2002:a24:4fd3:: with SMTP id c202-v6mr5912206itb.32.1530126394634;
        Wed, 27 Jun 2018 12:06:34 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id l13-v6sm2155355iob.82.2018.06.27.12.06.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 12:06:33 -0700 (PDT)
Subject: Re: [PATCH 12/15] block: introduce blk-iolatency io controller
To:     Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
        kernel-team@fb.com, akpm@linux-foundation.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Josef Bacik <jbacik@fb.com>
References: <20180625151243.2132-1-josef@toxicpanda.com>
 <20180625151243.2132-13-josef@toxicpanda.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <05a581ed-8f21-9d89-a813-a03d802d3469@kernel.dk>
Date:   Wed, 27 Jun 2018 13:06:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180625151243.2132-13-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/18 9:12 AM, Josef Bacik wrote:
> +static void __blkcg_iolatency_throttle(struct rq_qos *rqos,
> +				       struct iolatency_grp *iolat,
> +				       spinlock_t *lock, bool issue_as_root,
> +				       bool use_memdelay)
> +	__releases(lock)
> +	__acquires(lock)
> +{
> +	struct rq_wait *rqw = &iolat->rq_wait;
> +	unsigned use_delay = atomic_read(&lat_to_blkg(iolat)->use_delay);
> +	DEFINE_WAIT(wait);
> +	bool first_block = true;
> +
> +	if (use_delay)
> +		blkcg_schedule_throttle(rqos->q, use_memdelay);
> +
> +	/*
> +	 * To avoid priority inversions we want to just take a slot if we are
> +	 * issuing as root.  If we're being killed off there's no point in
> +	 * delaying things, we may have been killed by OOM so throttling may
> +	 * make recovery take even longer, so just let the IO's through so the
> +	 * task can go away.
> +	 */
> +	if (issue_as_root || fatal_signal_pending(current)) {
> +		atomic_inc(&rqw->inflight);
> +		return;
> +	}
> +
> +	if (iolatency_may_queue(iolat, &wait, first_block))
> +		return;
> +
> +	do {
> +		prepare_to_wait_exclusive(&rqw->wait, &wait,
> +					  TASK_UNINTERRUPTIBLE);
> +
> +		iolatency_may_queue(iolat, &wait, first_block);
> +		first_block = false;
> +
> +		if (lock) {
> +			spin_unlock_irq(lock);
> +			io_schedule();
> +			spin_lock_irq(lock);
> +		} else {
> +			io_schedule();
> +		}
> +	} while (1);

So how does this wait loop ever exit?

-- 
Jens Axboe

