Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC52C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D7C20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmrOoHE9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D7C20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389947AbeHARUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:20:44 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:37614 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389455AbeHARUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:20:44 -0400
Received: by mail-vk0-f68.google.com with SMTP id v72-v6so9504908vkd.4;
        Wed, 01 Aug 2018 08:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zjJuAl9SbVha/bLPaX6gg/cgSpp1HHcPVbIOdQ7cWd4=;
        b=GmrOoHE9yrbiJLqq8BI8tDPBLXbDEgVSbxRCAVDq5DQabNaBA+u7j/Q3E92AMVIgvr
         EEiMvEWsGY0j7jXVogIs77SGEfOf9ushCE2bfnWV5AMOkPNbrYOV9IVb5rU/USwmnYaq
         u1aJSE1MQNwQi+ufPe0NCvNIil8NXBdxWCB9zcveiPb/a7sy1beUiifkMbqarfnIKo/X
         41xt271/SVQHvjUbas3364thL591AMbG13qmm4nDfya8hRhda1i5V0XZQsLSU5g1peVz
         es7Mdtoe2p5INiyq/baAGfa8KnqwrWCQv1HU4/89Aj3aMP0yx8gsifJu8b8YTm2enLaZ
         8qSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zjJuAl9SbVha/bLPaX6gg/cgSpp1HHcPVbIOdQ7cWd4=;
        b=FQsniSfpMLq/9ROVC+Tr9yquB5zt9zidm/QtlcvmIu0U8UjHtdGLc9WzZcW6xFzx6V
         mq/hZiEFY7cHCTVggw+YSw9RvqqL9mmy5LNLf3Mu1aUcmAjiBIQuHfGHpsBF0xkl1/aN
         yQmujue37DVqNG/4flf7ZhbZmxp7DVt0wqbCTh7RuP/x+O7PJyzYwnx5wFY3LmyGCR+X
         +J/1bfL4eMpq+OwDXgicquQZPhb9wI6RZbRDOsMQCf9ocpJZq1WCujaQwqDVBqRjyJhx
         frwyrlQ0HmP2A/t2Q3nTjmazv5SLrNcRbRC515jX+3WogKgfYimZ8YLk31hd0IyyootD
         ZF3g==
X-Gm-Message-State: AOUpUlH6WqYgWuG3dutNKDh4QqINoamXXej2AUFiAzS4QIEYKmwazb+1
        YZ9CH+g7sK/5OidiJGSqg/YzYavt8hqyMV8CY60=
X-Google-Smtp-Source: AAOMgpf4kulOuN38cQK58IFcNm21DRBLoS+KiINB9NgW2xQqcGE1A69mkA5oq3zLwt9ZxF9E4JvPulq9AwDMFN98810=
X-Received: by 2002:a1f:b503:: with SMTP id e3-v6mr17244869vkf.97.1533137667217;
 Wed, 01 Aug 2018 08:34:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 08:34:26 -0700 (PDT)
In-Reply-To: <1533129976-51930-5-git-send-email-zhongjiang@huawei.com>
References: <1533129976-51930-1-git-send-email-zhongjiang@huawei.com> <1533129976-51930-5-git-send-email-zhongjiang@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 1 Aug 2018 18:34:26 +0300
Message-ID: <CAHp75Vdir4W+nFHVwH=Vh++441C3TzbN8fxVXDf7_08Qs-4XwA@mail.gmail.com>
Subject: Re: [PATCH 4/4] drivers/scsi/mvsas/mv_init: Use dma_zalloc_coherent
 to replace dma_alloc_coherent+memset
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     John Garry <john.garry@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        aacraid@microsemi.com, linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 4:26 PM, zhong jiang <zhongjiang@huawei.com> wrote:
> The dma_zalloc_coherent is better than dma_alloc_coherent+memset,
> so replace them.
>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>


> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/scsi/mvsas/mv_init.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
> index 8c91637..da62e18 100644
> --- a/drivers/scsi/mvsas/mv_init.c
> +++ b/drivers/scsi/mvsas/mv_init.c
> @@ -253,33 +253,29 @@ static int mvs_alloc(struct mvs_info *mvi, struct Scsi_Host *shost)
>         /*
>          * alloc and init our DMA areas
>          */
> -       mvi->tx = dma_alloc_coherent(mvi->dev,
> +       mvi->tx = dma_zalloc_coherent(mvi->dev,
>                                      sizeof(*mvi->tx) * MVS_CHIP_SLOT_SZ,
>                                      &mvi->tx_dma, GFP_KERNEL);
>         if (!mvi->tx)
>                 goto err_out;
> -       memset(mvi->tx, 0, sizeof(*mvi->tx) * MVS_CHIP_SLOT_SZ);
> -       mvi->rx_fis = dma_alloc_coherent(mvi->dev, MVS_RX_FISL_SZ,
> +       mvi->rx_fis = dma_zalloc_coherent(mvi->dev, MVS_RX_FISL_SZ,
>                                          &mvi->rx_fis_dma, GFP_KERNEL);
>         if (!mvi->rx_fis)
>                 goto err_out;
> -       memset(mvi->rx_fis, 0, MVS_RX_FISL_SZ);
>
> -       mvi->rx = dma_alloc_coherent(mvi->dev,
> +       mvi->rx = dma_zalloc_coherent(mvi->dev,
>                                      sizeof(*mvi->rx) * (MVS_RX_RING_SZ + 1),
>                                      &mvi->rx_dma, GFP_KERNEL);
>         if (!mvi->rx)
>                 goto err_out;
> -       memset(mvi->rx, 0, sizeof(*mvi->rx) * (MVS_RX_RING_SZ + 1));
>         mvi->rx[0] = cpu_to_le32(0xfff);
>         mvi->rx_cons = 0xfff;
>
> -       mvi->slot = dma_alloc_coherent(mvi->dev,
> +       mvi->slot = dma_zalloc_coherent(mvi->dev,
>                                        sizeof(*mvi->slot) * slot_nr,
>                                        &mvi->slot_dma, GFP_KERNEL);
>         if (!mvi->slot)
>                 goto err_out;
> -       memset(mvi->slot, 0, sizeof(*mvi->slot) * slot_nr);
>
>         mvi->bulk_buffer = dma_alloc_coherent(mvi->dev,
>                                        TRASH_BUCKET_SIZE,
> --
> 1.7.12.4
>



-- 
With Best Regards,
Andy Shevchenko
