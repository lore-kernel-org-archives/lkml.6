Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4C6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7BB20660
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fehF92b6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbfAJN6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:58:04 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39092 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbfAJN6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:58:02 -0500
Received: by mail-wr1-f68.google.com with SMTP id t27so11472562wra.6;
        Thu, 10 Jan 2019 05:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3x+9fkk6/bbP+07UcfWoI9QQHyfy+n6unKbbRb9xq0E=;
        b=fehF92b6YVvVv7zIKtCFJopVI+9JqTqRYKIClsb6bGsrW8yLM+DuxBvtSxsizZUeeu
         FOkefHjtlteM45oEH6ovsRXLGM9jV+Qgj5zTBoiV9X62kq1V100eu3zpGX3k3IU9+tj6
         8cMC5iEKB82gRw4rtrkhDfmTJnm1pgXZ/xZmHYaTcAgQLTzeO13qdoquTM8xmRaQDAE1
         y8v/yqwYpxSu8idHtkDd9l2XPVbSfJUhhBOo4inH4D36MpT5Vqbm+YxdEAsSDwIfg1N7
         2EA0Kc9vluhT7+1WG1s3mnA8bWlyWgwye9ZfThJfPhD42p6G1/RDF6EwzBn0Xb89pS2d
         DHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3x+9fkk6/bbP+07UcfWoI9QQHyfy+n6unKbbRb9xq0E=;
        b=NOPO4F/yNGRqi79OsugJZlZAsJG+/PREEoaONIETiSPlK4q0eVuioL00vPVmBurQJo
         WKTiyNAYxtPbCRs54uKIHKzCpS4+29jyrmo+cQrOvZ2escc+vbmZ+0vf1/WO479VGW1M
         IM9SOGrCka9A04Ozi00D7kaHnlHLTS8Cp5dOgFHV2NgrB1VA1pWrVX11QmyhzyWw5SZa
         rS4E1uPVBxem8UZIoKS9fRhAtek0/oY3r9KxgwTyYKfJUWqzRedZ7IwLxAqaO+TjIZSz
         NYHFwR06GMQOxQU1gnFrZ/MyfICOOwfN+rW/uxPbVhgY9V7uI0iXqu4AB1YH2U4IYWhL
         B4gQ==
X-Gm-Message-State: AJcUukcZXam0Z5K0OhLsHKpMEAg8TwAJZaitgcBQUV4QtRdwQu+/nt+l
        ZHvTsJ8ag4G9+dcvqafWi34=
X-Google-Smtp-Source: ALg8bN53wPK6721LG+CWpZfqHQiPuEI9IuHgAhMPo9dqEDS9rbZFn0dPZzJIJvGazuxBMAkJK/a+6w==
X-Received: by 2002:adf:e1c3:: with SMTP id l3mr9541595wri.36.1547128680412;
        Thu, 10 Jan 2019 05:58:00 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id 124sm16680220wmh.22.2019.01.10.05.57.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 05:57:59 -0800 (PST)
Date:   Thu, 10 Jan 2019 14:57:57 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Kalyani Akula <kalyani.akula@xilinx.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kalyani Akula <kalyania@xilinx.com>,
        Sarat Chand Savitala <saratcha@xilinx.com>
Subject: Re: [RFC PATCH V2 3/4] crypto: Add Xilinx SHA3 driver
Message-ID: <20190110135757.GA32218@Red>
References: <1547025985-7228-1-git-send-email-kalyani.akula@xilinx.com>
 <1547025985-7228-4-git-send-email-kalyani.akula@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547025985-7228-4-git-send-email-kalyani.akula@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 02:56:24PM +0530, Kalyani Akula wrote:
> This patch adds SHA3 driver support for the Xilinx
> ZynqMP SoC.
> 
> Signed-off-by: Kalyani Akula <kalyani.akula@xilinx.com>
> ---
>  drivers/crypto/Kconfig      |   10 ++
>  drivers/crypto/Makefile     |    1 +
>  drivers/crypto/zynqmp-sha.c |  305 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 316 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/crypto/zynqmp-sha.c

Hello

I have some comment below

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

Since kbuf is in dma coherent memory, I dont understand why do you flush cache.

> +	ret = eemi_ops->sha_hash(dma_addr, req->nbytes, ZYNQMP_SHA3_UPDATE);
> +	dma_free_coherent(dd->dev, dma_size, kbuf, dma_addr);

Since your update function does not return/write any result, I suppose that the resulat is kept in hardware, so what happen if two hash process happen in parallel ?
Furthermore, how do you have tested import/export function ?
Anyway, I am sure they are totally buggy.

> +
> +	return ret;
> +}
> +
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

You can do this check at probe time.

> +static int zynqmp_sha_finup(struct ahash_request *req)
> +{
> +	zynqmp_sha_update(req);
> +	zynqmp_sha_final(req);
> +
> +	return 0;
> +}
> +
> +static int zynqmp_sha_digest(struct ahash_request *req)
> +{
> +	zynqmp_sha_init(req);
> +	zynqmp_sha_update(req);
> +	zynqmp_sha_final(req);
> +
> +	return 0;
> +}

So you ignore the return value of zynqmp_sha_init/zynqmp_sha_update/zynqmp_sha_final().

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

As already said in my last review, why init the queue if you do not use it ?


> +	spin_lock(&zynqmp_sha.lock);
> +	list_add_tail(&sha_dd->list, &zynqmp_sha.dev_list);
> +	spin_unlock(&zynqmp_sha.lock);

Why do you maintain a device list ?
Clearly your current driver support only one hardware instance.

Regards
