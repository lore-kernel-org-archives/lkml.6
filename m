Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034070AbeEXRFH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 13:05:07 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42313 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034036AbeEXRFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 13:05:02 -0400
X-Google-Smtp-Source: AB8JxZogCWkoMNVBuxxi260p4SgDe8Ln0jBCK1TZpgGqSuo+rft+ZQ8RxULB89OJQyLpk/vyUKRoGA==
Date: Thu, 24 May 2018 10:04:59 -0700
From: Moritz Fischer <mdf@kernel.org>
To: richard.gong@linux.intel.com
Cc: catalin.marinas@arm.com, will.deacon@arm.com, dinguyen@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, atull@kernel.org,
        mdf@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        corbet@lwn.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        yves.vandervennet@linux.intel.com, richard.gong@intel.com
Subject: Re: [PATCHv5 2/8] arm64: dts: stratix10: add stratix10 service
 driver binding to base dtsi
Message-ID: <20180524170459.GB4051@archbook>
References: <1527179600-26441-1-git-send-email-richard.gong@linux.intel.com>
 <1527179600-26441-3-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527179600-26441-3-git-send-email-richard.gong@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On Thu, May 24, 2018 at 11:33:14AM -0500, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Add Intel Stratix10 service layer to the device tree
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> Signed-off-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
> v2: Change to put service layer driver node under the firmware node
>     Change compatible to "intel, stratix10-svc"
> v3: No change
> v4: s/service driver/stratix10 service driver/ in subject line
> v5: No change
> ---
>  arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> index d8c94d5..c257287 100644
> --- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> @@ -24,6 +24,19 @@
>  	#address-cells = <2>;
>  	#size-cells = <2>;
>  
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		service_reserved: svcbuffer@0 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x0 0x0 0x0 0x1000000>;
> +			alignment = <0x1000>;
> +			no-map;
> +		};
> +	};
> +
>  	cpus {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> @@ -487,5 +500,13 @@
>  
>  			status = "disabled";
>  		};
> +
> +		firmware {
> +			svc {
> +				compatible = "intel,stratix10-svc";
> +				method = "smc";
> +				memory-region = <&service_reserved>;
> +			};
> +		};
>  	};
>  };
> -- 
> 2.7.4
> 
