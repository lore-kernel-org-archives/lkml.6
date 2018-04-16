Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523914094; cv=none;
        d=google.com; s=arc-20160816;
        b=aPZIjll4iNYGnYU8kTtmmfu8ZEg5HWOb8UbcE5bTVPH2HFxe3Qdt6db2bKOUXQByIT
         0QlGyjRp5q1jiqIa2DtDka1J1Xro/OhC90IKdZjTdhIhLSx8jEyTZq5DdG6Cd7Qtb6Nk
         eLHd2+BvmCFGUVTg+d9bdaidb5EJ8dioCQ6N2LG5/O1bo+611m7DwskzBlfsso0nf/xG
         ZxZj0B+cM4IhqJGvjxjZICST9oIDzUdnQtqjdyfYEgJfhh7ik+skGjBPGjTPVDd2fQis
         zakMvUZCP+ccrfY7Rfvgh2SYZZvUE/v6HOs10PWBL35Pz8yvTcQcDhZkcz4gykz2LBLo
         iU1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=T4xdeoEYQ80F95dRAon1aJH93hWkTPzim01gPeyEbyU=;
        b=XDe7MjinIQAqGjECPgiK1aIZioVqs8HdzkIrZcFLB3iYRs0EGN74pOcOCY3gFOyutR
         Q0u/rmL3/XpqK0q+lj4cHNsPYKIMz8l7KMjI0X0U07S0yZiw7xX0cmE2PX9oAmjXjO5A
         jH1Rl8X+dD2A1D+Zp96eoCSa/ookK+lBM65Z4wOqafh6Jema4T5oq8MA2Vq5G7ihRJc6
         GyvZx3OmMNRNWSFPv86dyR9746AC6bjNtJfCiGmOJ2syjcbvYs9Abh8ZBztEcxuCT3Ub
         9ckjYjF/NDVpEfRkofdq45hBSN+iInq/D8toiOmPxejOJ/+xwfiAstHXRukREUuik7gy
         nIcQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AIpwx4/gibErSxOlIOOGDctHIMVo5YKUlPYKia0BWAP9pT0TCNW1xGh/Ik1eExG3bFjvuBC8UHW+Yg==
Date: Mon, 16 Apr 2018 16:28:12 -0500
From: Rob Herring <robh@kernel.org>
To: Jolly Shah <jolly.shah@xilinx.com>
Cc: ard.biesheuvel@linaro.org, mingo@kernel.org, gregkh@linuxfoundation.org,
	matt@codeblueprint.co.uk, sudeep.holla@arm.com,
	hkallweit1@gmail.com, keescook@chromium.org,
	dmitry.torokhov@gmail.com, mturquette@baylibre.com,
	sboyd@codeaurora.org, michal.simek@xilinx.com, mark.rutland@arm.com,
	linux-clk@vger.kernel.org, rajanv@xilinx.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Jolly Shah <jollys@xilinx.com>
Subject: Re: [PATCH v6 10/11] dt-bindings: clock: Add bindings for ZynqMP
 clock driver
Message-ID: <20180416212812.abmxy23r5peiwbik@rob-hp-laptop>
References: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
 <1523389127-14243-11-git-send-email-jollys@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523389127-14243-11-git-send-email-jollys@xilinx.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597389325116534911?=
X-GMAIL-MSGID: =?utf-8?q?1597939745157644160?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 12:38:46PM -0700, Jolly Shah wrote:
> From: Rajan Vaja <rajanv@xilinx.com>
> 
> Add documentation to describe Xilinx ZynqMP clock driver
> bindings.
> 
> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> ---
>  .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |  53 ++++++++++
>  include/dt-bindings/clock/xlnx,zynqmp-clk.h        | 116 +++++++++++++++++++++
>  2 files changed, 169 insertions(+)
>  create mode 100644 include/dt-bindings/clock/xlnx,zynqmp-clk.h

One nit, otherwise:

Reviewed-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> index 1b431d9..ee8d0b0 100644
> --- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> @@ -17,6 +17,53 @@ Required properties:
>  		  - "smc" : SMC #0, following the SMCCC
>  		  - "hvc" : HVC #0, following the SMCCC
>  
> +--------------------------------------------------------------------------
> +Device Tree Clock bindings for the Zynq Ultrascale+ MPSoC controlled using
> +Zynq MPSoC firmware interface
> +--------------------------------------------------------------------------
> +The clock controller is a h/w block of Zynq Ultrascale+ MPSoC clock
> +tree. It reads required input clock frequencies from the devicetree and acts
> +as clock provider for all clock consumers of PS clocks.
> +
> +See clock_bindings.txt for more information on the generic clock bindings.
> +
> +Required properties:
> + - #clock-cells:	Must be 1
> + - compatible:		Must contain:	"xlnx,zynqmp-clk"
> + - clocks:		List of clock specifiers which are external input
> +			clocks to the given clock controller. Please refer
> +			the next section to find the input clocks for a
> +			given controller.
> + - clock-names:		List of clock names which are exteral input clocks
> +			to the given clock controller. Please refer to the
> +			clock bindings for more details.
> +
> +Input clocks for zynqmp Ultrascale+ clock controller:
> +
> +The Zynq UltraScale+ MPSoC has one primary and four alternative reference clock
> +inputs. These required clock inputs are:
> + - pss_ref_clk (PS reference clock)
> + - video_clk (reference clock for video system )
> + - pss_alt_ref_clk (alternative PS reference clock)
> + - aux_ref_clk
> + - gt_crx_ref_clk (transceiver reference clock)
> +
> +The following strings are optional parameters to the 'clock-names' property in
> +order to provide an optional (E)MIO clock source:
> + - swdt0_ext_clk
> + - swdt1_ext_clk
> + - gem0_emio_clk
> + - gem1_emio_clk
> + - gem2_emio_clk
> + - gem3_emio_clk
> + - mio_clk_XX		# with XX = 00..77
> + - mio_clk_50_or_51	#for the mux clock to gem tsu from 50 or 51
> +
> +
> +Output clocks are registered based on clock information received
> +from firmware. Output clocks indexes are mentioned in
> +include/dt-bindings/clock/xlnx,zynqmp-clk.h.
> +
>  -------
>  Example
>  -------
> @@ -25,5 +72,11 @@ firmware {
>  	zynqmp_firmware: zynqmp-firmware {
>  		compatible = "xlnx,zynqmp-firmware";
>  		method = "smc";
> +		clk: clk {

clock-controller {

> +			#clock-cells = <1>;
> +			compatible = "xlnx,zynqmp-clk";
> +			clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
> +			clock-names = "pss_ref_clk", "video_clk", "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
> +		};
>  	};
>  };
