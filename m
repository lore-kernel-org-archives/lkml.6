Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbeBGV6b (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 16:58:31 -0500
Received: from vern.gendns.com ([206.190.152.46]:39265 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751343AbeBGV62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 16:58:28 -0500
Subject: Re: [PATCH 4/7] ARM: dts: da850: add power controller nodes
To: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180207134553.13510-1-brgl@bgdev.pl>
 <20180207134553.13510-5-brgl@bgdev.pl>
From: David Lechner <david@lechnology.com>
Message-ID: <41f32de3-5daa-75fd-51e9-e6dc1f7142a3@lechnology.com>
Date: Wed, 7 Feb 2018 15:58:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180207134553.13510-5-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/07/2018 07:45 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Add two power controller nodes corresponding with the two PSC modules
> present on the da850 SoC.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   arch/arm/boot/dts/da850.dtsi | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> index 3a1f2ced05ca..ac2eef4e6b7c 100644
> --- a/arch/arm/boot/dts/da850.dtsi
> +++ b/arch/arm/boot/dts/da850.dtsi
> @@ -24,6 +24,11 @@
>   		};
>   	};
>   
> +	aliases {
> +		pwc0 = &pwc0;
> +		pwc1 = &pwc1;
> +	};

Why do we need aliases? (would be nice to have the reason in the commit
message if there is a good reason)

> +
>   	opp_table: opp-table {
>   		compatible = "operating-points-v2";
>   
> @@ -141,6 +146,10 @@
>   				      "pll0_sysclk4", "pll0_sysclk6",
>   				      "async1";
>   		};
> +		pwc0: power-controller@10000 {
> +			compatible = "ti,davinci-pm-domains";
> +			#power-domain-cells = <0>;
> +		};
>   		pll0: clock-controller@11000 {
>   			compatible = "ti,da850-pll0";
>   			reg = <0x11000 0x1000>;
> @@ -757,6 +766,10 @@
>   				 <&async3_clk>;
>   			clock-names = "pll0_sysclk2", "pll0_sysclk4", "async3";
>   		};
> +		pwc1: power-controller@227000 {
> +			compatible = "ti,davinci-pm-domains";
> +			#power-domain-cells = <0>;
> +		};
>   		pinconf: pin-controller@22c00c {
>   			compatible = "ti,da850-pupd";
>   			reg = <0x22c00c 0x8>;
> 
