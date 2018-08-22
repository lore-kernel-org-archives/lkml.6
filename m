Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0B0C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EBC5214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ifLJ6Wuk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EBC5214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbeHVNMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 09:12:48 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:34958 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728694AbeHVNMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 09:12:47 -0400
Received: by mail-it0-f66.google.com with SMTP id 139-v6so2167301itf.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 02:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Bu6eciyrsLRQ5aSEBrlZy/dw3IS+tKd61vhXUohlYxw=;
        b=ifLJ6WukEaQvtFrPWeYrlH4YnFdzCzgcN0LgfC2Rp/yAZNei9iOm5ADfEi1FOnP1yh
         t5xPJK59+IrfYoO9QbDLqwSnW5B7kn/w8+KAzF0W6sOTzyJZNXOObp+IpSSfE+5myS5M
         heS8vzMxpJ5dCXeaKMDd7iDieg+CFf9mGXxN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Bu6eciyrsLRQ5aSEBrlZy/dw3IS+tKd61vhXUohlYxw=;
        b=mqAUMxGSyQ+WJqAK9iW0OV5Bt5ecEHQqr5zribsbcNStfQI5pMgK5YshvSsQFqHBSM
         ZmW7UpDPag1mytC7t+s2+i2fbi8iMotZQbWEBldRdmrk8m8E8YDhgVY2gCvq1uWhmWWN
         83BpBVkx0uy8ZInnzI8uevAXTLlnMO6ZVzk2nESifudmHxXaFx7XChufAWFN4mT7GFhF
         A1X6v0CtCCDfsB5vqvDESMFrgjTRUF8BRf8gyXPR4DFZins5gBMnUIYMihm82xqFQf0c
         b05+Yi7zBZ1PND4zUuXp8xynM1yuytttRzWhiChrNbXfL9F/CddN/WG1++91X/iNiRgp
         03eg==
X-Gm-Message-State: AOUpUlG2YU8EIfIgN41rLpEgY5slRHVQ1ImIrAeAaj5V0yd5TYGz/KRI
        3fl6uC3RBRRhpDrZUcI3Ky1f8yI10PcdEzygXKJ/lg==
X-Google-Smtp-Source: AA+uWPyInNNGarlVWhJyyvnxqKCmJf0IAgEPFmluWY4vm7Jxq9gow/WhDrAiV84n/Z92zj45iFVrI99DavzovJOct2g=
X-Received: by 2002:a02:70d7:: with SMTP id f206-v6mr12867969jac.142.1534931318478;
 Wed, 22 Aug 2018 02:48:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Wed, 22 Aug 2018 02:48:38
 -0700 (PDT)
In-Reply-To: <1534770297-5242-1-git-send-email-igor.opaniuk@linaro.org>
References: <1534770297-5242-1-git-send-email-igor.opaniuk@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 22 Aug 2018 11:48:38 +0200
Message-ID: <CAPDyKFpQfOgdzpqM9VytADxE9ZHOAw=6VzTgP=WD=iM93eRRnQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mmc: dw_mmc: hi3798cv200: add MMC_CAP_CMD23 cap
To:     Igor Opaniuk <igor.opaniuk@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        tianshuliang <tianshuliang@hisilicon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 August 2018 at 15:04, Igor Opaniuk <igor.opaniuk@linaro.org> wrote:
> Enable access to the RPMB on the on-board eMMC of the
> Poplar board.
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@linaro.org>

Thanks, queued for v.4.20!

Kind regards
Uffe

> ---
>
> v2:
> - as there are three dwmmc blocks integrated on Hi3798CV200 SoC with
> identical CMD23 support, provide MMC_CAP_CMD23 capability instead of 0 for
> the third block also.
>
>  drivers/mmc/host/dw_mmc-hi3798cv200.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/host/dw_mmc-hi3798cv200.c b/drivers/mmc/host/dw_mmc-hi3798cv200.c
> index f9b333f..bc51cef 100644
> --- a/drivers/mmc/host/dw_mmc-hi3798cv200.c
> +++ b/drivers/mmc/host/dw_mmc-hi3798cv200.c
> @@ -23,6 +23,12 @@ struct hi3798cv200_priv {
>         struct clk *drive_clk;
>  };
>
> +static unsigned long dw_mci_hi3798cv200_caps[] = {
> +       MMC_CAP_CMD23,
> +       MMC_CAP_CMD23,
> +       MMC_CAP_CMD23
> +};
> +
>  static void dw_mci_hi3798cv200_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>  {
>         struct hi3798cv200_priv *priv = host->priv;
> @@ -160,6 +166,8 @@ static int dw_mci_hi3798cv200_init(struct dw_mci *host)
>  }
>
>  static const struct dw_mci_drv_data hi3798cv200_data = {
> +       .caps = dw_mci_hi3798cv200_caps,
> +       .num_caps = ARRAY_SIZE(dw_mci_hi3798cv200_caps),
>         .init = dw_mci_hi3798cv200_init,
>         .set_ios = dw_mci_hi3798cv200_set_ios,
>         .execute_tuning = dw_mci_hi3798cv200_execute_tuning,
> --
> 2.7.4
>
