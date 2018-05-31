Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932646AbeEaAxI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 20:53:08 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:40840 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932451AbeEaAxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 20:53:05 -0400
X-Google-Smtp-Source: ADUXVKIrTHNUdkpwfIOHAJrERQJS6O3dakITn98JX0WlXMXNe5VcJUTaxck95Io/ZP/kib0xXsNlWA==
Date: Wed, 30 May 2018 19:53:02 -0500
From: Rob Herring <robh@kernel.org>
To: Dong Aisheng <aisheng.dong@nxp.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, sboyd@kernel.org,
        mturquette@baylibre.com, shawnguo@kernel.org, Anson.Huang@nxp.com,
        ping.bai@nxp.com, linux-imx@nxp.com,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@codeaurora.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND V4 6/9] dt-bindings: clock: add imx7ulp clock
 binding doc
Message-ID: <20180531005302.GA13776@rob-hp-laptop>
References: <1527234671-31755-1-git-send-email-aisheng.dong@nxp.com>
 <1527234671-31755-7-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527234671-31755-7-git-send-email-aisheng.dong@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 03:51:08PM +0800, Dong Aisheng wrote:
> i.MX7ULP Clock functions are under joint control of the System
> Clock Generation (SCG) modules, Peripheral Clock Control (PCC)
> modules, and Core Mode Controller (CMC)1 blocks
> 
> Note IMX7ULP has two clock domains: M4 and A7. This binding doc
> is only for A7 clock domain.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Anson Huang <Anson.Huang@nxp.com>
> Cc: Bai Ping <ping.bai@nxp.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> 
> ---
> ChangeLog:
> v2->v3:
>  * no changes
> v1->v2: no changes
> ---
>  .../devicetree/bindings/clock/imx7ulp-clock.txt    |  62 ++++++++++++
>  include/dt-bindings/clock/imx7ulp-clock.h          | 105 +++++++++++++++++++++
>  2 files changed, 167 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
>  create mode 100644 include/dt-bindings/clock/imx7ulp-clock.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt b/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
> new file mode 100644
> index 0000000..76ea3c7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
> @@ -0,0 +1,62 @@
> +* Clock bindings for Freescale i.MX7ULP
> +
> +i.MX7ULP Clock functions are under joint control of the System
> +Clock Generation (SCG) modules, Peripheral Clock Control (PCC)
> +modules, and Core Mode Controller (CMC)1 blocks
> +
> +The clocking scheme provides clear separation between M4 domain
> +and A7 domain. Except for a few clock sources shared between two
> +domains, such as the System Oscillator clock, the Slow IRC (SIRC),
> +and and the Fast IRC clock (FIRCLK), clock sources and clock
> +management are separated and contained within each domain.
> +
> +M4 clock management consists of SCG0, PCC0, PCC1, and CMC0 modules.
> +A7 clock management consists of SCG1, PCC2, PCC3, and CMC1 modules.
> +
> +Note: this binding doc is only for A7 clock domain.
> +
> +Required properties:
> +
> +- compatible:	Should be "fsl,imx7ulp-clock".
> +- reg : 	Should contain registers location and length for scg1,
> +		pcc2 and pcc3.
> +- reg-names:	Should contain the according reg names "scg1", "pcc2"
> +		and "pcc3".

Sounds like separate blocks. These should each be their own node and 
binding.
