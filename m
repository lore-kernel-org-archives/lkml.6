Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B27C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 06:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11812088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 06:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="0AfDxMwj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D11812088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kapsi.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbeGYII5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 04:08:57 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:52561 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728222AbeGYII5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 04:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZkTq46yl0Y/KKXl58qKJPN6dFmCdgttLfMRlTHLAu/M=; b=0AfDxMwjQ1qC5UEpmy0mmMuMjp
        /gRQCoVRwzjkZUHTT3ilFz8H+zJeljyhYSwbNs32prcibr+pOZgO6zJWqth9pUqAxoRprVLx1xo/S
        rEhv1cskGB2mI4y4oJAo1/72c3GUshe9zTQs71szbBeQcGdLi6SZ+YjXm9NUOxdC32AINXTTzdLMf
        289eiGRBq5O63dePOxEEQjrWvdIjkNW/OLfF+Go565xc+wyHYPBl7S5HBNcMEsDOj3ffIDOnPphwM
        PlM009f1PMmZPXNwVvxbDO5u16dil4SoltVkD9ODjIfH0XmoCtkRTqDJOqJjxH5sCsPYNzwS/Eaj5
        351wPvrw==;
Received: from [193.209.96.43] (helo=[10.21.26.144])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1fiDkr-0006ik-D1; Wed, 25 Jul 2018 09:58:37 +0300
Subject: Re: [PATCH 7/7] arm64: dts: tegra210-p2597: Remove no-1-8-v from
 sdmmc1
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
References: <1532090746-15863-1-git-send-email-avienamo@nvidia.com>
 <1532090746-15863-8-git-send-email-avienamo@nvidia.com>
From:   Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <8946636e-5da7-baf1-5390-669f7442e6ff@kapsi.fi>
Date:   Wed, 25 Jul 2018 09:58:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1532090746-15863-8-git-send-email-avienamo@nvidia.com>
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

Looks like patch 6 will probably cause tegra-sdhci to start advertising 
faster modes (see " if (!IS_ERR(host->mmc->supply.vqmmc))" in 
sdhci-tegra.c). With that patch and this, will the SDHCI core start to 
try putting us into these higher modes? Clearly that won't work yet 
before the upcoming patches.

Mikko

On 20.07.2018 15:45, Aapo Vienamo wrote:
> Allow sdmmc1 to set the signaling voltage to 1.8 V in order to support
> faster signaling modes.
> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>   arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
> index 9d5a0e6..365726d 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
> @@ -1452,7 +1452,6 @@
>   	sdhci@700b0000 {
>   		status = "okay";
>   		bus-width = <4>;
> -		no-1-8-v;
>   
>   		cd-gpios = <&gpio TEGRA_GPIO(Z, 1) GPIO_ACTIVE_LOW>;
>   
> 
