Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAED2C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88FC124EA7
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="Hso520IZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88FC124EA7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755151AbeF2LOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 07:14:40 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41381 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752841AbeF2LOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 07:14:39 -0400
Received: by mail-pg0-f68.google.com with SMTP id l65-v6so3858360pgl.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 04:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4gaTgaeLOoJUG/awI0wVlomO8QHgj0wsqD4SgHx7Pho=;
        b=Hso520IZp2cKJjDjwiivitW+Akjp0Bjc/KTV+dQIbjdfuwleBXIpQJagJx+i3X0a1j
         QDbqrmdssRfgdOjGgwzkq/TfmhlY6mDJOxVU/DSdP48dExVWomxMdszosvinK/h7va0R
         uySmb7D/rmUAlmrzljdZHRYfQqKu8OwwgCi1g6ZeSjMgrvOAEd/xQEh4rMKvugmX0zuA
         e6JSumIHGV1alf4cd/MSx5Pvm8x6NdUjE76PTDmWBaV5v1kN8h9PwvONnlZBlu90qgi7
         jeCWDPWp5nXcKsapn6IJyH3awY8sUiWjFj5BMI9x4BQUHS8i+Kx/wGURrQwiUAW+sc7u
         6Vkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4gaTgaeLOoJUG/awI0wVlomO8QHgj0wsqD4SgHx7Pho=;
        b=dKS0II9YfEnTN03kQMfPZiSCh5001kXwQyuhRqjxxfJeRETMAOdSKhh8yxf38eU8n4
         VGuMVHsRCd8E5QZHP3P4188WH3MS0vDng86SlRbh/vyvjb5gH0mlZ+7id6B1HN8K2Dgi
         RXz53pRFbkz++g7IZBsMxmEM34EryeEAuxD8Hf9SLnudWzKDQ75AUJDnjnJTq4gKxx7k
         VXx9VNDS68ppgstocKgkmRcrbaZRVjmApW2OMWU4e21WiCJBZBCqzVRRKqSO6DCsaXg7
         ENSyadnToOUe95QPuPCvkoqfg2eSlR+HR8cwjNWKAEpvpaZRHju5aRIlX4AlDgJRTkLd
         QRTQ==
X-Gm-Message-State: APt69E2gmyhtn9TrHjfOeLAXz+mOC3lkVNZE3uiwA+z2mlSErcdlovsk
        /q6l0l0MTTp7lzMw3znqGimdfmSX
X-Google-Smtp-Source: ADUXVKIPdGryxJdFM2Dae1QqPVUTLT1DwR4PpAyV19KTiJv5l84PWOjrxsgjDztFcl9A+K2RYwR4uQ==
X-Received: by 2002:a63:8341:: with SMTP id h62-v6mr11949011pge.298.1530270878642;
        Fri, 29 Jun 2018 04:14:38 -0700 (PDT)
Received: from [10.86.51.149] (rap-us.hgst.com. [199.255.44.250])
        by smtp.googlemail.com with ESMTPSA id 74-v6sm20278218pfj.127.2018.06.29.04.14.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 04:14:37 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: recover chunk state on 1.2 devices
To:     javier@javigon.com
Cc:     hans.holmberg@cnexlabs.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, javier@cnexlabs.com
References: <1530177121-24908-1-git-send-email-javier@cnexlabs.com>
 <1530177121-24908-2-git-send-email-javier@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <e42e5ab4-48c7-e822-618d-dc28c25262ed@lightnvm.io>
Date:   Fri, 29 Jun 2018 13:14:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1530177121-24908-2-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/28/2018 11:12 AM, Javier González wrote:
> The Open-Channel 1.2 spec does not define a mechanism for the host to
> recover the block (chunk) state. As a consequence, a newly format device
> will need to reconstruct the state. Currently, pblk assumes that blocks
> are not erased, which might cause double-erases in case that the device
> does not protect itself against them (which is not specified in the spec
> either).

It should not be specified in the spec. It is up to the device to handle
double erases and not do it.

> 
> This patch, reconstructs the state based on read errors. If the first
> sector of a block returns and empty page (NVM_RSP_ERR_EMPTYPAGE), then
> the block s marked free, i.e., erased and ready to be used
> (NVM_CHK_ST_FREE). Otherwise, the block is marked as closed
> (NVM_CHK_ST_CLOSED). Note that even if a block is open and not fully
> written, it has to be erased in order to be used again.

Should we extend it to do the scan, and update the write pointer as 
well? I think this kind of feature already is baked into pblk?

> 
> One caveat of this approach is that blocks that have been erased at a
> moment in time, will always be considered as erased. However, some media
> might become unstable if blocks are not erased before usage. Since pblk
> would follow this principle after the state of all blocks fall under
> pblk's domain, we can consider this as an initialization problem. The
> trade-off would be to fall back to the old behavior and risk premature
> media wearing.

The above is up to the device implementation to handle. We cannot expect 
users to understand the intrinsics of media.

> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk-init.c | 138 ++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 124 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> index 3b8aa4a64cac..ce25f1473d8e 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -697,47 +697,138 @@ static void pblk_set_provision(struct pblk *pblk, long nr_free_blks)
>   	atomic_set(&pblk->rl.free_user_blocks, nr_free_blks);
>   }
>   
> +static void pblk_state_complete(struct kref *ref)
> +{
> +	struct pblk_pad_rq *pad_rq = container_of(ref, struct pblk_pad_rq, ref);
> +
> +	complete(&pad_rq->wait);
> +}
> +
> +static void pblk_end_io_state(struct nvm_rq *rqd)
> +{
> +	struct pblk_pad_rq *pad_rq = rqd->private;
> +	struct pblk *pblk = pad_rq->pblk;
> +	struct nvm_tgt_dev *dev = pblk->dev;
> +	struct nvm_geo *geo = &dev->geo;
> +	struct pblk_line *line;
> +	struct nvm_chk_meta *chunk;
> +	int pos;
> +
> +	line = &pblk->lines[pblk_ppa_to_line(rqd->ppa_addr)];
> +	pos = pblk_ppa_to_pos(geo, rqd->ppa_addr);
> +
> +	chunk = &line->chks[pos];
> +
> +	if (rqd->error == NVM_RSP_ERR_EMPTYPAGE)
> +		chunk->state = NVM_CHK_ST_FREE;
> +	else
> +		chunk->state = NVM_CHK_ST_CLOSED;
> +
> +	bio_put(rqd->bio);
> +	pblk_free_rqd(pblk, rqd, PBLK_READ);
> +	kref_put(&pad_rq->ref, pblk_state_complete);
> +}
> +
> +static int pblk_check_chunk_state(struct pblk *pblk, struct nvm_chk_meta *chunk,
> +				struct ppa_addr ppa, struct pblk_pad_rq *pad_rq)
> +{
> +	struct nvm_rq *rqd;
> +	struct bio *bio;
> +	int ret;
> +
> +	bio = bio_alloc(GFP_KERNEL, 1);
> +
> +	if (pblk_bio_add_pages(pblk, bio, GFP_KERNEL, 1))
> +		goto fail_free_bio;
> +
> +	rqd = pblk_alloc_rqd(pblk, PBLK_READ);
> +
> +	rqd->bio = bio;
> +	rqd->opcode = NVM_OP_PREAD;
> +	rqd->flags = pblk_set_read_mode(pblk, PBLK_READ_SEQUENTIAL);
> +	rqd->nr_ppas = 1;
> +	rqd->ppa_addr = ppa;
> +	rqd->end_io = pblk_end_io_state;
> +	rqd->private = pad_rq;
> +
> +	kref_get(&pad_rq->ref);
> +
> +	ret = pblk_submit_io(pblk, rqd);
> +	if (ret) {
> +		pr_err("pblk: I/O submissin failed: %d\n", ret);
> +		goto fail_free_rqd;
> +	}
> +
> +	return NVM_IO_OK;
> +
> +fail_free_rqd:
> +	pblk_free_rqd(pblk, rqd, PBLK_READ);
> +	pblk_bio_free_pages(pblk, bio, 0, bio->bi_vcnt);
> +fail_free_bio:
> +	bio_put(bio);
> +
> +	return NVM_IO_ERR;
> +}
> +
>   static int pblk_setup_line_meta_12(struct pblk *pblk, struct pblk_line *line,
>   				   void *chunk_meta)
>   {
>   	struct nvm_tgt_dev *dev = pblk->dev;
>   	struct nvm_geo *geo = &dev->geo;
>   	struct pblk_line_meta *lm = &pblk->lm;
> +	struct pblk_pad_rq *pad_rq;
>   	int i, chk_per_lun, nr_bad_chks = 0;
>   
> +	pad_rq = kmalloc(sizeof(struct pblk_pad_rq), GFP_KERNEL);
> +	if (!pad_rq)
> +		return -1;
> +
> +	pad_rq->pblk = pblk;
> +	init_completion(&pad_rq->wait);
> +	kref_init(&pad_rq->ref);
> +
>   	chk_per_lun = geo->num_chk * geo->pln_mode;
>   
>   	for (i = 0; i < lm->blk_per_line; i++) {
>   		struct pblk_lun *rlun = &pblk->luns[i];
>   		struct nvm_chk_meta *chunk;
> -		int pos = pblk_ppa_to_pos(geo, rlun->bppa);
> +		struct ppa_addr ppa = rlun->bppa;
> +		int pos = pblk_ppa_to_pos(geo, ppa);
>   		u8 *lun_bb_meta = chunk_meta + pos * chk_per_lun;
>   
>   		chunk = &line->chks[pos];
>   
> -		/*
> -		 * In 1.2 spec. chunk state is not persisted by the device. Thus
> -		 * some of the values are reset each time pblk is instantiated,
> -		 * so we have to assume that the block is closed.
> -		 */
> -		if (lun_bb_meta[line->id] == NVM_BLK_T_FREE)
> -			chunk->state =  NVM_CHK_ST_CLOSED;
> -		else
> -			chunk->state = NVM_CHK_ST_OFFLINE;
> -
>   		chunk->type = NVM_CHK_TP_W_SEQ;
>   		chunk->wi = 0;
>   		chunk->slba = -1;
>   		chunk->cnlb = geo->clba;
>   		chunk->wp = 0;
>   
> -		if (!(chunk->state & NVM_CHK_ST_OFFLINE))
> +		if (lun_bb_meta[line->id] != NVM_BLK_T_FREE) {
> +			chunk->state = NVM_CHK_ST_OFFLINE;
> +			set_bit(pos, line->blk_bitmap);
> +			nr_bad_chks++;
> +
>   			continue;
> +		}
>   
> -		set_bit(pos, line->blk_bitmap);
> -		nr_bad_chks++;
> +		/*
> +		 * In 1.2 spec. chunk state is not persisted by the device.
> +		 * Recover the state based on media response.
> +		 */
> +		ppa.g.blk = line->id;
> +		pblk_check_chunk_state(pblk, chunk, ppa, pad_rq);
>   	}
>   
> +	kref_put(&pad_rq->ref, pblk_state_complete);
> +
> +	if (!wait_for_completion_io_timeout(&pad_rq->wait,
> +				msecs_to_jiffies(PBLK_COMMAND_TIMEOUT_MS))) {
> +		pr_err("pblk: state recovery timed out\n");
> +		return -1;
> +	}
> +
> +	kfree(pad_rq);
>   	return nr_bad_chks;
>   }
>   
> @@ -1036,6 +1127,23 @@ static int pblk_line_meta_init(struct pblk *pblk)
>   	return 0;
>   }
>   
> +static void check_meta(struct pblk *pblk, struct pblk_line *line)
> +{
> +	struct nvm_tgt_dev *dev = pblk->dev;
> +	struct nvm_geo *geo = &dev->geo;
> +	struct pblk_line_meta *lm = &pblk->lm;
> +	int i;
> +
> +	for (i = 0; i < lm->blk_per_line; i++) {
> +		struct pblk_lun *rlun = &pblk->luns[i];
> +		struct nvm_chk_meta *chunk;
> +		struct ppa_addr ppa = rlun->bppa;
> +		int pos = pblk_ppa_to_pos(geo, ppa);
> +
> +		chunk = &line->chks[pos];
> +	}
> +}
> +
>   static int pblk_lines_init(struct pblk *pblk)
>   {
>   	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
> @@ -1077,6 +1185,8 @@ static int pblk_lines_init(struct pblk *pblk)
>   			goto fail_free_lines;
>   
>   		nr_free_chks += pblk_setup_line_meta(pblk, line, chunk_meta, i);
> +
> +		check_meta(pblk, line);
>   	}
>   
>   	if (!nr_free_chks) {
> 

I'm okay with us doing this in pblk for now. Over time, someone may do 
the work move this (and other specific only-1.2/2.0 stuff) into the 
lightnvm subsystem. I don't think pblk should need to care about either 
1.2 or 2.0.
