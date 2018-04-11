Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753393AbeDKOqR convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 10:46:17 -0400
Received: from mail-out-2.itc.rwth-aachen.de ([134.130.5.47]:47845 "EHLO
        mail-out-2.itc.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752901AbeDKOqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 10:46:16 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2ACAwBZHM5a/5kagoZcHQEBBQELAYJvU?=
 =?us-ascii?q?1N9KAqLWY0SgXSBD5JhgXoLhQMCglAhNBgBAgEBAQEBAQJsKIUjAQV5EAIBCBg?=
 =?us-ascii?q?JJQ8BIiUCBAENBYUNAQOpJohFgh+FVIIagVU+gQyDBIRvhVQCjDaLJgh0lQKFB?=
 =?us-ascii?q?Y9oAgICAgkCFIElHDiBUk0kgxGCSI4Gb4wgAYEWAQE?=
X-IPAS-Result: =?us-ascii?q?A2ACAwBZHM5a/5kagoZcHQEBBQELAYJvU1N9KAqLWY0SgXS?=
 =?us-ascii?q?BD5JhgXoLhQMCglAhNBgBAgEBAQEBAQJsKIUjAQV5EAIBCBgJJQ8BIiUCBAENB?=
 =?us-ascii?q?YUNAQOpJohFgh+FVIIagVU+gQyDBIRvhVQCjDaLJgh0lQKFBY9oAgICAgkCFIE?=
 =?us-ascii?q?lHDiBUk0kgxGCSI4Gb4wgAYEWAQE?=
X-IronPort-AV: E=Sophos;i="5.48,436,1517871600";
   d="scan'208";a="42785840"
From: =?iso-8859-1?Q?Br=FCns=2C_Stefan?= <Stefan.Bruens@rwth-aachen.de>
To: "linux-sunxi@googlegroups.com" <linux-sunxi@googlegroups.com>,
        "icenowy@aosc.io" <icenowy@aosc.io>
CC: Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [linux-sunxi] [PATCH 1/5] dt-bindings: allow dwmac-sun8i to use
 other devices' exported regmap
Thread-Topic: [linux-sunxi] [PATCH 1/5] dt-bindings: allow dwmac-sun8i to use
 other devices' exported regmap
Thread-Index: AQHT0aA4DI3iB5OYJUWa6ikrqoHSlqP7gCGA
Date: Wed, 11 Apr 2018 14:36:19 +0000
Message-ID: <2600251.cZke1zkLXN@sbruens-linux>
References: <20180411141641.14675-1-icenowy@aosc.io>
 <20180411141641.14675-2-icenowy@aosc.io>
In-Reply-To: <20180411141641.14675-2-icenowy@aosc.io>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [78.35.13.203]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <D7F87D293F40A54E820A5050931C2521@rwth-ad.de>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mittwoch, 11. April 2018 16:16:37 CEST Icenowy Zheng wrote:
> On some Allwinner SoCs the EMAC clock register needed by dwmac-sun8i is
> in another device's memory space. In this situation dwmac-sun8i can use
> a regmap exported by the other device with only the EMAC clock register.
> 
> Document this situation in the dwmac-sun8i device tree binding
> documentation.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  Documentation/devicetree/bindings/net/dwmac-sun8i.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
> b/Documentation/devicetree/bindings/net/dwmac-sun8i.txt index
> 3d6d5fa0c4d5..0c5f63a80617 100644
> --- a/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
> +++ b/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
> @@ -20,8 +20,9 @@ Required properties:
>  - phy-handle: See ethernet.txt
>  - #address-cells: shall be 1
>  - #size-cells: shall be 0
> -- syscon: A phandle to the syscon of the SoC with one of the following
> - compatible string:
> +- syscon: A phandle to a device which exports the EMAC clock register as a
> + regmap or to the syscon of the SoC with one of the following compatible
.. regmap, or ...

> + string:
string_s_:

>    - allwinner,sun8i-h3-system-controller
>    - allwinner,sun8i-v3s-system-controller
>    - allwinner,sun50i-a64-system-controller

Kind regards,

Stefan
