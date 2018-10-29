Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE5CC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D19B2064C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="q2K0yRZC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D19B2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbeJ3D2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:28:16 -0400
Received: from mta-p4.oit.umn.edu ([134.84.196.204]:54886 "EHLO
        mta-p4.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbeJ3D2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:28:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by mta-p4.oit.umn.edu (Postfix) with ESMTP id 7663170F;
        Mon, 29 Oct 2018 18:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=umn.edu; h=
        content-type:content-type:subject:subject:message-id:date:date
        :from:from:in-reply-to:references:mime-version:received:received
        :received; s=20160920; t=1540838302; x=1542652703; bh=arq/ef21aH
        Il+jmTbTUcD2IoLtefOuc207ioU1JQX8E=; b=q2K0yRZCYDdTskbxaZfvSNfTox
        q5tz8QtvoR+F713uJsDR0eVq/CHB4WFvmfQwBtcrm+YizGYBnugjXohNCKYTa4kB
        oViwS1i/+bT62UEjojf14j6poUTYh6XqMbb02VG5bbRMlJoIIdDe/PoZyFpj3lsQ
        Im5SU8fFC1L86Vi+3oLyhIYzxD4ZrBLHBk/Gi5k8F7oAJzNp0d5tL2XpmzkTExr1
        EYf4kvzWk0x33dZwIU6NTQmendZbZOsJOLJ5rQbFJsNXfFcQ9/eqJo8idcLcrW7c
        KAnujhE9Q2KrExtrt2RbrcCZLYUHwST/V75mO2Jk890ycmGZZBqGjzTrLwyQ==
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p4.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p4.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id V6gi3DoRBX-S; Mon, 29 Oct 2018 13:38:22 -0500 (CDT)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wang6495)
        by mta-p4.oit.umn.edu (Postfix) with ESMTPSA id 481A26E3;
        Mon, 29 Oct 2018 13:38:22 -0500 (CDT)
Received: by mail-io1-f48.google.com with SMTP id k17-v6so5633873ioc.4;
        Mon, 29 Oct 2018 11:38:22 -0700 (PDT)
X-Gm-Message-State: AGRZ1gJarGbt9gjQid1KfsJIoOEvRZwG7Qax9jqs9WjN+HFUPU+8tpsM
        nySIB2vYldJ4ddR/VyNiiGi91T7ohqFJeAteTLA=
X-Google-Smtp-Source: AJdET5d28lxGcwYiHGxPFfVbRcRWU64z/3dUn+MJXhvf2HADDPTtQQtqweIfARwGcI+L0kL67B3AY/YKuBAI2NVSsb4=
X-Received: by 2002:a6b:7f4d:: with SMTP id m13-v6mr9058505ioq.16.1540838302003;
 Mon, 29 Oct 2018 11:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <1539910247-9250-1-git-send-email-wang6495@umn.edu>
In-Reply-To: <1539910247-9250-1-git-send-email-wang6495@umn.edu>
From:   Wenwen Wang <wang6495@umn.edu>
Date:   Mon, 29 Oct 2018 13:37:45 -0500
X-Gmail-Original-Message-ID: <CAAa=b7eOM+NPNxaanw-mK-i05UfQ7uhCsN2ViiSoe0_YB-ppyA@mail.gmail.com>
Message-ID: <CAAa=b7eOM+NPNxaanw-mK-i05UfQ7uhCsN2ViiSoe0_YB-ppyA@mail.gmail.com>
Subject: Re: [PATCH] crypto: cavium/nitrox - fix a DMA pool free failure
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>, herbert@gondor.apana.org.au,
        "David S. Miller" <davem@davemloft.net>,
        kstewart@linuxfoundation.org, tglx@linutronix.de,
        pombredanne@nexb.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        baijiaju1990@gmail.com, Jampala.Srikanth@cavium.com,
        sgadam@cavium.com, linux-crypto@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Can anyone confirm this bug? Thanks!

Wenwen

On Thu, Oct 18, 2018 at 7:51 PM Wenwen Wang <wang6495@umn.edu> wrote:
>
> In crypto_alloc_context(), a DMA pool is allocated through dma_pool_alloc()
> to hold the crypto context. The meta data of the DMA pool, including the
> pool used for the allocation 'ndev->ctx_pool' and the base address of the
> DMA pool used by the device 'dma', are then stored to the beginning of the
> pool. These meta data are eventually used in crypto_free_context() to free
> the DMA pool through dma_pool_free(). However, given that the DMA pool can
> also be accessed by the device, a malicious device can modify these meta
> data, especially when the device is controlled to deploy an attack. This
> can cause an unexpected DMA pool free failure.
>
> To avoid the above issue, this patch introduces a new structure
> crypto_ctx_hdr and a new field chdr in the structure nitrox_crypto_ctx hold
> the meta data information of the DMA pool after the allocation. Note that
> the original structure ctx_hdr is not changed to ensure the compatibility.
>
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> ---
>  drivers/crypto/cavium/nitrox/nitrox_algs.c | 12 +++++++-----
>  drivers/crypto/cavium/nitrox/nitrox_lib.c  | 22 +++++++++++++++++-----
>  drivers/crypto/cavium/nitrox/nitrox_req.h  |  7 +++++++
>  3 files changed, 31 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/crypto/cavium/nitrox/nitrox_algs.c b/drivers/crypto/cavium/nitrox/nitrox_algs.c
> index 2ae6124..5d54ebc 100644
> --- a/drivers/crypto/cavium/nitrox/nitrox_algs.c
> +++ b/drivers/crypto/cavium/nitrox/nitrox_algs.c
> @@ -73,7 +73,7 @@ static int flexi_aes_keylen(int keylen)
>  static int nitrox_skcipher_init(struct crypto_skcipher *tfm)
>  {
>         struct nitrox_crypto_ctx *nctx = crypto_skcipher_ctx(tfm);
> -       void *fctx;
> +       struct crypto_ctx_hdr *chdr;
>
>         /* get the first device */
>         nctx->ndev = nitrox_get_first_device();
> @@ -81,12 +81,14 @@ static int nitrox_skcipher_init(struct crypto_skcipher *tfm)
>                 return -ENODEV;
>
>         /* allocate nitrox crypto context */
> -       fctx = crypto_alloc_context(nctx->ndev);
> -       if (!fctx) {
> +       chdr = crypto_alloc_context(nctx->ndev);
> +       if (!chdr) {
>                 nitrox_put_device(nctx->ndev);
>                 return -ENOMEM;
>         }
> -       nctx->u.ctx_handle = (uintptr_t)fctx;
> +       nctx->chdr = chdr;
> +       nctx->u.ctx_handle = (uintptr_t)((u8 *)chdr->vaddr +
> +                                        sizeof(struct ctx_hdr));
>         crypto_skcipher_set_reqsize(tfm, crypto_skcipher_reqsize(tfm) +
>                                     sizeof(struct nitrox_kcrypt_request));
>         return 0;
> @@ -102,7 +104,7 @@ static void nitrox_skcipher_exit(struct crypto_skcipher *tfm)
>
>                 memset(&fctx->crypto, 0, sizeof(struct crypto_keys));
>                 memset(&fctx->auth, 0, sizeof(struct auth_keys));
> -               crypto_free_context((void *)fctx);
> +               crypto_free_context((void *)nctx->chdr);
>         }
>         nitrox_put_device(nctx->ndev);
>
> diff --git a/drivers/crypto/cavium/nitrox/nitrox_lib.c b/drivers/crypto/cavium/nitrox/nitrox_lib.c
> index 4d31df0..28baf1a 100644
> --- a/drivers/crypto/cavium/nitrox/nitrox_lib.c
> +++ b/drivers/crypto/cavium/nitrox/nitrox_lib.c
> @@ -146,12 +146,19 @@ static void destroy_crypto_dma_pool(struct nitrox_device *ndev)
>  void *crypto_alloc_context(struct nitrox_device *ndev)
>  {
>         struct ctx_hdr *ctx;
> +       struct crypto_ctx_hdr *chdr;
>         void *vaddr;
>         dma_addr_t dma;
>
> +       chdr = kmalloc(sizeof(*chdr), GFP_KERNEL);
> +       if (!chdr)
> +               return NULL;
> +
>         vaddr = dma_pool_alloc(ndev->ctx_pool, (GFP_KERNEL | __GFP_ZERO), &dma);
> -       if (!vaddr)
> +       if (!vaddr) {
> +               kfree(chdr);
>                 return NULL;
> +       }
>
>         /* fill meta data */
>         ctx = vaddr;
> @@ -159,7 +166,11 @@ void *crypto_alloc_context(struct nitrox_device *ndev)
>         ctx->dma = dma;
>         ctx->ctx_dma = dma + sizeof(struct ctx_hdr);
>
> -       return ((u8 *)vaddr + sizeof(struct ctx_hdr));
> +       chdr->pool = ndev->ctx_pool;
> +       chdr->dma = dma;
> +       chdr->vaddr = vaddr;
> +
> +       return chdr;
>  }
>
>  /**
> @@ -168,13 +179,14 @@ void *crypto_alloc_context(struct nitrox_device *ndev)
>   */
>  void crypto_free_context(void *ctx)
>  {
> -       struct ctx_hdr *ctxp;
> +       struct crypto_ctx_hdr *ctxp;
>
>         if (!ctx)
>                 return;
>
> -       ctxp = (struct ctx_hdr *)((u8 *)ctx - sizeof(struct ctx_hdr));
> -       dma_pool_free(ctxp->pool, ctxp, ctxp->dma);
> +       ctxp = ctx;
> +       dma_pool_free(ctxp->pool, ctxp->vaddr, ctxp->dma);
> +       kfree(ctxp);
>  }
>
>  /**
> diff --git a/drivers/crypto/cavium/nitrox/nitrox_req.h b/drivers/crypto/cavium/nitrox/nitrox_req.h
> index d091b6f..19f0a20 100644
> --- a/drivers/crypto/cavium/nitrox/nitrox_req.h
> +++ b/drivers/crypto/cavium/nitrox/nitrox_req.h
> @@ -181,12 +181,19 @@ struct flexi_crypto_context {
>         struct auth_keys auth;
>  };
>
> +struct crypto_ctx_hdr {
> +       struct dma_pool *pool;
> +       dma_addr_t dma;
> +       void *vaddr;
> +};
> +
>  struct nitrox_crypto_ctx {
>         struct nitrox_device *ndev;
>         union {
>                 u64 ctx_handle;
>                 struct flexi_crypto_context *fctx;
>         } u;
> +       struct crypto_ctx_hdr *chdr;
>  };
>
>  struct nitrox_kcrypt_request {
> --
> 2.7.4
>
