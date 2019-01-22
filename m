Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D79C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79CD620854
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jz+0DWQd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfAVHsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 02:48:47 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44926 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbfAVHsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 02:48:46 -0500
Received: by mail-vs1-f67.google.com with SMTP id u11so14122956vsp.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 23:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=luSxlYN7vH7kmtcgnXY/0/3ilVvQg21/O14SnN2k+dw=;
        b=jz+0DWQdODDoJcogPbhZI7iUwYJywfd3P/NB0K1vXt8WM5NoYWIVlRSQBe8kWTNt1u
         Ukt2aDqKo/3TzoN7xyJ8P9p/we1tisCzyRX1c7vGGVABBPCZF2yscPuDsIMPU6aQh+wO
         svhXwHAJfDRrAwwlQTBFTjDMnrXJyvv4EsHTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=luSxlYN7vH7kmtcgnXY/0/3ilVvQg21/O14SnN2k+dw=;
        b=TduKFY1ztlSnrueRJIQdNYR5Ix3NoqjTvxhkUU2X/N6fDKnqdITdZR/A1bgfKFHI/f
         bwkCCbusXGjW+FPICrtSOCd1A0f6r1Mll+kbbKfwOTnRchRWjUmUSuRooeCX4xZV7zKG
         6O0e+py7mWjeVNDeMDAO191QT4IRqlf4quz6k/R2Bq4hVV+tFvntpOZuu5l/nUnO1Gy/
         Wxs4glUqWigfMli4lw1bYEJwBSo7+tZiFwRsfFzJGsnnHhVxx2G1TkhVA0Ghqk5Jz7dV
         uU1M9fMi5gYNbh8G572Gvzr6FK2b9Ih84dbUmx8oMlq52gMHJqtkJ7/kvMdhLmMtjJQ8
         +Ymg==
X-Gm-Message-State: AJcUukdczbNXa/kgqR+amTp767TbI7cVzGxRA52tuMyWYTA2mheOxoBN
        24JoUlsvrNGAxQcDdrmp5X4bCJo2HsLDYKhhCRea8A==
X-Google-Smtp-Source: ALg8bN6x1YT/OgPQlyz4CXVBPJ65ekbQtKh4l7RWjXSCfURECz6jHn5JFNX7fdbyE5Wnf1Ey9tDImncrMfeds/3dqC0=
X-Received: by 2002:a67:b245:: with SMTP id s5mr881051vsh.200.1548143325389;
 Mon, 21 Jan 2019 23:48:45 -0800 (PST)
MIME-Version: 1.0
References: <7f45f1c645ec166b25afe51aa9ae1decdae0b600.1547834838.git.lsun@mellanox.com>
In-Reply-To: <7f45f1c645ec166b25afe51aa9ae1decdae0b600.1547834838.git.lsun@mellanox.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 22 Jan 2019 08:48:09 +0100
Message-ID: <CAPDyKFp6nK-cWOHdSARsgU6N0gsV3srL2pH2Y5VYiwC-pkXwpg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mmc: dw_mmc-bluefield: : Fix the license information
To:     Liming Sun <lsun@mellanox.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        David Woods <dwoods@mellanox.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "# 4.0+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019 at 19:12, Liming Sun <lsun@mellanox.com> wrote:
>
> The SPDX license identifier and the boiler plate text are
> contradicting. Only the SPDX license identifier is needed. The
> other one is removed.
>
> Fixes: 86958dcc5ad7 ("mmc: dw_mmc-bluefield: Add driver extension")
> Cc: stable@vger.kernel.org
> Reviewed-by: David Woods <dwoods@mellanox.com>
> Signed-off-by: Liming Sun <lsun@mellanox.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc-bluefield.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-bluefield.c b/drivers/mmc/host/dw_mmc-bluefield.c
> index ed8f225..aa38b1a 100644
> --- a/drivers/mmc/host/dw_mmc-bluefield.c
> +++ b/drivers/mmc/host/dw_mmc-bluefield.c
> @@ -1,11 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (C) 2018 Mellanox Technologies.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
>   */
>
>  #include <linux/bitfield.h>
> --
> 1.8.3.1
>
