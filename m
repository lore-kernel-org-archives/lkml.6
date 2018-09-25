Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F9BC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C972089D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C972089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeIZAbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:31:06 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39177 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbeIZAbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:31:06 -0400
Received: by mail-oi1-f196.google.com with SMTP id y81-v6so2332969oia.6;
        Tue, 25 Sep 2018 11:22:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DUQ40vFzW2GAuFjoc7XdppquH178BfF0CmSjRIc7xmk=;
        b=MVk+T9AGFCSXIER10vHT6jNdMxNu5317pjrAqwEYLMo7nW8x2BQCGUK7cTfyS9I0ZX
         TcPmwD39MiPSPOC9Vk31fh81s+DNqkZh0+HLCJoqqCYQzNdkcBvVs1d2uNjpQMV9ah0a
         ajNPMwXz6dsxBHEyGstFg7cK3aioh+fEdVJsg3zYn9YUoY0JFoLJH2p/9k+7NwSchEY/
         u3wL9JHoZLFiQWltwOa0j01bz7sl5slQqnVdNuyZF/9k4wm2BDj1E0vtV+PzNhL61iP8
         clMDQYwOnNsKPx4hXYkR3nFsZFWLtSNG8RfzrWHSPAPItWqXpLAVXXbIHiCPj7Ysr0ds
         X0Kg==
X-Gm-Message-State: ABuFfogI0Aa6GJ3vD5K7mfa56Z+br+gXoem7dbxTLBTecCCh9QbafWaW
        ChByKtXUP+iETW0frpmFVQ==
X-Google-Smtp-Source: ACcGV60aWfApKBrPFZTXf966m1umjf7Wm8LdMtf0MXnvdvmEv+inr2cd0ydADlOuie8DhZveIwCEqw==
X-Received: by 2002:aca:240b:: with SMTP id n11-v6mr1566812oic.174.1537899740023;
        Tue, 25 Sep 2018 11:22:20 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p32-v6sm1061636otc.28.2018.09.25.11.22.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 11:22:19 -0700 (PDT)
Date:   Tue, 25 Sep 2018 13:22:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, mturquette@baylibre.com, khilman@baylibre.com,
        vincent.guittot@linaro.org, skannan@codeaurora.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, abailon@baylibre.com,
        maxime.ripard@bootlin.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v9 6/8] dt-bindings: interconnect: Document qcom,msm8916
 NoC bindings
Message-ID: <20180925182217.GA15771@bogus>
References: <20180831140151.13972-1-georgi.djakov@linaro.org>
 <20180831140151.13972-7-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831140151.13972-7-georgi.djakov@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 05:01:49PM +0300, Georgi Djakov wrote:
> Document the device-tree bindings of the Network-On-Chip interconnect
> hardware found on Qualcomm msm8916 platforms.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  .../bindings/interconnect/qcom-msm8916.txt    | 41 ++++++++
>  include/dt-bindings/interconnect/qcom.h       | 98 +++++++++++++++++++
>  2 files changed, 139 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom-msm8916.txt
>  create mode 100644 include/dt-bindings/interconnect/qcom.h
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom-msm8916.txt b/Documentation/devicetree/bindings/interconnect/qcom-msm8916.txt
> new file mode 100644
> index 000000000000..744df51df4ed
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom-msm8916.txt
> @@ -0,0 +1,41 @@
> +Qualcomm MSM8916 Network-On-Chip interconnect driver binding
> +----------------------------------------------------
> +
> +Required properties :
> +- compatible : shall contain only one of the following:
> +			"qcom,msm8916-bimc"
> +			"qcom,msm8916-pnoc"
> +			"qcom,msm8916-snoc"
> +- #interconnect-cells : should contain 1
> +- reg : shall contain base register location and length
> +
> +Optional properties :
> +clocks : list of phandles and specifiers to all interconnect bus clocks
> +clock-names : clock names should include both "bus_clk" and "bus_a_clk"
> +
> +Examples:
> +
> +		snoc: snoc@580000 {

interconnect@...

> +			compatible = "qcom,msm8916-snoc";
> +			#interconnect-cells = <1>;
> +			reg = <0x580000 0x14000>;
> +			clock-names = "bus_clk", "bus_a_clk";
> +			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
> +				 <&rpmcc RPM_SMD_SNOC_A_CLK>;
> +		};
> +		bimc: bimc@400000 {

interconnect@...

> +			compatible = "qcom,msm8916-bimc";
> +			#interconnect-cells = <1>;
> +			reg = <0x400000 0x62000>;
> +			clock-names = "bus_clk", "bus_a_clk";
> +			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
> +				 <&rpmcc RPM_SMD_BIMC_A_CLK>;
> +		};
> +		pnoc: pnoc@500000 {

and here.

> +			compatible = "qcom,msm8916-pnoc";
> +			#interconnect-cells = <1>;
> +			reg = <0x500000 0x11000>;
> +			clock-names = "bus_clk", "bus_a_clk";
> +			clocks = <&rpmcc RPM_SMD_PCNOC_CLK>,
> +				 <&rpmcc RPM_SMD_PCNOC_A_CLK>;
> +		};
> diff --git a/include/dt-bindings/interconnect/qcom.h b/include/dt-bindings/interconnect/qcom.h
> new file mode 100644
> index 000000000000..48f944b30e5d
> --- /dev/null
> +++ b/include/dt-bindings/interconnect/qcom.h
> @@ -0,0 +1,98 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Qualcomm interconnect IDs
> + *
> + * Copyright (c) 2018, Linaro Ltd.
> + * Author: Georgi Djakov <georgi.djakov@linaro.org>
> + */
> +
> +#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_H
> +#define __DT_BINDINGS_INTERCONNECT_QCOM_H
> +
> +#define BIMC_SNOC_MAS			1
> +#define BIMC_SNOC_SLV			2
> +#define MASTER_AMPSS_M0			3
> +#define MASTER_BLSP_1			4
> +#define MASTER_CRYPTO_CORE0		5
> +#define MASTER_DEHR			6
> +#define MASTER_GRAPHICS_3D		7
> +#define MASTER_JPEG			8
> +#define MASTER_LPASS			9
> +#define MASTER_MDP_PORT0		10
> +#define MASTER_QDSS_BAM			11
> +#define MASTER_QDSS_ETR			12
> +#define MASTER_SDCC_1			13
> +#define MASTER_SDCC_2			14
> +#define MASTER_SNOC_CFG			15
> +#define MASTER_SPDM			16
> +#define MASTER_TCU_0			17
> +#define MASTER_TCU_1			18
> +#define MASTER_USB_HS			19
> +#define MASTER_VFE			20
> +#define MASTER_VIDEO_P0			21
> +#define PNOC_INT_0			22
> +#define PNOC_INT_1			23
> +#define PNOC_M_0			24
> +#define PNOC_M_1			25
> +#define PNOC_SLV_0			26
> +#define PNOC_SLV_1			27
> +#define PNOC_SLV_2			28
> +#define PNOC_SLV_3			29
> +#define PNOC_SLV_4			30
> +#define PNOC_SLV_8			31
> +#define PNOC_SLV_9			32
> +#define PNOC_SNOC_MAS			33
> +#define PNOC_SNOC_SLV			34
> +#define SLAVE_AMPSS_L2			35
> +#define SLAVE_BIMC_CFG			36
> +#define SLAVE_BLSP_1			37
> +#define SLAVE_BOOT_ROM			38
> +#define SLAVE_CAMERA_CFG		39
> +#define SLAVE_CATS_128			40
> +#define SLAVE_CLK_CTL			41
> +#define SLAVE_CRYPTO_0_CFG		42
> +#define SLAVE_DEHR_CFG			43
> +#define SLAVE_DISPLAY_CFG		44
> +#define SLAVE_EBI_CH0			45
> +#define SLAVE_GRAPHICS_3D_CFG		46
> +#define SLAVE_IMEM_CFG			47
> +#define SLAVE_LPASS			48
> +#define SLAVE_MPM			49
> +#define SLAVE_MSM_PDM			50
> +#define SLAVE_MSM_TCSR			51
> +#define SLAVE_MSS			52
> +#define SLAVE_OCMEM_64			53
> +#define SLAVE_PMIC_ARB			54
> +#define SLAVE_PNOC_CFG			55
> +#define SLAVE_PRNG			56
> +#define SLAVE_QDSS_CFG			57
> +#define SLAVE_QDSS_STM			58
> +#define SLAVE_RBCPR_CFG			59
> +#define SLAVE_RPM_MSG_RAM		60
> +#define SLAVE_SDCC_1			61
> +#define SLAVE_SDCC_4			62
> +#define SLAVE_SECURITY			63
> +#define SLAVE_SERVICE_SNOC		64
> +#define SLAVE_SNOC_CFG			65
> +#define SLAVE_SPDM			66
> +#define SLAVE_SYSTEM_IMEM		67
> +#define SLAVE_TLMM			68
> +#define SLAVE_USB_HS			69
> +#define SLAVE_VENUS_CFG			70
> +#define SNOC_BIMC_0_MAS			71
> +#define SNOC_BIMC_0_SLV			72
> +#define SNOC_BIMC_1_MAS			73
> +#define SNOC_BIMC_1_SLV			74
> +#define SNOC_INT_0			75
> +#define SNOC_INT_1			76
> +#define SNOC_INT_BIMC			77
> +#define SNOC_MM_INT_0			78
> +#define SNOC_MM_INT_1			79
> +#define SNOC_MM_INT_2			80
> +#define SNOC_MM_INT_BIMC		81
> +#define SNOC_PNOC_MAS			82
> +#define SNOC_PNOC_SLV			83
> +#define SNOC_QDSS_INT			84
> +#define SYSTEM_SLAVE_FAB_APPS		85

Each of the 3 providers in the example should have their own number 
space. This looks like you have combined them all. Though that is hard 
to tell because I can't really decipher the naming convention 
completely.

Rob
