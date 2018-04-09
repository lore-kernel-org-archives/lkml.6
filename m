Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754967AbeDIUKf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 16:10:35 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:40463 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754943AbeDIUK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 16:10:29 -0400
X-Google-Smtp-Source: AIpwx4+Nnn3n0lclk/VUejSDgd6otkt3Jeoj7usZzkqHP4BaoyoDkbeAGMWYcwvJJgn1fn1H+frINw==
Date: Mon, 9 Apr 2018 15:10:27 -0500
From: Rob Herring <robh@kernel.org>
To: Michel Pollet <michel.pollet@bp.renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        phil.edworthy@renesas.com, Michel Pollet <buserror+upstream@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/8] DT: reset: renesas,rzn1-reboot: document RZ/N1
 reboot driver
Message-ID: <20180409201027.ydlvyx72mrt5fphh@rob-hp-laptop>
References: <1522309629-10152-1-git-send-email-michel.pollet@bp.renesas.com>
 <1522309629-10152-3-git-send-email-michel.pollet@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522309629-10152-3-git-send-email-michel.pollet@bp.renesas.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 08:46:58AM +0100, Michel Pollet wrote:
> The Renesas RZ/N1 Family (Part #R9A06G0xx) requires a driver
> as part of the sysctrl MFD to handle rebooting the CA7 cores.
> This documents the driver bindings.
> 
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> ---
>  .../bindings/power/renesas,rzn1-reboot.txt           | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/renesas,rzn1-reboot.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/renesas,rzn1-reboot.txt b/Documentation/devicetree/bindings/power/renesas,rzn1-reboot.txt
> new file mode 100644
> index 0000000..f592769
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/renesas,rzn1-reboot.txt
> @@ -0,0 +1,20 @@
> +DT bindings for the Renesas RZ/N1 Reboot Driver
> +
> +== Reboot Driver Node ==
> +
> +The reboot driver is always a subnode of the system controller node, see
> +renesas,rzn1-sysctrl.txt for details.
> +
> +Bindings:
> ++ Required:
> +	compatible = "renesas,rzn1-reboot";
> +
> +Example:
> +	sysctrl: sysctrl@4000c000 {
> +		compatible = "renesas,rzn1-sysctrl", "syscon", "simple-mfd";

Are there other functions for this block? If so, please define a 
complete binding for the block.

> +		reg = <0x4000c000 0x1000>;
> +
> +		reboot {
> +			compatible = "renesas,rzn1-reboot";

Why is this node needed? The driver for "renesas,rzn1-sysctrl" should 
be able to register as a reboot handler/driver/provider.

Rob
