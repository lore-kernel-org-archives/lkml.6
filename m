Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932649AbeCEWdc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:33:32 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44152 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752040AbeCEWda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:33:30 -0500
X-Google-Smtp-Source: AG47ELvMBoGDw2YaCVZ9/PkOVcS8Wl30X3dyPXyqHpJncT5bAHJNAAnCzDZT8Gp7NnwWuSaD4HDmhg==
Date: Mon, 5 Mar 2018 16:33:28 -0600
From: Rob Herring <robh@kernel.org>
To: Jolly Shah <jolly.shah@xilinx.com>
Cc: matthias.bgg@gmail.com, andy.gross@linaro.org, shawnguo@kernel.org,
        geert+renesas@glider.be, bjorn.andersson@linaro.org,
        sean.wang@mediatek.com, m.szyprowski@samsung.com,
        michal.simek@xilinx.com, mark.rutland@arm.com, rajanv@xilinx.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jolly Shah <jollys@xilinx.com>
Subject: Re: [PATCH 1/2] dt-bindings: soc: Add ZynqMP PM bindings
Message-ID: <20180305223328.la462hdwwsymvusk@rob-hp-laptop>
References: <1519773866-18196-1-git-send-email-jollys@xilinx.com>
 <1519773866-18196-2-git-send-email-jollys@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519773866-18196-2-git-send-email-jollys@xilinx.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 03:24:25PM -0800, Jolly Shah wrote:
> Add documentation to describe Xilinx ZynqMP power management
> bindings.
> 
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> ---
>  .../bindings/soc/xilinx/xlnx,zynqmp-power.txt      | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/xilinx/xlnx,zynqmp-power.txt
> 
> diff --git a/Documentation/devicetree/bindings/soc/xilinx/xlnx,zynqmp-power.txt b/Documentation/devicetree/bindings/soc/xilinx/xlnx,zynqmp-power.txt
> new file mode 100644
> index 0000000..5b7d963
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/xilinx/xlnx,zynqmp-power.txt
> @@ -0,0 +1,28 @@
> +Xilinx Zynq MPSoC Power Management Device Tree Bindings
> +
> +The zynqmp-power node describes the power management configurations.

That really tells me nothing. What aspect of power management does this 
interface control?

> +
> +Required properties:
> + - compatible	: Must contain:  "xlnx,zynqmp-power"
> + - mbox-names	: Name given to channels seen in the 'mboxes' property.
> +		  "rx" - Mailbox corresponding to receive path
> +		  "tx" - Mailbox corresponding to transmit path
> + - mboxes	: Standard property to specify a Mailbox. Each value of
> +		  the mboxes property should contain a phandle to the
> +		  mailbox controller device node and an args specifier
> +		  that will be the phandle to the intended sub-mailbox
> +		  child node to be used for communication. See
> +		  Documentation/devicetree/bindings/mailbox/mailbox.txt
> +		  for more details about the generic mailbox controller
> +		  and client driver bindings. Also see
> +		  Documentation/devicetree/bindings/mailbox/ \
> +		  xlnx,zynqmp-ipi-mailbox.txt for typical controller that
> +		  is used to communicate with this System controllers.

No need to define a standard property here. Just need to say how many 
entries and refer to the common binding.

> +
> +Examples:
> +	zynqmp_power: zynqmp-power {
> +		compatible = "xlnx,zynqmp-power";
> +		mboxes = <&ipi_mailbox_pmu0 0>,
> +			 <&ipi_mailbox_pmu0 1>;
> +		mbox-names = "tx", "rx";
> +	};
> -- 
> 2.7.4
> 
