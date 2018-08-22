Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B05FC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E74214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d9D028G7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E74214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbeHVNNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 09:13:19 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:37881 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbeHVNNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 09:13:19 -0400
Received: by mail-io0-f182.google.com with SMTP id v14-v6so972041iob.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 02:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xcbAKIQ8fS8zQq0sO9sfv9DFiBx7yrI8/I571jdsySM=;
        b=d9D028G7R3Vuq9XIMB3xzbvSF8fgNaIfKcKjy60lFvgZ6pwwu0EiQ+QAltT18NNQTX
         2S9KZZCMiORe3gnCn4ioAqsYM3KAXOG72jMsReEfNFYF2Db8G8dIsLZibv9JBAkSFP7Y
         N+uC+6HavIH4c/7NCd98nY7B9QxP6+1gYRHqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xcbAKIQ8fS8zQq0sO9sfv9DFiBx7yrI8/I571jdsySM=;
        b=Mgf0eWAEmZzguPT95lgQI6mjowS8X4BoNez+4nCRUg1ac2C4cKcA7OwoEix9GEvoja
         W7NwRfWwnDChFWynI/JcuDKN+nVd0fAd4/ltso7Gu8Hy/qLY1FFnxrADRBdhix/FOPcq
         Luqv545wGXNz2plIavgGH5B3Sl+ocCTS7UfGmu+vzVFHoU6QEl+3aspmLrbAKPQPdfjk
         t7Iaixe/+h5Qj7qs0mQrFr8cft2ERNGwbiOPvr2gZQue/bMKjcO5OSu8mcBqeAj9t3gF
         HCwaUlnsJE0hX0/QWb5Vh+A+FvfwQbCiDG+ZadlGfiCa5axTD2hi66A0w+acKRY9DoXg
         eTyg==
X-Gm-Message-State: APzg51AR4DGpB2xDtw21tWmJXpjgetRBirng6gpsRUgRKbDbJzbD9yyX
        nQQ7es+ee8WcD2bRRwKVroZFVQKHHsj9fiM8yyLUlg==
X-Google-Smtp-Source: ANB0VdYFPKve8frBIiTH6xFm3CQ4p9clgy/HRNu/gxP+rPjiyLQxKRWJ7bWOhVGlZrub51uED5vErT24+7ZSuf28VIk=
X-Received: by 2002:a6b:c995:: with SMTP id z143-v6mr17340940iof.266.1534931349634;
 Wed, 22 Aug 2018 02:49:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Wed, 22 Aug 2018 02:49:09
 -0700 (PDT)
In-Reply-To: <20180821220233.9202-5-wsa+renesas@sang-engineering.com>
References: <20180821220233.9202-1-wsa+renesas@sang-engineering.com> <20180821220233.9202-5-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 22 Aug 2018 11:49:09 +0200
Message-ID: <CAPDyKFpb3kOYh5tms8Q=f=M-+597jyFZSj8dwr5cRz+VHqs_OA@mail.gmail.com>
Subject: Re: [PATCH 04/11] mmc: use SPDX identifier for Renesas drivers
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 August 2018 at 00:02, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, queued for v4.20!

> ---
>
> To be applied individually per subsystem tree. Morimoto-san, could you maybe
> ack this with your Renesas address?

I will add his ack when he sends it.

Kind regards
Uffe

>
>  drivers/mmc/host/renesas_sdhi.h               | 5 +----
>  drivers/mmc/host/renesas_sdhi_core.c          | 5 +----
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 5 +----
>  drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 5 +----
>  drivers/mmc/host/sh_mmcif.c                   | 7 ++-----
>  drivers/mmc/host/tmio_mmc.c                   | 5 +----
>  drivers/mmc/host/tmio_mmc.h                   | 6 +-----
>  drivers/mmc/host/tmio_mmc_core.c              | 5 +----
>  drivers/mmc/host/usdhi6rol0.c                 | 5 +----
>  9 files changed, 10 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
> index f13f798d8506..da1e49c45bec 100644
> --- a/drivers/mmc/host/renesas_sdhi.h
> +++ b/drivers/mmc/host/renesas_sdhi.h
> @@ -1,12 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * Renesas Mobile SDHI
>   *
>   * Copyright (C) 2017 Horms Solutions Ltd., Simon Horman
>   * Copyright (C) 2017 Renesas Electronics Corporation
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
>   */
>
>  #ifndef RENESAS_SDHI_H
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index 777e32b0e410..68ece2f183cf 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Renesas SDHI
>   *
> @@ -6,10 +7,6 @@
>   * Copyright (C) 2016-17 Horms Solutions, Simon Horman
>   * Copyright (C) 2009 Magnus Damm
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>   * Based on "Compaq ASIC3 support":
>   *
>   * Copyright 2001 Compaq Computer Corporation.
> diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> index 35cc0de6be67..a3e03c473bb2 100644
> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * DMA support for Internal DMAC with SDHI SD/SDIO controller
>   *
>   * Copyright (C) 2016-17 Renesas Electronics Corporation
>   * Copyright (C) 2016-17 Horms Solutions, Simon Horman
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
>   */
>
>  #include <linux/bitops.h>
> diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> index 890f192dedbd..f5fcbb5dc8cd 100644
> --- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * DMA support use of SYS DMAC with SDHI SD/SDIO controller
>   *
> @@ -5,10 +6,6 @@
>   * Copyright (C) 2016-17 Sang Engineering, Wolfram Sang
>   * Copyright (C) 2017 Horms Solutions, Simon Horman
>   * Copyright (C) 2010-2011 Guennadi Liakhovetski
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
>   */
>
>  #include <linux/device.h>
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 4c2a1f8ddbf3..81bd9afb0980 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * MMCIF eMMC driver.
>   *
>   * Copyright (C) 2010 Renesas Solutions Corp.
>   * Yusuke Goda <yusuke.goda.sx@renesas.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License.
>   */
>
>  /*
> @@ -1573,6 +1570,6 @@ static struct platform_driver sh_mmcif_driver = {
>  module_platform_driver(sh_mmcif_driver);
>
>  MODULE_DESCRIPTION("SuperH on-chip MMC/eMMC interface driver");
> -MODULE_LICENSE("GPL");
> +MODULE_LICENSE("GPL v2");
>  MODULE_ALIAS("platform:" DRIVER_NAME);
>  MODULE_AUTHOR("Yusuke Goda <yusuke.goda.sx@renesas.com>");
> diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
> index 43a2ea5cff24..36d8e7db00e6 100644
> --- a/drivers/mmc/host/tmio_mmc.c
> +++ b/drivers/mmc/host/tmio_mmc.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Driver for the MMC / SD / SDIO cell found in:
>   *
> @@ -7,10 +8,6 @@
>   * Copyright (C) 2017 Horms Solutions, Simon Horman
>   * Copyright (C) 2007 Ian Molton
>   * Copyright (C) 2004 Ian Molton
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
>   */
>
>  #include <linux/device.h>
> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> index 5d141f79e175..efa5a1e3e5af 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * Driver for the MMC / SD / SDIO cell found in:
>   *
> @@ -8,11 +9,6 @@
>   * Copyright (C) 2016-17 Horms Solutions, Simon Horman
>   * Copyright (C) 2007 Ian Molton
>   * Copyright (C) 2004 Ian Molton
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>   */
>
>  #ifndef TMIO_MMC_H
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index 261b4d62d2b1..b750f6372dc2 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Driver for the MMC / SD / SDIO IP found in:
>   *
> @@ -10,10 +11,6 @@
>   * Copyright (C) 2007 Ian Molton
>   * Copyright (C) 2004 Ian Molton
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>   * This driver draws mainly on scattered spec sheets, Reverse engineering
>   * of the toshiba e800  SD driver and some parts of the 2.4 ASIC3 driver (4 bit
>   * support). (Further 4 bit support from a later datasheet).
> diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
> index cdfeb15b6f05..cd8b1b9d4d8a 100644
> --- a/drivers/mmc/host/usdhi6rol0.c
> +++ b/drivers/mmc/host/usdhi6rol0.c
> @@ -1,10 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (C) 2013-2014 Renesas Electronics Europe Ltd.
>   * Author: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
>   */
>
>  #include <linux/clk.h>
> --
> 2.11.0
>
