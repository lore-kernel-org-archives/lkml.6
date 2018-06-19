Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C7DC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F4220874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=czerwinskis.de header.i=@czerwinskis.de header.b="nKwN999l";
	dkim=pass (1024-bit key) header.d=czerwinskis.de header.i=@czerwinskis.de header.b="iCTATvpn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F4220874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=czerwinskis.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755654AbeFSFpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:45:16 -0400
Received: from magratgarlick.emantor.de ([78.46.208.201]:36940 "EHLO
        margratgarlick.emantor.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbeFSFpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:45:14 -0400
X-Greylist: delayed 434 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jun 2018 01:45:14 EDT
Received: by margratgarlick.emantor.de (Postfix, from userid 114)
        id 65CBD96737; Tue, 19 Jun 2018 07:37:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=czerwinskis.de;
        s=mail; t=1529386679;
        bh=K/4Uv1rFj0OGeB3S14FO+pmaq5gPeGkm3VeKbM8Nry0=;
        h=References:From:To:Cc:Subject:In-reply-to:Date:From;
        b=nKwN999llfGgsdJeAMVN6IZnCSxyHin0DnaklemIzFqDfe1KUHqqWEadJ7a9pqnYQ
         SdrdrTr6zOEDm3XgW+sZMGGweU4+BewgT1zlWSjSaM6lz19M4HzWwyKc7DyU6SOeBo
         xYRm25iWH3foY3+ZkhS/uwCRRzsWPDuigs+f6ePo=
Received: from localhost (p200300D21BD00900DB416971093FF1DA.dip0.t-ipconnect.de [IPv6:2003:d2:1bd0:900:db41:6971:93f:f1da])
        by margratgarlick.emantor.de (Postfix) with ESMTPSA id 55E8D96732;
        Tue, 19 Jun 2018 07:37:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=czerwinskis.de;
        s=mail; t=1529386677;
        bh=K/4Uv1rFj0OGeB3S14FO+pmaq5gPeGkm3VeKbM8Nry0=;
        h=References:From:To:Cc:Subject:In-reply-to:Date:From;
        b=iCTATvpnkAsaA1HxgL+pGuNChL3pm7K++tked3UzCzwn9fcEMRXeMEHYdoc0SNhsC
         QP586dvu9uvKiSO/SZMdmy9zzrSGVogpYA2xoKAcGeZB9bJZH69lMFjb2dKvAYp+Gd
         gYrHbLaEqsZDZ+tsh0XPddnqCQUr1QppJuAxdXTw=
References: <1529320275-30079-1-git-send-email-volodymyr_babchuk@epam.com>
User-agent: mu4e 1.1.0; emacs 26.1
From:   Rouven Czerwinski <rouven@czerwinskis.de>
To:     Volodymyr Babchuk <volodymyr_babchuk@epam.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Subject: Re: [Tee-dev] [PATCH] optee: allow to work without static shared memory
In-reply-to: <1529320275-30079-1-git-send-email-volodymyr_babchuk@epam.com>
Date:   Tue, 19 Jun 2018 07:37:56 +0200
Message-ID: <87tvpzfia3.fsf@czerwinskis.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Volodymyr Babchuk <volodymyr_babchuk@epam.com> writes:

> From: Volodymyr Babchuk <vlad.babchuk@gmail.com>
>
> On virtualized systems it is possible that OP-TEE will provide
> only dynamic shared memory support. So it is fine to boot
> without static SHM enabled if dymanic one is supported.
>
> Signed-off-by: Volodymyr Babchuk <vlad.babchuk@gmail.com>
> ---
>  drivers/tee/optee/core.c | 83 ++++++++++++++++++++++++++++--------------------
>  1 file changed, 49 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index 4a2c420..d80da29 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -420,9 +420,35 @@ static bool optee_msg_exchange_capabilities(optee_invoke_fn *invoke_fn,
>  	return true;
>  }
>  
> +static struct tee_shm_pool *optee_config_dyn_shm(void)
> +{
> +	struct tee_shm_pool_mgr *priv_mgr;
> +	struct tee_shm_pool_mgr *dmabuf_mgr;
> +	void *rc;
> +
> +	rc = optee_shm_pool_alloc_pages();
> +	if (IS_ERR(rc))
> +		return rc;
> +	priv_mgr = rc;
> +
> +	rc = optee_shm_pool_alloc_pages();
> +	if (IS_ERR(rc)) {
> +		tee_shm_pool_mgr_destroy(priv_mgr);
> +		return rc;
> +	}
> +	dmabuf_mgr = rc;
> +
> +	rc = tee_shm_pool_alloc(priv_mgr, dmabuf_mgr);
> +	if (IS_ERR(rc)) {
> +		tee_shm_pool_mgr_destroy(priv_mgr);
> +		tee_shm_pool_mgr_destroy(dmabuf_mgr);
> +	}
> +
> +	return rc;
> +}
> +
>  static struct tee_shm_pool *
> -optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm,
> -			  u32 sec_caps)
> +optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm)
>  {
>  	union {
>  		struct arm_smccc_res smccc;
> @@ -437,10 +463,11 @@ optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm,
>  	struct tee_shm_pool_mgr *priv_mgr;
>  	struct tee_shm_pool_mgr *dmabuf_mgr;
>  	void *rc;
> +	const int sz = OPTEE_SHM_NUM_PRIV_PAGES * PAGE_SIZE;
>  
>  	invoke_fn(OPTEE_SMC_GET_SHM_CONFIG, 0, 0, 0, 0, 0, 0, 0, &res.smccc);
>  	if (res.result.status != OPTEE_SMC_RETURN_OK) {
> -		pr_info("shm service not available\n");
> +		pr_err("static shm service not available\n");
>  		return ERR_PTR(-ENOENT);
>  	}
>  
> @@ -466,28 +493,15 @@ optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm,
>  	}
>  	vaddr = (unsigned long)va;
>  
> -	/*
> -	 * If OP-TEE can work with unregistered SHM, we will use own pool
> -	 * for private shm
> -	 */
> -	if (sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM) {
> -		rc = optee_shm_pool_alloc_pages();
> -		if (IS_ERR(rc))
> -			goto err_memunmap;
> -		priv_mgr = rc;
> -	} else {
> -		const size_t sz = OPTEE_SHM_NUM_PRIV_PAGES * PAGE_SIZE;
> -
> -		rc = tee_shm_pool_mgr_alloc_res_mem(vaddr, paddr, sz,
> -						    3 /* 8 bytes aligned */);
> -		if (IS_ERR(rc))
> -			goto err_memunmap;
> -		priv_mgr = rc;
> -
> -		vaddr += sz;
> -		paddr += sz;
> -		size -= sz;
> -	}
> +	rc = tee_shm_pool_mgr_alloc_res_mem(vaddr, paddr, sz,
> +					    3 /* 8 bytes aligned */);
> +	if (IS_ERR(rc))
> +		goto err_memunmap;
> +	priv_mgr = rc;
> +
> +	vaddr += sz;
> +	paddr += sz;
> +	size -= sz;
>  
>  	rc = tee_shm_pool_mgr_alloc_res_mem(vaddr, paddr, size, PAGE_SHIFT);
>  	if (IS_ERR(rc))
> @@ -553,7 +567,7 @@ static optee_invoke_fn *get_invoke_func(struct device_node *np)
>  static struct optee *optee_probe(struct device_node *np)
>  {
>  	optee_invoke_fn *invoke_fn;
> -	struct tee_shm_pool *pool;
> +	struct tee_shm_pool *pool = ERR_PTR(-EINVAL);
>  	struct optee *optee = NULL;
>  	void *memremaped_shm = NULL;
>  	struct tee_device *teedev;
> @@ -582,13 +596,17 @@ static struct optee *optee_probe(struct device_node *np)
>  	}
>  
>  	/*
> -	 * We have no other option for shared memory, if secure world
> -	 * doesn't have any reserved memory we can use we can't continue.
> +	 * Try to use dynamic shared memory if possible
>  	 */
> -	if (!(sec_caps & OPTEE_SMC_SEC_CAP_HAVE_RESERVED_SHM))
> -		return ERR_PTR(-EINVAL);
> +	if (sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
> +		pool = optee_config_dyn_shm();
> +
> +	/*
> +	 * If dynamic shared memory is not available or failed - try static one
> +	 */
> +	if (IS_ERR(pool) && (sec_caps & OPTEE_SMC_SEC_CAP_HAVE_RESERVED_SHM))
> +		pool = optee_config_shm_memremap(invoke_fn, &memremaped_shm);
>  
> -	pool = optee_config_shm_memremap(invoke_fn, &memremaped_shm, sec_caps);
>  	if (IS_ERR(pool))
>  		return (void *)pool;
>  

-- BEGIN --
> @@ -632,9 +650,6 @@ static struct optee *optee_probe(struct device_node *np)
>  
>  	optee_enable_shm_cache(optee);
>  
> -	if (optee->sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
> -		pr_info("dynamic shared memory is enabled\n");
> -
>  	pr_info("initialized driver\n");
>  	return optee;
>  err:
-- END --

This part does not apply against upstream.

Greetings

Rouven
