Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759103AbeD0TxY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 15:53:24 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:41716 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759055AbeD0TxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 15:53:20 -0400
X-Google-Smtp-Source: AB8JxZp7k20GsjtwnShR4+asRMvmG6FE599Ef4lARZv2JIQMDa2lJyc+WmQmR+zJVP/kGkcJPvKo7w==
Date: Fri, 27 Apr 2018 14:53:19 -0500
From: Rob Herring <robh@kernel.org>
To: Eric Anholt <eric@anholt.net>
Cc: dri-devel@lists.freedesktop.org, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: Add a new binding for Broadcom V3D
 3.x and newer GPUs.
Message-ID: <20180427195318.s5bzwplylk3uwou4@rob-hp-laptop>
References: <20180424004610.4637-1-eric@anholt.net>
 <20180424004610.4637-3-eric@anholt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424004610.4637-3-eric@anholt.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 05:46:09PM -0700, Eric Anholt wrote:
> These OpenGL ES GPUs are present in the 7268 and 7278 set top box
> chips.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  .../bindings/display/brcm,bcm-v3d.txt         | 28 +++++++++++++++++++

Does this have display h/w? If not bindings/gpu/ would be more 
appropriate.

>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm-v3d.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/brcm,bcm-v3d.txt b/Documentation/devicetree/bindings/display/brcm,bcm-v3d.txt
> new file mode 100644
> index 000000000000..1c814714de0e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/brcm,bcm-v3d.txt
> @@ -0,0 +1,28 @@
> +Broadcom V3D GPU
> +
> +Only the Broadcom V3D 3.x and newer GPUs are covered by this binding.
> +For V3D 2.x, see brcm,bcm-vc4.txt.
> +
> +Required properties:
> +- compatible:	Should be "brcm,7268-v3d" or "brcm,7278-v3d"
> +- reg:		Physical base addresses and lengths of the register areas
> +- reg-names:	Names for the register areas.  The "hub", "bridge", and "core0"
> +		  register areas are always required.  The "gca" register area
> +		  is required if the GCA cache controller is present.
> +- interrupts:	The interrupt numbers.  The first interrupt is for the hub,
> +		  while the following inerrupts are for the cores.

typo

> +		  See bindings/interrupt-controller/interrupts.txt
> +
> +Optional properties:
> +- clocks:	The core clock the unit runs on
> +
> +v3d {
> +	compatible = "brcm,7268-v3d";
> +	reg = <0xf1204000 0x100>,
> +	      <0xf1200000 0x4000>,
> +	      <0xf1208000 0x4000>,
> +	      <0xf1204100 0x100>;
> +	reg-names = "bridge", "hub", "core0", "gca";
> +	interrupts = <0 78 4>,
> +		     <0 77 4>;
> +};
> -- 
> 2.17.0
> 
