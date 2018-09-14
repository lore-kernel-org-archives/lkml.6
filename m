Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B69ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD0B20861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCD0B20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbeINUQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:16:06 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47018 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbeINUQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:16:06 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B28452071D; Fri, 14 Sep 2018 17:01:09 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8066220379;
        Fri, 14 Sep 2018 17:00:59 +0200 (CEST)
Date:   Fri, 14 Sep 2018 17:00:59 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, davem@davemloft.net,
        andrew@lunn.ch, f.fainelli@gmail.com, allan.nielsen@microchip.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        thomas.petazzoni@bootlin.com, antoine.tenart@bootlin.com
Subject: Re: [PATCH 7/7] MIPS: mscc: add PCB120 to the ocelot fitImage
Message-ID: <20180914150059.GS14988@piout.net>
References: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
 <87ab2f80e3942dfca4eab896ba087e7b69bb7b12.1536916714.git-series.quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ab2f80e3942dfca4eab896ba087e7b69bb7b12.1536916714.git-series.quentin.schulz@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2018 11:44:28+0200, Quentin Schulz wrote:
> PCB120 and PCB123 are both development boards based on Microsemi Ocelot
> so let's use the same fitImage for both.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  arch/mips/generic/Kconfig                   |  6 +--
>  arch/mips/generic/Platform                  |  2 +-
>  arch/mips/generic/board-ocelot.its.S        | 40 ++++++++++++++++++++++-
>  arch/mips/generic/board-ocelot_pcb123.its.S | 23 +-------------
>  4 files changed, 44 insertions(+), 27 deletions(-)
>  create mode 100644 arch/mips/generic/board-ocelot.its.S
>  delete mode 100644 arch/mips/generic/board-ocelot_pcb123.its.S
> 
> diff --git a/arch/mips/generic/Kconfig b/arch/mips/generic/Kconfig
> index 08e33c6..fd60198 100644
> --- a/arch/mips/generic/Kconfig
> +++ b/arch/mips/generic/Kconfig
> @@ -65,11 +65,11 @@ config FIT_IMAGE_FDT_XILFPGA
>  	  Enable this to include the FDT for the MIPSfpga platform
>  	  from Imagination Technologies in the FIT kernel image.
>  
> -config FIT_IMAGE_FDT_OCELOT_PCB123
> -	bool "Include FDT for Microsemi Ocelot PCB123"
> +config FIT_IMAGE_FDT_OCELOT
> +	bool "Include FDT for Microsemi Ocelot development platforms"
>  	select MSCC_OCELOT
>  	help
> -	  Enable this to include the FDT for the Ocelot PCB123 platform
> +	  Enable this to include the FDT for the Ocelot development platforms
>  	  from Microsemi in the FIT kernel image.
>  	  This requires u-boot on the platform.
>  
> diff --git a/arch/mips/generic/Platform b/arch/mips/generic/Platform
> index 879cb80..eaa19d1 100644
> --- a/arch/mips/generic/Platform
> +++ b/arch/mips/generic/Platform
> @@ -16,5 +16,5 @@ all-$(CONFIG_MIPS_GENERIC)	:= vmlinux.gz.itb
>  its-y					:= vmlinux.its.S
>  its-$(CONFIG_FIT_IMAGE_FDT_BOSTON)	+= board-boston.its.S
>  its-$(CONFIG_FIT_IMAGE_FDT_NI169445)	+= board-ni169445.its.S
> -its-$(CONFIG_FIT_IMAGE_FDT_OCELOT_PCB123) += board-ocelot_pcb123.its.S
> +its-$(CONFIG_FIT_IMAGE_FDT_OCELOT)	+= board-ocelot.its.S
>  its-$(CONFIG_FIT_IMAGE_FDT_XILFPGA)	+= board-xilfpga.its.S
> diff --git a/arch/mips/generic/board-ocelot.its.S b/arch/mips/generic/board-ocelot.its.S
> new file mode 100644
> index 0000000..3da2398
> --- /dev/null
> +++ b/arch/mips/generic/board-ocelot.its.S
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +/ {
> +	images {
> +		fdt@ocelot_pcb123 {
> +			description = "MSCC Ocelot PCB123 Device Tree";
> +			data = /incbin/("boot/dts/mscc/ocelot_pcb123.dtb");
> +			type = "flat_dt";
> +			arch = "mips";
> +			compression = "none";
> +			hash@0 {
> +				algo = "sha1";
> +			};
> +		};
> +
> +		fdt@ocelot_pcb120 {
> +			description = "MSCC Ocelot PCB120 Device Tree";
> +			data = /incbin/("boot/dts/mscc/ocelot_pcb120.dtb");
> +			type = "flat_dt";
> +			arch = "mips";
> +			compression = "none";
> +			hash@0 {
> +				algo = "sha1";
> +			};
> +		};
> +	};
> +
> +	configurations {
> +		conf@ocelot_pcb123 {
> +			description = "Ocelot Linux kernel";
> +			kernel = "kernel@0";
> +			fdt = "fdt@ocelot_pcb123";
> +		};
> +
> +		conf@ocelot_pcb120 {
> +			description = "Ocelot Linux kernel";
> +			kernel = "kernel@0";
> +			fdt = "fdt@ocelot_pcb120";
> +		};
> +	};
> +};
> diff --git a/arch/mips/generic/board-ocelot_pcb123.its.S b/arch/mips/generic/board-ocelot_pcb123.its.S
> deleted file mode 100644
> index 5a7d5e1..0000000
> --- a/arch/mips/generic/board-ocelot_pcb123.its.S
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> -/ {
> -	images {
> -		fdt@ocelot_pcb123 {
> -			description = "MSCC Ocelot PCB123 Device Tree";
> -			data = /incbin/("boot/dts/mscc/ocelot_pcb123.dtb");
> -			type = "flat_dt";
> -			arch = "mips";
> -			compression = "none";
> -			hash@0 {
> -				algo = "sha1";
> -			};
> -		};
> -	};
> -
> -	configurations {
> -		conf@ocelot_pcb123 {
> -			description = "Ocelot Linux kernel";
> -			kernel = "kernel@0";
> -			fdt = "fdt@ocelot_pcb123";
> -		};
> -	};
> -};
> -- 
> git-series 0.9.1

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
