Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751749AbeDYJB0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 05:01:26 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:37420 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751705AbeDYJBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 05:01:22 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Philippe Cornu <philippe.cornu@st.com>
Cc: Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yannick Fertre <yannick.fertre@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [PATCH v2 1/2] dt-bindings/display/bridge: sii902x: add optional power supplies
Date: Wed, 25 Apr 2018 12:01:35 +0300
Message-ID: <16954794.QiYqgNKfkn@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180425075314.19137-2-philippe.cornu@st.com>
References: <20180425075314.19137-1-philippe.cornu@st.com> <20180425075314.19137-2-philippe.cornu@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philippe,

Thank you for the patch.

On Wednesday, 25 April 2018 10:53:13 EEST Philippe Cornu wrote:
> Add optional power supplies using the description found in
> "SiI9022A/SiI9024A HDMI Transmitter Data Sheet (August 2016)".
> 
> There is a single 1v2 supply voltage named vcc12 from which cvcc12
> (digital core) and avcc12 (TMDS analog) are derived because according
> to this data sheet:
> "cvcc12 and avcc12 can be derived from the same power source"

Shouldn't the power supplies be mandatory, as explained by Mark in https://
lists.freedesktop.org/archives/dri-devel/2018-April/172400.html ?

> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> ---
>  Documentation/devicetree/bindings/display/bridge/sii902x.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/sii902x.txt
> b/Documentation/devicetree/bindings/display/bridge/sii902x.txt index
> 56a3e68ccb80..9fb41fc9af51 100644
> --- a/Documentation/devicetree/bindings/display/bridge/sii902x.txt
> +++ b/Documentation/devicetree/bindings/display/bridge/sii902x.txt
> @@ -8,6 +8,8 @@ Optional properties:
>  	- interrupts-extended or interrupt-parent + interrupts: describe
>  	  the interrupt line used to inform the host about hotplug events.
>  	- reset-gpios: OF device-tree gpio specification for RST_N pin.
> +	- iovcc-supply: I/O supply voltage (1.8V or 3.3V, host-dependent).
> +	- vcc12-supply: TMDS analog & digital core supply voltage (1.2V).
> 
>  Optional subnodes:
>  	- video input: this subnode can contain a video input port node

-- 
Regards,

Laurent Pinchart
