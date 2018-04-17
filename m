Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1716434-1523967031-2-1800631597176214677
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523967030; b=Z3MIXnoVXl8k7diW1yxm5zM5fE6xJCCn5YfcgPkiT+LLZ7ENX5
    RCCAY4ag/XHpEyBatqClGxQKHiIV5/Tu1ZuBZ/SjcyZ8W9ikovXb7VFBp0GortgU
    /hLnz1/5WWInpz5poAQgeDHGn3Xf8UXfIt/Ck3NxdBETlv5DlxOmm0uIeF9U4m9z
    cH5ZbYO5xzai4MVSJdq3dpWVUsHDqKgRGGNH5HNt8AQ/NOSNup2P8c9UeuxaTiKD
    TdmbwvYjulUwPPZ9P2+FgX87d9CjM0RjNK2SIWhctzd2IAfEk7LmnF1SjlO76LzE
    CRNGdEoeLwjB+vIzj//d8qCoHtHyCIk/FkjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-transfer-encoding
    :content-type:sender:list-id; s=fm2; t=1523967030; bh=3HbJE2M+7T
    fKBjRTAKWaj/aD5clas/rTcjJr+wtu1Pc=; b=l3IoAzUcBbHBOU1uWTQ0f47+3Y
    ofCudD5ezlPIsALApBEoN2AF8TSCrMbgQa78NqSQ1cjO9+x/pJeAUe6YNXn2S97I
    pHS5z9xZHV2PGw9bhMxV6nBuqBJmP7GAc3Jv3I2z50Yw6JDoBuVrabYWe8e/Kd4M
    256kB7Uq919L6VGL9bTq3Mn9yhAW7RWBlaNpzrwMYuCgHcVftZSkDdsoV8EZY0Rl
    h5Rk0c4p25MJIs+jWYMYWBxkJSWKVGETK62pbH2j//SSD5Jk6ybuQ8FePDCd4Nza
    2v0qm25ZfrZnvMD5V4RSpq4xsFw5IpMBEwpPEpQwpk06quLC/k4PSk3UmsIw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lichtvoll.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lichtvoll.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lichtvoll.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lichtvoll.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBaeo00B4NLI81Zlb2Ducs/5JHS4lnn2ZkTvnOvVzaloN1QH3sxwm/HoXKkrlxs4PpUO9PR2sg7+tFVYBjy9/I1dkCz45emUhXj8MM1Q6c6sufgfGPcz
    +6UQAQ/MWBXElRCfFt65zhXohp46w/AeZvUVWLl/iq1iqmYh9BbkIfvOQ7gnowDK0QTvW2UmqCAvpgInQVrqMd8OiElMtxkXaIErxhbqi96PsdZNrXKNXPoY
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=JF9118EUAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
    a=I9QjSo0uVMMpW2p-shAA:9 a=0Go2i65TiDG78nCO:21 a=B7VonkaQ8JXOjMJ6:21
    a=CjuIK1q_8ugA:10 a=xVlTc564ipvMDusKsbsT:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752655AbeDQMKR (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 08:10:17 -0400
Received: from mondschein.lichtvoll.de ([194.150.191.11]:57487 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752546AbeDQMKQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 08:10:16 -0400
Authentication-Results: auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: axboe@kernel.dk, bart.vanassche@wdc.com, tj@kernel.org,
        ming.lei@redhat.com, stable@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: start request gstate with gen 1
Date: Tue, 17 Apr 2018 14:10:08 +0200
Message-ID: <2612135.Ur0PZolWSD@merkaba>
In-Reply-To: <1523936780-1589-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1523936780-1589-1-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Jianchao,

Jianchao Wang - 17.04.18, 05:46:
> rq->gstate and rq->aborted_gstate both are zero before rqs are
> allocated. If we have a small timeout, when the timer fires,
> there could be rqs that are never allocated, and also there could
> be rq that has been allocated but not initialized and started. At
> the moment, the rq->gstate and rq->aborted_gstate both are 0, thus
> the blk_mq_terminate_expired will identify the rq is timed out and
> invoke .timeout early.

For testing it I add it to 4.16.2 with the patches I have already?

- '[PATCH] blk-mq_Directly schedule q->timeout_work when aborting a 
request.mbox'

- '[PATCH v2] block: Change a rcu_read_{lock,unlock}_sched() pair into 
rcu_read_{lock,unlock}().mbox'

- '[PATCH V4 1_2] blk-mq_set RQF_MQ_TIMEOUT_EXPIRED when the rq'\''s 
timeout isn'\''t handled.mbox'

- '[PATCH V4 2_2] blk-mq_fix race between complete and 
BLK_EH_RESET_TIMER.mbox'

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
> @@ -201,6 +201,10 @@ void blk_rq_init(struct request_queue *q, struct
> request *rq) rq->part = NULL;
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
> @@ -2069,6 +2069,13 @@ static int blk_mq_init_request(struct
> blk_mq_tag_set *set, struct request *rq,
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


-- 
Martin
