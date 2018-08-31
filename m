Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3FCC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3212077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="R7UUNuEt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F3212077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbeHaSWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:22:13 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37917 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727563AbeHaSWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:22:12 -0400
Received: by mail-lf1-f68.google.com with SMTP id i7-v6so10102260lfh.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 07:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RGydeJoBtP4AFmp8vlV1AUrDpMcQsrWDh/6C9daDoGc=;
        b=R7UUNuEtFIAHepQIGGeRY85Dxv+4Bm5So3LeuOFcLIKFgZI99PYVqk5aI+ci6zZV4u
         ZoxNanjfwVOv0c7A6ra8opGDBxqfcOD0p1B4xK5uxImv50zGtVb7ZGEZNULotW56FK63
         akqll4FlGwQI6MygsCiRb1P4WxN7H6rcQA17LBN3jP4E4VlZfv741/sRYEv19gZYjeMK
         dK9CPDeWAYeKqwPW5ulReRgSeZSKVTxdT9ilXqC3V6/EXuU7//5W1EP95FBk6OXT7gpr
         Ne2HXzH6PS6q7iYExC1AT5dK92SRrM4jSWZMyf+wV0g3w6liESx08+f6n/cJO7SEj37/
         CKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RGydeJoBtP4AFmp8vlV1AUrDpMcQsrWDh/6C9daDoGc=;
        b=JQkI0Kfmlwi88ZMKYaq53tIJ/EnrywE/qZxGLqmc7TawKB7yEZ74NrTbwjbeTcObrD
         ODjajZPknFP9B4hU/pSsks8l6MxIDJzebir+CY5KZ9Nl1nKY+BZ8gPeoGGqEXuMGni2U
         SAQr0RfOZZyHvsfv+1CqlhgXCTPoCaWiFKkSi2f/QbI3bTy4tluH0IxzYFNaMmfJ+J6W
         1v/hTco9hhBslLJSks5jGNHW6RUeVqYsJGqswlbA/Y/GhF7F+wMpybNmow1fGRHu/18v
         OI0pK6Kj2C/cC0yIJ9SFBeAAkP8h8KEGVbR9Ehd0uJofPps8s2Ip729RGULLeXgExybd
         +HLA==
X-Gm-Message-State: APzg51DkyYeFq/2LtR4G/E3YMmxxU2aMbKk6b/+hHQQAaqeMHsaR4UWF
        HxVWpiLRGR9HMJuuzIiRY8AXxw==
X-Google-Smtp-Source: ANB0VdY3uCm3g6M4yqLvL/0zn3npa/r5jFvU4fGbPRnMaz5/BpbT8xqeItoVfpHhtbJ9bUeHs/98Hw==
X-Received: by 2002:a19:6388:: with SMTP id v8-v6mr10758832lfi.95.1535724869202;
        Fri, 31 Aug 2018 07:14:29 -0700 (PDT)
Received: from [192.168.0.10] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id 17-v6sm1809998ljs.32.2018.08.31.07.14.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 07:14:28 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: stop recreating global caches
To:     hans.ml.holmberg@owltronix.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com
References: <1535709570-8923-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <1535709570-8923-2-git-send-email-hans.ml.holmberg@owltronix.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <c2e682ab-b1e9-596d-b892-0e72685cec37@lightnvm.io>
Date:   Fri, 31 Aug 2018 16:14:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1535709570-8923-2-git-send-email-hans.ml.holmberg@owltronix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/31/2018 11:59 AM, Hans Holmberg wrote:
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> 
> Pblk should not create a set of global caches every time
> a pblk instance is created. The global caches should be
> made available only when there is one or more pblk instances.
> 
> This patch bundles the global caches together with a kref
> keeping track of whether the caches should be available or not.
> 
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk-init.c | 113 ++++++++++++++++++++++++++-----------------
>   1 file changed, 68 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> index 9aebdee8e4c9..e2cdd840e7d0 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -26,9 +26,19 @@ static unsigned int write_buffer_size;
>   module_param(write_buffer_size, uint, 0644);
>   MODULE_PARM_DESC(write_buffer_size, "number of entries in a write buffer");
>   
> -static struct kmem_cache *pblk_ws_cache, *pblk_rec_cache, *pblk_g_rq_cache,
> -				*pblk_w_rq_cache;
> -static DECLARE_RWSEM(pblk_lock);
> +struct pblk_global_caches {

How about pblk_caches?

> +	struct kmem_cache *ws_cache;
> +	struct kmem_cache *rec_cache;
> +	struct kmem_cache *g_rq_cache;
> +	struct kmem_cache *w_rq_cache;

You can drop _cache from the names now that its implicit from the structure.

> +	struct kref kref;
> +};
> +
> +static struct pblk_global_caches caches = {

g_caches? pblk_caches?

> +	.kref = KREF_INIT(0)
> +};
> +
> +static DECLARE_RWSEM(pblk_lock);	/* Protects global caches */
pblk_caches_lock? and consider just using a semaphore, we don't need 
separate readers and writers for this.

>   struct bio_set pblk_bio_set;
>   
>   static int pblk_rw_io(struct request_queue *q, struct pblk *pblk,
> @@ -307,53 +317,68 @@ static int pblk_set_addrf(struct pblk *pblk)
>   	return 0;
>   }
>   
> -static int pblk_init_global_caches(struct pblk *pblk)
> +static int pblk_get_global_caches(void)

Looks like what this one does is initializing the caches. I get the 
get/put concept, but you may want to split it into two other functions. 
Such that you have

pblk_init_caches() (only called by pblk_get_caches)

and

pblk_get_caches()
{
	down(&pblk_cache_sem);
	if (kref_read(&caches.kref) > 0) {
		down(&pblk_cache_sem);
		return 0;
}

	ret = pblk_init_caches(..);
	up(&pblk_cache_sem);
	return ret;
}

>   {
>   	down_write(&pblk_lock);
> -	pblk_ws_cache = kmem_cache_create("pblk_blk_ws",
> +
> +	if (kref_read(&caches.kref) > 0)
> +		goto caches_available;
> +
> +	caches.ws_cache = kmem_cache_create("pblk_blk_ws",
>   				sizeof(struct pblk_line_ws), 0, 0, NULL);
> -	if (!pblk_ws_cache) {
> -		up_write(&pblk_lock);
> -		return -ENOMEM;
> -	}
> +	if (!caches.ws_cache)
> +		goto fail;
>   
> -	pblk_rec_cache = kmem_cache_create("pblk_rec",
> +	caches.rec_cache = kmem_cache_create("pblk_rec",
>   				sizeof(struct pblk_rec_ctx), 0, 0, NULL);
> -	if (!pblk_rec_cache) {
> -		kmem_cache_destroy(pblk_ws_cache);
> -		up_write(&pblk_lock);
> -		return -ENOMEM;
> -	}
> +	if (!caches.rec_cache)
> +		goto fail_destroy_ws_cache;
>   
> -	pblk_g_rq_cache = kmem_cache_create("pblk_g_rq", pblk_g_rq_size,
> +	caches.g_rq_cache = kmem_cache_create("pblk_g_rq", pblk_g_rq_size,
>   				0, 0, NULL);
> -	if (!pblk_g_rq_cache) {
> -		kmem_cache_destroy(pblk_ws_cache);
> -		kmem_cache_destroy(pblk_rec_cache);
> -		up_write(&pblk_lock);
> -		return -ENOMEM;
> -	}
> +	if (!caches.g_rq_cache)
> +		goto fail_destroy_rec_cache;
>   
> -	pblk_w_rq_cache = kmem_cache_create("pblk_w_rq", pblk_w_rq_size,
> +	caches.w_rq_cache = kmem_cache_create("pblk_w_rq", pblk_w_rq_size,
>   				0, 0, NULL);
> -	if (!pblk_w_rq_cache) {
> -		kmem_cache_destroy(pblk_ws_cache);
> -		kmem_cache_destroy(pblk_rec_cache);
> -		kmem_cache_destroy(pblk_g_rq_cache);
> -		up_write(&pblk_lock);
> -		return -ENOMEM;
> -	}
> +	if (!caches.w_rq_cache)
> +		goto fail_destroy_g_rq_cache;
> +
> +caches_available:
> +	kref_get(&caches.kref);
>   	up_write(&pblk_lock);
>   
>   	return 0;
> +
> +fail_destroy_g_rq_cache:
> +	kmem_cache_destroy(caches.g_rq_cache);
> +fail_destroy_rec_cache:
> +	kmem_cache_destroy(caches.rec_cache);
> +fail_destroy_ws_cache:
> +	kmem_cache_destroy(caches.ws_cache);
> +fail:
> +	up_write(&pblk_lock);
> +
> +	return -ENOMEM;
>   }
>   
> -static void pblk_free_global_caches(struct pblk *pblk)
> +static void pblk_destroy_global_caches(struct kref *ref)
>   {
> -	kmem_cache_destroy(pblk_ws_cache);
> -	kmem_cache_destroy(pblk_rec_cache);
> -	kmem_cache_destroy(pblk_g_rq_cache);
> -	kmem_cache_destroy(pblk_w_rq_cache);
> +	struct pblk_global_caches *c;
> +
> +	c = container_of(ref, struct pblk_global_caches, kref);
> +
> +	kmem_cache_destroy(c->ws_cache);
> +	kmem_cache_destroy(c->rec_cache);
> +	kmem_cache_destroy(c->g_rq_cache);
> +	kmem_cache_destroy(c->w_rq_cache);
> +}
> +
> +static void pblk_put_global_caches(void)
> +{
> +	down_write(&pblk_lock);
> +	kref_put(&caches.kref, pblk_destroy_global_caches);
> +	up_write(&pblk_lock);
>   }
>   
>   static int pblk_core_init(struct pblk *pblk)
> @@ -382,7 +407,7 @@ static int pblk_core_init(struct pblk *pblk)
>   	if (!pblk->pad_dist)
>   		return -ENOMEM;
>   
> -	if (pblk_init_global_caches(pblk))
> +	if (pblk_get_global_caches())
>   		goto fail_free_pad_dist;
>   
>   	/* Internal bios can be at most the sectors signaled by the device. */
> @@ -391,27 +416,27 @@ static int pblk_core_init(struct pblk *pblk)
>   		goto free_global_caches;
>   
>   	ret = mempool_init_slab_pool(&pblk->gen_ws_pool, PBLK_GEN_WS_POOL_SIZE,
> -				     pblk_ws_cache);
> +				     caches.ws_cache);
>   	if (ret)
>   		goto free_page_bio_pool;
>   
>   	ret = mempool_init_slab_pool(&pblk->rec_pool, geo->all_luns,
> -				     pblk_rec_cache);
> +				     caches.rec_cache);
>   	if (ret)
>   		goto free_gen_ws_pool;
>   
>   	ret = mempool_init_slab_pool(&pblk->r_rq_pool, geo->all_luns,
> -				     pblk_g_rq_cache);
> +				     caches.g_rq_cache);
>   	if (ret)
>   		goto free_rec_pool;
>   
>   	ret = mempool_init_slab_pool(&pblk->e_rq_pool, geo->all_luns,
> -				     pblk_g_rq_cache);
> +				     caches.g_rq_cache);
>   	if (ret)
>   		goto free_r_rq_pool;
>   
>   	ret = mempool_init_slab_pool(&pblk->w_rq_pool, geo->all_luns,
> -				     pblk_w_rq_cache);
> +				     caches.w_rq_cache);
>   	if (ret)
>   		goto free_e_rq_pool;
>   
> @@ -457,7 +482,7 @@ static int pblk_core_init(struct pblk *pblk)
>   free_page_bio_pool:
>   	mempool_exit(&pblk->page_bio_pool);
>   free_global_caches:
> -	pblk_free_global_caches(pblk);
> +	pblk_put_global_caches();
>   fail_free_pad_dist:
>   	kfree(pblk->pad_dist);
>   	return -ENOMEM;
> @@ -481,7 +506,7 @@ static void pblk_core_free(struct pblk *pblk)
>   	mempool_exit(&pblk->e_rq_pool);
>   	mempool_exit(&pblk->w_rq_pool);
>   
> -	pblk_free_global_caches(pblk);
> +	pblk_put_global_caches();
>   	kfree(pblk->pad_dist);
>   }
>   
> @@ -1074,7 +1099,6 @@ static void pblk_exit(void *private, bool graceful)
>   {
>   	struct pblk *pblk = private;
>   
> -	down_write(&pblk_lock);
>   	pblk_gc_exit(pblk, graceful);
>   	pblk_tear_down(pblk, graceful);
>   
> @@ -1083,7 +1107,6 @@ static void pblk_exit(void *private, bool graceful)
>   #endif
>   
>   	pblk_free(pblk);
> -	up_write(&pblk_lock);
>   }
>   
>   static sector_t pblk_capacity(void *private)
> 

