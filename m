Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F775ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4022098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cm6rZG0k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C4022098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731395AbeIYBSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:18:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42487 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730914AbeIYBSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:18:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id y4-v6so9621752pgp.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 12:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8oKy/FMnmlf4VEFI0GiByfl+vIaUvF0ghpDr8GF9mHU=;
        b=cm6rZG0ktgaWNezYnEbTDdDN7mP3ntKXwsoUHTjgNsZTwZL6kMa7cpyn5Z5TLdt/wf
         fsCUgiVURGALPXRF3EZtsNBMrxuQdl7YA55RPpqtx659R9tOt6RJETnC7ObXmFiodjY3
         Ivov952iviWlZzKaIkrtOG7BWwyEyQDNUyKVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8oKy/FMnmlf4VEFI0GiByfl+vIaUvF0ghpDr8GF9mHU=;
        b=UkyMB52WAbG0gfkobBWTKcgSifyNuUEX5ZGbILxkF7en4lUYh0MZGyVpPHL6ZhMydk
         S/tbw4jllmTtRGXRCCMNlfebdz8Z2rp/FskBxjD/APU15PI6vWFkj9A74AdHooTKQDue
         0LIlWgMmOjyTJBWTz8QVCRnnAvmHi75ONpNmcZnYY9zJo+/1iH3uwuumoCin3PojTEQ+
         5/F3js90FhJPzj7nxglh0k2+RWpW+LnuCqiZBtbSwkKc3mQnxMUjkjGsHOzHj4hfF4Fq
         O7LZV9ABPL9hLZdHJ7PFOF7doYtXveUYRsGsPy/6eb4vvXzuKjM/50dpjuWrYhmIoCQl
         Tfcg==
X-Gm-Message-State: ABuFfogY1KcIZgaEDdMsccRukRDVpE3GUcGfWhy1dTwe0FK4lslBJ9d3
        VcSNaroKD6MPtHDGt7p4HJ1WOQ==
X-Google-Smtp-Source: ACcGV63fzTW9H1A2aIvuDdPyg2QY/eHCoqKLCZBWWPopuSukdzGGA83S0zkz1OIyZDMeR65Se8EKsA==
X-Received: by 2002:a63:ce14:: with SMTP id y20-v6mr209259pgf.248.1537816509476;
        Mon, 24 Sep 2018 12:15:09 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p1-v6sm125263pfn.53.2018.09.24.12.15.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 12:15:08 -0700 (PDT)
Date:   Mon, 24 Sep 2018 12:19:29 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Craig Tatlor <ctatlor97@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: sdm630 SoC and Sony Pioneer (Xperia XA2)
 support
Message-ID: <20180924191929.GQ1367@tuxbook-pro>
References: <20180811162549.12312-1-ctatlor97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180811162549.12312-1-ctatlor97@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 11 Aug 09:25 PDT 2018, Craig Tatlor wrote:

> Initial device tree support for Qualcomm SDM630 SoC and
> Sony Pioneer (Xperia XA2).
> 
> SDM630 is based off of the SDM660 soc and all SDM660 specific drivers are
> compatible with it. SDM660 is also based off of MSM8998 so it uses some
> of its drivers aswell.

Consider adding both sdm630 and sdm660 compatibles to the bindings and
drivers and use the right one in the dts, in case we find details that
differs in the future.

> 
> The device tree is based on the CAF 4.4 kernel tree.
> 
> The device can be booted into the initrd with a shell over UART.
> 
> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
[..]
> diff --git a/arch/arm64/boot/dts/qcom/sdm630-pins.dtsi b/arch/arm64/boot/dts/qcom/sdm630-pins.dtsi
> new file mode 100644
> index 000000000000..78b79c1076f1
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm630-pins.dtsi
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2018, Craig Tatlor. */
> +
> +&tlmm {
> +	blsp1_uart1_default: blsp1_uart1_default {
> +		pinmux {
> +			pins = "gpio0", "gpio1", "gpio2", "gpio3";
> +			function = "gpio";

Please put these in the sdm630.dtsi directly, rather than spreading the
pins out in a separate file.

> +		};
> +
> +		pinconf {
> +			pins = "gpio0", "gpio1", "gpio2", "gpio3";
> +			drive-strength = <2>;
> +			bias-disable;

Please extend &blsp1_uart1_default in the pioneer dtsi with these
"electrical properties".

> +		};
> +	};
> +};
[..]
> diff --git a/arch/arm64/boot/dts/qcom/sdm630-pioneer.dtsi b/arch/arm64/boot/dts/qcom/sdm630-pioneer.dtsi
> new file mode 100644
> index 000000000000..512792c23369
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm630-pioneer.dtsi
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2018, Craig Tatlor. */
> +
> +#include "sdm630.dtsi"
> +
> +/ {
> +	aliases {
> +		serial0 = &blsp1_uart1;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&soc {
> +	serial@c170000 {

Please reference this by &blsp1_uart1, rather than duplicating the
hierarchy.

> +		status = "okay";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&blsp1_uart1_default>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> new file mode 100644
> index 000000000000..8a544979b7c0
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> @@ -0,0 +1,383 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2018, Craig Tatlor. */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/qcom,gcc-sdm660.h>
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. SDM630";

We expect the board to always override this, so no need to specify it
here.

> +
> +	interrupt-parent = <&intc>;
> +
> +	qcom,msm-id = <318 0x0>;
> +
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	chosen { };
> +
> +	memory {
> +		device_type = "memory";
> +		/* We expect the bootloader to fill in the reg */
> +		reg = <0 0 0 0>;
> +	};
> +
> +

Extra empty line.

> +	cpus {
[..]
> +
> +	timer {

Please sort these nodes by name, except for "soc" which is convenient
to have last.

> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 1 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 2 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 3 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 0 IRQ_TYPE_LEVEL_LOW>;
> +	};
[..]
> +	firmware {
> +		scm {
> +			compatible = "qcom,scm-sdm660";
> +		};
> +	};
> +
> +

Extra empty line.

> +	rpm-glink {
> +		compatible = "qcom,glink-rpm";
> +
> +		interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> +
> +		qcom,rpm-msg-ram = <&rpm_msg_ram>;
> +
> +		mboxes = <&apcs_glb 0>;

Remove a few of these extra empty lines and add the rpm_requests channel
here while you're at it:

		rpm_requests: glink-channel {
                        compatible = "qcom,rpm-sdm660";
                        qcom,glink-channels = "rpm_requests";
                };

> +	};
> +
> +	soc: soc {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0 0 0xffffffff>;
> +		compatible = "simple-bus";
> +
> +		intc: interrupt-controller@17a00000 {

Please sort these nodes by base address.

> +			compatible = "arm,gic-v3";
> +			reg = <0x17a00000 0x10000>,
> +			      <0x17b00000 0x100000>;
> +			#interrupt-cells = <3>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			interrupt-controller;
> +			#redistributor-regions = <1>;
> +			redistributor-stride = <0x0 0x20000>;
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		gcc: clock-controller@100000 {
> +			compatible = "qcom,gcc-sdm660";
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			#power-domain-cells = <1>;
> +			reg = <0x100000 0x94000>;

Please 0-pad addresses in "reg", makes it easier to sort them as well
(but keep the @address after the node name unpadded).

> +		};
> +
[..]
> +		rpm_msg_ram: memory@778000 {
> +			compatible = "qcom,rpm-msg-ram";
> +			reg = <0x778000 0x7000>;
> +		};
> +
> +		apcs_glb: mailbox@17911000 {
> +			compatible = "qcom,msm8998-apcs-hmss-global";

Please update the apcs ipc driver with a sdm660 compatible and update
this.

> +			reg = <0x17911000 0x1000>;
> +
> +			#mbox-cells = <1>;
> +		};

Regards,
Bjorn
