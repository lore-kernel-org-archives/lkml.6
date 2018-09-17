Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8109EECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC24214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dgl2hjf1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FC24214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbeIRAEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 20:04:08 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54940 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbeIRAEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 20:04:08 -0400
Received: by mail-it0-f67.google.com with SMTP id f14-v6so12546022ita.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 11:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OYrSi1V7lR8DIOe2oTa8DcRNpOb3O2kJw7hmjEVYZdM=;
        b=dgl2hjf16DdPgaXGVqXEe2t5FYZnBd/kjqH/R+K3zS6SQ9qajo/USXaF9gQTm4BZHR
         vW5UATy5qBKo3VinDDCvh+5r7mANPTbLS3duHiwHDX8GU1cum16B/ZIByCf8cCdCDQZ5
         4mqVMcjqJ1He9kQpw0PUBThrFOtmrRMtqB/FA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OYrSi1V7lR8DIOe2oTa8DcRNpOb3O2kJw7hmjEVYZdM=;
        b=PYBol6L4pbhw1T5DdEeqTWs3yLV6N1smpfq/koWyC9o52+1MjzyrNPP80Ea/RJDN+6
         C8kbJNm/xZlPwpNIWe4oi35Y0lM1Wr5+QtOdHZPQYpm+JxLch8fY3+Me0svw3vUo3gwo
         XNH7ueLjx9MFa4WfJNJiJ0pImLITPXjAJcq9bFAW5jS4FyAu2XjXXtuG55F3ifsnGbS+
         Jnkglf8rzO9GX6TlC9ybF5+nthn2TtxJZtOCk7Sa0b5Tw/GcsKV5ktMZHBZmcFVRjH3T
         gkiD6ypvv3Yz2rfkDMleTr94MF3A3l2DfUa5bvbgbEs4kIlPFxI0J+bDotOA/RCYsoaf
         4YgA==
X-Gm-Message-State: APzg51APi4bbIKnv96lipEoF6hkWutZ3ZQYdMnXf5yOGwqsnnDvQjvhy
        EdptlK4mteo1JmOAC7rNbAvg8hH7D5edu6UKd4QbHA==
X-Google-Smtp-Source: ANB0VdZ0Ex2w3dJw4hgwjh14TGTgqASEzpytuHW0smBFhctbv9v4roCqBi5WZ1pIK1MX2apKgqXVBY9oDgt6A3IJcN8=
X-Received: by 2002:a24:3fc6:: with SMTP id d189-v6mr13259180ita.64.1537209334180;
 Mon, 17 Sep 2018 11:35:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:6a18:0:0:0:0:0 with HTTP; Mon, 17 Sep 2018 11:35:33
 -0700 (PDT)
In-Reply-To: <20180911144701.53383-1-hangdianqj@163.com>
References: <20180911144701.53383-1-hangdianqj@163.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Sep 2018 20:35:33 +0200
Message-ID: <CAPDyKFqr61j91qPKMv49nSKnwUbiZxPXDCYpbX4CNvN7eVGWGw@mail.gmail.com>
Subject: Re: [PATCH] mmc: mxcmmc: replace spin_lock_irqsave with spin_lock in ISR
To:     jun qian <hangdianqj@163.com>
Cc:     Kees Cook <keescook@chromium.org>, Allen <allen.lkml@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 September 2018 at 16:47, jun qian <hangdianqj@163.com> wrote:
> As you are already in ISR, it is unnecessary to call spin_lock_irqsave.
>
> Signed-off-by: jun qian <hangdianqj@163.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/mxcmmc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index de4e6e5bf304..4d17032d15ee 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -728,7 +728,6 @@ static void mxcmci_cmd_done(struct mxcmci_host *host, unsigned int stat)
>  static irqreturn_t mxcmci_irq(int irq, void *devid)
>  {
>         struct mxcmci_host *host = devid;
> -       unsigned long flags;
>         bool sdio_irq;
>         u32 stat;
>
> @@ -740,9 +739,9 @@ static irqreturn_t mxcmci_irq(int irq, void *devid)
>
>         dev_dbg(mmc_dev(host->mmc), "%s: 0x%08x\n", __func__, stat);
>
> -       spin_lock_irqsave(&host->lock, flags);
> +       spin_lock(&host->lock);
>         sdio_irq = (stat & STATUS_SDIO_INT_ACTIVE) && host->use_sdio;
> -       spin_unlock_irqrestore(&host->lock, flags);
> +       spin_unlock(&host->lock);
>
>         if (mxcmci_use_dma(host) && (stat & (STATUS_WRITE_OP_DONE)))
>                 mxcmci_writel(host, STATUS_WRITE_OP_DONE, MMC_REG_STATUS);
> --
> 2.17.1
>
>
>
