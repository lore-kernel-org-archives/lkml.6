Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755508AbeCSNGO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 09:06:14 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60166 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755270AbeCSNGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 09:06:12 -0400
Date: Mon, 19 Mar 2018 14:06:06 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ivan Gorinov <ivan.gorinov@intel.com>
cc: Frank Rowand <frowand.list@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v6 1/2] of: Documentation: Specify local APIC ID in
 "reg"
In-Reply-To: <c5eb2fd010855d187007859e7a332c866fbd41ec.1520974793.git.ivan.gorinov@intel.com>
Message-ID: <alpine.DEB.2.21.1803191405340.2010@nanos.tec.linutronix.de>
References: <cover.1520974793.git.ivan.gorinov@intel.com> <c5eb2fd010855d187007859e7a332c866fbd41ec.1520974793.git.ivan.gorinov@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob,

On Tue, 13 Mar 2018, Ivan Gorinov wrote:

> Use the "reg" property to specify the processor's local APIC ID.
> Local APIC ID is assigned by hardware and may differ from CPU number.

Any opinion on this version?

Thanks,

	tglx

> Signed-off-by: Ivan Gorinov <ivan.gorinov@intel.com>
> ---
>  Documentation/devicetree/bindings/x86/ce4100.txt | 37 ++++++++++++++++++------
>  1 file changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/x86/ce4100.txt b/Documentation/devicetree/bindings/x86/ce4100.txt
> index b49ae59..1c41cbd 100644
> --- a/Documentation/devicetree/bindings/x86/ce4100.txt
> +++ b/Documentation/devicetree/bindings/x86/ce4100.txt
> @@ -7,17 +7,36 @@ Many of the "generic" devices like HPET or IO APIC have the ce4100
>  name in their compatible property because they first appeared in this
>  SoC.
>  
> -The CPU node
> -------------
> -	cpu@0 {
> -		device_type = "cpu";
> -		compatible = "intel,ce4100";
> -		reg = <0>;
> -		lapic = <&lapic0>;
> +The CPU nodes
> +-------------
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu@0x00 {
> +			device_type = "cpu";
> +			compatible = "intel,ce4100";
> +			reg = <0x00>;
> +		};
> +
> +		cpu@0x02 {
> +			device_type = "cpu";
> +			compatible = "intel,ce4100";
> +			reg = <0x02>;
> +		};
>  	};
>  
> -The reg property describes the CPU number. The lapic property points to
> -the local APIC timer.
> +A "cpu" node describes one logical processor (hardware thread).
> +
> +Required properties:
> +
> +- device_type
> +	Device type, must be "cpu".
> +
> +- reg
> +	Local APIC ID, the unique number assigned to each processor by
> +	system hardware.
>  
>  The SoC node
>  ------------
> -- 
> 2.7.4
> 
> 
