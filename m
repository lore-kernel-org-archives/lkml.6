Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752848AbeDSITt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 04:19:49 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:34270 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbeDSITq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 04:19:46 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Philippe Cornu <philippe.cornu@st.com>
Cc: Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yannick Fertre <yannick.fertre@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [PATCH 1/2] dt-bindings/display/bridge: sii902x: add optional power supplies
Date: Thu, 19 Apr 2018 11:11:26 +0300
Message-ID: <20599695.GSkeUvMnvx@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180410051927.8268-2-philippe.cornu@st.com>
References: <20180410051927.8268-1-philippe.cornu@st.com> <20180410051927.8268-2-philippe.cornu@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philippe,

Thank you for the patch.

On Tuesday, 10 April 2018 08:19:26 EEST Philippe Cornu wrote:
> Add the 3 optional power supplies using the exact description
> found in the document named
> "SiI9022A/SiI9024A HDMI Transmitter Data Sheet (August 2016)".
> 
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> ---
>  Documentation/devicetree/bindings/display/bridge/sii902x.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/sii902x.txt
> b/Documentation/devicetree/bindings/display/bridge/sii902x.txt index
> 56a3e68ccb80..cf53678fe574 100644
> --- a/Documentation/devicetree/bindings/display/bridge/sii902x.txt
> +++ b/Documentation/devicetree/bindings/display/bridge/sii902x.txt
> @@ -8,6 +8,9 @@ Optional properties:
>  	- interrupts-extended or interrupt-parent + interrupts: describe
>  	  the interrupt line used to inform the host about hotplug events.
>  	- reset-gpios: OF device-tree gpio specification for RST_N pin.
> +	- iovcc-supply: I/O supply voltage (1.8V or 3.3V, host-dependent).
> +	- avcc12-supply: TMDS analog supply voltage (1.2V).
> +	- cvcc12-supply: Digital core supply voltage (1.2V).

It seems that the AVCC12 and CVCC12 power supplies are usually derived from 
the same source. How about starting with one DT property for both, and adding 
a second one later if needed ?

>  Optional subnodes:
>  	- video input: this subnode can contain a video input port node

-- 
Regards,

Laurent Pinchart
