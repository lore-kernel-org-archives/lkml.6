Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75DEC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 23:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D64F2082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 23:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oJdlxWod"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D64F2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbeHaDvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 23:51:38 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36576 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeHaDvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 23:51:38 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7UNkjUX001177;
        Thu, 30 Aug 2018 18:46:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535672805;
        bh=2OVMPKY0148sA8jKk05Pm1ox+wk27nADchoSUsWrw9o=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=oJdlxWodTe1xiDS0CbW5DhcicPqSO+rxo6WGUXzFJbGzW1gLFIfhVZlx7dbabKzUM
         /g8bjTA5gBHMnWjpoZC+ynJk6vXXx0aW6AfUruv14VvEzYjsSrRU0gVXZLPlGTmnzJ
         s5vD2A+9q7+rBCFMmk13cVkUXenVTMApAsIjsvps=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7UNkjHr010197;
        Thu, 30 Aug 2018 18:46:45 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 30
 Aug 2018 18:46:44 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 30 Aug 2018 18:46:44 -0500
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7UNkiAf011794;
        Thu, 30 Aug 2018 18:46:44 -0500
Subject: Re: [PATCH 2/3] ARM: dts: am335x: add support for Moxa UC-2101 open
 platform
To:     =?UTF-8?B?U1ogTGluICjmnpfkuIrmmbop?= <sz.lin@moxa.com>,
        <linux-kernel@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Wes Huang <wes.huang@moxa.com>,
        Fero JD Zhou <FeroJD.Zhou@moxa.com>
References: <20180830040929.23357-1-sz.lin@moxa.com>
 <20180830040929.23357-3-sz.lin@moxa.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <47ebc8e6-b1cb-e040-8533-06eec05b4edd@ti.com>
Date:   Thu, 30 Aug 2018 18:46:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180830040929.23357-3-sz.lin@moxa.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/29/2018 11:09 PM, SZ Lin (林上智) wrote:
> Add support for Moxa UC-2101 open platform
> 
> The UC-2101 computing platform is designed for industrial embedded
> data acquisition and processing applications.
> 
> The features of UC-2101 are:
> * eMMC
> * SPI flash
> * 1x LAN
> * 1x RS-232/422/485 ports, software-selectable
> * EEPROM
> * TPM 2.0
> * Watchdog
> * RTC
> * User gpio-keys
> * User LEDs
> * User button
> 
> Signed-off-by: Wes Huang (黃淵河) <wes.huang@moxa.com>
> Signed-off-by: Fero JD Zhou (周俊達) <FeroJD.Zhou@moxa.com>
> Signed-off-by: SZ Lin (林上智) <sz.lin@moxa.com>
> ---
>   .../devicetree/bindings/arm/omap/omap.txt     |  3 +
>   arch/arm/boot/dts/Makefile                    |  1 +
>   arch/arm/boot/dts/am335x-moxa-uc-2101.dts     | 63 +++++++++++++++++++
>   3 files changed, 67 insertions(+)
>   create mode 100644 arch/arm/boot/dts/am335x-moxa-uc-2101.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
> index 2ecc712bf707..c5ca3d6a8099 100644
> --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
> +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
> @@ -157,6 +157,9 @@ Boards:
>   - AM335X phyCORE-AM335x: Development kit
>     compatible = "phytec,am335x-pcm-953", "phytec,am335x-phycore-som", "ti,am33xx"
>   
> +- AM335X UC-2100: Wireless-enabled palm-sized industrial computing platform
> +  compatible = "moxa,uc-2101", "ti,am33xx"
> +
>   - AM335X UC-8100-ME-T: Communication-centric industrial computing platform
>     compatible = "moxa,uc-8100-me-t", "ti,am33xx";
>   
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b5bd3de87c33..6167c068601c 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -706,6 +706,7 @@ dtb-$(CONFIG_SOC_AM33XX) += \
>   	am335x-evmsk.dtb \
>   	am335x-icev2.dtb \
>   	am335x-lxm.dtb \
> +	am335x-moxa-uc-2101.dtb \
>   	am335x-moxa-uc-8100-me-t.dtb \
>   	am335x-nano.dtb \
>   	am335x-pdu001.dtb \
> diff --git a/arch/arm/boot/dts/am335x-moxa-uc-2101.dts b/arch/arm/boot/dts/am335x-moxa-uc-2101.dts
> new file mode 100644
> index 000000000000..d0c1eea4a6c9
> --- /dev/null
> +++ b/arch/arm/boot/dts/am335x-moxa-uc-2101.dts
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 MOXA Inc. - https://www.moxa.com/
> + *
> + * Authors: SZ Lin (林上智) <sz.lin@moxa.com>
> + *          Wes Huang (黃淵河) <wes.huang@moxa.com>
> + *          Fero JD Zhou (周俊達) <FeroJD.Zhou@moxa.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "am335x-moxa-uc-2100-common.dtsi"
> +

> +
> +&cpsw_emac0 {
> +	status = "okay";
> +	phy_id = <&davinci_mdio>, <0x4>;

Pls, use phy-handle instead of phy_id here and in the next patch.

> +	phy-mode = "rmii";
> +};
> +
> +&cpsw_emac1 {
> +	status = "disable";
> +};
> 

-- 
regards,
-grygorii
