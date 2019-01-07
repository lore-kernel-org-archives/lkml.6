Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D369BC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A387E2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPq8R0xS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfAGKNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 05:13:19 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37198 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfAGKNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 05:13:18 -0500
Received: by mail-ed1-f65.google.com with SMTP id h15so326074edb.4;
        Mon, 07 Jan 2019 02:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bu0nFXgfRIpl1d7qh46UAqgGnDv6CoRNmpsbwlwwmQY=;
        b=IPq8R0xSHUGBW6GABvNlAJ8LylFX+iAU1PJDymJkVEpGl7PUIBjMu8C/sGjnBzCx1g
         7HoMvHesWHVbWaaDQQNken+LWKH6i5n3YuO0O35SaJxq+lPNjCzuAArnJkadrQ2/kueo
         h3tQuWDg++qtpym19+LpAumq8Yzt1F2pe7UHmlnb6izYMtG+xBp/tuImDEOS8PuEh9on
         hc2wpfseeiSywTsBe1bEbdzhFP3vyWig3P/lbbc6I/A7e1DjLFvMrZSpx0wvBRHgxKBS
         yhc/0LxWbcSNZAQCHuwmfMZQibv5WvtYbjT9Yd/seGk8I/X5/7ZyGgdBXfx5Y9/BBjCG
         bGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bu0nFXgfRIpl1d7qh46UAqgGnDv6CoRNmpsbwlwwmQY=;
        b=gf/OmK2YQFhyMF1rPW5DoNsWEP6fBZPgdxnxp6GvM1G8oPCs86UYdqjo4kl/JUHag6
         l/aoQBDe+EIe891CNJ4A4foYDoVU5DUeCZqIyZMPfLILEoGjf8PZs8zMxqOcpTE7iLzT
         4CrzsrWDZnhwoRmO/pVuwrY58BCRjU7WTcH2ic+OhSfPUKXqOtBs90voM4UBbIiw6TDe
         ptIhVwbZP8gzxK98zbrbrgqXNCSMfE1k15aFTbc7hhcpTYT7O0m1LBYiua0sIfrL+ZtW
         0WPs5rewwsAVc5xeJqogtLfjKaIFHG/hDNR0Jsg4ZhVd5wV6DlruFD3LQBYL8riDZv4s
         /NXA==
X-Gm-Message-State: AA+aEWZE78mgInT+zAVROFXcg444reX682vQ4I4xnUSbsWLuii7EO0lU
        /pvmdLZ1SZpPKTvyKrsRJoN867Ev
X-Google-Smtp-Source: AFSGD/WFWEr67ipFvmd+VB30LpLBH3g+5PvqWmKj5u0Tj2KL/u6rid1UVxbi/4Ye4Vt3Cc1plUgDTg==
X-Received: by 2002:a50:b744:: with SMTP id g62mr56233518ede.14.1546855996120;
        Mon, 07 Jan 2019 02:13:16 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id r42sm30868056edd.23.2019.01.07.02.13.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 02:13:15 -0800 (PST)
Date:   Mon, 7 Jan 2019 11:13:13 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Kalyani Akula <kalyani.akula@xilinx.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kalyani Akula <kalyania@xilinx.com>,
        Sarat Chand Savitala <saratcha@xilinx.com>
Subject: Re: [RFC PATCH 2/3] crypto: Add Xilinx SHA3 driver
Message-ID: <20190107101313.GA17747@Red>
References: <1546851776-3456-1-git-send-email-kalyani.akula@xilinx.com>
 <1546851776-3456-3-git-send-email-kalyani.akula@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546851776-3456-3-git-send-email-kalyani.akula@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 02:32:55PM +0530, Kalyani Akula wrote:
> This patch adds SHA3 driver suuport for the Xilinx
> ZynqMP SoC.
> 
> Signed-off-by: Kalyani Akula <kalyani.akula@xilinx.com>

Hello

I have some comment below

> +static int zynqmp_sha_init(struct ahash_request *req)
> +{
> +	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
> +	struct zynqmp_sha_reqctx *ctx = ahash_request_ctx(req);
> +	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
> +	struct zynqmp_sha_ctx *tctx = crypto_ahash_ctx(tfm);
> +	struct zynqmp_sha_dev *dd = NULL;
> +	struct zynqmp_sha_dev *tmp;
> +	int ret;
> +
> +	if (!eemi_ops || !eemi_ops->sha_hash)
> +		return -ENOTSUPP;
> +

Where can I find sha_hash() ?
It seems that your serie miss some patchs.

> +	spin_lock_bh(&zynqmp_sha.lock);
> +	if (!tctx->dd) {
> +		list_for_each_entry(tmp, &zynqmp_sha.dev_list, list) {
> +			dd = tmp;
> +			break;
> +		}
> +		tctx->dd = dd;
> +	} else {
> +		dd = tctx->dd;
> +	}
> +	spin_unlock_bh(&zynqmp_sha.lock);
> +
> +	ctx->dd = dd;
> +	dev_dbg(dd->dev, "init: digest size: %d\n",
> +		crypto_ahash_digestsize(tfm));
> +
> +	ret = eemi_ops->sha_hash(0, 0, ZYNQMP_SHA3_INIT);
> +
> +	return ret;
> +}
> +
> +static int zynqmp_sha_update(struct ahash_request *req)
> +{
> +	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
> +	struct zynqmp_sha_ctx *tctx = crypto_tfm_ctx(req->base.tfm);
> +	struct zynqmp_sha_dev *dd = tctx->dd;
> +	size_t dma_size = req->nbytes;
> +	dma_addr_t dma_addr;
> +	char *kbuf;
> +	int ret;
> +
> +	if (!req->nbytes)
> +		return 0;
> +
> +	if (!eemi_ops || !eemi_ops->sha_hash)
> +		return -ENOTSUPP;
> +
> +	kbuf = dma_alloc_coherent(dd->dev, dma_size, &dma_addr, GFP_KERNEL);
> +	if (!kbuf)
> +		return -ENOMEM;
> +
> +	scatterwalk_map_and_copy(kbuf, req->src, 0, req->nbytes, 0);
> +	 __flush_cache_user_range((unsigned long)kbuf,
> +				  (unsigned long)kbuf + dma_size);
> +	ret = eemi_ops->sha_hash(dma_addr, req->nbytes, ZYNQMP_SHA3_UPDATE);

Even with the sha_hash prototype missing, I think your driver have a problem:
You support having more than one device, but sha_hash lacks any reference on the device doing the request.

> +static int zynqmp_sha_final(struct ahash_request *req)
> +{
> +	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
> +	struct zynqmp_sha_ctx *tctx = crypto_tfm_ctx(req->base.tfm);
> +	struct zynqmp_sha_dev *dd = tctx->dd;
> +	size_t dma_size = SHA384_DIGEST_SIZE;
> +	dma_addr_t dma_addr;
> +	char *kbuf;
> +	int ret;
> +
> +	if (!eemi_ops || !eemi_ops->sha_hash)
> +		return -ENOTSUPP;
> +
> +	kbuf = dma_alloc_coherent(dd->dev, dma_size, &dma_addr, GFP_KERNEL);
> +	if (!kbuf)
> +		return -ENOMEM;
> +
> +	ret = eemi_ops->sha_hash(dma_addr, dma_size, ZYNQMP_SHA3_FINAL);
> +	memcpy(req->result, kbuf, 48);

It is better to use SHA384_DIGEST_SIZE instead of 48

[...]
> +static int zynqmp_sha_probe(struct platform_device *pdev)
> +{
> +	struct zynqmp_sha_dev *sha_dd;
> +	struct device *dev = &pdev->dev;
> +	int err;
> +
> +	sha_dd = devm_kzalloc(&pdev->dev, sizeof(*sha_dd), GFP_KERNEL);
> +	if (!sha_dd)
> +		return -ENOMEM;
> +
> +	sha_dd->dev = dev;
> +	platform_set_drvdata(pdev, sha_dd);
> +	INIT_LIST_HEAD(&sha_dd->list);
> +	spin_lock_init(&sha_dd->lock);
> +	crypto_init_queue(&sha_dd->queue, ZYNQMP_SHA_QUEUE_LENGTH);

You create a queue, but you didnt use it.

[...]
> +	spin_lock(&zynqmp_sha.lock);
> +	list_add_tail(&sha_dd->list, &zynqmp_sha.dev_list);
> +	spin_unlock(&zynqmp_sha.lock);
> +
> +	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(44));
> +	if (err < 0)
> +		dev_err(dev, "no usable DMA configuration");

It is an error that you ignore, you miss some goto errxxx.

Regards
