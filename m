Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5294FC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F79624FA5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d9TG2mJM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F79624FA5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752282AbeGBOhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:37:02 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:46636 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752218AbeGBOhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:37:00 -0400
Received: by mail-io0-f194.google.com with SMTP id p7-v6so2546029ioh.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 07:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UdkZKrJTrVLAYmJJd/4SeiwTVFwKsw8LWOVEDJLB1cw=;
        b=d9TG2mJMr85FUe3Ka9dzmVXisnPxjX5HtxPisVcJl2GkUoQrW+ozAPurxeHlJ5ts3a
         jEicY+kcRaHBMKCwn9pLSGIVvEkW/Nkm00/LuTAwg9V3ERH7XAnn7Mj59oqTuV4X0BDP
         qh5luNNBHXLWwIP0Zv4W+YeGltlSnks5CmcCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UdkZKrJTrVLAYmJJd/4SeiwTVFwKsw8LWOVEDJLB1cw=;
        b=btU9JBseo6q3IlBIVeuf1/kXFqr9Xp8Y25G98qpAuB8k8Md1OQ+sR3tVbdePcEI905
         GK4G/R5inelNns4VsFm/A7biG/y53xZFofgLo241u3WyK+mUfJvnqhRljQed3MThAuQF
         e0muhTKuZkoIbK88QvJX1HNHXcjiFXLnzl6i4GF0HcDWtCZWSnmnwitKb5DEsDWwSuzC
         BqGfh0LOcQjaQNx2g9H159XQHdmN0AkondvZFMaE+VuupMThYnag9NJw2IG4H8GVw2q4
         TQPfwM0MGo1MKALR65uwTdJ8jEdmIAcHo925eTrCqSKPHJejIKPiHAnNmkoqaSRdurz6
         dzRA==
X-Gm-Message-State: APt69E2sgSX6CvK+UoNVfgKUYR9w8l6pxiZHcJPLTVWWQIXwivgouYGB
        lA/gAmrmj1J4gksgjc55DCVvDuIIbmAe8WE4mOKBkg==
X-Google-Smtp-Source: AAOMgpfcVCI5KAWUVH332OZG+ViiKufRfj6Mb57oqkOePeiHopSnTn6Kmjv+Uxe/hs8jm5c3M2A9mhePq7Al8rBtLJw=
X-Received: by 2002:a6b:e403:: with SMTP id u3-v6mr20586737iog.131.1530542220076;
 Mon, 02 Jul 2018 07:37:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 07:36:59 -0700 (PDT)
In-Reply-To: <20180628081331.13051-3-stefan@agner.ch>
References: <20180628081331.13051-1-stefan@agner.ch> <20180628081331.13051-3-stefan@agner.ch>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 2 Jul 2018 16:36:59 +0200
Message-ID: <CAPDyKFqPaRRuXdSD50q=et-OvJ=emdbq-XWyeddkiuC5SjuLig@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc: sdhci: add quirk to prevent higher speed modes
To:     Stefan Agner <stefan@agner.ch>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 June 2018 at 10:13, Stefan Agner <stefan@agner.ch> wrote:
> Some hosts are capable of running higher speed modes but do not
> have the board support for it. Introduce a quirk which prevents
> the stack from using modes running at 100MHz or faster.

To cap the freq, use the DT property "max-frequency". To enable
certain speed modes, use the corresponding speed mode binding. For
example "sd-uhs-sdr*" and "mmc-hs200*".
Documented in Documentation/devicetree/bindings/mmc/mmc.txt

In case the sdhci cap register, doesn't reflect the board support
properly, such that you may want to disable some speed modes, then you
may benefit from using the DT properties "sdhci-caps*.
Documented in Documentation/devicetree/bindings/mmc/sdhci.txt

Kind regards
Uffe

>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/mmc/host/sdhci.c | 8 ++++++++
>  drivers/mmc/host/sdhci.h | 2 ++
>  2 files changed, 10 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 1c828e0e9905..8ac257dfaab3 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3749,6 +3749,14 @@ int sdhci_setup_host(struct sdhci_host *host)
>                 }
>         }
>
> +       if (host->quirks2 & SDHCI_QUIRK2_NO_UHS_HS200_HS400) {
> +               host->caps1 &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
> +                                SDHCI_SUPPORT_DDR50);
> +
> +               mmc->caps2 &= ~(MMC_CAP2_HSX00_1_8V | MMC_CAP2_HSX00_1_2V |
> +                               MMC_CAP2_HS400_ES);
> +       }
> +
>         if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V) {
>                 host->caps1 &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
>                                  SDHCI_SUPPORT_DDR50);
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 23966f887da6..cb2433d6d61f 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -450,6 +450,8 @@ struct sdhci_host {
>   * obtainable timeout.
>   */
>  #define SDHCI_QUIRK2_DISABLE_HW_TIMEOUT                        (1<<17)
> +/* Do not support any higher speeds (>50MHz) */
> +#define SDHCI_QUIRK2_NO_UHS_HS200_HS400                        (1<<18)
>
>         int irq;                /* Device IRQ */
>         void __iomem *ioaddr;   /* Mapped address */
> --
> 2.18.0
>
