Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B6FC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72EAF2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="A18hXnCz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72EAF2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbeH2SOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:14:19 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36458 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbeH2SOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:14:18 -0400
Received: by mail-pl1-f194.google.com with SMTP id e11-v6so2369532plb.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 07:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h/Fm1TGJVBWYySzQ6sb0BgLJ+BTmDTPetFu11f+LGS0=;
        b=A18hXnCz5ObP6Z648KYS+u0CnBAQYT5Cefwo8AWO2WnszEjacvdvTriu2hnr18iVpl
         ewJaZzMD6kmqVvLE7E/Qmlx8GsF0wfahJv9JRuh3w0yD+rTmgGnswwnMKWjObuN/Str2
         ktyR0FDbfUxucbPcf/IvX6YkxXHipSuGRjlLJQSmMIDa4j1fIpqh58h0B9nhcTYVE6ut
         bXr7MY6hpIwK7Abq2Y4e2i6XCeRbJYGKVZjLm/+uKfHqfNwkRVie0URdO6/kZmexnprk
         RwKrOOQr/6zpxyFHiSmyIMrkS2vV4rHXV2Lbjg/R7OF5rD3wNTph8GHZpmWj8VzyvDea
         P8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h/Fm1TGJVBWYySzQ6sb0BgLJ+BTmDTPetFu11f+LGS0=;
        b=PXF5D9QxKvCbxa2KNErzoJ25HVKgcE/gQrw+048sPuJTeVCwmwoq/q3NOEclUqbU7q
         Fad1MJAzSuI6itoIXkYxeGU7d0F68oT8IekvkwjRXI6LEFJaugLI8jDARQ6WOZ6HAAFp
         92orGxZrlMt9Kclr4/fxayZ6LQQ8oMdGP7b9LeNHG2t4RmboWNXuzvnO9yJm+ygOXOBC
         nUhCYyooEHSn0Z1CF32m7dBncbEP7RoeNwpnHfI8BBlWshmEKfj466EGpJ2Ime8smV1H
         z6yuiK/HzRS1ywUMM9a7aCTb0HhCieA1bYbWkGEfmJDwSLxmoIunR4CTk/6ky4BqQhAH
         KO/w==
X-Gm-Message-State: APzg51Abxkm9tLLf+SHg53N4Y4cE3vGExEwg4EabSYbvL/rCafyPoFcn
        4+omP9souTz+tgXFIvAPzwU3ew==
X-Google-Smtp-Source: ANB0VdZO6dKMQv0rphldGYYx4aQbZPgiVwrXqA5q/Uxca3C1i8m+GhNrHO1kJ0h0A21/GV56bf8udQ==
X-Received: by 2002:a17:902:7086:: with SMTP id z6-v6mr90017plk.236.1535552228951;
        Wed, 29 Aug 2018 07:17:08 -0700 (PDT)
Received: from [10.86.62.45] (rap-us.hgst.com. [199.255.44.250])
        by smtp.googlemail.com with ESMTPSA id d24-v6sm4880961pgv.23.2018.08.29.07.17.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 07:17:07 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: improve line helpers
To:     javier@javigon.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com
References: <1535532258-24039-1-git-send-email-javier@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <67952975-32cd-8dd0-6605-b634f3125f39@lightnvm.io>
Date:   Wed, 29 Aug 2018 16:17:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1535532258-24039-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/2018 10:44 AM, Javier González wrote:
> The current helper to obtain a line from a ppa returns the line id,
> which requires its users to explicitly retrieve the pointer to the line
> with the id.
> 
> Make 2 different helpers: one returning the line id and one returning
> the line directly.
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk-core.c  | 15 ++++++---------
>   drivers/lightnvm/pblk-rb.c    |  2 +-
>   drivers/lightnvm/pblk-read.c  |  4 ++--
>   drivers/lightnvm/pblk-write.c |  4 ++--
>   drivers/lightnvm/pblk.h       | 13 +++++++++----
>   5 files changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index 8e3f3c5fe233..dbf037b2b32f 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -35,7 +35,7 @@ static void pblk_line_mark_bb(struct work_struct *work)
>   		struct pblk_line *line;
>   		int pos;
>   
> -		line = &pblk->lines[pblk_ppa_to_line(*ppa)];
> +		line = pblk_ppa_to_line(pblk, *ppa);
>   		pos = pblk_ppa_to_pos(&dev->geo, *ppa);
>   
>   		pblk_err(pblk, "failed to mark bb, line:%d, pos:%d\n",
> @@ -83,7 +83,7 @@ static void __pblk_end_io_erase(struct pblk *pblk, struct nvm_rq *rqd)
>   	struct pblk_line *line;
>   	int pos;
>   
> -	line = &pblk->lines[pblk_ppa_to_line(rqd->ppa_addr)];
> +	line = pblk_ppa_to_line(pblk, rqd->ppa_addr);
>   	pos = pblk_ppa_to_pos(geo, rqd->ppa_addr);
>   	chunk = &line->chks[pos];
>   
> @@ -204,7 +204,6 @@ void pblk_map_invalidate(struct pblk *pblk, struct ppa_addr ppa)
>   {
>   	struct pblk_line *line;
>   	u64 paddr;
> -	int line_id;
>   
>   #ifdef CONFIG_NVM_PBLK_DEBUG
>   	/* Callers must ensure that the ppa points to a device address */
> @@ -212,8 +211,7 @@ void pblk_map_invalidate(struct pblk *pblk, struct ppa_addr ppa)
>   	BUG_ON(pblk_ppa_empty(ppa));
>   #endif
>   
> -	line_id = pblk_ppa_to_line(ppa);
> -	line = &pblk->lines[line_id];
> +	line = pblk_ppa_to_line(pblk, ppa);
>   	paddr = pblk_dev_ppa_to_line_addr(pblk, ppa);
>   
>   	__pblk_map_invalidate(pblk, line, paddr);
> @@ -1493,7 +1491,7 @@ void pblk_ppa_to_line_put(struct pblk *pblk, struct ppa_addr ppa)
>   {
>   	struct pblk_line *line;
>   
> -	line = &pblk->lines[pblk_ppa_to_line(ppa)];
> +	line = pblk_ppa_to_line(pblk, ppa);
>   	kref_put(&line->ref, pblk_line_put_wq);
>   }
>   
> @@ -1759,7 +1757,7 @@ int pblk_blk_erase_async(struct pblk *pblk, struct ppa_addr ppa)
>   		struct nvm_geo *geo = &dev->geo;
>   
>   		pblk_err(pblk, "could not async erase line:%d,blk:%d\n",
> -					pblk_ppa_to_line(ppa),
> +					pblk_ppa_to_line_id(ppa),
>   					pblk_ppa_to_pos(geo, ppa));
>   	}
>   
> @@ -2131,8 +2129,7 @@ void pblk_lookup_l2p_seq(struct pblk *pblk, struct ppa_addr *ppas,
>   
>   		/* If the L2P entry maps to a line, the reference is valid */
>   		if (!pblk_ppa_empty(ppa) && !pblk_addr_in_cache(ppa)) {
> -			int line_id = pblk_ppa_to_line(ppa);
> -			struct pblk_line *line = &pblk->lines[line_id];
> +			struct pblk_line *line = pblk_ppa_to_line(pblk, ppa);
>   
>   			kref_get(&line->ref);
>   		}
> diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
> index f6eec0212dfc..a7648e12f54f 100644
> --- a/drivers/lightnvm/pblk-rb.c
> +++ b/drivers/lightnvm/pblk-rb.c
> @@ -225,7 +225,7 @@ static int __pblk_rb_update_l2p(struct pblk_rb *rb, unsigned int to_update)
>   		pblk_update_map_dev(pblk, w_ctx->lba, w_ctx->ppa,
>   							entry->cacheline);
>   
> -		line = &pblk->lines[pblk_ppa_to_line(w_ctx->ppa)];
> +		line = pblk_ppa_to_line(pblk, w_ctx->ppa);
>   		kref_put(&line->ref, pblk_line_put);
>   		clean_wctx(w_ctx);
>   		rb->l2p_update = (rb->l2p_update + 1) & (rb->nr_entries - 1);
> diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
> index 97d602f153e2..6d13763f2f6a 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -249,9 +249,9 @@ static void pblk_end_partial_read(struct nvm_rq *rqd)
>   	i = 0;
>   	hole = find_first_zero_bit(read_bitmap, nr_secs);
>   	do {
> -		int line_id = pblk_ppa_to_line(rqd->ppa_list[i]);
> -		struct pblk_line *line = &pblk->lines[line_id];
> +		struct pblk_line *line;
>   
> +		line = pblk_ppa_to_line(pblk, rqd->ppa_list[i]);
>   		kref_put(&line->ref, pblk_line_put);
>   
>   		meta_list[hole].lba = lba_list_media[i];
> diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
> index a3c77092ad3f..8ea66bb83c29 100644
> --- a/drivers/lightnvm/pblk-write.c
> +++ b/drivers/lightnvm/pblk-write.c
> @@ -148,7 +148,7 @@ static void pblk_map_remaining(struct pblk *pblk, struct ppa_addr *ppa)
>   	u64 paddr;
>   	int done = 0;
>   
> -	line = &pblk->lines[pblk_ppa_to_line(*ppa)];
> +	line = pblk_ppa_to_line(pblk, *ppa);
>   	spin_lock(&line->lock);
>   
>   	while (!done)  {
> @@ -198,7 +198,7 @@ static void pblk_prepare_resubmit(struct pblk *pblk, unsigned int sentry,
>   		/* Decrese the reference count to the line as we will
>   		 * re-map these entries
>   		 */
> -		line = &pblk->lines[pblk_ppa_to_line(w_ctx->ppa)];
> +		line = pblk_ppa_to_line(pblk, w_ctx->ppa);
>   		kref_put(&line->ref, pblk_line_put);
>   
>   		pos = (pos + 1) & (rb->nr_entries - 1);
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 23e6b3528852..6195e3f5d2e6 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -994,11 +994,17 @@ static inline int pblk_pad_distance(struct pblk *pblk)
>   	return geo->mw_cunits * geo->all_luns * geo->ws_opt;
>   }
>   
> -static inline int pblk_ppa_to_line(struct ppa_addr p)
> +static inline int pblk_ppa_to_line_id(struct ppa_addr p)
>   {
>   	return p.a.blk;
>   }
>   
> +static inline struct pblk_line *pblk_ppa_to_line(struct pblk *pblk,
> +						 struct ppa_addr p)
> +{
> +	return &pblk->lines[pblk_ppa_to_line_id(p)];
> +}
> +
>   static inline int pblk_ppa_to_pos(struct nvm_geo *geo, struct ppa_addr p)
>   {
>   	return p.a.lun * geo->num_ch + p.a.ch;
> @@ -1049,7 +1055,7 @@ static inline struct nvm_chk_meta *pblk_dev_ppa_to_chunk(struct pblk *pblk,
>   {
>   	struct nvm_tgt_dev *dev = pblk->dev;
>   	struct nvm_geo *geo = &dev->geo;
> -	struct pblk_line *line = &pblk->lines[pblk_ppa_to_line(p)];
> +	struct pblk_line *line = pblk_ppa_to_line(pblk, p);
>   	int pos = pblk_ppa_to_pos(geo, p);
>   
>   	return &line->chks[pos];
> @@ -1391,8 +1397,7 @@ static inline int pblk_check_io(struct pblk *pblk, struct nvm_rq *rqd)
>   		int i;
>   
>   		for (i = 0; i < rqd->nr_ppas; i++) {
> -			ppa = ppa_list[i];
> -			line = &pblk->lines[pblk_ppa_to_line(ppa)];
> +			line = pblk_ppa_to_line(pblk, ppa_list[i]);
>   
>   			spin_lock(&line->lock);
>   			if (line->state != PBLK_LINESTATE_OPEN) {
> 

Thanks. Applied for 4.20.
