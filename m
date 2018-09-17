Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D0CECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25AE214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="EU6HPlHi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25AE214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbeIQNjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 09:39:43 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42891 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbeIQNjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 09:39:43 -0400
Received: by mail-ed1-f67.google.com with SMTP id l5so12121725edw.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 01:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=epeG0DhenjP0u7pI0HvTJKFmwml6LKw+TfD5hqFj2G4=;
        b=EU6HPlHiu/08uLmNkygjKj9VPph0QrmH/cL6vSFIxj7B9U7/L6Qi0RThe9/gbGR7Qo
         f1IeJKoAMJlzznpFuAbYSqfAi7WkfSweNrMAB8hOw7FX4PXg9VMFOI3mbea4/tNu2kO1
         dxnBkV5MVPrbMh778oTe+DbIo0xO4dh4jNwwryLXSnU4Hy5+gWreNA9NsTBFxv26ssaT
         dZVUYA8gkn/FzIent3NyOiEqcWJxfs1dhMhxGEeXxPAD46nhKuZQAJH0m3Md61q/C1/N
         Ji7g82QiDt6ilpjX2wU8R+MjR8xJTom2VoYgHZN45vOWP7e0sU9h1sZCtmTXs8LVkDHo
         8tJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=epeG0DhenjP0u7pI0HvTJKFmwml6LKw+TfD5hqFj2G4=;
        b=pTI84Pb4civfo6dI7kh5KpSZ0dCp3m0mNmz6FU/aVLjLviDZxMdpsMK/6lpQ/rg7Zc
         ziQFH1CReKcbOK+8YxKnP/kWYIzuNMshQMypSE/XLdkdiWjNck3AKeMOjMr1AUPlk6wp
         MmsfijNcvRThIWnukTy9GGKYlvzf5AJ7WuwOteI0tL/TQMVn54pEOirUd6VTyYpzLnJC
         26fWNFyogXri2+NkOO7TWruqgF7T90bO4DT8ULyuIPCIdFQOzqreL4t0RzITYR7E2Gaf
         aWqPh3oHUdXEsxfbcFt1uXeSucM7hywIwJh4zKwna8snXn/WEqqyvtaRL80X90pMqwlK
         EUaA==
X-Gm-Message-State: APzg51AXjyPvMajyxCX7psFCSTeitX1o6kHbADfNWiaYAKx99xgiy2uI
        zeUzTgV1R49VEn0wMCOwvlW+tA==
X-Google-Smtp-Source: ANB0VdZOAgshu1liSguaHKdTQBnCiWgziwA0N5CcHA824IuCLX8Sv2Kmm9SID98l7xFwPERCAS5NNQ==
X-Received: by 2002:a50:abc2:: with SMTP id u60-v6mr41267638edc.131.1537172003484;
        Mon, 17 Sep 2018 01:13:23 -0700 (PDT)
Received: from [192.168.0.10] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id g4-v6sm7268373eda.86.2018.09.17.01.13.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 01:13:22 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: recover open lines on 2.0 devices
To:     javier@javigon.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com
References: <1536665354-13493-1-git-send-email-javier@cnexlabs.com>
 <1536665354-13493-2-git-send-email-javier@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <4a95e41c-22af-2c5a-1af3-8e70669e738d@lightnvm.io>
Date:   Mon, 17 Sep 2018 10:13:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536665354-13493-2-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2018 01:29 PM, Javier González wrote:
> In the OCSSD 2.0 spec, each chunk reports its write pointer. This means
> that pblk does not need to scan open lines to find the write pointer,
> but instead, it can retrieve it directly (and verify it).
> 
> This patch uses the write pointer on open lines to (i) recover the line
> up until the last written lba and (ii) reconstruct the map bitmap and
> rest of line metadata so that the line can be used for new data.
> 
> Since the 1.2 path in lightnvm core has been re-implemented to populate
> the chunk structure and thus recover the write pointer on
> initialization, this patch removes 1.2 specific recovery, as the 2.0
> path can be reused.
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk-recovery.c | 406 ++++++++++++---------------------------
>   1 file changed, 124 insertions(+), 282 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
> index 6c57eb00a7f1..fccf65bc70b3 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -86,15 +86,39 @@ static int pblk_recov_l2p_from_emeta(struct pblk *pblk, struct pblk_line *line)
>   	return 0;
>   }
>   
> -static int pblk_calc_sec_in_line(struct pblk *pblk, struct pblk_line *line)
> +static void pblk_update_line_wp(struct pblk *pblk, struct pblk_line *line,
> +				u64 written_secs)
> +{
> +	int i;
> +
> +	for (i = 0; i < written_secs; i += pblk->min_write_pgs)
> +		pblk_alloc_page(pblk, line, pblk->min_write_pgs);
> +}
> +
> +static u64 pblk_sec_in_open_line(struct pblk *pblk, struct pblk_line *line)
>   {
> -	struct nvm_tgt_dev *dev = pblk->dev;
> -	struct nvm_geo *geo = &dev->geo;
>   	struct pblk_line_meta *lm = &pblk->lm;
>   	int nr_bb = bitmap_weight(line->blk_bitmap, lm->blk_per_line);
> +	u64 written_secs = 0;
> +	int valid_chunks = 0;
> +	int i;
>   
> -	return lm->sec_per_line - lm->smeta_sec - lm->emeta_sec[0] -
> -				nr_bb * geo->clba;
> +	for (i = 0; i < lm->blk_per_line; i++) {
> +		struct nvm_chk_meta *chunk = &line->chks[i];
> +
> +		if (chunk->state & NVM_CHK_ST_OFFLINE)
> +			continue;
> +
> +		written_secs += chunk->wp;
> +		valid_chunks++;
> +	}
> +
> +	if (lm->blk_per_line - nr_bb != valid_chunks)
> +		pblk_err(pblk, "recovery line %d is bad\n", line->id);
> +
> +	pblk_update_line_wp(pblk, line, written_secs - lm->smeta_sec);
> +
> +	return written_secs;
>   }
>   
>   struct pblk_recov_alloc {
> @@ -106,115 +130,6 @@ struct pblk_recov_alloc {
>   	dma_addr_t dma_meta_list;
>   };
>   
> -static int pblk_recov_read_oob(struct pblk *pblk, struct pblk_line *line,
> -			       struct pblk_recov_alloc p, u64 r_ptr)
> -{
> -	struct nvm_tgt_dev *dev = pblk->dev;
> -	struct nvm_geo *geo = &dev->geo;
> -	struct ppa_addr *ppa_list;
> -	struct pblk_sec_meta *meta_list;
> -	struct nvm_rq *rqd;
> -	struct bio *bio;
> -	void *data;
> -	dma_addr_t dma_ppa_list, dma_meta_list;
> -	u64 r_ptr_int;
> -	int left_ppas;
> -	int rq_ppas, rq_len;
> -	int i, j;
> -	int ret = 0;
> -
> -	ppa_list = p.ppa_list;
> -	meta_list = p.meta_list;
> -	rqd = p.rqd;
> -	data = p.data;
> -	dma_ppa_list = p.dma_ppa_list;
> -	dma_meta_list = p.dma_meta_list;
> -
> -	left_ppas = line->cur_sec - r_ptr;
> -	if (!left_ppas)
> -		return 0;
> -
> -	r_ptr_int = r_ptr;
> -
> -next_read_rq:
> -	memset(rqd, 0, pblk_g_rq_size);
> -
> -	rq_ppas = pblk_calc_secs(pblk, left_ppas, 0);
> -	if (!rq_ppas)
> -		rq_ppas = pblk->min_write_pgs;
> -	rq_len = rq_ppas * geo->csecs;
> -
> -	bio = bio_map_kern(dev->q, data, rq_len, GFP_KERNEL);
> -	if (IS_ERR(bio))
> -		return PTR_ERR(bio);
> -
> -	bio->bi_iter.bi_sector = 0; /* internal bio */
> -	bio_set_op_attrs(bio, REQ_OP_READ, 0);
> -
> -	rqd->bio = bio;
> -	rqd->opcode = NVM_OP_PREAD;
> -	rqd->meta_list = meta_list;
> -	rqd->nr_ppas = rq_ppas;
> -	rqd->ppa_list = ppa_list;
> -	rqd->dma_ppa_list = dma_ppa_list;
> -	rqd->dma_meta_list = dma_meta_list;
> -
> -	if (pblk_io_aligned(pblk, rq_ppas))
> -		rqd->is_seq = 1;
> -
> -	ppa_list = nvm_rq_to_ppa_list(rqd);
> -
> -	for (i = 0; i < rqd->nr_ppas; ) {
> -		struct ppa_addr ppa;
> -		int pos;
> -
> -		ppa = addr_to_gen_ppa(pblk, r_ptr_int, line->id);
> -		pos = pblk_ppa_to_pos(geo, ppa);
> -
> -		while (test_bit(pos, line->blk_bitmap)) {
> -			r_ptr_int += pblk->min_write_pgs;
> -			ppa = addr_to_gen_ppa(pblk, r_ptr_int, line->id);
> -			pos = pblk_ppa_to_pos(geo, ppa);
> -		}
> -
> -		for (j = 0; j < pblk->min_write_pgs; j++, i++, r_ptr_int++)
> -			ppa_list[i] =
> -				addr_to_gen_ppa(pblk, r_ptr_int, line->id);
> -	}
> -
> -	/* If read fails, more padding is needed */
> -	ret = pblk_submit_io_sync(pblk, rqd);
> -	if (ret) {
> -		pblk_err(pblk, "I/O submission failed: %d\n", ret);
> -		return ret;
> -	}
> -
> -	atomic_dec(&pblk->inflight_io);
> -
> -	/* At this point, the read should not fail. If it does, it is a problem
> -	 * we cannot recover from here. Need FTL log.
> -	 */
> -	if (rqd->error && rqd->error != NVM_RSP_WARN_HIGHECC) {
> -		pblk_err(pblk, "L2P recovery failed (%d)\n", rqd->error);
> -		return -EINTR;
> -	}
> -
> -	for (i = 0; i < rqd->nr_ppas; i++) {
> -		u64 lba = le64_to_cpu(meta_list[i].lba);
> -
> -		if (lba == ADDR_EMPTY || lba > pblk->rl.nr_secs)
> -			continue;
> -
> -		pblk_update_map(pblk, lba, ppa_list[i]);
> -	}
> -
> -	left_ppas -= rq_ppas;
> -	if (left_ppas > 0)
> -		goto next_read_rq;
> -
> -	return 0;
> -}
> -
>   static void pblk_recov_complete(struct kref *ref)
>   {
>   	struct pblk_pad_rq *pad_rq = container_of(ref, struct pblk_pad_rq, ref);
> @@ -236,8 +151,9 @@ static void pblk_end_io_recov(struct nvm_rq *rqd)
>   	kref_put(&pad_rq->ref, pblk_recov_complete);
>   }
>   
> -static int pblk_recov_pad_oob(struct pblk *pblk, struct pblk_line *line,
> -			      int left_ppas)
> +/* pad line using line bitmap.  */
> +static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
> +			       int left_ppas)
>   {
>   	struct nvm_tgt_dev *dev = pblk->dev;
>   	struct nvm_geo *geo = &dev->geo;
> @@ -379,143 +295,42 @@ static int pblk_pad_distance(struct pblk *pblk, struct pblk_line *line)
>   	return (distance > line->left_msecs) ? line->left_msecs : distance;
>   }
>   
> -/* When this function is called, it means that not all upper pages have been
> - * written in a page that contains valid data. In order to recover this data, we
> - * first find the write pointer on the device, then we pad all necessary
> - * sectors, and finally attempt to read the valid data
> - */
> -static int pblk_recov_scan_all_oob(struct pblk *pblk, struct pblk_line *line,
> -				   struct pblk_recov_alloc p)
> +static int pblk_line_wp_is_unbalanced(struct pblk *pblk,
> +				      struct pblk_line *line)
>   {
>   	struct nvm_tgt_dev *dev = pblk->dev;
>   	struct nvm_geo *geo = &dev->geo;
> -	struct ppa_addr *ppa_list;
> -	struct pblk_sec_meta *meta_list;
> -	struct nvm_rq *rqd;
> -	struct bio *bio;
> -	void *data;
> -	dma_addr_t dma_ppa_list, dma_meta_list;
> -	u64 w_ptr = 0, r_ptr;
> -	int rq_ppas, rq_len;
> -	int i, j;
> -	int ret = 0;
> -	int rec_round;
> -	int left_ppas = pblk_calc_sec_in_line(pblk, line) - line->cur_sec;
> -
> -	ppa_list = p.ppa_list;
> -	meta_list = p.meta_list;
> -	rqd = p.rqd;
> -	data = p.data;
> -	dma_ppa_list = p.dma_ppa_list;
> -	dma_meta_list = p.dma_meta_list;
> -
> -	/* we could recover up until the line write pointer */
> -	r_ptr = line->cur_sec;
> -	rec_round = 0;
> -
> -next_rq:
> -	memset(rqd, 0, pblk_g_rq_size);
> -
> -	rq_ppas = pblk_calc_secs(pblk, left_ppas, 0);
> -	if (!rq_ppas)
> -		rq_ppas = pblk->min_write_pgs;
> -	rq_len = rq_ppas * geo->csecs;
> -
> -	bio = bio_map_kern(dev->q, data, rq_len, GFP_KERNEL);
> -	if (IS_ERR(bio))
> -		return PTR_ERR(bio);
> -
> -	bio->bi_iter.bi_sector = 0; /* internal bio */
> -	bio_set_op_attrs(bio, REQ_OP_READ, 0);
> -
> -	rqd->bio = bio;
> -	rqd->opcode = NVM_OP_PREAD;
> -	rqd->meta_list = meta_list;
> -	rqd->nr_ppas = rq_ppas;
> -	rqd->ppa_list = ppa_list;
> -	rqd->dma_ppa_list = dma_ppa_list;
> -	rqd->dma_meta_list = dma_meta_list;
> -
> -	if (pblk_io_aligned(pblk, rq_ppas))
> -		rqd->is_seq = 1;
> -
> -	for (i = 0; i < rqd->nr_ppas; ) {
> -		struct ppa_addr ppa;
> -		int pos;
> -
> -		w_ptr = pblk_alloc_page(pblk, line, pblk->min_write_pgs);
> -		ppa = addr_to_gen_ppa(pblk, w_ptr, line->id);
> +	struct pblk_line_meta *lm = &pblk->lm;
> +	struct pblk_lun *rlun;
> +	struct nvm_chk_meta *chunk;
> +	struct ppa_addr ppa;
> +	u64 line_wp;
> +	int pos, i;
> +
> +	rlun = &pblk->luns[0];
> +	ppa = rlun->bppa;
> +	pos = pblk_ppa_to_pos(geo, ppa);
> +	chunk = &line->chks[pos];
> +
> +	line_wp = chunk->wp;
> +
> +	for (i = 1; i < lm->blk_per_line; i++) {
> +		rlun = &pblk->luns[i];
> +		ppa = rlun->bppa;
>   		pos = pblk_ppa_to_pos(geo, ppa);
> +		chunk = &line->chks[pos];
>   
> -		while (test_bit(pos, line->blk_bitmap)) {
> -			w_ptr += pblk->min_write_pgs;
> -			ppa = addr_to_gen_ppa(pblk, w_ptr, line->id);
> -			pos = pblk_ppa_to_pos(geo, ppa);
> -		}
> -
> -		for (j = 0; j < pblk->min_write_pgs; j++, i++, w_ptr++)
> -			rqd->ppa_list[i] =
> -				addr_to_gen_ppa(pblk, w_ptr, line->id);
> -	}
> -
> -	ret = pblk_submit_io_sync(pblk, rqd);
> -	if (ret) {
> -		pblk_err(pblk, "I/O submission failed: %d\n", ret);
> -		return ret;
> +		if (chunk->wp > line_wp)
> +			return 1;
> +		else if (chunk->wp < line_wp)
> +			line_wp = chunk->wp;
>   	}
>   
> -	atomic_dec(&pblk->inflight_io);
> -
> -	/* This should not happen since the read failed during normal recovery,
> -	 * but the media works funny sometimes...
> -	 */
> -	if (!rec_round++ && !rqd->error) {
> -		rec_round = 0;
> -		for (i = 0; i < rqd->nr_ppas; i++, r_ptr++) {
> -			u64 lba = le64_to_cpu(meta_list[i].lba);
> -
> -			if (lba == ADDR_EMPTY || lba > pblk->rl.nr_secs)
> -				continue;
> -
> -			pblk_update_map(pblk, lba, rqd->ppa_list[i]);
> -		}
> -	}
> -
> -	/* Reached the end of the written line */
> -	if (rqd->error == NVM_RSP_ERR_EMPTYPAGE) {
> -		int pad_secs, nr_error_bits, bit;
> -		int ret;
> -
> -		bit = find_first_bit((void *)&rqd->ppa_status, rqd->nr_ppas);
> -		nr_error_bits = rqd->nr_ppas - bit;
> -
> -		/* Roll back failed sectors */
> -		line->cur_sec -= nr_error_bits;
> -		line->left_msecs += nr_error_bits;
> -		bitmap_clear(line->map_bitmap, line->cur_sec, nr_error_bits);
> -
> -		pad_secs = pblk_pad_distance(pblk, line);
> -
> -		ret = pblk_recov_pad_oob(pblk, line, pad_secs);
> -		if (ret)
> -			pblk_err(pblk, "OOB padding failed (err:%d)\n", ret);
> -
> -		ret = pblk_recov_read_oob(pblk, line, p, r_ptr);
> -		if (ret)
> -			pblk_err(pblk, "OOB read failed (err:%d)\n", ret);
> -
> -		left_ppas = 0;
> -	}
> -
> -	left_ppas -= rq_ppas;
> -	if (left_ppas > 0)
> -		goto next_rq;
> -
> -	return ret;
> +	return 0;
>   }
>   
>   static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
> -			       struct pblk_recov_alloc p, int *done)
> +			       struct pblk_recov_alloc p)
>   {
>   	struct nvm_tgt_dev *dev = pblk->dev;
>   	struct nvm_geo *geo = &dev->geo;
> @@ -525,11 +340,16 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
>   	struct bio *bio;
>   	void *data;
>   	dma_addr_t dma_ppa_list, dma_meta_list;
> -	u64 paddr;
> +	__le64 *lba_list;
> +	u64 paddr = 0;
> +	bool padded = false;
>   	int rq_ppas, rq_len;
>   	int i, j;
> -	int ret = 0;
> -	int left_ppas = pblk_calc_sec_in_line(pblk, line);
> +	int ret;
> +	u64 left_ppas = pblk_sec_in_open_line(pblk, line);
> +
> +	if (pblk_line_wp_is_unbalanced(pblk, line))
> +		pblk_warn(pblk, "recovering unbalanced line (%d)\n", line->id);
>   
>   	ppa_list = p.ppa_list;
>   	meta_list = p.meta_list;
> @@ -538,7 +358,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
>   	dma_ppa_list = p.dma_ppa_list;
>   	dma_meta_list = p.dma_meta_list;
>   
> -	*done = 1;
> +	lba_list = emeta_to_lbas(pblk, line->emeta->buf);
>   
>   next_rq:
>   	memset(rqd, 0, pblk_g_rq_size);
> @@ -566,11 +386,11 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
>   	if (pblk_io_aligned(pblk, rq_ppas))
>   		rqd->is_seq = 1;
>   
> +retry_rq:
>   	for (i = 0; i < rqd->nr_ppas; ) {
>   		struct ppa_addr ppa;
>   		int pos;
>   
> -		paddr = pblk_alloc_page(pblk, line, pblk->min_write_pgs);
>   		ppa = addr_to_gen_ppa(pblk, paddr, line->id);
>   		pos = pblk_ppa_to_pos(geo, ppa);
>   
> @@ -580,9 +400,9 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
>   			pos = pblk_ppa_to_pos(geo, ppa);
>   		}
>   
> -		for (j = 0; j < pblk->min_write_pgs; j++, i++, paddr++)
> +		for (j = 0; j < pblk->min_write_pgs; j++, i++)
>   			rqd->ppa_list[i] =
> -				addr_to_gen_ppa(pblk, paddr, line->id);
> +				addr_to_gen_ppa(pblk, paddr + j, line->id);
>   	}
>   
>   	ret = pblk_submit_io_sync(pblk, rqd);
> @@ -594,31 +414,33 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
>   
>   	atomic_dec(&pblk->inflight_io);
>   
> -	/* Reached the end of the written line */
> +	/* If a read fails, do a best effort by padding the line and retrying */
>   	if (rqd->error) {
> -		int nr_error_bits, bit;
> +		int pad_distance, ret;
>   
> -		bit = find_first_bit((void *)&rqd->ppa_status, rqd->nr_ppas);
> -		nr_error_bits = rqd->nr_ppas - bit;
> +		if (padded) {
> +			pblk_log_read_err(pblk, rqd);
> +			return -EINTR;
> +		}
>   
> -		/* Roll back failed sectors */
> -		line->cur_sec -= nr_error_bits;
> -		line->left_msecs += nr_error_bits;
> -		bitmap_clear(line->map_bitmap, line->cur_sec, nr_error_bits);
> +		pad_distance = pblk_pad_distance(pblk, line);
> +		ret = pblk_recov_pad_line(pblk, line, pad_distance);
> +		if (ret)
> +			return ret;
>   
> -		left_ppas = 0;
> -		rqd->nr_ppas = bit;
> -
> -		if (rqd->error != NVM_RSP_ERR_EMPTYPAGE)
> -			*done = 0;
> +		padded = true;
> +		goto retry_rq;
>   	}
>   
>   	for (i = 0; i < rqd->nr_ppas; i++) {
>   		u64 lba = le64_to_cpu(meta_list[i].lba);
>   
> +		lba_list[paddr++] = cpu_to_le64(lba);
> +
>   		if (lba == ADDR_EMPTY || lba > pblk->rl.nr_secs)
>   			continue;
>   
> +		line->nr_valid_lbas++;
>   		pblk_update_map(pblk, lba, rqd->ppa_list[i]);
>   	}
>   
> @@ -626,7 +448,11 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
>   	if (left_ppas > 0)
>   		goto next_rq;
>   
> -	return ret;
> +#ifdef CONFIG_NVM_PBLK_DEBUG
> +	WARN_ON(padded && !pblk_line_is_full(line));
> +#endif
> +
> +	return 0;
>   }
>   
>   /* Scan line for lbas on out of bound area */
> @@ -640,7 +466,7 @@ static int pblk_recov_l2p_from_oob(struct pblk *pblk, struct pblk_line *line)
>   	struct pblk_recov_alloc p;
>   	void *data;
>   	dma_addr_t dma_ppa_list, dma_meta_list;
> -	int done, ret = 0;
> +	int ret = 0;
>   
>   	meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL, &dma_meta_list);
>   	if (!meta_list)
> @@ -655,7 +481,8 @@ static int pblk_recov_l2p_from_oob(struct pblk *pblk, struct pblk_line *line)
>   		goto free_meta_list;
>   	}
>   
> -	rqd = pblk_alloc_rqd(pblk, PBLK_READ);
> +	rqd = mempool_alloc(&pblk->r_rq_pool, GFP_KERNEL);
> +	memset(rqd, 0, pblk_g_rq_size);
>   
>   	p.ppa_list = ppa_list;
>   	p.meta_list = meta_list;
> @@ -664,24 +491,17 @@ static int pblk_recov_l2p_from_oob(struct pblk *pblk, struct pblk_line *line)
>   	p.dma_ppa_list = dma_ppa_list;
>   	p.dma_meta_list = dma_meta_list;
>   
> -	ret = pblk_recov_scan_oob(pblk, line, p, &done);
> +	ret = pblk_recov_scan_oob(pblk, line, p);
>   	if (ret) {
> -		pblk_err(pblk, "could not recover L2P from OOB\n");
> +		pblk_err(pblk, "could not recover L2P form OOB\n");
>   		goto out;
>   	}
>   
> -	if (!done) {
> -		ret = pblk_recov_scan_all_oob(pblk, line, p);
> -		if (ret) {
> -			pblk_err(pblk, "could not recover L2P from OOB\n");
> -			goto out;
> -		}
> -	}
> -
>   	if (pblk_line_is_full(line))
>   		pblk_line_recov_close(pblk, line);
>   
>   out:
> +	mempool_free(rqd, &pblk->r_rq_pool);
>   	kfree(data);
>   free_meta_list:
>   	nvm_dev_dma_free(dev->parent, meta_list, dma_meta_list);
> @@ -770,7 +590,7 @@ static void pblk_recov_wa_counters(struct pblk *pblk,
>   }
>   
>   static int pblk_line_was_written(struct pblk_line *line,
> -			    struct pblk *pblk)
> +				 struct pblk *pblk)
>   {
>   
>   	struct pblk_line_meta *lm = &pblk->lm;
> @@ -796,6 +616,18 @@ static int pblk_line_was_written(struct pblk_line *line,
>   	return 1;
>   }
>   
> +static bool pblk_line_is_open(struct pblk *pblk, struct pblk_line *line)
> +{
> +	struct pblk_line_meta *lm = &pblk->lm;
> +	int i;
> +
> +	for (i = 0; i < lm->blk_per_line; i++)
> +		if (line->chks[i].state & NVM_CHK_ST_OPEN)
> +			return true;
> +
> +	return false;
> +}
> +
>   struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
>   {
>   	struct pblk_line_meta *lm = &pblk->lm;
> @@ -906,6 +738,11 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
>   		line->emeta = emeta;
>   		memset(line->emeta->buf, 0, lm->emeta_len[0]);
>   
> +		if (pblk_line_is_open(pblk, line)) {
> +			pblk_recov_l2p_from_oob(pblk, line);
> +			goto next;
> +		}
> +
>   		if (pblk_line_emeta_read(pblk, line, line->emeta->buf)) {
>   			pblk_recov_l2p_from_oob(pblk, line);
>   			goto next;
> @@ -944,15 +781,20 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
>   			line->smeta = NULL;
>   			line->emeta = NULL;
>   		} else {
> -			if (open_lines > 1)
> -				pblk_err(pblk, "failed to recover L2P\n");
> +			spin_lock(&line->lock);
> +			line->state = PBLK_LINESTATE_OPEN;
> +			spin_unlock(&line->lock);
> +
> +			line->emeta->mem = 0;
> +			atomic_set(&line->emeta->sync, 0);
>   
>   			trace_pblk_line_state(pblk_disk_name(pblk), line->id,
>   					line->state);
>   
> -			open_lines++;
> -			line->meta_line = meta_line;
>   			data_line = line;
> +			line->meta_line = meta_line;
> +
> +			open_lines++;
>   		}
>   	}
>   
> @@ -1000,7 +842,7 @@ int pblk_recov_pad(struct pblk *pblk)
>   	left_msecs = line->left_msecs;
>   	spin_unlock(&l_mg->free_lock);
>   
> -	ret = pblk_recov_pad_oob(pblk, line, left_msecs);
> +	ret = pblk_recov_pad_line(pblk, line, left_msecs);
>   	if (ret) {
>   		pblk_err(pblk, "tear down padding failed (%d)\n", ret);
>   		return ret;
> 

Thanks. Applied for 4.20.
