Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C798C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 01:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E5720857
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 01:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tRXKN1H6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E5720857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbeICFfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 01:35:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:48416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725762AbeICFfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 01:35:22 -0400
Received: from dragon (unknown [45.56.155.166])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FA7C20841;
        Mon,  3 Sep 2018 01:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535937457;
        bh=HYkK9EBLn+0IpmIx9SexuX5SNqIN8TgxqejaIqM0Kec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tRXKN1H6k4elKmuDOsF7sB3CLvlv4C1PCIiA/0qc0DL/MzIAvNKKKum3CAwx2WbTa
         xmc80ZsOs0aIO/pmrN0nzFPXmjWmzgN9W6ILHrknWQ4oBIRIvyYX9dBl5MHCsFmSes
         u1z36Zfdx+iLj4c1LcfayDv2hHKKwEYjqpnVSy0o=
Date:   Mon, 3 Sep 2018 09:16:26 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH 1/2] ARM: dts: imx7s: enable cpuidle driver
Message-ID: <20180903011625.GZ3850@dragon>
References: <1535518847-24417-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535518847-24417-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 01:00:46PM +0800, Anson Huang wrote:
> Enable cpuidle for i.MX7S/D using generic ARM cpuidle
> driver, below 2 idle states enabled:
> 
> 1. ARM WFI;
> 2. SoC WAIT mode.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm/boot/dts/imx7d.dtsi |  1 +
>  arch/arm/boot/dts/imx7s.dtsi | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
> index 7cbc2ff..4d0d0f6 100644
> --- a/arch/arm/boot/dts/imx7d.dtsi
> +++ b/arch/arm/boot/dts/imx7d.dtsi
> @@ -20,6 +20,7 @@
>  			reg = <1>;
>  			clock-frequency = <996000000>;
>  			operating-points-v2 = <&cpu0_opp_table>;
> +			cpu-idle-states = <&CPU_SLEEP>;
>  		};
>  	};
>  
> diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
> index 93884ce..cf5570b 100644
> --- a/arch/arm/boot/dts/imx7s.dtsi
> +++ b/arch/arm/boot/dts/imx7s.dtsi
> @@ -54,6 +54,19 @@
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> +		idle-states {
> +			entry-method = "psci";
> +
> +			CPU_SLEEP: WAIT {

I understand uppercase is allowed, but we conventionally use lowercase
for label and node name.  Can we do something like below?

	cpu_sleep_wait: cpu-sleep-wait {
		...
	}

Shawn

> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x0010000>;
> +				local-timer-stop;
> +				entry-latency-us = <100>;
> +				exit-latency-us = <50>;
> +				min-residency-us = <1000>;
> +			};
> +		};
> +
>  		cpu0: cpu@0 {
>  			compatible = "arm,cortex-a7";
>  			device_type = "cpu";
> @@ -61,6 +74,7 @@
>  			clock-frequency = <792000000>;
>  			clock-latency = <61036>; /* two CLK32 periods */
>  			clocks = <&clks IMX7D_CLK_ARM>;
> +			cpu-idle-states = <&CPU_SLEEP>;
>  		};
>  	};
>  
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
