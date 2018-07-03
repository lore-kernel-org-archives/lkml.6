Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74A4C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61CB52083F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FetWM24c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61CB52083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754711AbeGCJAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 05:00:35 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54902 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754698AbeGCJAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 05:00:32 -0400
Received: by mail-it0-f65.google.com with SMTP id s7-v6so2057659itb.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 02:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3ZApTaR7hBzIFIfOWRo/yS0/gpNLXNnSbAENWNGlS/c=;
        b=FetWM24cNXM8DL0phGtEB8OSSvXYId+U1AceW/UtZ/N5x8F8Mke9m/jh5DmR1Dpx/J
         05sxb3iYsbXPuelHQE7fBRfOfs9CcIrmoil0xtySrH3e445XC+Q5lCPEj+/5ZCnT8SPQ
         CFAoRiF7iCiYjudWV/JZwAoxYi7ZHuP6t1+WI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3ZApTaR7hBzIFIfOWRo/yS0/gpNLXNnSbAENWNGlS/c=;
        b=gqK0Uwr5AimQfMf3mkWPNCXWOX1bd9hsovvJ9nVX8L6MOLe/e2CN1SV4kduP/Q8Vyx
         LsLlWEBUyXxx94dEMMB5DQyMU61c1j8kn3HiPZxv/P7ciXYWtDRT5949ArOluIvfoEXV
         TBeYv2ZisNB8i38OZtlXWF9I7es0NN9/F8y1Pv7lTjBRzY6VsdbH2fTamrc45YpXsztw
         5B+khgOjehgz8Bjz/w+vZBFn7qW4/UaXWlHwuzAHftWdd1v1bstd6eJaa4Z0UZ+o98jf
         nSPMphiQyXLs29i2ySgGENwpI6B9SGoMTvnd249qDXjHyqkrMwe5samItmORkGh00P66
         whVw==
X-Gm-Message-State: APt69E0Xj6+uGffpE/35n/fWcSLSUrXsJDJxjd94GMEkb+lerv3TBobe
        DGagx8iWU2bZ8Z/kIDETIUtEDHfK9YPdhCtkg64qlA==
X-Google-Smtp-Source: AAOMgpdMkhT2WtuhqJ5tMkVPHdT5f6JIeBMewiKdC9ynpK3TPbls4RB6bnF3OU0AFyNxN9FsR+ugrwaCEqZETdRlp9A=
X-Received: by 2002:a24:69cb:: with SMTP id e194-v6mr13478871itc.102.1530608431198;
 Tue, 03 Jul 2018 02:00:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 02:00:30 -0700 (PDT)
In-Reply-To: <1530601587-160436-1-git-send-email-xiaqing17@hisilicon.com>
References: <1530601587-160436-1-git-send-email-xiaqing17@hisilicon.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 3 Jul 2018 11:00:30 +0200
Message-ID: <CAPDyKFrPw63KD5mESDmm2pya6bsz01jHiKguMP1GPhWDDZ644Q@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: dw_mmc: fix card threshold control configuration
To:     Qing Xia <xiaqing17@hisilicon.com>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        Evgeniy Didin <Evgeniy.Didin@synopsys.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Doug Anderson <dianders@chromium.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 July 2018 at 09:06, Qing Xia <xiaqing17@hisilicon.com> wrote:
> From: x00270170 <xiaqing17@hisilicon.com>
>
> Card write threshold control is supposed to be set since controller
> version 2.80a for data write in HS400 mode and data read in
> HS200/HS400/SDR104 mode. However the current code returns without
> configuring it in the case of data writing in HS400 mode.
> Meanwhile the patch fixes that the current code goes to
> 'disable' when doing data reading in HS400 mode.
>
> Fixes: 7e4bf1bc9543 ("mmc: dw_mmc: add the card write threshold for HS400 mode")
> Signed-off-by: Qing Xia <xiaqing17@hisilicon.com>

Thanks, applied/moved to fixes for 4.18!

Kind regards
Uffe

> ---
>  drivers/mmc/host/dw_mmc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 29a1afa..3ee8f57 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1065,8 +1065,8 @@ static void dw_mci_ctrl_thld(struct dw_mci *host, struct mmc_data *data)
>          * It's used when HS400 mode is enabled.
>          */
>         if (data->flags & MMC_DATA_WRITE &&
> -               !(host->timing != MMC_TIMING_MMC_HS400))
> -               return;
> +               host->timing != MMC_TIMING_MMC_HS400)
> +               goto disable;
>
>         if (data->flags & MMC_DATA_WRITE)
>                 enable = SDMMC_CARD_WR_THR_EN;
> @@ -1074,7 +1074,8 @@ static void dw_mci_ctrl_thld(struct dw_mci *host, struct mmc_data *data)
>                 enable = SDMMC_CARD_RD_THR_EN;
>
>         if (host->timing != MMC_TIMING_MMC_HS200 &&
> -           host->timing != MMC_TIMING_UHS_SDR104)
> +           host->timing != MMC_TIMING_UHS_SDR104 &&
> +           host->timing != MMC_TIMING_MMC_HS400)
>                 goto disable;
>
>         blksz_depth = blksz / (1 << host->data_shift);
> --
> 2.8.1
>
