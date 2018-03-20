Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753625AbeCTNv2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 09:51:28 -0400
Received: from galahad.ideasonboard.com ([185.26.127.97]:34061 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753395AbeCTNvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 09:51:23 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] dt-bindings: display: bridge: lvds-transmitter: add ti,ds90c185
Date: Tue, 20 Mar 2018 15:52:28 +0200
Message-ID: <4505095.GfTyCNF5lz@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180317221525.18534-2-peda@axentia.se>
References: <20180317221525.18534-1-peda@axentia.se> <20180317221525.18534-2-peda@axentia.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thank you for the patch.

On Sunday, 18 March 2018 00:15:23 EET Peter Rosin wrote:
> Start list of actual chips compatible with "lvds-encoder".
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  .../devicetree/bindings/display/bridge/lvds-transmitter.txt       | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git
> a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> index fd39ad34c383..9d09190d9210 100644
> --- a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> +++ b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> @@ -24,6 +24,11 @@ Required properties:
> 
>  - compatible: Must be "lvds-encoder"
> 
> +	      Known actual chips (these should still use "lvds-encoder" as a
> +	      fallback compatible) include:
> +
> +	      "ti,ds90c185"

The wording sounds a bit strange to me. How about

 - compatible: Must be one or more of the following
   - "ti,ds90c185" for the TI DS90C185 FPD-Link Serializer
   - "lvds-encoder" for a generic LVDS encoder device

   When compatible with the generic version nodes must list the
   device-specific version corresponding to the device first
   followed by the generic version.

>  Required nodes:
> 
>  This device has two video ports. Their connections are modeled using the OF

-- 
Regards,

Laurent Pinchart
