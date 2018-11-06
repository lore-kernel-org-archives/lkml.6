Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A04DC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 013C820818
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ochU3cbz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 013C820818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbeKFWyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:54:37 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:51895 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730470AbeKFWyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 17:54:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=5xStelAygbaRUd73prMzRwqglE4IXVGwqJUuZt8/dd0=;
        b=ochU3cbzmrIMKLhZlybINF8Z+tHttnDU964PDK/NkTrOqUyAtlHFKU29cdWiY5ZbsUUvkaMTIvDAD5WGORlIYjZ2AM51R3tIPPYHhIn+6UC73fCwnCLAZt7bHu8cMc6pEsXMK+HgnGdYLMOA214kcOwO2KvU4LJA/qbHnXwTJ7M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gK1Po-00028n-3p; Tue, 06 Nov 2018 14:29:08 +0100
Date:   Tue, 6 Nov 2018 14:29:08 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florinel Iordache <florinel.iordache@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [bindings][PATCH] bindings/net: DPAA Backplane Device Bindings
Message-ID: <20181106132908.GA30774@lunn.ch>
References: <1541504900-30091-1-git-send-email-florinel.iordache@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541504900-30091-1-git-send-email-florinel.iordache@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 11:48:30AM +0000, Florinel Iordache wrote:
> Device Tree Bindings for DPAA backplane available on Layerscape
>  communications processors.
> 
> Signed-off-by: Florinel Iordache <florinel.iordache@nxp.com>
> ---
>  .../devicetree/bindings/net/dpaa-backplane.txt     | 105 +++++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/dpaa-backplane.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/dpaa-backplane.txt b/Documentation/devicetree/bindings/net/dpaa-backplane.txt
> new file mode 100644
> index 0000000..f147c84
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/dpaa-backplane.txt
> @@ -0,0 +1,105 @@
> +=============================================================================
> +DPAA Backplane Device Bindings
> +
> +CONTENTS
> +  - SerDes Node
> +  - PCS Phy Node
> +
> +=============================================================================
> +SerDes Node
> +
> +DESCRIPTION
> +
> +SerDes (Serializer/Deserializer) HW peripheral
> +

Hi Florinel

It is normal to indicate which properties are required, and which are
optional using the section headers. There is a defacto standard for
the format of a device tree binding, and this text does not follow it.

> +PROPERTIES
> +
> +- compatible
> +		Usage: required
> +		Value type: <stringlist>
> +		Definition: Specifies the type of SerDes.
> +		Must include the prefix "fsl,serdes"
> +		SerDes can be of different types:
> +		- 10G SerDes must be specified as: "fsl,serdes-10g"
> +		- 28G SerDes must be specified as: "fsl,serdes-28g"

Does a different driver get loaded depending on the compatible? I'm
just wondering if there should be one compatible string, and a speed
property.

> +
> +- reg
> +		Usage: required
> +		Value type: <prop-encoded-array>
> +		Definition: Specifies the offset of the SerDes configuration registers
> +
> +- little-endian
> +		Usage: optional
> +		Value type: <Boolean>
> +		Definition: Specifies endianness access to SerDes registers.
> +		If omitted, big-endian will be used
> +		See common-properties.txt for complete definition
> +
> +EXAMPLE
> +
> +Example of 10G SerDes node:
> +
> +serdes1: serdes@1ea0000 {
> +		compatible = "fsl,serdes-10g";
> +		reg = <0x0 0x1ea0000 0 0x00002000>;
> +		little-endian;
> +};
> +
> +=============================================================================
> +PCS Phy Node
> +
> +DESCRIPTION
> +
> +PCS Phy (Physical Coding Sublayer / Physical layer) node
> +
> +PROPERTIES
> +
> +- compatible
> +		Usage: required

This is normally optional, and defaults to c22 if not present.

> +		Value type: <stringlist>
> +		Definition: A standard property. Specifies the IEEE 802.3 Clause
> +		Different IEEE 802.3 Clauses can be specified:
> +		- Clause 22 must be specified as: "ethernet-phy-ieee802.3-c22"
> +		- Clause 45 must be specified as: "ethernet-phy-ieee802.3-c45"
> +		For complete definition see:
> +		Documentation/devicetree/bindings/net/phy.txt
> +
> +- reg
> +		Usage: required
> +		Value type: <prop-encoded-array>
> +		Definition: A standard property.
> +		Specifies the offset of the PCS Phy configuration registers
> +		For complete definition see:
> +		Documentation/devicetree/bindings/net/phy.txt

Rather than state what is already in phy.txt, just say that the
following additional properties can be used:

> +
> +- backplane-mode
> +		Usage: required

So your PHYs can only be used in backplane-mode? Base-T is never
supported?

> +		Value type: <stringlist>
> +		Definition: Specifies the speed and type of the protocol used
> +		Different speeds and backplane protocol types can be used:
> +		- 10GBase-KR must be specified as: "10gbase-kr"
> +		- 40GBase-KR must be specified as: "40gbase-kr"

I don't see why this is needed. The PHY driver should know what speeds
the PHY supports. You might want to make use of the standard max-speed
property to prevent it doing a high speed, because of layout issues,
etc.

> +
> +- fsl,lane-handle
> +		Usage: required
> +		Value type: <phandle>
> +		Definition: Specifies the reference to a node representing the SerDes
> +		device
> +
> +- fsl,lane-reg
> +		Usage: required
> +		Value type: <prop-encoded-array>
> +		Definition: Specifies the offsets of the SerDes lanes configuration
> +		registers

No other PHY driver we have needs such properties. Why are these
needed?

It is also a bit ununsed to post a binding without the code. Maybe the
code for these two drivers will help me understand.

     Thanks
	Andrew
