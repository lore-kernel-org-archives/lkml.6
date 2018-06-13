Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0F9EDC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4AB1208CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4AB1208CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935684AbeFMVsE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:48:04 -0400
Received: from foss.arm.com ([217.140.101.70]:52826 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754517AbeFMVsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:48:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7A511435;
        Wed, 13 Jun 2018 14:48:02 -0700 (PDT)
Received: from [10.0.2.15] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D67453F59D;
        Wed, 13 Jun 2018 14:48:00 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: hikey960: Define wl1837 power capabilities
To:     Ryan Grachek <ryan@edited.us>
Cc:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180613180321.16745-1-ryan@edited.us>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <91404bb0-4fa8-4e00-0b21-c104a5171833@arm.com>
Date:   Wed, 13 Jun 2018 22:47:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180613180321.16745-1-ryan@edited.us>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/18 19:03, Ryan Grachek wrote:
> These properties are required for compatibility with runtime PM.
> Without these properties, MMC host controller will not be aware
> of power capabilities. When the wlcore driver attempts to power
> on the device, it will erroneously fail with -EACCES. This fixes
> a regression found here: https://lkml.org/lkml/2018/6/12/930
> 

Thanks! As mentioned in the above thread, this lets wlan0 come up properly,
which otherwise doesn't come up and spits out:
[    8.466097] wl1271_sdio mmc1:0001:2: wl12xx_sdio_power_on: failed to get_sync(-13)

Tested-by: Valentin Schneider <valentin.schneider@arm.com>

> Signed-off-by: Ryan Grachek <ryan@edited.us>
> ---
>  arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> index c6999624ed8a..68c5a6c819ae 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> @@ -585,6 +585,8 @@
>  	vmmc-supply = <&wlan_en>;
>  	ti,non-removable;
>  	non-removable;
> +	cap-power-off-card;
> +	keep-power-in-suspend;
>  	#address-cells = <0x1>;
>  	#size-cells = <0x0>;
>  	status = "ok";
> 
