Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AA6C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198B42087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 198B42087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbeLCQza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 11:55:30 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41888 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbeLCQza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 11:55:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 294A51682;
        Mon,  3 Dec 2018 08:55:28 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79A9C3F59C;
        Mon,  3 Dec 2018 08:55:24 -0800 (PST)
Date:   Mon, 3 Dec 2018 16:55:21 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        devicetree@vger.kernel.org,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Juri Lelli <juri.lelli@arm.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFT PATCH v1 2/4] dt-binding: cpu-topology: Move cpu-map to a
 common binding.
Message-ID: <20181203165521.GB17883@e107155-lin>
References: <1543534100-3654-1-git-send-email-atish.patra@wdc.com>
 <1543534100-3654-3-git-send-email-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543534100-3654-3-git-send-email-atish.patra@wdc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 03:28:18PM -0800, Atish Patra wrote:
> cpu-map binding can be used to described cpu topology for both
> RISC-V & ARM. It makes more sense to move the binding to document
> to a common place.
>
> The relevant discussion can be found here.
> https://lkml.org/lkml/2018/11/6/19
>

Looks good to me apart from a minor query below in the example.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  .../{arm/topology.txt => cpu/cpu-topology.txt}     | 81 ++++++++++++++++++----
>  1 file changed, 67 insertions(+), 14 deletions(-)
>  rename Documentation/devicetree/bindings/{arm/topology.txt => cpu/cpu-topology.txt} (86%)
>
> diff --git a/Documentation/devicetree/bindings/arm/topology.txt b/Documentation/devicetree/bindings/cpu/cpu-topology.txt
> similarity index 86%
> rename from Documentation/devicetree/bindings/arm/topology.txt
> rename to Documentation/devicetree/bindings/cpu/cpu-topology.txt
> index 66848355..1de6fbce 100644
> --- a/Documentation/devicetree/bindings/arm/topology.txt
> +++ b/Documentation/devicetree/bindings/cpu/cpu-topology.txt

[...]

> +Example 3: HiFive Unleashed (RISC-V 64 bit, 4 core system)
> +
> +cpus {
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +	compatible = "sifive,fu540g", "sifive,fu500";
> +	model = "sifive,hifive-unleashed-a00";
> +
> +	...
> +
> +	cpu-map {
> +		cluster0 {
> +			core0 {
> +				cpu = <&L12>;
> +		 	};
> +			core1 {
> +				cpu = <&L15>;
> +			};
> +			core2 {
> +				cpu0 = <&L18>;
> +			};
> +			core3 {
> +				cpu0 = <&L21>;
> +			};
> +		};
> + 	};
> +
> +	L12: cpu@1 {
> +		device_type = "cpu";
> +		compatible = "sifive,rocket0", "riscv";
> +		reg = <0x1>;
> +	}
> +
> +	L15: cpu@2 {
> +		device_type = "cpu";
> +		compatible = "sifive,rocket0", "riscv";
> +		reg = <0x2>;
> +	}
> +	L18: cpu@3 {
> +		device_type = "cpu";
> +		compatible = "sifive,rocket0", "riscv";
> +		reg = <0x3>;
> +	}
> +	L21: cpu@4 {
> +		device_type = "cpu";
> +		compatible = "sifive,rocket0", "riscv";
> +		reg = <0x4>;
> +	}
> +};

The labels for the CPUs drew my attention. Is it intentionally random
(or even specific) or just chosen to show anything can be used as labels ?
The reason I ask is people tend to copy from existing DT or examples
like here and so want to make sure if it can be kept as generic as
possible in the example. Just my opinion and I am fine if you want to
keep it as is, thought of checking the intentions here.

--
Regards,
Sudeep
