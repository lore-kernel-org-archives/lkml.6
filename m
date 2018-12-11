Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0694C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E22A2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPROrBR8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E22A2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbeLKAre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:47:34 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:40918 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbeLKAre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 19:47:34 -0500
Received: by mail-it1-f195.google.com with SMTP id h193so993043ita.5;
        Mon, 10 Dec 2018 16:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y1WkjeKSWAmq+SQweWcOAebDmIrh3t1RL48KkpeOplg=;
        b=UPROrBR8X7+rroJMYBD+opm7LDjHA+X7mebKAR8qn7i1lCTFTcQ3mZ5AZRxipUGJMr
         qnlGYLFLdu3608Y1wXzLeQep2qF52UJnCS9LNbvrIfwzMhxDjB/4COYe+Mu2mniT+/s7
         Qi54kyydaiFEh/whntc3GwNJ8F9B1vaXi58tmL+2VpPT3gVkcbNDBpbAgkO3liyItWjm
         xqzjhT/AZvPNVM35ykh2k++emeK9nSuiNyZ2qQbIEOvSZs5qSWaoiNZkpOSOwnZHFwM9
         8c88k+mnMv5BlrTfMzAg+920KSOcTOVOhxWVoAEiqT8Wq5oOSxV/qBbD2gJ1AAgXbhRN
         ruSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y1WkjeKSWAmq+SQweWcOAebDmIrh3t1RL48KkpeOplg=;
        b=myxu3/7/rQAM3OSzKshWuA6PYsSBgr8SdvKNQcf7kS8xwVVneiAUKRirFXE4naGnxK
         D4/bbA4KVZWh7zDMItuYRY86PzBV1SA5inyT/LSMFG0TXc4IPk9r2rq5mOknk6sA0byY
         QksnbmjlzgtSqq7G5EABKtum4/sozWQtXRBPcV5C8kY+RQZOHdeMnJDSmoJyJD+XZZaa
         OK//GuXgLfDZmQy1V1DWeeuczyMa3Nb60B9SmqxtxU9DBV7s8MPkgeUIQPnwl6YyZbUy
         jIr4XW+TnwENAyIkUYBuh5bgTm4QIxcvSXxveM+ByG6+i5iAiIKlr5i/ZRws4m3YDI45
         dEgQ==
X-Gm-Message-State: AA+aEWYaPrwgo0tUv4v1jzujuD0BFga3as7bdaG70byY9xoIE9VUR+1s
        iYpxOB5Bx/r8IWenWtlxuteSQAev0FWPVWgga3kVZg==
X-Google-Smtp-Source: AFSGD/XI3obp8N8HZQU6PBz7cfe7MLy02ukRV4d9FdKFRc+D2mysKRxiPxHgrDjxS8AiLEhoBAz5NjUUh1HgquDwJmk=
X-Received: by 2002:a24:5314:: with SMTP id n20mr525019itb.132.1544489253065;
 Mon, 10 Dec 2018 16:47:33 -0800 (PST)
MIME-Version: 1.0
References: <20181210205620.3041207-1-arnd@arndb.de>
In-Reply-To: <20181210205620.3041207-1-arnd@arndb.de>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 10 Dec 2018 19:47:19 -0500
Message-ID: <CAF6AEGtg51tCu31C91e95c3j59VvjSscK2Fg-Bm7ZNsz6GbJqg@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: fix arm64 build error
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Airlie <airlied@linux.ie>, Jonathan <jonathan@marek.ca>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 3:56 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> The new a200 GPU MMU support fails to build on arm64 because
> of a conflicting macro name:
>
> drivers/gpu/drm/msm/msm_gpummu.c:17: error: "VA_START" redefined [-Werror]
>  #define VA_START SZ_16M
>
> In file included from arch/arm64/include/asm/pgtable-hwdef.h:19,
>                  from arch/arm64/include/asm/processor.h:48,
>                  from include/linux/mutex.h:19,
>                  from include/linux/notifier.h:14,
>                  from include/linux/clk.h:17,
>                  from drivers/gpu/drm/msm/msm_drv.h:23,
>                  from drivers/gpu/drm/msm/msm_gpummu.c:4:
> arch/arm64/include/asm/memory.h:51: note: this is the location of the previous definition
>  #define VA_START  (UL(0xffffffffffffffff) - \
>
> Rename this and the related macros with a GPU_ prefix.
>
> Fixes: 1c0088f255ae ("drm/msm: implement a2xx mmu")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

fyi I've updated this patch in msm-next/linux-next with a fixup from
Jonathan which prefixes these with GPUMMU_*

not entirely sure why I didn't hit this build error locally, but
thanks to you and kbuild-robot for noticing so we could fix

BR,
-R


> ---
>  drivers/gpu/drm/msm/msm_gpummu.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_gpummu.c b/drivers/gpu/drm/msm/msm_gpummu.c
> index f1dc2b7e5fd3..2a7ddd449d3d 100644
> --- a/drivers/gpu/drm/msm/msm_gpummu.c
> +++ b/drivers/gpu/drm/msm/msm_gpummu.c
> @@ -14,10 +14,10 @@ struct msm_gpummu {
>  };
>  #define to_msm_gpummu(x) container_of(x, struct msm_gpummu, base)
>
> -#define VA_START SZ_16M
> -#define VA_RANGE (0xfff * SZ_64K)
> -#define MMU_PAGE_SIZE SZ_4K
> -#define TABLE_SIZE (sizeof(uint32_t) * VA_RANGE / MMU_PAGE_SIZE)
> +#define GPU_VA_START SZ_16M
> +#define GPU_VA_RANGE (0xfff * SZ_64K)
> +#define GPU_MMU_PAGE_SIZE SZ_4K
> +#define GPU_TABLE_SIZE (sizeof(uint32_t) * GPU_VA_RANGE / GPU_MMU_PAGE_SIZE)
>
>  static int msm_gpummu_attach(struct msm_mmu *mmu, const char * const *names,
>                 int cnt)
> @@ -34,7 +34,7 @@ static int msm_gpummu_map(struct msm_mmu *mmu, uint64_t iova,
>                 struct sg_table *sgt, unsigned len, int prot)
>  {
>         struct msm_gpummu *gpummu = to_msm_gpummu(mmu);
> -       unsigned idx = (iova - VA_START) / MMU_PAGE_SIZE;
> +       unsigned idx = (iova - GPU_VA_START) / GPU_MMU_PAGE_SIZE;
>         struct scatterlist *sg;
>         unsigned prot_bits = 0;
>         unsigned i, j;
> @@ -46,9 +46,9 @@ static int msm_gpummu_map(struct msm_mmu *mmu, uint64_t iova,
>
>         for_each_sg(sgt->sgl, sg, sgt->nents, i) {
>                 dma_addr_t addr = sg->dma_address;
> -               for (j = 0; j < sg->length / MMU_PAGE_SIZE; j++, idx++) {
> +               for (j = 0; j < sg->length / GPU_MMU_PAGE_SIZE; j++, idx++) {
>                         gpummu->table[idx] = addr | prot_bits;
> -                       addr += MMU_PAGE_SIZE;
> +                       addr += GPU_MMU_PAGE_SIZE;
>                 }
>         }
>
> @@ -62,10 +62,10 @@ static int msm_gpummu_map(struct msm_mmu *mmu, uint64_t iova,
>  static int msm_gpummu_unmap(struct msm_mmu *mmu, uint64_t iova, unsigned len)
>  {
>         struct msm_gpummu *gpummu = to_msm_gpummu(mmu);
> -       unsigned idx = (iova - VA_START) / MMU_PAGE_SIZE;
> +       unsigned idx = (iova - GPU_VA_START) / GPU_MMU_PAGE_SIZE;
>         unsigned i;
>
> -       for (i = 0; i < len / MMU_PAGE_SIZE; i++, idx++)
> +       for (i = 0; i < len / GPU_MMU_PAGE_SIZE; i++, idx++)
>                  gpummu->table[idx] = 0;
>
>         gpu_write(gpummu->gpu, REG_A2XX_MH_MMU_INVALIDATE,
> @@ -78,7 +78,7 @@ static void msm_gpummu_destroy(struct msm_mmu *mmu)
>  {
>         struct msm_gpummu *gpummu = to_msm_gpummu(mmu);
>
> -       dma_free_attrs(mmu->dev, TABLE_SIZE, gpummu->table, gpummu->pt_base,
> +       dma_free_attrs(mmu->dev, GPU_TABLE_SIZE, gpummu->table, gpummu->pt_base,
>                 DMA_ATTR_FORCE_CONTIGUOUS);
>
>         kfree(gpummu);
> @@ -100,7 +100,7 @@ struct msm_mmu *msm_gpummu_new(struct device *dev, struct msm_gpu *gpu)
>         if (!gpummu)
>                 return ERR_PTR(-ENOMEM);
>
> -       gpummu->table = dma_alloc_attrs(dev, TABLE_SIZE + 32, &gpummu->pt_base,
> +       gpummu->table = dma_alloc_attrs(dev, GPU_TABLE_SIZE + 32, &gpummu->pt_base,
>                 GFP_KERNEL | __GFP_ZERO, DMA_ATTR_FORCE_CONTIGUOUS);
>         if (!gpummu->table) {
>                 kfree(gpummu);
> @@ -119,5 +119,5 @@ void msm_gpummu_params(struct msm_mmu *mmu, dma_addr_t *pt_base,
>         dma_addr_t base = to_msm_gpummu(mmu)->pt_base;
>
>         *pt_base = base;
> -       *tran_error = base + TABLE_SIZE; /* 32-byte aligned */
> +       *tran_error = base + GPU_TABLE_SIZE; /* 32-byte aligned */
>  }
> --
> 2.20.0
>
