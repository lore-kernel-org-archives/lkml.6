Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB70C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C543207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hxLZduSx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C543207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeJXWu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 18:50:58 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:54289 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbeJXWu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 18:50:57 -0400
Received: by mail-it1-f195.google.com with SMTP id l191-v6so6379740ita.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 07:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BLYyvct9f51IMOrQIPtchioY0a5M0Oga9MtVLwOvygg=;
        b=hxLZduSxxTqeMUJen0NaP4zOV38iGZ9YUniB8yhvgmM3JkcjbaFB/ugfL/E6MdWEIj
         UNVoSJ8fTd7yPOnBt7GEE46HSEfotAbgbOhmScDqpOMdfRSZ/+FWg2VvMDaDm82MCXKq
         gkDYprZ67FCW96wMWGHSmm81GnXuO2/AV0/JI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BLYyvct9f51IMOrQIPtchioY0a5M0Oga9MtVLwOvygg=;
        b=dESGWcFiUDXnn9kB+bSgcRuH/J2OJdTB7wwDRuNJ40NVIQDHsMlrOjhsNe2JsR9coU
         Cdr7QBP2RwTsjEhPe2KtKDyviGMs/CBHYOU2zx9lsJwIFDwlOitVRefGe9Sakxbfm43G
         3367qBfTupSHz4fL3IT+IRcWmtsRD3q9JD1qahWubBgBorU/l9Go9V0wz0VywenT8dSM
         U95zaeX0F2X3w3fSIUgGs8xkl3q80eGojr+UDtZF4aw4KHCgCUbqKytuFbVckawtUFJO
         t6jx4CkeFSPMuJmAWjCRcSSguV8R6yift4tB8w3LroxbRF+UzVOPg/SJTq19XwLreRnM
         LBfA==
X-Gm-Message-State: AGRZ1gJESezcyxcqdPz/yHC3ybzopslLXAS6NzhME6u2QXjA57x5RZWw
        XlKrOTQSfVly45ZYGdUFCpYYRAg2eWxeqw+Av9CZLg==
X-Google-Smtp-Source: AJdET5fxrKAG58N1LO0LyrVlB+FbUS67iL5dRyCFmKo/hqzEcOtwNXjExuSMEJ4aCHY8vc4MeNDykrsr6D8WUhAbNoM=
X-Received: by 2002:a24:6b4d:: with SMTP id v74-v6mr1577239itc.26.1540390958416;
 Wed, 24 Oct 2018 07:22:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Wed, 24 Oct 2018 07:21:58
 -0700 (PDT)
In-Reply-To: <20181024141008.30312-1-michael.thalmeier@hale.at>
References: <20181024141008.30312-1-michael.thalmeier@hale.at>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 24 Oct 2018 16:21:58 +0200
Message-ID: <CAPDyKFoeK6uf3UGLQ0Qe+xqgGRbe-MsG2tD78EBHWfAt0uwiEg@mail.gmail.com>
Subject: Re: [PATCH] Revert "mmc: mxs: fix card detection in case of
 'broken-cd' flag set"
To:     Michael Thalmeier <michael.thalmeier@hale.at>
Cc:     Roman Peniaev <r.peniaev@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        michael@thalmeier.at
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 October 2018 at 16:10, Michael Thalmeier
<michael.thalmeier@hale.at> wrote:
> This reverts commit 6f726f495f2d ("mmc: mxs: fix card detection in case of 'broken-cd' flag set").
>
> Since mxs_mmc_probe always sets MMC_CAP_NEEDS_POLL unconditionally, card
> detect is not working properly any more since commit 6f726f495f2d.
> Instead of querying the card detect status mxs_mmc_get_cd now always
> returns 1 which causes probing commands being sent to the mmc card.
>
> The expected behaviour of commit 6f726f495f2d should be reachable by setting
> broken_cd instead.

I would rather make a new fix on top, rather than reverting a four
year old patch. Can you please look into that instead?

Kind regards
Uffe

>
> Signed-off-by: Michael Thalmeier <michael.thalmeier@hale.at>
> ---
>  drivers/mmc/host/mxs-mmc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index add1e70..cfdae61 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -86,8 +86,7 @@ static int mxs_mmc_get_cd(struct mmc_host *mmc)
>         if (ret >= 0)
>                 return ret;
>
> -       present = mmc->caps & MMC_CAP_NEEDS_POLL ||
> -               !(readl(ssp->base + HW_SSP_STATUS(ssp)) &
> +       present = !(readl(ssp->base + HW_SSP_STATUS(ssp)) &
>                         BM_SSP_STATUS_CARD_DETECT);
>
>         if (mmc->caps2 & MMC_CAP2_CD_ACTIVE_HIGH)
> --
> 2.9.2
>
