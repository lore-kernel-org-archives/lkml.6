Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836C2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 553662083D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aDWcaziB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730540AbfB0OLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:11:46 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:34213 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729784AbfB0OLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:11:45 -0500
Received: by mail-vk1-f193.google.com with SMTP id k64so3879041vke.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 06:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jq+R6y6V9MrqwdALCFm6gyLZXiTVokPktPvVjsvyAos=;
        b=aDWcaziBvZNF6Eng3z3pjqoqReadx0OsuM/ZQwZaRe0G+suVn9jeEHEtFapGDXOzjy
         iSBp6uTxIr5oky8fdiAdn661twKBSqnT1A+Ndf4Z/Zw79FnjMnmPRYlYpfZSDkiMpw6z
         L7tRV0G4FB12Vy16aeUyD40VCy45UB0tzixTM38J5eOIh3Z9YDmabgBtUIhDHhYt62XY
         1UcqaqfOInKi28TPvI2isxrpALZMfCGYvoawUL1TFipZAx57qlxdk94QyKpWNvV9CsPE
         JuPuQ8ssJua4wAX+DrIB/rgC16z/v8d2eQjgaVlCqmpnfZ5MdXhrLibwh/FXSZMjtfen
         w3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jq+R6y6V9MrqwdALCFm6gyLZXiTVokPktPvVjsvyAos=;
        b=fbyeeF0/f+Vnfn5Kntl+h3onhR4zx0zHtudZu+ai+7Nn0uCH8Vfktg1VnCTbIfdk3/
         431125q4JiBLna0T2kX5dNaYtibFNpKKQBFqwBlHE/i+ygmnePmPH9GovmKwu+YuAeO9
         UHVu6Fix2rX5Cq6/l4VgW4nfwnxfI+EkYtiLnUd4VEBWNZfm52VX2n+9/657dZGOPBbo
         B3/PDM30GbGirjsvfq5KpAIckMZ5NmQRxg1CNAIv0aOIslYebciFXSvYVlWFbrdLfdOq
         dSkMTYNvt9czPVRZD/a2neLSCHIOckRg8uGxCktmBExTn/ynIVLNDv73BEXJzxEDOS2N
         jV4g==
X-Gm-Message-State: AHQUAubwxxCiaNogqGCtBJf03Td7ym/f+94+THthcV1hu/joKX0IcGOY
        cxkAn/GEQJDO1JAuANR4baeBeEeVkGZfpOIoInylGg==
X-Google-Smtp-Source: AHgI3IZOios8WkxOeIqP3dt7UZ4EHQAYRieQq7+M9Tgj8VcKBVZWiejxBzKOa3Jsxrk6dHD6DKPKrdqIUyGk5Xgkj2I=
X-Received: by 2002:a1f:35f:: with SMTP id 92mr746811vkd.52.1551276704554;
 Wed, 27 Feb 2019 06:11:44 -0800 (PST)
MIME-Version: 1.0
References: <20190225192214.3881-1-alamy.liu@gmail.com> <20190225192214.3881-2-alamy.liu@gmail.com>
In-Reply-To: <20190225192214.3881-2-alamy.liu@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 27 Feb 2019 15:11:08 +0100
Message-ID: <CAPDyKFqOgFMH3r8svC--fy88g5geuxGFMZ7VTYGfPGY7C3C9OA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: cqhci: Fix a tiny potential memory leak on
 error condition
To:     Alamy Liu <alamy.liu@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "# 4.0+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2019 at 20:22, Alamy Liu <alamy.liu@gmail.com> wrote:
>
> Free up the allocated memory in the case of error return
>
> --- code study ---

Using three dashes makes "git am" believe this hole text snippet is a
comment and drops it from the changelog. I fixed it up this time, no
worries.

> The value of mmc_host->cqe_enabled stays 'false'.
> Thus, cqhci_disable (mmc_cqe_ops->cqe_disable) won't be called to
> free the memory.
> Also, cqhci_disable() seems to be designed to disable and free
> all resources, not suitable to handle this corner case.
>
> Fixes: a4080225f51d ("mmc: cqhci: support for command queue enabled host")
> Signed-off-by: Alamy Liu <alamy.liu@gmail.com>

Applied for fixes and added a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/cqhci.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
> index 974997b6cb..795893ba47 100644
> --- a/drivers/mmc/host/cqhci.c
> +++ b/drivers/mmc/host/cqhci.c
> @@ -218,12 +218,21 @@ static int cqhci_host_alloc_tdl(struct cqhci_host *cq_host)
>                                                  cq_host->desc_size,
>                                                  &cq_host->desc_dma_base,
>                                                  GFP_KERNEL);
> +       if (!cq_host->desc_base)
> +               return -ENOMEM;
> +
>         cq_host->trans_desc_base = dmam_alloc_coherent(mmc_dev(cq_host->mmc),
>                                               cq_host->data_size,
>                                               &cq_host->trans_desc_dma_base,
>                                               GFP_KERNEL);
> -       if (!cq_host->desc_base || !cq_host->trans_desc_base)
> +       if (!cq_host->trans_desc_base) {
> +               dmam_free_coherent(mmc_dev(cq_host->mmc), cq_host->desc_size,
> +                                  cq_host->desc_base,
> +                                  cq_host->desc_dma_base);
> +               cq_host->desc_base = NULL;
> +               cq_host->desc_dma_base = 0;
>                 return -ENOMEM;
> +       }
>
>         pr_debug("%s: cqhci: desc-base: 0x%p trans-base: 0x%p\n desc_dma 0x%llx trans_dma: 0x%llx\n",
>                  mmc_hostname(cq_host->mmc), cq_host->desc_base, cq_host->trans_desc_base,
> --
> 2.17.1
>
