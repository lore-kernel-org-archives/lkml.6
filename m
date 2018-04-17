Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-842624-1523940400-2-4556239984668906961
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523940399; b=iYoEgU84OdQ9620hs9RjVlZm1fFF0ubDMAP+sjHVxwSSwlALds
    umRrpavz3Jnh5zixCeWQMFVhQVuPPxCjYHaQ2u4QJMp3cAlKDjDSVfSQ1BcUEMBf
    P/K+207CdxNNelEVWvZUAg8jugvkiYpFvAS5I92B8OcKcxIneiTHDGdFGrduYGC1
    +ABrQkZwYy5DTCQ8uvGtKDSyWrtYveQbL50wm/2RF4JmPJ66Emi6N07EkQdsDkhs
    l/6oWmyAF0Le+AoEQeoVyADNpEKalkZA7hBe7Nt6C6c3mngp5vVoXco9VVR5HXKb
    6srpvqe8IpRIAfzT/prDBxqQn5A18sC9DkDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523940399; bh=eZme3vIdn27OHd3R5zaKCY1CaGZZjo
    astI5anpnDPxk=; b=LyJhIvHM/J6OCxwXtlRKNdBWI6TSVmymgLBVc0VYwAL8NV
    bKPJm3pIbB2JGUIM8afuPjgSnZgawR+Z98p45/lGGwsHEzfxgYNJGCU9DWwCet9I
    KQQy7ki/5GfBTfpYL8N9i1BBd/Q+qpZ69dSbcsefKMHSGDPb3R6691TtylLszfn9
    Y3OuLcxLZWtZIR/UUXhFsop2no+5gpLlilZmB3oSmTmIovbBNRqP8IubcD0zaxRE
    PtYtDw5OkgJzSczOHYNKOU0TrMkAK/mhjm+Cc1mTbDot0V7FyzUu/5aue/4oVfXQ
    Pc2gWJ41DEwMVlrfCfwprPfrKEqbl1Noxrcmr/3w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEDsXXuCH7C3lgyk+G3tF41jdk+v+637NpXD10kLXdxH8bgxJaVi2HAwQAWZLpxTiNVa9IX8G/OwPgm7aUhFoXpfKBoPW4zXOzji4+H2E31oT0i0iivQ
    1m6tifY+CdPoUfhlslQNqRQ6OYNzH8HGx7U0BD8ZsUxiGVBQrEeXK2So5sFK/KTJjNSqpm6wqX4M6/YipgZ78g67VW7Whh69nmgexKa0WKKWVhoxy/LQ8F5F
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=JF9118EUAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
    a=I9QjSo0uVMMpW2p-shAA:9 a=iDUrIjUsz9rrFn45:21 a=f0SACWbo8KV-TCHN:21
    a=CjuIK1q_8ugA:10 a=xVlTc564ipvMDusKsbsT:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751057AbeDQEqZ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 00:46:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43194 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750744AbeDQEqZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 17 Apr 2018 00:46:25 -0400
Date: Tue, 17 Apr 2018 12:46:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: axboe@kernel.dk, bart.vanassche@wdc.com, tj@kernel.org,
        Martin@Lichtvoll.de, stable@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: start request gstate with gen 1
Message-ID: <20180417044603.GA16286@ming.t460p>
References: <1523936780-1589-1-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523936780-1589-1-git-send-email-jianchao.w.wang@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 11:46:20AM +0800, Jianchao Wang wrote:
> rq->gstate and rq->aborted_gstate both are zero before rqs are
> allocated. If we have a small timeout, when the timer fires,
> there could be rqs that are never allocated, and also there could
> be rq that has been allocated but not initialized and started. At
> the moment, the rq->gstate and rq->aborted_gstate both are 0, thus
> the blk_mq_terminate_expired will identify the rq is timed out and
> invoke .timeout early.
> 
> For scsi, this will cause scsi_times_out to be invoked before the
> scsi_cmnd is not initialized, scsi_cmnd->device is still NULL at
> the moment, then we will get crash.
> 
> Cc: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Martin Steigerwald <Martin@Lichtvoll.de>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  block/blk-core.c | 4 ++++
>  block/blk-mq.c   | 7 +++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index abcb868..ce62681 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -201,6 +201,10 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
>  	rq->part = NULL;
>  	seqcount_init(&rq->gstate_seq);
>  	u64_stats_init(&rq->aborted_gstate_sync);
> +	/*
> +	 * See comment of blk_mq_init_request
> +	 */
> +	WRITE_ONCE(rq->gstate, MQ_RQ_GEN_INC);
>  }
>  EXPORT_SYMBOL(blk_rq_init);
>  
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index f5c7dbc..d62030a 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2069,6 +2069,13 @@ static int blk_mq_init_request(struct blk_mq_tag_set *set, struct request *rq,
>  
>  	seqcount_init(&rq->gstate_seq);
>  	u64_stats_init(&rq->aborted_gstate_sync);
> +	/*
> +	 * start gstate with gen 1 instead of 0, otherwise it will be equal
> +	 * to aborted_gstate, and be identified timed out by
> +	 * blk_mq_terminate_expired.
> +	 */
> +	WRITE_ONCE(rq->gstate, MQ_RQ_GEN_INC);
> +
>  	return 0;
>  }

Good catch, blk_mq_check_expired() is bypassed, but it is still hit
by blk_mq_terminate_expired().

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming
