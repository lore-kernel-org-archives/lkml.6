Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FFDC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59EA820647
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="RWXGLcBP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59EA820647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kapsi.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbeGYIfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 04:35:41 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:55099 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728369AbeGYIfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 04:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7/BhBfGeTqWEzkaFIMPkn3u3NZbjNFTzH2H0vY9ED1k=; b=RWXGLcBPm4IVist7BrAsWIeK83
        41MzDkMyxndiGTXqqq86VzPS2porAjrm5d2KuRtsmkljWBpXZ59ePJ5mz4DoHQsPBArBQo4dFzB8v
        sxoczROkKM/ivyoPwt2jHqWgGMXE/Zx1zd0HuGdD5XMaTGtCK59AhJ8KPFEIyXsrd7CAxnVZShjxn
        +0tSj3ez79T5Xue7mVCkLFq6i8BM7dIJxJKAQwXwNmxzVXkamSDOo3LoeooPeOmyMGXm+FU3eML3o
        yMLD4di0zV84Nk6mlg8ai8eBsvt7heKWOK7nVybF1hD9CHDRMVk7kTlATqapKzxiDOdkkG1ZGUR45
        4KovXEYw==;
Received: from [193.209.96.43] (helo=[10.21.26.144])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1fiEAf-0008CK-4f; Wed, 25 Jul 2018 10:25:17 +0300
Subject: Re: [PATCH 09/10] mmc: tegra: Perform pad calibration after voltage
 switch
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
 <1532442865-6391-1-git-send-email-avienamo@nvidia.com>
 <1532442865-6391-8-git-send-email-avienamo@nvidia.com>
From:   Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <b44d6ae5-7965-16db-7ad3-39ff682755ca@kapsi.fi>
Date:   Wed, 25 Jul 2018 10:25:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1532442865-6391-8-git-send-email-avienamo@nvidia.com>
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



On 24.07.2018 17:34, Aapo Vienamo wrote:
> Run the automatic pad calibration after voltage switching if
> tegra_host->pad_calib_required is set.
> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>   drivers/mmc/host/sdhci-tegra.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 78781bd..529aa4e7 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -537,6 +537,8 @@ static int sdhci_tegra_start_signal_voltage_switch(struct mmc_host *mmc,
>   						   struct mmc_ios *ios)
>   {
>   	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
>   	int ret = 0;
>   
>   	if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
> @@ -551,6 +553,9 @@ static int sdhci_tegra_start_signal_voltage_switch(struct mmc_host *mmc,
>   		ret = tegra_sdhci_set_padctrl(host, ios->signal_voltage);
>   	}
>   
> +	if (tegra_host->pad_calib_required)
> +		tegra_sdhci_pad_autocalib(host);

What if the autocalibration fails? Should we return an error?

> +
>   	return ret;
>   }
>   
> 
