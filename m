Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AC5C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E14220851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Q+YY6+zl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZmFQoVms"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E14220851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbeLCWKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:10:39 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49044 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbeLCWKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 17:10:38 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 30BAB60A33; Mon,  3 Dec 2018 22:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543875037;
        bh=wzzF/+xrkrPLC2bh8Hg4oY4qj9NdTA4BS+gipVPwm8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q+YY6+zlgPbh7DTmcrwtZ7RB1G9NnFEFYAiN9wKYUIVurJjfyyXfK3TL0s9dq8LqD
         SOzcTFrU3ntp+l+aylFkUjeVTNJXGe57g/XcX1HaqpZiPrXHez5mCPmpFMpZ2JMkaJ
         yF9wR3qC9rJB3h01jaDXcEvgG+OBcblvWfuYxdvQ=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 22C996019F;
        Mon,  3 Dec 2018 22:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543875036;
        bh=wzzF/+xrkrPLC2bh8Hg4oY4qj9NdTA4BS+gipVPwm8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZmFQoVmsr+g0neq+Xl7t/bGqXgRtg9U2EQNzw28bsBW1G/yXjbZCbjdAAQmRqyExw
         QPLW74OrTSkBUAjNZnk1wgLVPcOno6beJnZde5nTGikVrhqu7IvRyrz9ftZppVbH/g
         jrL+1smgb4w697cHIljqI16DNg8Qi473EAqKp38o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 22C996019F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Mon, 3 Dec 2018 15:10:33 -0700
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     freedreno@lists.freedesktop.org,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, festevam@gmail.com,
        Sascha Hauer <s.hauer@pengutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chris.Healy@zii.aero,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [Freedreno] [PATCH v3 4/4] ARM: dts: imx5: add gpu nodes
Message-ID: <20181203221032.GA20602@jcrouse-lnx.qualcomm.com>
Mail-Followup-To: Jonathan Marek <jonathan@marek.ca>,
        freedreno@lists.freedesktop.org,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        festevam@gmail.com, Sascha Hauer <s.hauer@pengutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chris.Healy@zii.aero,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>
References: <20181203211816.5129-1-jonathan@marek.ca>
 <20181203211816.5129-4-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203211816.5129-4-jonathan@marek.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 04:18:16PM -0500, Jonathan Marek wrote:
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  arch/arm/boot/dts/imx51.dtsi | 17 +++++++++++++++++
>  arch/arm/boot/dts/imx53.dtsi | 17 +++++++++++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
> index 67d462715..e9a7bbce9 100644
> --- a/arch/arm/boot/dts/imx51.dtsi
> +++ b/arch/arm/boot/dts/imx51.dtsi
> @@ -628,5 +628,22 @@
>  				clock-names = "ipg", "ahb";
>  			};
>  		};
> +
> +		gpu: gpu@30000000 {
> +			compatible = "amd,imageon-200.1", "amd,imageon";
> +			reg = <0x30000000 0x20000>;
> +			reg-names = "kgsl_3d0_reg_memory";
> +			interrupts = <12>;
> +			interrupt-names = "kgsl_3d0_irq";
> +			clocks = <&clks IMX5_CLK_GPU3D_GATE>, <&clks IMX5_CLK_GARB_GATE>;
> +			clock-names = "core_clk", "mem_iface_clk";
> +
> +			qcom,gpu-pwrlevels {
> +				compatible = "qcom,gpu-pwrlevels";
> +				qcom,gpu-pwrlevel@0 {
> +					qcom,gpu-freq = <166250000>;
> +				};
> +			};

There shouldn't be any incremental cost in the source code to use OPP; it should
just work. And then this won't give us a further reason to keep the legacy
code around when we decide to dump any pretense of downstream "compatibility".

> +		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> index 207eb557c..586d45586 100644
> --- a/arch/arm/boot/dts/imx53.dtsi
> +++ b/arch/arm/boot/dts/imx53.dtsi
> @@ -838,5 +838,22 @@
>  			reg = <0xf8000000 0x20000>;
>  			clocks = <&clks IMX5_CLK_OCRAM>;
>  		};
> +
> +		gpu: gpu@30000000 {
> +			compatible = "amd,imageon-200.0", "amd,imageon";
> +			reg = <0x30000000 0x20000>;
> +			reg-names = "kgsl_3d0_reg_memory";
> +			interrupts = <12>;
> +			interrupt-names = "kgsl_3d0_irq";
> +			clocks = <&clks IMX5_CLK_GPU3D_GATE>, <&clks IMX5_CLK_GARB_GATE>;
> +			clock-names = "core_clk", "mem_iface_clk";
> +
> +			qcom,gpu-pwrlevels {
> +				compatible = "qcom,gpu-pwrlevels";
> +				qcom,gpu-pwrlevel@0 {
> +					qcom,gpu-freq = <200000000>;
> +				};

Same.

> +			};

> +		};
>  	};
>  };
> -- 
> 2.17.1

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
