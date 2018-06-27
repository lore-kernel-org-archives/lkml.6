Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A6CC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68102527F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HgWw+kIG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E68102527F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935092AbeF0TZB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 15:25:01 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:38164 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934833AbeF0TY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 15:24:59 -0400
Received: by mail-it0-f68.google.com with SMTP id v83-v6so9047584itc.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 12:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xRPfvk3q8fAABxM/Oo8y57EZKXOQJ1gWCmDX8CSfIv4=;
        b=HgWw+kIGjj/nMeN1vN4Jvux0e4QPEquNAARtaFKiFwkoOpMfOqvMV9yTK+hVUuJo9U
         UNchVNpzuUnvoOdqqmoU+gARIogFw9FZPsbnKxgEOy3EpfLN0ypKn9G3JIqX1FSQ2TlE
         r+9re6c/ast6bky+rgGKO1rN34D784DXne3HJHQjYScNds2L6qZHTvlJqfK0W3AYi+6h
         vA/5B0hj0FcIkTMcoCuXEJkmuOA+9rmtHnVWxx9Na3W7PaRbi9Am871V9ya4o4yJHppF
         SyyTBDFDk46ir112RmkgYlLwYqk6cijdZHiK2/XTxB9kw11DDvJb5jzD+6Zg/s2IeZQ3
         0B2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xRPfvk3q8fAABxM/Oo8y57EZKXOQJ1gWCmDX8CSfIv4=;
        b=tgD1MQilaypQ8Kou7cD9DAkowphqNn4V6vQIXEyd+85dkkxEBBoTWUAyXh0AtUq7Cv
         +m6mhX5alkPqt3LaNPbTEHI68VSYtjasBa8+XVybp2Wc1DRJmqPNqAf44FLM0ALy1056
         NwSjEzBgU6JBZvuCZqzjnxk/0GtX5OhK2pGJzUAxP0mIJQ+iWqpYH/qcZd9+OoOIebKM
         84PXLdDF+jNOn+uDtfc/49Ln6woIf4J7eoy3uKI8cnNAFGlpH044Q+8RAmyL+/llYBt3
         73/fCrc5fJCeppTZW+SFtp2Swli/QoBbFVAL3b/Y+BTBFbf91CFV7YWAxVch6pEE7YNu
         vxVw==
X-Gm-Message-State: APt69E1zQGUqtP5RxNwP+4DPYABGbXnrFQLZEiD8M9+nIj+J49/tZA4o
        e3hVtj/L/9Dny3RZZrbqeqC7tQ==
X-Google-Smtp-Source: AAOMgpffBdtQVVQp3bb3bd3S0KzhKsm3JGWcJxWoL+l86eOeKbD5AHoC941/IwoYJldyyEgzNIe+Lg==
X-Received: by 2002:a02:45cd:: with SMTP id o74-v6mr5854775jad.43.1530127498060;
        Wed, 27 Jun 2018 12:24:58 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id j11-v6sm2816423itb.16.2018.06.27.12.24.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 12:24:56 -0700 (PDT)
Subject: Re: [PATCH 12/15] block: introduce blk-iolatency io controller
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, kernel-team@fb.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org, Josef Bacik <jbacik@fb.com>
References: <20180625151243.2132-1-josef@toxicpanda.com>
 <20180625151243.2132-13-josef@toxicpanda.com>
 <05a581ed-8f21-9d89-a813-a03d802d3469@kernel.dk>
 <20180627192046.ieqncfl6ioy37mof@destiny>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <784f0862-0441-5ed2-1beb-3effa82b3438@kernel.dk>
Date:   Wed, 27 Jun 2018 13:24:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180627192046.ieqncfl6ioy37mof@destiny>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/18 1:20 PM, Josef Bacik wrote:
> On Wed, Jun 27, 2018 at 01:06:31PM -0600, Jens Axboe wrote:
>> On 6/25/18 9:12 AM, Josef Bacik wrote:
>>> +static void __blkcg_iolatency_throttle(struct rq_qos *rqos,
>>> +				       struct iolatency_grp *iolat,
>>> +				       spinlock_t *lock, bool issue_as_root,
>>> +				       bool use_memdelay)
>>> +	__releases(lock)
>>> +	__acquires(lock)
>>> +{
>>> +	struct rq_wait *rqw = &iolat->rq_wait;
>>> +	unsigned use_delay = atomic_read(&lat_to_blkg(iolat)->use_delay);
>>> +	DEFINE_WAIT(wait);
>>> +	bool first_block = true;
>>> +
>>> +	if (use_delay)
>>> +		blkcg_schedule_throttle(rqos->q, use_memdelay);
>>> +
>>> +	/*
>>> +	 * To avoid priority inversions we want to just take a slot if we are
>>> +	 * issuing as root.  If we're being killed off there's no point in
>>> +	 * delaying things, we may have been killed by OOM so throttling may
>>> +	 * make recovery take even longer, so just let the IO's through so the
>>> +	 * task can go away.
>>> +	 */
>>> +	if (issue_as_root || fatal_signal_pending(current)) {
>>> +		atomic_inc(&rqw->inflight);
>>> +		return;
>>> +	}
>>> +
>>> +	if (iolatency_may_queue(iolat, &wait, first_block))
>>> +		return;
>>> +
>>> +	do {
>>> +		prepare_to_wait_exclusive(&rqw->wait, &wait,
>>> +					  TASK_UNINTERRUPTIBLE);
>>> +
>>> +		iolatency_may_queue(iolat, &wait, first_block);
>>> +		first_block = false;
>>> +
>>> +		if (lock) {
>>> +			spin_unlock_irq(lock);
>>> +			io_schedule();
>>> +			spin_lock_irq(lock);
>>> +		} else {
>>> +			io_schedule();
>>> +		}
>>> +	} while (1);
>>
>> So how does this wait loop ever exit?
>>
> 
> Sigh, I cleaned this up from what we're using in production and did it poorly,
> I'll fix it up.  Thanks,

Also may want to consider NOT using exclusive add if first_block == false, as
you'll end up at the tail of the waitqueue after sleeping and being denied.
This is similar to the wbt change I posted last week.

For may_queue(), your wq_has_sleeper() is also going to be always true
inside your loop, since you call it after doing the prepare_to_wait()
which adds you to the queue. That's why wbt does the list checks, but
it'd be nicer to have a wq_has_other_sleepers() for that. So your
first iolatency_may_queue() inside the loop will always be false.

-- 
Jens Axboe

