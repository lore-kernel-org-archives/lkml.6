Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707B0C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42CD520866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="A2b8CkTg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbfAOO3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 09:29:37 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40162 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730384AbfAOO3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 09:29:37 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0FETR1p084512;
        Tue, 15 Jan 2019 08:29:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547562567;
        bh=RqrHh6DrBDW9ZgxObAnYihtfnmdCabbyJU45XXWFvJc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=A2b8CkTg3ZxYuAAJPdVvKD7S0m8W2HDY3ExGHhqcYoWyh0Z/9WMaWPKmNjWaWioqc
         nH/Dhw+AVAjaIaeAVZFyiMBGBgqYhQ/nL6Y8iRNsl97YpKrLSLuTNGpdgmqf8tNrR/
         dNtt402Mc2JXmNPfgMhSSpFfUCpk8fP0FpUlSawM=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0FETRq0063795
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Jan 2019 08:29:27 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 15
 Jan 2019 08:29:27 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 15 Jan 2019 08:29:27 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0FETR7h017394;
        Tue, 15 Jan 2019 08:29:27 -0600
Date:   Tue, 15 Jan 2019 08:28:54 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Faiz Abbas <faiz_abbas@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <t-kristo@ti.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: k3-am654-base-board: Add MMC
 support
Message-ID: <20190115142854.xbfep5by73oi3sxd@kahuna>
References: <20190110073355.3382-1-faiz_abbas@ti.com>
 <20190110073355.3382-3-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190110073355.3382-3-faiz_abbas@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar problem here as well.. $subject probably needs to be explicit
about eMMC?

On 13:03-20190110, Faiz Abbas wrote:
> On the am654x-evm, the sdhci0 node is connected to an eMMC. Add node and
> pinmux for the same.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  .../arm64/boot/dts/ti/k3-am654-base-board.dts | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> index e41fc3a5987b..11e9a2a43dfc 100644
> --- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> @@ -69,6 +69,23 @@
>  			AM65X_IOPAD(0x01bc, PIN_OUTPUT, 0) /* (AG13) SPI0_CS0 */
>  		>;
>  	};
> +
> +	main_mmc0_pins_default: main-mmc0-pins-default {
> +		pinctrl-single,pins = <
> +			AM65X_IOPAD(0x01a8, PIN_INPUT_PULLDOWN, 0) /* (B25) MMC0_CLK */
> +			AM65X_IOPAD(0x01ac, PIN_INPUT_PULLUP, 0) /* (B27) MMC0_CMD */
> +			AM65X_IOPAD(0x01a4, PIN_INPUT_PULLUP, 0) /* (A26) MMC0_DAT0 */
> +			AM65X_IOPAD(0x01a0, PIN_INPUT_PULLUP, 0) /* (E25) MMC0_DAT1 */
> +			AM65X_IOPAD(0x019c, PIN_INPUT_PULLUP, 0) /* (C26) MMC0_DAT2 */
> +			AM65X_IOPAD(0x0198, PIN_INPUT_PULLUP, 0) /* (A25) MMC0_DAT3 */
> +			AM65X_IOPAD(0x0194, PIN_INPUT_PULLUP, 0) /* (E24) MMC0_DAT4 */
> +			AM65X_IOPAD(0x0190, PIN_INPUT_PULLUP, 0) /* (A24) MMC0_DAT5 */
> +			AM65X_IOPAD(0x018c, PIN_INPUT_PULLUP, 0) /* (B26) MMC0_DAT6 */
> +			AM65X_IOPAD(0x0188, PIN_INPUT_PULLUP, 0) /* (D25) MMC0_DAT7 */
> +			AM65X_IOPAD(0x01b4, PIN_INPUT_PULLUP, 0) /* (A23) MMC0_SDCD */
> +			AM65X_IOPAD(0x01b0, PIN_INPUT, 0) /* (C25) MMC0_DS */
> +		>;
> +	};
>  };
>  
>  &main_pmx1 {
> @@ -163,3 +180,11 @@
>  		#size-cells= <1>;
>  	};
>  };
> +
> +&sdhci0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mmc0_pins_default>;
> +	bus-width = <8>;
> +	non-removable;
> +	ti,driver-strength-ohm = <50>;
> +};
> -- 
> 2.19.2
> 

-- 
Regards,
Nishanth Menon
