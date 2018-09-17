Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36704ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4822147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="DDvkTsC0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF4822147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbeIQNw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 09:52:56 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33746 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbeIQNw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 09:52:56 -0400
Received: by mail-ed1-f66.google.com with SMTP id d8-v6so12179276edv.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 01:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I9YDhd1l7k1yBhTYB/Fw/Jk8rQi7IfoKQmtu15LWyIg=;
        b=DDvkTsC0PsFnE0Mn5JOrh7ufDBfWOBrAHNQY0vCD7hWjQ66w7BxFq12TU6IBC393mG
         RFUMVmnfUXb4YDj1d9965A5Httjg58G2CG/9MAMr57QHUad1lmJdX0Bm9VwYFzv1XnSa
         0qBtXi8ps8q4fAthK3c60oWjCsEJEe1Baoh6AZtYD9yYXSeLCAIroNyrVTqGvVIZJslp
         NWgGhY0aduO10i/nzsxaL6bNoVCuP75kcmNs2dvAqalJUFXJyUsMAYNJ975NpJ8oYiPD
         itGE9mmpqQidU/kCKKuxJKt103qShwRVQjvfcqlTIMp0E7uQnhQ7fdDKATJsLbCh7SKw
         yPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I9YDhd1l7k1yBhTYB/Fw/Jk8rQi7IfoKQmtu15LWyIg=;
        b=Bdf7u40V9bu/aNAAYOW5TjqBCUSz9QnC8pnpw6igdhaSaFlvtKW/c93OxYqxQgaWPL
         TakeNeZy+hIOVHWBIWnscm9nbp2a17yd+ebzel5AZtusXh8M1Edk5V1cVBAtcZWKYL6g
         a7CAKBGRzkekL2CWma+BvNmjV9UZ1Myt+I3zOgvUaKuglG1wA4c4W8iGUE7hvI848YQ9
         E99gZRjUpUXT7hC8cF83FZMDM/qiJMPgy7EXSgzgoS0ctYYawVvg2d38PAITmzg9VDGh
         JIAkcGZvnyNqVg3F8qyf1oxMeqNTnZdRYoq+5S2cdCub3z3DG/IuWGlABnkUqFNKTNx4
         Ywsg==
X-Gm-Message-State: APzg51BFi4td3hY5fu1EGg70+Q7fTdQl1esU2QM8oNzqNuN1VprOHZxS
        i7Hlw4Ls7pX97Jtc0mzETstUkcZ0Lzk=
X-Google-Smtp-Source: ANB0VdYqOx8Xlf20uzevrpRjlaDUdHPigooHIxF/9KADvmvw32s7B6vEnC2JYST8QCy9XbNOcxYnKA==
X-Received: by 2002:a50:b0c1:: with SMTP id j59-v6mr39202032edd.267.1537172792873;
        Mon, 17 Sep 2018 01:26:32 -0700 (PDT)
Received: from [192.168.0.10] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id g38-v6sm6772654edc.40.2018.09.17.01.26.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 01:26:31 -0700 (PDT)
Subject: Re: [PATCH 2/2] lightnvm: pblk: retrieve chunk metadata on erase
To:     javier@javigon.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com
References: <1536665734-14305-1-git-send-email-javier@cnexlabs.com>
 <1536665734-14305-3-git-send-email-javier@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <cc17398e-a3dd-4777-3f71-c10751f1aca0@lightnvm.io>
Date:   Mon, 17 Sep 2018 10:26:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536665734-14305-3-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2018 01:35 PM, Javier González wrote:
> On the OCSSD 2.0 spec, the device populates the metadata pointer (if
> provided) when a chunk is reset. Implement this path in pblk and use it
> for sanity chunk checks.
> 
> For 1.2, reset the write pointer and the state on core so that the erase
> path is transparent to pblk wrt OCSSD version.
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/lightnvm/core.c      | 44 ++++++++++++++++++++++++++++++++++++--
>   drivers/lightnvm/pblk-core.c | 51 +++++++++++++++++++++++++++++++++-----------
>   2 files changed, 80 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index efb976a863d2..dceaae4e795f 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -750,9 +750,40 @@ int nvm_submit_io(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd)
>   }
>   EXPORT_SYMBOL(nvm_submit_io);
>   
> +/* Take only addresses in generic format */
> +static void nvm_set_chunk_state_12(struct nvm_dev *dev, struct nvm_rq *rqd)
> +{
> +	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
> +	int i;
> +
> +	for (i = 0; i < rqd->nr_ppas; i++) {
> +		struct ppa_addr ppa;
> +		struct nvm_chk_meta *chunk;
> +
> +		chunk = ((struct nvm_chk_meta *)rqd->meta_list) + i;
> +
> +		if (rqd->error)
> +			chunk->state = NVM_CHK_ST_OFFLINE;
> +		else
> +			chunk->state = NVM_CHK_ST_FREE;
> +
> +		chunk->wp = 0;
> +		chunk->wi = 0;
> +		chunk->type = NVM_CHK_TP_W_SEQ;
> +		chunk->cnlb = dev->geo.clba;
> +
> +		/* recalculate slba for the chunk */
> +		ppa = ppa_list[i];
> +		ppa.g.pg = ppa.g.pl = ppa.g.sec = 0;
> +
> +		chunk->slba = generic_to_dev_addr(dev, ppa).ppa;
> +	}
> +}
> +
>   int nvm_submit_io_sync(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd)
>   {
>   	struct nvm_dev *dev = tgt_dev->parent;
> +	struct nvm_geo *geo = &dev->geo;
>   	int ret;
>   
>   	if (!dev->ops->submit_io_sync)
> @@ -765,8 +796,12 @@ int nvm_submit_io_sync(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd)
>   
>   	/* In case of error, fail with right address format */
>   	ret = dev->ops->submit_io_sync(dev, rqd);
> +
>   	nvm_rq_dev_to_tgt(tgt_dev, rqd);
>   
> +	if (geo->version == NVM_OCSSD_SPEC_12 && rqd->opcode == NVM_OP_ERASE)
> +		nvm_set_chunk_state_12(dev, rqd);
> +
>   	return ret;
>   }
>   EXPORT_SYMBOL(nvm_submit_io_sync);
> @@ -775,10 +810,15 @@ void nvm_end_io(struct nvm_rq *rqd)
>   {
>   	struct nvm_tgt_dev *tgt_dev = rqd->dev;
>   
> -	/* Convert address space */
> -	if (tgt_dev)
> +	if (tgt_dev) {
> +		/* Convert address space */
>   		nvm_rq_dev_to_tgt(tgt_dev, rqd);
>   
> +		if (tgt_dev->geo.version == NVM_OCSSD_SPEC_12 &&
> +						rqd->opcode == NVM_OP_ERASE)
> +			nvm_set_chunk_state_12(tgt_dev->parent, rqd);
> +	}
> +
>   	if (rqd->end_io)
>   		rqd->end_io(rqd);
>   }
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index 417d12b274da..80f0ec756672 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -79,7 +79,7 @@ static void __pblk_end_io_erase(struct pblk *pblk, struct nvm_rq *rqd)
>   {
>   	struct nvm_tgt_dev *dev = pblk->dev;
>   	struct nvm_geo *geo = &dev->geo;
> -	struct nvm_chk_meta *chunk;
> +	struct nvm_chk_meta *chunk, *dev_chunk;
>   	struct pblk_line *line;
>   	int pos;
>   
> @@ -89,22 +89,39 @@ static void __pblk_end_io_erase(struct pblk *pblk, struct nvm_rq *rqd)
>   
>   	atomic_dec(&line->left_seblks);
>   
> +	/* pblk submits a single erase per command */
> +	dev_chunk = rqd->meta_list;
> +
> +	if (dev_chunk->slba != chunk->slba || dev_chunk->wp)
> +		print_chunk(pblk, chunk, "corrupted erase chunk", 0);
> +
> +	memcpy(chunk, dev_chunk, sizeof(struct nvm_chk_meta));
> +
>   	if (rqd->error) {
>   		trace_pblk_chunk_reset(pblk_disk_name(pblk),
>   				&rqd->ppa_addr, PBLK_CHUNK_RESET_FAILED);
>   
> -		chunk->state = NVM_CHK_ST_OFFLINE;
> +#ifdef CONFIG_NVM_PBLK_DEBUG
> +		if (chunk->state != NVM_CHK_ST_OFFLINE)
> +			print_chunk(pblk, chunk,
> +					"corrupted erase chunk state", 0);
> +#endif
>   		pblk_mark_bb(pblk, line, rqd->ppa_addr);
>   	} else {
>   		trace_pblk_chunk_reset(pblk_disk_name(pblk),
>   				&rqd->ppa_addr, PBLK_CHUNK_RESET_DONE);
>   
> -		chunk->state = NVM_CHK_ST_FREE;
> +#ifdef CONFIG_NVM_PBLK_DEBUG
> +		if (chunk->state != NVM_CHK_ST_FREE)
> +			print_chunk(pblk, chunk,
> +					"corrupted erase chunk state", 0);
> +#endif >   	}
>   
>   	trace_pblk_chunk_state(pblk_disk_name(pblk), &rqd->ppa_addr,
>   				chunk->state);
>   
> +	pblk_free_rqd_meta(pblk, rqd);
>   	atomic_dec(&pblk->inflight_io);
>   }
>   
> @@ -952,14 +969,16 @@ int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
>   	return ret;
>   }
>   
> -static void pblk_setup_e_rq(struct pblk *pblk, struct nvm_rq *rqd,
> -			    struct ppa_addr ppa)
> +static int pblk_setup_e_rq(struct pblk *pblk, struct nvm_rq *rqd,
> +			   struct ppa_addr ppa)
>   {
>   	rqd->opcode = NVM_OP_ERASE;
>   	rqd->ppa_addr = ppa;
>   	rqd->nr_ppas = 1;
>   	rqd->is_seq = 1;
>   	rqd->bio = NULL;
> +
> +	return pblk_alloc_rqd_meta(pblk, rqd);
>   }
>   
>   static int pblk_blk_erase_sync(struct pblk *pblk, struct ppa_addr ppa)
> @@ -967,10 +986,12 @@ static int pblk_blk_erase_sync(struct pblk *pblk, struct ppa_addr ppa)
>   	struct nvm_rq rqd = {NULL};
>   	int ret;
>   
> +	ret = pblk_setup_e_rq(pblk, &rqd, ppa);
> +	if (ret)
> +		return ret;
> +
>   	trace_pblk_chunk_reset(pblk_disk_name(pblk), &ppa,
> -				PBLK_CHUNK_RESET_START);
> -
> -	pblk_setup_e_rq(pblk, &rqd, ppa);
> +						PBLK_CHUNK_RESET_START);
>   
>   	/* The write thread schedules erases so that it minimizes disturbances
>   	 * with writes. Thus, there is no need to take the LUN semaphore.
> @@ -1774,11 +1795,15 @@ void pblk_line_put_wq(struct kref *ref)
>   int pblk_blk_erase_async(struct pblk *pblk, struct ppa_addr ppa)
>   {
>   	struct nvm_rq *rqd;
> -	int err;
> +	int ret;
>   
>   	rqd = pblk_alloc_rqd(pblk, PBLK_ERASE);
>   
> -	pblk_setup_e_rq(pblk, rqd, ppa);
> +	ret = pblk_setup_e_rq(pblk, rqd, ppa);
> +	if (ret) {
> +		pblk_free_rqd(pblk, rqd, PBLK_ERASE);
> +		return ret;
> +	}
>   
>   	rqd->end_io = pblk_end_io_erase;
>   	rqd->private = pblk;
> @@ -1789,8 +1814,8 @@ int pblk_blk_erase_async(struct pblk *pblk, struct ppa_addr ppa)
>   	/* The write thread schedules erases so that it minimizes disturbances
>   	 * with writes. Thus, there is no need to take the LUN semaphore.
>   	 */
> -	err = pblk_submit_io(pblk, rqd);
> -	if (err) {
> +	ret = pblk_submit_io(pblk, rqd);
> +	if (ret) {
>   		struct nvm_tgt_dev *dev = pblk->dev;
>   		struct nvm_geo *geo = &dev->geo;
>   
> @@ -1799,7 +1824,7 @@ int pblk_blk_erase_async(struct pblk *pblk, struct ppa_addr ppa)
>   					pblk_ppa_to_pos(geo, ppa));
>   	}
>   
> -	return err;
> +	return ret;
>   }
>   
>   struct pblk_line *pblk_line_get_data(struct pblk *pblk)
> 

I'll lean towards not taking this patch. The usecase adds extra logic, 
overhead, complexity, and its only usecase for debugging.

I am not an advocate of defensive coding in the fast path. For example, 
if an SLBA is inequal with the chunk slba, the drive is buggy, and does 
not behave according to the spec. and therefore does not warrant the 
checks. These type of bugs can be caught in the general drive testing suite.
