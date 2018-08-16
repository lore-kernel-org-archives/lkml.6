Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08A3C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A043A2147D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bi2bdS98"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A043A2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389761AbeHPK6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 06:58:54 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36034 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389732AbeHPK6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 06:58:53 -0400
Received: by mail-lf1-f65.google.com with SMTP id b22-v6so2749001lfa.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 01:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jDgjW+QdeoXmGgB/+SepaeR5unzohegltxHW5URA7K4=;
        b=bi2bdS98mHqBOUgDbZyYDrjH86WI9WiUDdIb6aP2b7lZI6HiHN3oiqIs7puyj7D8B3
         q97RySEIrheXT4kCnGKPHgMXARA1HIHYYSEVIqjule0OKQeq6pTaBy9RDmrBUgEgmzYF
         ZRxkw8OtE5QHhBdLGPA9cMq5qa11qGQU92Ak8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jDgjW+QdeoXmGgB/+SepaeR5unzohegltxHW5URA7K4=;
        b=mLFRkYIGjmbjVtkKhuA1N7OmRhXrjdbSUoSW1moU2liIEPBkg0UCPuSap9EkeB5fNh
         M4wPyGw5Wgopnv3bTDVmffzQN+1vuSD0BIG4V/opTbkmL9C7dxfxDBw0GA651lk47ia7
         kdoeao70ausLKI/UK3n4FsWVqZq8gv0UimNTCPFMR2Sc5wO549W9mc5ofjz9h8HBZf9b
         L4Zzm3s2UTqndj8fGdvpdQi4Y3cP/aieq1LkpYqDlukp+5FpV5teV+nEpfIJkbPV0iYM
         tpanFpV8umT0dYvKN9rm4OqKX3G5bQcxlpdgrs+0YVTs2ic5jRqfn44o1NoO3UMuGmK9
         n29A==
X-Gm-Message-State: AOUpUlF53BhYLa2pSJpFWkHhNc54P7NVcMJ1RCybkzt1wcefWHv3qGPA
        T+U9m5LZuXHHFC0anwTUtYGahTUEO0x1Ks9nAfSRcw==
X-Google-Smtp-Source: AA+uWPxp4YQXGDVR+H1BniN3Qck1qN35T0Wn2fpLY39Sr2TevvXvMoFdpymisOhpQv3kjMxrdETZcjlwG4fvvAPUdSo=
X-Received: by 2002:a19:95c9:: with SMTP id x192-v6mr17963018lfd.37.1534406529304;
 Thu, 16 Aug 2018 01:02:09 -0700 (PDT)
MIME-Version: 1.0
References: <1534333184-25599-1-git-send-email-igor.opaniuk@linaro.org>
In-Reply-To: <1534333184-25599-1-git-send-email-igor.opaniuk@linaro.org>
From:   Shawn Guo <shawn.guo@linaro.org>
Date:   Thu, 16 Aug 2018 16:01:51 +0800
Message-ID: <CAAQ0ZWRj6VhgY_hBz0iaxG8rJQVOVCKn4GOpoC_m1opp+qEyqQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mmc: dw_mmc: hi3798cv200: add MMC_CAP_CMD23 capability
To:     igor.opaniuk@linaro.org
Cc:     linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        tianshuliang <tianshuliang@hisilicon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 7:39 PM Igor Opaniuk <igor.opaniuk@linaro.org> wrote:
>
> Enable access to the RPMB on the on-board eMMC of the
> Poplar board.
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@linaro.org>
> ---
>  drivers/mmc/host/dw_mmc-hi3798cv200.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/host/dw_mmc-hi3798cv200.c b/drivers/mmc/host/dw_mmc-hi3798cv200.c
> index f9b333f..7a023f0 100644
> --- a/drivers/mmc/host/dw_mmc-hi3798cv200.c
> +++ b/drivers/mmc/host/dw_mmc-hi3798cv200.c
> @@ -23,6 +23,12 @@ struct hi3798cv200_priv {
>         struct clk *drive_clk;
>  };
>
> +static unsigned long dw_mci_hi3798cv200_caps[] = {
> +       MMC_CAP_CMD23,
> +       MMC_CAP_CMD23,
> +       0
> +};

I believe the three dwmmc blocks integrated on Hi3798CV200 SoC are
identical on CMD23 support.  So I expect the zero to be MMC_CAP_CMD23
as well.

Shawn

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
