Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966006AbeEXJan (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 05:30:43 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:34990 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965936AbeEXJak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 05:30:40 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Thu, 24 May 2018 11:30:38 +0200
From: Stefan Agner <stefan@agner.ch>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Lucas Stach <dev@lynxeye.de>
Subject: Re: [PATCH v7 2/4] ARM: dts: tegra: Fix unit_address_vs_reg DTC
 warnings for /memory
In-Reply-To: <1527144833-24285-2-git-send-email-krzk@kernel.org>
References: <1527144833-24285-1-git-send-email-krzk@kernel.org>
 <1527144833-24285-2-git-send-email-krzk@kernel.org>
Message-ID: <f7115418ec6eb4dadee12114278bce67@agner.ch>
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
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.05.2018 08:53, Krzysztof Kozlowski wrote:
> Add a generic /memory node in each Tegra DTSI (with empty reg property,
> to be overidden by each DTS) and set proper unit address for /memory
> nodes to fix the DTC warnings:
> 
>     arch/arm/boot/dts/tegra20-harmony.dtb: Warning (unit_address_vs_reg):
>         /memory: node has a reg or ranges property, but no unit name
> 
> The DTB after the change is the same as before except adding
> unit-address to /memory node.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 

Looks good to me! Thanks!

Reviewed-by: Stefan Agner <stefan@agner.ch>

--
Stefan

> ---
> 
> Changes since v6:
> 1. Fix unit addresses for tegra124 and minor nits (suggested by Stefan).
> 
> Changes since v5:
> 1. Split with skeleton.dtsi removal (suggested by Stefan).
> 
> Changes since v4:
> 1. None
> ---
>  arch/arm/boot/dts/tegra114-dalmore.dts      | 2 +-
>  arch/arm/boot/dts/tegra114-roth.dts         | 2 +-
>  arch/arm/boot/dts/tegra114-tn7.dts          | 2 +-
>  arch/arm/boot/dts/tegra114.dtsi             | 3 ++-
>  arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi | 2 +-
>  arch/arm/boot/dts/tegra124-apalis.dtsi      | 2 +-
>  arch/arm/boot/dts/tegra124-jetson-tk1.dts   | 2 +-
>  arch/arm/boot/dts/tegra124-nyan.dtsi        | 2 +-
>  arch/arm/boot/dts/tegra124-venice2.dts      | 2 +-
>  arch/arm/boot/dts/tegra124.dtsi             | 3 ++-
>  arch/arm/boot/dts/tegra20-colibri-512.dtsi  | 2 +-
>  arch/arm/boot/dts/tegra20-harmony.dts       | 2 +-
>  arch/arm/boot/dts/tegra20-paz00.dts         | 2 +-
>  arch/arm/boot/dts/tegra20-seaboard.dts      | 2 +-
>  arch/arm/boot/dts/tegra20-tamonten.dtsi     | 2 +-
>  arch/arm/boot/dts/tegra20-trimslice.dts     | 2 +-
>  arch/arm/boot/dts/tegra20-ventana.dts       | 2 +-
>  arch/arm/boot/dts/tegra20.dtsi              | 3 ++-
>  arch/arm/boot/dts/tegra30-apalis.dtsi       | 4 ++--
>  arch/arm/boot/dts/tegra30-beaver.dts        | 2 +-
>  arch/arm/boot/dts/tegra30-cardhu.dtsi       | 2 +-
>  arch/arm/boot/dts/tegra30-colibri.dtsi      | 2 +-
>  arch/arm/boot/dts/tegra30.dtsi              | 3 ++-
>  23 files changed, 28 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts
> b/arch/arm/boot/dts/tegra114-dalmore.dts
> index eafff16765b4..1788556b4977 100644
> --- a/arch/arm/boot/dts/tegra114-dalmore.dts
> +++ b/arch/arm/boot/dts/tegra114-dalmore.dts
> @@ -23,7 +23,7 @@
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> -	memory {
> +	memory@80000000 {
>  		reg = <0x80000000 0x40000000>;
>  	};
>  
> diff --git a/arch/arm/boot/dts/tegra114-roth.dts
> b/arch/arm/boot/dts/tegra114-roth.dts
> index 7ed7370ee67a..3d3835591cd2 100644
> --- a/arch/arm/boot/dts/tegra114-roth.dts
> +++ b/arch/arm/boot/dts/tegra114-roth.dts
> @@ -28,7 +28,7 @@
>  		};
>  	};
>  
> -	memory {
> +	memory@80000000 {
>  		/* memory >= 0x79600000 is reserved for firmware usage */
>  		reg = <0x80000000 0x79600000>;
>  	};
> diff --git a/arch/arm/boot/dts/tegra114-tn7.dts
> b/arch/arm/boot/dts/tegra114-tn7.dts
> index 7fc4a8b31e45..bfdd1bf61816 100644
> --- a/arch/arm/boot/dts/tegra114-tn7.dts
> +++ b/arch/arm/boot/dts/tegra114-tn7.dts
> @@ -28,7 +28,7 @@
>  		};
>  	};
>  
> -	memory {
> +	memory@80000000 {
>  		/* memory >= 0x37e00000 is reserved for firmware usage */
>  		reg = <0x80000000 0x37e00000>;
>  	};
> diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
> index 27ef515e5640..85488a150701 100644
> --- a/arch/arm/boot/dts/tegra114.dtsi
> +++ b/arch/arm/boot/dts/tegra114.dtsi
> @@ -11,8 +11,9 @@
>  	#address-cells = <1>;
>  	#size-cells = <1>;
>  
> -	memory {
> +	memory@80000000 {
>  		device_type = "memory";
> +		reg = <0x80000000 0x0>;
>  	};
>  
>  	host1x@50000000 {
> diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
> b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
> index bb67edb016c5..acb5b379e896 100644
> --- a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
> +++ b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
> @@ -15,7 +15,7 @@
>  	compatible = "toradex,apalis-tk1-v1.2", "toradex,apalis-tk1",
>  		     "nvidia,tegra124";
>  
> -	memory {
> +	memory@80000000 {
>  		reg = <0x0 0x80000000 0x0 0x80000000>;
>  	};
>  
> diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi
> b/arch/arm/boot/dts/tegra124-apalis.dtsi
> index 65a2161b9b8e..08518e424448 100644
> --- a/arch/arm/boot/dts/tegra124-apalis.dtsi
> +++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
> @@ -50,7 +50,7 @@
>  	model = "Toradex Apalis TK1";
>  	compatible = "toradex,apalis-tk1", "nvidia,tegra124";
>  
> -	memory {
> +	memory@80000000 {
>  		reg = <0x0 0x80000000 0x0 0x80000000>;
>  	};
>  
> diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
> b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
> index 6dbcf84dafbc..9151b3ebb839 100644
> --- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
> +++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
> @@ -24,7 +24,7 @@
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> -	memory {
> +	memory@80000000 {
>  		reg = <0x0 0x80000000 0x0 0x80000000>;
>  	};
>  
> diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi
> b/arch/arm/boot/dts/tegra124-nyan.dtsi
> index 3609367037a6..d5f11d6d987e 100644
> --- a/arch/arm/boot/dts/tegra124-nyan.dtsi
> +++ b/arch/arm/boot/dts/tegra124-nyan.dtsi
> @@ -13,7 +13,7 @@
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> -	memory {
> +	memory@80000000 {
>  		reg = <0x0 0x80000000 0x0 0x80000000>;
>  	};
>  
> diff --git a/arch/arm/boot/dts/tegra124-venice2.dts
> b/arch/arm/boot/dts/tegra124-venice2.dts
> index 89bcc178994d..82d139648ef1 100644
> --- a/arch/arm/boot/dts/tegra124-venice2.dts
> +++ b/arch/arm/boot/dts/tegra124-venice2.dts
> @@ -18,7 +18,7 @@
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> -	memory {
> +	memory@80000000 {
>  		reg = <0x0 0x80000000 0x0 0x80000000>;
>  	};
>  
> diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
> index 951feea784af..183c5acafb22 100644
> --- a/arch/arm/boot/dts/tegra124.dtsi
> +++ b/arch/arm/boot/dts/tegra124.dtsi
> @@ -13,8 +13,9 @@
>  	#address-cells = <2>;
>  	#size-cells = <2>;
>  
> -	memory {
> +	memory@80000000 {
>  		device_type = "memory";
> +		reg = <0x0 0x80000000 0x0 0x0>;
>  	};
>  
>  	pcie@1003000 {
> diff --git a/arch/arm/boot/dts/tegra20-colibri-512.dtsi
> b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
> index 5c202b3e3bb1..5623ff8d128c 100644
> --- a/arch/arm/boot/dts/tegra20-colibri-512.dtsi
> +++ b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
> @@ -10,7 +10,7 @@
>  		rtc1 = "/rtc@7000e000";
>  	};
>  
> -	memory {
> +	memory@0 {
>  		reg = <0x00000000 0x20000000>;
>  	};
>  
> diff --git a/arch/arm/boot/dts/tegra20-harmony.dts
> b/arch/arm/boot/dts/tegra20-harmony.dts
> index 628a55a9318b..1d96d92b72a7 100644
> --- a/arch/arm/boot/dts/tegra20-harmony.dts
> +++ b/arch/arm/boot/dts/tegra20-harmony.dts
> @@ -18,7 +18,7 @@
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> -	memory {
> +	memory@0 {
>  		reg = <0x00000000 0x40000000>;
>  	};
>  
> diff --git a/arch/arm/boot/dts/tegra20-paz00.dts
> b/arch/arm/boot/dts/tegra20-paz00.dts
> index 30436969adc0..ef245291924f 100644
> --- a/arch/arm/boot/dts/tegra20-paz00.dts
> +++ b/arch/arm/boot/dts/tegra20-paz00.dts
> @@ -19,7 +19,7 @@
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> -	memory {
> +	memory@0 {
>  		reg = <0x00000000 0x20000000>;
>  	};
>  
> diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts
> b/arch/arm/boot/dts/tegra20-seaboard.dts
> index 284aae351ff2..f91441683aad 100644
> --- a/arch/arm/boot/dts/tegra20-seaboard.dts
> +++ b/arch/arm/boot/dts/tegra20-seaboard.dts
> @@ -18,7 +18,7 @@
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> -	memory {
> +	memory@0 {
>  		reg = <0x00000000 0x40000000>;
>  	};
>  
> diff --git a/arch/arm/boot/dts/tegra20-tamonten.dtsi
> b/arch/arm/boot/dts/tegra20-tamonten.dtsi
> index 872046d48709..20137fc578b1 100644
> --- a/arch/arm/boot/dts/tegra20-tamonten.dtsi
> +++ b/arch/arm/boot/dts/tegra20-tamonten.dtsi
> @@ -15,7 +15,7 @@
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> -	memory {
> +	memory@0 {
>  		reg = <0x00000000 0x20000000>;
>  	};
>  
> diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts
> b/arch/arm/boot/dts/tegra20-trimslice.dts
> index d55c6b240a30..9eb26dc15f6b 100644
> --- a/arch/arm/boot/dts/tegra20-trimslice.dts
> +++ b/arch/arm/boot/dts/tegra20-trimslice.dts
> @@ -18,7 +18,7 @@
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> -	memory {
> +	memory@0 {
>  		reg = <0x00000000 0x40000000>;
>  	};
>  
> diff --git a/arch/arm/boot/dts/tegra20-ventana.dts
> b/arch/arm/boot/dts/tegra20-ventana.dts
> index ee3fbf941e79..f44551e2d9d0 100644
> --- a/arch/arm/boot/dts/tegra20-ventana.dts
> +++ b/arch/arm/boot/dts/tegra20-ventana.dts
> @@ -18,7 +18,7 @@
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> -	memory {
> +	memory@0 {
>  		reg = <0x00000000 0x40000000>;
>  	};
>  
> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
> index 88dd1afb5877..55581c0e5105 100644
> --- a/arch/arm/boot/dts/tegra20.dtsi
> +++ b/arch/arm/boot/dts/tegra20.dtsi
> @@ -13,8 +13,9 @@
>  	chosen { };
>  	aliases { };
>  
> -	memory {
> +	memory@0 {
>  		device_type = "memory";
> +		reg = <0 0>;
>  	};
>  
>  	iram@40000000 {
> diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi
> b/arch/arm/boot/dts/tegra30-apalis.dtsi
> index 6f29cbad6e8a..9465fc592b7b 100644
> --- a/arch/arm/boot/dts/tegra30-apalis.dtsi
> +++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
> @@ -10,8 +10,8 @@
>  	model = "Toradex Apalis T30";
>  	compatible = "toradex,apalis_t30", "nvidia,tegra30";
>  
> -	memory {
> -		reg = <0 0>;
> +	memory@80000000 {
> +		reg = <0x80000000 0x40000000>;
>  	};
>  
>  	pcie@3000 {
> diff --git a/arch/arm/boot/dts/tegra30-beaver.dts
> b/arch/arm/boot/dts/tegra30-beaver.dts
> index ae52a5039506..1434d50438f9 100644
> --- a/arch/arm/boot/dts/tegra30-beaver.dts
> +++ b/arch/arm/boot/dts/tegra30-beaver.dts
> @@ -17,7 +17,7 @@
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> -	memory {
> +	memory@80000000 {
>  		reg = <0x80000000 0x7ff00000>;
>  	};
>  
> diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi
> b/arch/arm/boot/dts/tegra30-cardhu.dtsi
> index 92a9740c533f..33b73dca16a3 100644
> --- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
> +++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
> @@ -40,7 +40,7 @@
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> -	memory {
> +	memory@80000000 {
>  		reg = <0x80000000 0x40000000>;
>  	};
>  
> diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi
> b/arch/arm/boot/dts/tegra30-colibri.dtsi
> index c44d8c40c410..9bf3327665d3 100644
> --- a/arch/arm/boot/dts/tegra30-colibri.dtsi
> +++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
> @@ -10,7 +10,7 @@
>  	model = "Toradex Colibri T30";
>  	compatible = "toradex,colibri_t30", "nvidia,tegra30";
>  
> -	memory {
> +	memory@80000000 {
>  		reg = <0x80000000 0x40000000>;
>  	};
>  
> diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
> index 19237c08c166..bc42f791d791 100644
> --- a/arch/arm/boot/dts/tegra30.dtsi
> +++ b/arch/arm/boot/dts/tegra30.dtsi
> @@ -14,8 +14,9 @@
>  	chosen { };
>  	aliases { };
>  
> -	memory {
> +	memory@80000000 {
>  		device_type = "memory";
> +		reg = <0x80000000 0x0>;
>  	};
>  
>  	pcie@3000 {
