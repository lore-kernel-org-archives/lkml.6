Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB93C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E7520891
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fazBTxR+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31E7520891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbeH0NxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 09:53:09 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:38748 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeH0NxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 09:53:09 -0400
Received: by mail-it0-f65.google.com with SMTP id p129-v6so9763693ite.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 03:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Xrvker25ukWpZUa72n604pK+6+wgd2Qj1rl/I6TVXUk=;
        b=fazBTxR+m0yL2uqailSPKn1pN0AlGZ434VBw/5cg8SNluHTjUQQqlRw+dubshYu39D
         mZ0OdbRKRbqL+C8MxodxIc48eMEKCKGxisSnwt0m3+FwoFte1USWEGZjsCsKaZ3HcSlR
         5VhayDT+bExDVwXDOPMxnal+XHPH44j4ftZH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Xrvker25ukWpZUa72n604pK+6+wgd2Qj1rl/I6TVXUk=;
        b=ubMU0ecRmvz7O1G3HwnKrJPJ4mbsjlUnGLrra14slWFEkQ/4Iay5wKF3uTjYxAe6Z2
         O9yzhMbpqCX+xA1TJKJsbtZR3d9+Co1rPSfxaUDecRAd7lZZtAjxdmURhGoWyyKztN94
         w+qQjixsij8KeoEHTKvzbMWG+uoP2jw8lxx3CKN3dGLTMz5gW0eefNWEaPMpSyfLcWxd
         WmW3oDjRxh2itPYzfv0EwxZ8l0/lEDoSxQwwa1fNTL770GS3R73l4KrmrPfPqmTik4OJ
         olLIFWwD7Apv1jotGTcV2JIZIX+ko7zEXym/Mc9ih2TFp7E8wgGnBvohlFbYQJY3Eurb
         19bA==
X-Gm-Message-State: APzg51ChEu4LsVkZdmWhHXKobnwLVgwgRNCrc7R8uVooLg4+Il4FEMrO
        YGnl7g2lHSKlp4dNWWlpIA1FExNhzH9sJ6b6pVlEdg==
X-Google-Smtp-Source: ANB0Vda8QYDHqPZZrFA7ISwtndnhJPrOvHfL7utC6AAgsz9ac8FDnCdD1iRrTlha02AidBEoBuSr4XKlTXKBuXZ9918=
X-Received: by 2002:a24:a388:: with SMTP id p130-v6mr5976387ite.146.1535364429047;
 Mon, 27 Aug 2018 03:07:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Mon, 27 Aug 2018 03:07:08
 -0700 (PDT)
In-Reply-To: <1534757013-4524-2-git-send-email-avienamo@nvidia.com>
References: <1534757013-4524-1-git-send-email-avienamo@nvidia.com> <1534757013-4524-2-git-send-email-avienamo@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 27 Aug 2018 12:07:08 +0200
Message-ID: <CAPDyKFrxMWBisB5uuhFjxosExJx5cqLnTLE5Eoxp5LVdFk_43g@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci: Export sdhci_request()
To:     Aapo Vienamo <avienamo@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 August 2018 at 11:23, Aapo Vienamo <avienamo@nvidia.com> wrote:
> Allow SDHCI drivers to hook code before and after sdhci_request() by
> making it externally visible.
>
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>

This one happens to be useful for other variants but Tegras, hence I
have applied this one for next. Thanks!

Thierry, you may thus drop this one from your PR. Also, you should
probably base your pull request on top of my next branch, as I have
already started to queue up some changes for sdhci.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci.c | 3 ++-
>  drivers/mmc/host/sdhci.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index da47f7b..1e0c0a6 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1636,7 +1636,7 @@ EXPORT_SYMBOL_GPL(sdhci_set_power);
>   *                                                                           *
>  \*****************************************************************************/
>
> -static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
> +void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  {
>         struct sdhci_host *host;
>         int present;
> @@ -1675,6 +1675,7 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>         mmiowb();
>         spin_unlock_irqrestore(&host->lock, flags);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_request);
>
>  void sdhci_set_bus_width(struct sdhci_host *host, int width)
>  {
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index cc963a5..73c4744 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -729,6 +729,7 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
>                      unsigned short vdd);
>  void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
>                            unsigned short vdd);
> +void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq);
>  void sdhci_set_bus_width(struct sdhci_host *host, int width);
>  void sdhci_reset(struct sdhci_host *host, u8 mask);
>  void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
> --
> 2.7.4
>
