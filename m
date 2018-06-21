Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8A0C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 05:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B2F2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 05:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B2F2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932747AbeFUFiA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 01:38:00 -0400
Received: from muru.com ([72.249.23.125]:48556 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750862AbeFUFh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 01:37:58 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id EA787806C;
        Thu, 21 Jun 2018 05:40:40 +0000 (UTC)
Date:   Wed, 20 Jun 2018 22:37:54 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Nishanth Menon <nm@ti.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tero Kristo <t-kristo@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 3/5] arm64: dts: ti: Add Support for AM654 SoC
Message-ID: <20180621053754.GD112168@atomide.com>
References: <20180619194253.27288-1-nm@ti.com>
 <20180619194253.27288-4-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619194253.27288-4-nm@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Nishanth Menon <nm@ti.com> [180619 19:46]:
> +	cbass_main: cbass@100000 {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x00100000 0x00 0x00100000 0x00020000>, /* ctrl mmr */
> +			 <0x00600000 0x00 0x00600000 0x00001100>, /* GPIO */
> +			 <0x00900000 0x00 0x00900000 0x00012000>, /* serdes */
> +			 <0x01000000 0x00 0x01000000 0x0af02400>, /* Most peripherals */
> +			 <0x30800000 0x00 0x30800000 0x0bc00000>, /* MAIN NAVSS */
> +			 /* MCUSS Range */
> +			 <0x28380000 0x00 0x28380000 0x03880000>,
> +			 <0x40200000 0x00 0x40200000 0x00900100>,
> +			 <0x42040000 0x00 0x42040000 0x03ac2400>,
> +			 <0x45100000 0x00 0x45100000 0x00c24000>,
> +			 <0x46000000 0x00 0x46000000 0x00200000>,
> +			 <0x47000000 0x00 0x47000000 0x00068400>;
> +
> +		cbass_mcu: cbass@28380000 {
> +			compatible = "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x28380000 0x28380000 0x03880000>, /* MCU NAVSS*/
> +				 <0x40200000 0x40200000 0x00900100>, /* First peripheral window */
> +				 <0x42040000 0x42040000 0x03ac2400>, /* WKUP */
> +				 <0x45100000 0x45100000 0x00c24000>, /* MMRs, remaining NAVSS */
> +				 <0x46000000 0x46000000 0x00200000>, /* CPSW */
> +				 <0x47000000 0x47000000 0x00068400>; /* OSPI space 1 */
> +
> +			cbass_wakeup: cbass@42040000 {
> +				compatible = "simple-bus";
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				/* WKUP  Basic peripherals */
> +				ranges = <0x42040000 0x42040000 0x03ac2400>;
> +			};
> +		};
> +	};
> +};

You should use cbass_main: interconnect@1000000 and so on here.
Other than that looks good to me, thanks for updating it.

Regards,

Tony
