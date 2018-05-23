Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932722AbeEWLf4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 07:35:56 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:53110 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932391AbeEWLfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 07:35:52 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Wed, 23 May 2018 13:35:49 +0200
From: Stefan Agner <stefan@agner.ch>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Lucas Stach <dev@lynxeye.de>
Subject: Re: [PATCH v6 4/4] ARM: dts: tegra: Work safely with 256 MB
 Colibri-T20 modules
In-Reply-To: <1527069406-6359-4-git-send-email-krzk@kernel.org>
References: <1527069406-6359-1-git-send-email-krzk@kernel.org>
 <1527069406-6359-4-git-send-email-krzk@kernel.org>
Message-ID: <a8969b297da304c292e6587fba7fcc23@agner.ch>
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-3.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[10];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.05.2018 11:56, Krzysztof Kozlowski wrote:
> Colibri-T20 can come in 256 MB RAM (with 512 MB NAND) or 512 MB RAM
> (with 1024 MB NAND) flavors.  Both of them will use the same DTSI
> expecting the bootloader to do the fixup of /memory node.  However in
> case it does not happen, let's stay on safe side by limiting the memory
> to 256 MB for both versions of Colibri-T20.
> 

Maybe also mention the renaming stuff:

"Rename to remove the unnecessary memory size from the device tree file
name. While at it, also follow the typical Toradex SoC, module, carrier
board hierarchy."

--
Stefan

> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> RFT:
> Not tested on 512 MB module as I have only the 256 MB one.
> 
> Changes since v5:
> 1. Add "colibri" suffix to iris DTS (suggested by Stefan).
> 
> Changes since v4:
> 1. Drop the 512 suffix from file names (suggested by Stefan).
> 
> Changes since v3:
> 1. Reduce the memory in existing DTSI instead of creating a new one
>    (suggested by Marcel).
> 
> Changes since v2:
> 1. Do not add new compatible but use everywhere existing
>    "toradex,colibri_t20-512" (suggested by Rob).
> 
> Changes since v1:
> 1. Fix memory size in tegra20-colibri-256.dtsi (was working fine because
>    my bootloader uses mem= argument).
> ---
>  arch/arm/boot/dts/Makefile                                       | 2 +-
>  .../boot/dts/{tegra20-iris-512.dts => tegra20-colibri-iris.dts}  | 4 ++--
>  .../boot/dts/{tegra20-colibri-512.dtsi => tegra20-colibri.dtsi}  | 9 +++++++--
>  3 files changed, 10 insertions(+), 5 deletions(-)
>  rename arch/arm/boot/dts/{tegra20-iris-512.dts =>
> tegra20-colibri-iris.dts} (95%)
>  rename arch/arm/boot/dts/{tegra20-colibri-512.dtsi =>
> tegra20-colibri.dtsi} (98%)
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index ec2024ea8b1e..1c8bb55c0948 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1030,7 +1030,7 @@ dtb-$(CONFIG_ARCH_TANGO) += \
>  	tango4-vantage-1172.dtb
>  dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += \
>  	tegra20-harmony.dtb \
> -	tegra20-iris-512.dtb \
> +	tegra20-colibri-iris.dtb \
>  	tegra20-medcom-wide.dtb \
>  	tegra20-paz00.dtb \
>  	tegra20-plutux.dtb \
> diff --git a/arch/arm/boot/dts/tegra20-iris-512.dts
> b/arch/arm/boot/dts/tegra20-colibri-iris.dts
> similarity index 95%
> rename from arch/arm/boot/dts/tegra20-iris-512.dts
> rename to arch/arm/boot/dts/tegra20-colibri-iris.dts
> index 40126388946d..57f16c0e9917 100644
> --- a/arch/arm/boot/dts/tegra20-iris-512.dts
> +++ b/arch/arm/boot/dts/tegra20-colibri-iris.dts
> @@ -1,10 +1,10 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /dts-v1/;
>  
> -#include "tegra20-colibri-512.dtsi"
> +#include "tegra20-colibri.dtsi"
>  
>  / {
> -	model = "Toradex Colibri T20 512MB on Iris";
> +	model = "Toradex Colibri T20 256/512 MB on Iris";
>  	compatible = "toradex,iris", "toradex,colibri_t20-512", "nvidia,tegra20";
>  
>  	aliases {
> diff --git a/arch/arm/boot/dts/tegra20-colibri-512.dtsi
> b/arch/arm/boot/dts/tegra20-colibri.dtsi
> similarity index 98%
> rename from arch/arm/boot/dts/tegra20-colibri-512.dtsi
> rename to arch/arm/boot/dts/tegra20-colibri.dtsi
> index 5623ff8d128c..dc06b23183e1 100644
> --- a/arch/arm/boot/dts/tegra20-colibri-512.dtsi
> +++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
> @@ -2,7 +2,7 @@
>  #include "tegra20.dtsi"
>  
>  / {
> -	model = "Toradex Colibri T20 512MB";
> +	model = "Toradex Colibri T20 256/512 MB";
>  	compatible = "toradex,colibri_t20-512", "nvidia,tegra20";
>  
>  	aliases {
> @@ -11,7 +11,12 @@
>  	};
>  
>  	memory@0 {
> -		reg = <0x00000000 0x20000000>;
> +		/*
> +		 * Set memory to 256 MB to be safe as this could be used on
> +		 * 256 or 512 MB module. It is expected from bootloader
> +		 * to fix this up for 512 MB version.
> +		 */
> +		reg = <0x00000000 0x10000000>;
>  	};
>  
>  	host1x@50000000 {
