Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F4DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5944C2086C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wsioy7Yg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731462AbeLQIH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 03:07:57 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:46694 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbeLQIH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 03:07:56 -0500
Received: by mail-vk1-f195.google.com with SMTP id j23so2632666vke.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 00:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UVqByxargQ8RYhV+mPmbMYHRnLLXizlt6VQ5EtpK45E=;
        b=Wsioy7YgvcLzxfFxLVIcYLWwN0Evn8XJaiP2OpYisD0X8edIQnR3yPbs+eq2WhFpEK
         8h/syjYJu40qztkDgzoOjnK5wjcccAk9Jg7JnZH1aRN7UqPgIR4YPdRKQtp7sq7Pns89
         KXagMxWmH/5MwaXrPKrqNvUa1ubre3FStKezs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UVqByxargQ8RYhV+mPmbMYHRnLLXizlt6VQ5EtpK45E=;
        b=hyoLeKhnC+JfevI648ylAxdaenrD8I5vxlCervhdYyUSI3XmouyNF1F2xFyhKW/kBx
         UlcLg1TFiVg/s5p/z2HtA5ygpfg2Bt3gHzl7b6J01q1gov24GYcnoKhiIpe+rWcZH3P/
         ZvSiNbd032Hg5HC0OKnFEG7A6PHu6YgSqIVXCDqks4257iL9TvjXC3fONG5lIR53wAfn
         at5PmXO7lQHKgstS/Vf3MZDgrYKS5xm2+H3VzLraeFTQJL0eM79jAwW8ANMhblM1igkd
         UbSLm1hqKhbGBBX6FTkZ/xlKG5bzd2z/nlBLQeHAgEnXUm7G8qa50/ZhzAQt85bCxsQD
         dx0w==
X-Gm-Message-State: AA+aEWZAQr/bKd4sel/hgXo59hL8zLxxfLqkESuQjvyVahqL89i6wRXk
        qKZESMK+kFvP1C+S+leaD+7KvYtRavt1Sv07ooaqdA==
X-Google-Smtp-Source: AFSGD/WTH/ICBWnGwv9uuXzJno0/kYC11jAjSE2yeFDF6b0RlhMlduy9OFMktKQi0q7bIlGQWJXD495HQ+XvhhjRY9E=
X-Received: by 2002:a1f:9042:: with SMTP id s63mr5375689vkd.17.1545034075252;
 Mon, 17 Dec 2018 00:07:55 -0800 (PST)
MIME-Version: 1.0
References: <1544733246-11678-1-git-send-email-skomatineni@nvidia.com>
In-Reply-To: <1544733246-11678-1-git-send-email-skomatineni@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Dec 2018 09:07:19 +0100
Message-ID: <CAPDyKFpG-70QdtGoRMbTXS9OGfb_xn2N1VTVnQK_HiZAakRP9Q@mail.gmail.com>
Subject: Re: [PATCH V1] mmc: sdhci: Fix sdhci_do_enable_v4_mode
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018 at 21:34, Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:
>
> V4_MODE is Bit-15 of SDHCI_HOST_CONTROL2 register.
> Need to perform word access to this register.
>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 99bdae53fa2e..fde984d10619 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -127,12 +127,12 @@ static void sdhci_do_enable_v4_mode(struct sdhci_host *host)
>  {
>         u16 ctrl2;
>
> -       ctrl2 = sdhci_readb(host, SDHCI_HOST_CONTROL2);
> +       ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>         if (ctrl2 & SDHCI_CTRL_V4_MODE)
>                 return;
>
>         ctrl2 |= SDHCI_CTRL_V4_MODE;
> -       sdhci_writeb(host, ctrl2, SDHCI_HOST_CONTROL);
> +       sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
>  }
>
>  /*
> --
> 2.7.4
>
