Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7873AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B5420873
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B5420873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=KARO-electronics.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbeK1UF2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:05:28 -0500
Received: from smtprelay07.ispgateway.de ([134.119.228.104]:8274 "EHLO
        smtprelay07.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbeK1UF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:05:28 -0500
Received: from [89.1.81.74] (helo=karo-electronics.de)
        by smtprelay07.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <LW@KARO-electronics.de>)
        id 1gRvle-0008K8-Vl; Wed, 28 Nov 2018 10:04:23 +0100
Date:   Wed, 28 Nov 2018 10:04:20 +0100
From:   Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Aisheng DONG <aisheng.dong@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 4/4] ARM64: dts: imx: add i.MX8QXP system controller RTC
 support
Message-ID: <20181128100420.0c9a721a@karo-electronics.de>
In-Reply-To: <1543311334-8807-5-git-send-email-Anson.Huang@nxp.com>
References: <1543311334-8807-1-git-send-email-Anson.Huang@nxp.com>
        <1543311334-8807-5-git-send-email-Anson.Huang@nxp.com>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Df-Sender: bHdAa2Fyby1lbGVjdHJvbmljcy5kZQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 27 Nov 2018 09:41:46 +0000 Anson Huang wrote:
> Add i.MX8QXP system controller RTC support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> index 9155d45..ef57db6 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> @@ -433,4 +433,8 @@
>  		#size-cells = <1>;
>  		ranges = <0x5f000000 0x0 0x5f000000 0x1000000>;
>  	};
> +
> +	rtc: rtc {
> +		compatible = "nxp,imx8qxp-sc-rtc";
> +	};
>  };
IMO this should be disabled by default.


Lothar Waßmann
