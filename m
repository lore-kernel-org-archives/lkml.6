Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37DCC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4082F2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="gp38lb4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4082F2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kapsi.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbeGYIOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 04:14:45 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:48217 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728402AbeGYIOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 04:14:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gl+NR6SUqHqjXdm4fThj6+Ta9MfuquvrtMNkgXVPOW4=; b=gp38lb4ee71ac8zk1hwJMgEXpT
        9kgxBYpvpBUjebRsWWchk6+NCtQCJW3R39iiBr1Y09v1YhrAuRYagXhiyMBnST4jUabgw3E1QYDoz
        feBRcprbcipikC8DJbowJjdwCXVzOeNsxhMGIyiRNjpOYm2bNRII9A0HKatpU93W/O+koSkCU4vDV
        qZLucVrJ/0cI/p1dpzTvAZCfN9Zh6PZPXzmSu8JaSK/USpP6DjB5TG04gm467+Hh3lMUm20T0Pbf1
        BI3Bq4k8NdLpPwXn1LnfNCgCrZQugxf9+DU88QoamyVGNN4ec1YRjo6a6hGHQP2wsb6g8b/Y3F2Gm
        o4xnVrIQ==;
Received: from [193.209.96.43] (helo=[10.21.26.144])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1fiDqT-0000UM-5w; Wed, 25 Jul 2018 10:04:25 +0300
Subject: Re: [PATCH 01/10] mmc: tegra: Poll for calibration completion
To:     Aapo Vienamo <avienamo@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1532442591-5640-1-git-send-email-avienamo@nvidia.com>
 <1532442591-5640-2-git-send-email-avienamo@nvidia.com>
From:   Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <02139ade-23f4-8133-321e-8dd06a7011ea@kapsi.fi>
Date:   Wed, 25 Jul 2018 10:04:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1532442591-5640-2-git-send-email-avienamo@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 193.209.96.43
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.07.2018 17:29, Aapo Vienamo wrote:
> Implement polling with 10 ms timeout for automatic pad drive strength
> calibration.
> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>   drivers/mmc/host/sdhci-tegra.c | 24 +++++++++++++++++++-----
>   1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index f108c48..e40ca43 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -49,6 +49,9 @@
>   #define SDHCI_AUTO_CAL_START			BIT(31)
>   #define SDHCI_AUTO_CAL_ENABLE			BIT(29)
>   
> +#define SDHCI_TEGRA_AUTO_CAL_STATUS     0x1ec
> +#define SDHCI_TEGRA_AUTO_CAL_ACTIVE     BIT(31)

Please align the definition value with tabs. Also it looks like the 
alignments for the defines here are all over the place, would be nice to 
fix those up so they line up.

> +
>   #define NVQUIRK_FORCE_SDHCI_SPEC_200	BIT(0)
>   #define NVQUIRK_ENABLE_BLOCK_GAP_DET	BIT(1)
>   #define NVQUIRK_ENABLE_SDHCI_SPEC_300	BIT(2)
> @@ -198,13 +201,24 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
>   
>   static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
>   {
> -	u32 val;
> +	unsigned timeout = 10;

I prefer "unsigned int" instead of just "unsigned", but I guess that's 
just a personal preference..

> +	u32 reg;
>   
> -	mdelay(1);
> +	reg = sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_CONFIG);
> +	reg |= SDHCI_AUTO_CAL_ENABLE | SDHCI_AUTO_CAL_START;
> +	sdhci_writel(host, reg, SDHCI_TEGRA_AUTO_CAL_CONFIG);
> +	udelay(1);
> +
> +	do {
> +		reg = sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_STATUS);
> +		if (!(reg & SDHCI_TEGRA_AUTO_CAL_ACTIVE))
> +			break;
> +		mdelay(1);
> +		timeout--;
> +	} while (timeout);

Can we use readl_poll_timeout here? We'll need to calculate the address 
directly but it'd still look nicer.

Cheers,
Mikko

>   
> -	val = sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_CONFIG);
> -	val |= SDHCI_AUTO_CAL_ENABLE | SDHCI_AUTO_CAL_START;
> -	sdhci_writel(host,val, SDHCI_TEGRA_AUTO_CAL_CONFIG);
> +	if (timeout == 0)
> +		dev_err(mmc_dev(host->mmc), "Pad autocal timed out\n");
>   }
>   
>   static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> 
