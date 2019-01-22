Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE178C282C5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD7020854
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f9RPZhKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfAVHsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 02:48:38 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:40705 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbfAVHsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 02:48:36 -0500
Received: by mail-ua1-f67.google.com with SMTP id n7so7742273uao.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 23:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9KVAYJ0gpLIXYPyz//0HmScHy9SasXIBZTqrINVc2mg=;
        b=f9RPZhKEJAMuKOZIzh1vVcLxWBGAMkZRYS5g0cMwDgRQn5B1XB7RJIMEekJKAv3qxQ
         +whQE9o+mP7NJFw84bNveg3kqJK4FSHeJzbsy89g15M2G07VOTbbnfnzk9im8oQF+5GU
         94LA3cKiaNFGx8IY3lqd4XpqxTkuv66l/hisc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9KVAYJ0gpLIXYPyz//0HmScHy9SasXIBZTqrINVc2mg=;
        b=lqNVCdNJEVrL59NX9iugz2mFeLuMQwMm13Yq1NuyzbTaTrmWL2A/Ar2t0PTsno3I7I
         uq/DwpsuG0aH2MwFoSch2BOyD3fhnfEm+opu8h33FgqlW31m7e+qxgy+kpQv4+ZtSjNU
         XMT9Qj2xaUk59xxFBNFngD8JO1+aWXqXKYtQMkkoqGRyqLG98adc78Cz35BLC7WlCYg/
         kGSzPgUvxGEffqnBTy289rVlR3rsosEr2JNuLEt0qXZOi9a0qae2t0VbPqflA0aUZ8DQ
         cl5U5mJ8JUBKPkV7IYiICuA4Sfd+oSOxYwJva1KXuVLaREMvSgysoAYMtELow1h0ONLk
         UK2g==
X-Gm-Message-State: AJcUukfkKoV7ltCiLcFERTV0lIx4xr9v7HBnrglYxlwocpEajIRl1SZp
        TgGDqzaxAWtsOGXDyWtG+otjt9KMhyNeBQs6vNYo+BTo
X-Google-Smtp-Source: ALg8bN7tBMYi0Q1kxfcW8F5QLcSGGOBpRxT+zTsgeOAV/2ZUb7L2ioIBBenEk/obHwr+wCjFeYb+KBDHBYm2WOcDnLE=
X-Received: by 2002:a9f:2244:: with SMTP id 62mr12541630uad.119.1548143315448;
 Mon, 21 Jan 2019 23:48:35 -0800 (PST)
MIME-Version: 1.0
References: <20190116195219.2897-1-malat@debian.org>
In-Reply-To: <20190116195219.2897-1-malat@debian.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 22 Jan 2019 08:47:59 +0100
Message-ID: <CAPDyKFq2k=DqJmkRv_5Awwsc0Wken7tST11iAg3YefY-_y4y=w@mail.gmail.com>
Subject: Re: [PATCH] mmc: Annotate implicit fall through in jz_mmc_irq_worker
To:     Mathieu Malaterre <malat@debian.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2019 at 20:52, Mathieu Malaterre <malat@debian.org> wrote:
>
> There is a plan to build the kernel with -Wimplicit-fallthrough and
> these places in the code produced warnings (W=1).
>
> This commit removes the following warnings:
>
>   drivers/mmc/host/jz4740_mmc.c:745:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   drivers/mmc/host/jz4740_mmc.c:779:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/jz4740_mmc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
> index 33215d66afa2..a1df8bc0b964 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -743,6 +743,7 @@ static irqreturn_t jz_mmc_irq_worker(int irq, void *devid)
>                         break;
>
>                 jz_mmc_prepare_data_transfer(host);
> +               /* fall through */
>
>         case JZ4740_MMC_STATE_TRANSFER_DATA:
>                 if (host->use_dma) {
> @@ -777,6 +778,7 @@ static irqreturn_t jz_mmc_irq_worker(int irq, void *devid)
>                         break;
>                 }
>                 jz4740_mmc_write_irq_reg(host, JZ_MMC_IRQ_DATA_TRAN_DONE);
> +               /* fall through */
>
>         case JZ4740_MMC_STATE_SEND_STOP:
>                 if (!req->stop)
> --
> 2.19.2
>
