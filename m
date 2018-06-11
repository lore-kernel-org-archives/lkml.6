Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id hYPNEu5nHlsyHAAAmS7hNA
	; Mon, 11 Jun 2018 12:20:25 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9E37A607E4; Mon, 11 Jun 2018 12:20:09 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U/dpZocy"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1E3236074D;
	Mon, 11 Jun 2018 12:20:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1E3236074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754147AbeFKMUG (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 08:20:06 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35101 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754010AbeFKMUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 08:20:04 -0400
Received: by mail-it0-f65.google.com with SMTP id a3-v6so10631942itd.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 05:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XXE/ppThYU9iATRRsXWBtMgzDBecQQvCw1cKEFfzQes=;
        b=U/dpZocykHdK/Pc03+YX0qJWeVGAlsXd/t23k8MIT94cAA/3liDX+z4JMGQmrJ7tlm
         So/j+IiIUNBioT1WRKq2/tkKmsk76WfiX27IDyy75Xdl020GIp5if3ml0xJgKoVJ8Mgl
         JlY8zVIXwUq5cI6lRm/GDT59rBMr5Y/vJSLok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XXE/ppThYU9iATRRsXWBtMgzDBecQQvCw1cKEFfzQes=;
        b=W04UR+1dlnT0bXhE9f7CfT8Rbvx2PcCV5xXPBGP3mvlYboF+Fpwiave2fyskajK7PY
         mXYWjZ/Qhf8pTrQ+kKbdz+pjFfq+NSx83h6auhYf1ywjtwmqJoAM/PjeWEwc8bsM9RK/
         7/MRMAMTKZeqyYWiwNa4N//yw39ScPdVjZWtbi8xqoD/qv5mPTai02ullZLYF2054qIs
         iVy926L3fft5Pfy5ZpRBIc8vt4onLfPa24LHtcgQ3fng+ioBBYl30+Bws81TQvVYfB9W
         MyKKjqM0inKQyJPF2J6yLP5M/z/dfaw4ofLPFhUYLB7Cv2FgwPZAJbSvrwNdH33Wg5JL
         +gXQ==
X-Gm-Message-State: APt69E2q39cIvvz9PQSBo1xKWC87gO8SjTw08CYpODKZUNcGDizqC+eG
        2sjL8MkGSvs9HxYE6aNm/nP6fZUkZ7L0XFoTZc+lhw==
X-Google-Smtp-Source: ADUXVKJEFk1dSEV6f5wTAuGygDR9L+5U4waVc02daAYa7iiSbxvsNtMvQvDKL/Oa+I2EsWqRtuAKMePpLd1yyzAIEYs=
X-Received: by 2002:a24:91d3:: with SMTP id i202-v6mr10734136ite.97.1528719604072;
 Mon, 11 Jun 2018 05:20:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:c054:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 05:20:03
 -0700 (PDT)
In-Reply-To: <1527590335-171787-1-git-send-email-xiaqing17@hisilicon.com>
References: <1527590335-171787-1-git-send-email-xiaqing17@hisilicon.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 11 Jun 2018 14:20:03 +0200
Message-ID: <CAPDyKFo7FP5bL8doK3P749Rcyzh_H-3SzG+GZVJb2pp9j_ZH_A@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: fix card threshold control configuration
To: Shawn Lin <shawn.lin@rock-chips.com>,
        Evgeniy Didin <Evgeniy.Didin@synopsys.com>,
        Doug Anderson <dianders@chromium.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
        Qing Xia <xiaqing17@hisilicon.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Shawn Lin, Evgeniy Didin, Doug Andersson

On 29 May 2018 at 12:38, Qing Xia <xiaqing17@hisilicon.com> wrote:
> From: x00270170 <xiaqing17@hisilicon.com>
>
> Card write threshold control is supposed to be set since controller
> version 2.80a for data write in HS400 mode and data read in
> HS200/HS400/SDR104 mode. However the current code returns without
> configuring it in the case of data writing in HS400 mode.
> Meanwhile the patch fixes that the current code goes to
> 'disable' when doing data reading in HS400 mode.
>
> Signed-off-by: Qing Xia <xiaqing17@hisilicon.com>

This looks good to me. However, it seems like Jaehoon has been busy,
no response yet.

I have looped in a few more people to see if they thinks this makes sense.

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
