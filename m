Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65778160A325
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1682F20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bycAaVy0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1682F20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbeG3Qls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 12:41:48 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35973 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbeG3Qls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 12:41:48 -0400
Received: by mail-it0-f67.google.com with SMTP id p81-v6so132312itp.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 08:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QEwq2umHghMNNUAnYz7YsQiJem5oTYU1yTF1R/yQZ3Q=;
        b=bycAaVy0/a6oLf87p26W6AjreuDKURltYI9F3lWt5ZJO/FnVSGkA1h9aJallRRmjoE
         FgV6qVpo1omMJIyHsVMCsMOksTPK/ObQDH3bbDAwqNZezk8Yzlt8KzuiuMHM+mKWDdWW
         yjzARyCp/0soAUJXbzKSX3bWInJZgR7RVbWPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QEwq2umHghMNNUAnYz7YsQiJem5oTYU1yTF1R/yQZ3Q=;
        b=KHbcFqsFylHF58aF4nJBK3m6rRkK9aXC5PmbvjihKVt+zZWlCoWcenRYRRVT77nV3k
         wmM9a3/MWqKwOSfAEtwswoFVHMX/9T2REYkj8dM6ULOwKrQz1qWVkWf3atTuyqOGc9aU
         VCIAIZQ8y452q/z0OF4v/fXmdnEpF+NWQ6WlEGmhuA19mc4S2URg/Pjq9QIWIBS+hbbs
         6cI6GUbdH220nFE3sZvlanr2+6r4+sGW/SGGeRjL1siBkeumeaS5s+RLZtH+KbVS9lyj
         kGcG3zmFqGWGbjcdDAO2LNm53G2aPgBOU+g0Ls8ncrTcr8iu5wwq3Z90cabiIJio/tZx
         GjOg==
X-Gm-Message-State: AOUpUlGgtKn6oGHbib6Qb4sPYpZwtsj1RmZM9m3TbgZOiBlhrH9OpK0r
        dTF7xoU/ZMYHGAMVNRuzHE+Ht4QpLhCuKcRTb8t+8g7k
X-Google-Smtp-Source: AAOMgpfDAmYnBMIBSE01HNIX3wNICNIr3kPLNsUz1DR4Tplg1eSHjbI2OhDbq5Nk1iAip7alp0Kj+J+RRFd8Wk0EP6I=
X-Received: by 2002:a24:69cb:: with SMTP id e194-v6mr15760606itc.102.1532963183331;
 Mon, 30 Jul 2018 08:06:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 08:06:22
 -0700 (PDT)
In-Reply-To: <20180722125407.43107-1-icenowy@aosc.io>
References: <20180722125407.43107-1-icenowy@aosc.io>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 30 Jul 2018 17:06:22 +0200
Message-ID: <CAPDyKFopeCwOO0jVet8EG6hkiVROfZH=TUv57qWkoL6BeM9qSw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sunxi: allow 3.3V DDR when DDR is available
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 July 2018 at 14:54, Icenowy Zheng <icenowy@aosc.io> wrote:
> Some Allwinner boards feature an on-board eMMC with fixed 3.3V voltage
> (e.g. Banana Pi M2+), and in this case both the eMMC and the SoC are
> capable of doing 3.3V DDR transmission.
>
> Add capability of 3.3V DDR when DDR is available (extra clock or new
> timing).
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sunxi-mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 8e7f3e35ee3d..4ea8e2611079 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1388,7 +1388,7 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
>                                   MMC_CAP_ERASE | MMC_CAP_SDIO_IRQ;
>
>         if (host->cfg->clk_delays || host->use_new_timings)
> -               mmc->caps      |= MMC_CAP_1_8V_DDR;
> +               mmc->caps      |= MMC_CAP_1_8V_DDR | MMC_CAP_3_3V_DDR;
>
>         ret = mmc_of_parse(mmc);
>         if (ret)
> --
> 2.18.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
