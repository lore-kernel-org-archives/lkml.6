Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70572C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3562B2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550878657;
	bh=1CRNLvT+27cDItA/N3Dn10xLSX9UrBz2TslIss71tx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ltgyYPAVsZzr1K5gvv77CPe0NOZnd+OvN6Gv0kuklljBAKS57ltCHq6evzlK6flWi
	 A2VpebpGLwBedzUaOC1PuuyiDU2iAyQ6ET/SwEp/zqoTXypgPYPVSKM0fU/E+aC4za
	 T/mxvPVPN5//uD3RYoQvbs10yxiLkj80bLEFzVek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfBVXhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:37:36 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34008 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfBVXhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:37:35 -0500
Received: by mail-oi1-f194.google.com with SMTP id g16so3107144oib.1;
        Fri, 22 Feb 2019 15:37:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TXwjQ2b7Jw3X1MBD87UlddaI6hJT6VW9GD6LgD5VUJE=;
        b=PzRQ8Mw6a/hALvvytyMf10YDwl/tGv3U3HsCIfvePg/UGLQlOWspHY14tcJ7pmS3q3
         gEO+nUGK45sLdu9SaCNufqG3KnBhgsGoA/3+emIf5I/7GlHG8VlZrtDMSoCTO6doN4jq
         I1fTt5wTS5Wtily7nODlAyohCT7x5C1EcGI74EggLYgODfzpXfMZOKj5X8N3DqiWO1Ah
         LF7Qju21lOkHdq0Cpqhib1R9egEEy5640xwerIyTj7fT/xe5VBgBthIiZG+N8LKccWIj
         uoCsfb2eIcEbDil5zJTSKncea8Su7xPeMbB2XMiTL4UF3PHQxyCHtYR58sPQo9d+9WaB
         K3uw==
X-Gm-Message-State: AHQUAua3csKgxr4Ae54QHFq4LedIwpmb97hiS8G3/MdQSuRcfM41jA0X
        Iiv+QDCfCsCnglYe+uOCVTdxIec=
X-Google-Smtp-Source: AHgI3Ia5vCL+Al2a75f8dpb0twRi8Zctlq8hLuPr9oUT72Hqa2YgKPAsIkQsGuoRaqtxZWBTxIb6Rw==
X-Received: by 2002:aca:75cf:: with SMTP id q198mr4134244oic.125.1550878653778;
        Fri, 22 Feb 2019 15:37:33 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l134sm1185756oih.43.2019.02.22.15.37.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 15:37:33 -0800 (PST)
Date:   Fri, 22 Feb 2019 17:37:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Manoil <claudiu.manoil@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        alexandru.marginean@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/4] dt-bindings: net: freescale: enetc: Add
 connection bindings for ENETC ethernet nodes
Message-ID: <20190222233732.GA1518@bogus>
References: <1550847859-17346-1-git-send-email-claudiu.manoil@nxp.com>
 <1550847859-17346-5-git-send-email-claudiu.manoil@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550847859-17346-5-git-send-email-claudiu.manoil@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 05:04:19PM +0200, Claudiu Manoil wrote:
> Define connection bindings (external PHY connections and internal links)
> for the ENETC on-chip ethernet controllers.
> 
> Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> ---
> v3 - added this patch to the set
> 
>  .../devicetree/bindings/net/fsl-enetc.txt          | 109 +++++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/fsl-enetc.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/fsl-enetc.txt b/Documentation/devicetree/bindings/net/fsl-enetc.txt
> new file mode 100644
> index 0000000..2fbb998
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/fsl-enetc.txt
> @@ -0,0 +1,109 @@
> +* ENETC ethernet nodes - external connection bindings
> +
> +The ENETC ethernet controllers are PCIe integrated endpoints
> +(IEPs), on-chip devices discoverable as standard PCIe endpoints,
> +integrated into Freescale SoCs.  The ENETC devices are self
> +contained, the information needed for device initialization
> +is available in hardware (PCIe ECAM area).  However, depending
> +on board design, their external connections are configurable.
> +As usual for SoCs, device tree nodes may be used to define these
> +external connections.  The rest of the document specifies how
> +external connections for ENETC ethernet controllers may be
> +defined via device tree nodes.
> +
> +Silicon (SoC) availability (<SoC name>: <SoC DT path/name>)
> +	- LS1028A: [arch/arm64]	[...]freescale/fsl-ls1028a.dtsi

This doesn't belong in bindings.

> +
> +
> +* ENETC nodes
> +
> +Defined in the SoC device tree as "pci" child nodes of the
> +"pci-host-ecam-generic" compatible "pcie" parent node also known
> +as the Integrated Endpoint Root Complex (IERC) SoC node.

The host controller attachment is also outside the scope of this 
binding.

> +
> +Structure - example (LS1028A):
> +
> +	pcie@1f0000000 {
> +		compatible = "pci-host-ecam-generic";
> +		device_type = "pci";
> +		...
> +		enetc_port0: pci@0,0 {

The node name 'pci' is reserved for bridges. This should match the 
device class if possible (ethernet).

> +			reg = <0x000000 0 0 0 0>;
> +		};
> +		enetc_port1: pci@0,1 {
> +			reg = <0x000100 0 0 0 0>;
> +		};
> +		...
> +	}
> +
> +Each ENETC node has a device number and a function number (expressed
> +by its "reg" property and pci node name, i.e. "pci@0,1" represents
> +device number 0 and functions number 1).  Only the standard pci "reg"
> +property is needed here.

There should be a compatible too.

> +For easy reference, each ENETC node is tagged by a handle having the
> +following format:
> +
> +	"enetc_port<idx>"   where, idx = 0 .. n-1;
> +			    n - #of available ENETC nodes (Ports) on
> +				the given SoC.

These are just source labels, so really they can be anything.

> +
> +NOTES
> +i. The SoC H/W Reference Manual provides a mapping of the ENETC Port
> +numbers to the PCIe Device Number/ Function Number.
> +Example (LS1028):
> +	All ENETC PFs (PCIe Physical Functions) have Device Number 0.
> +	Port 0 - PF0 (pci@0,0)
> +	Port 1 - PF1 (pci@0,1)
> +	Port 2 - PF2 (pci@0,2)
> +	Port 3 - PF6 (pci@0,6)
> +
> +ii. The SoC H/W Reference Manual also defines which ENETC Ports may have
> +external connections (external ports) and which ones are internally
> +connected to a on-chip L2 switch for instance (internal ports).
> +
> +
> +* Defining connections for ENETC nodes
> +
> +To define external connections for the external ENETC Ports on a given
> +board/platform, the board device tree should include the SoC device tree
> +and reference the external ports by their "enetc_port<idx>" handle.

SoC vs. board files are convention, but not really part of the binding 
ABI.

> +
> +Following cases arise, defining all possible connection bindings:
> +
> +1) The ENETC Port is connected to a MDIO configurable PHY:
> +
> +	In this case, the ENETC node should include a "mdio" sub-node
> +	that in turn should contain the "phy" node describing the
> +	external phy.  ENETC Port node structure (example):
> +
> +	&enetc_port0 {

Please just show the full DT example, not separate chunks.

> +		phy-handle = <&sgmii_phy0>;
> +		phy-connection-type = "sgmii";
> +
> +		mdio {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			sgmii_phy0: ethernet-phy@2 {
> +				reg = <0x2>;
> +			};
> +		};
> +	};
> +
> +	All properties are mandatory for this case, their bindings already
> +	defined (see ethernet.txt and phy.txt).
> +
> +2) The ENETC Port has a fixed-link connection:
> +
> +	In this case, the ENETC Port node defines a fixed link connection,
> +	with the following structure (example):
> +
> +	&enetc_port2 {
> +		fixed-link {
> +			speed = <1000>;
> +			full-duplex;
> +		};
> +	};
> +
> +	The "fixed-link" node properties are standard (as defined in
> +	fixed-link.txt).
> +	This connection type also applies to the internal ENETC Ports.
> -- 
> 2.7.4
> 
