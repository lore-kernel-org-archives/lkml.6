Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0676AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55E12082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C55E12082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbeK0JDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 04:03:40 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41179 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbeK0JDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 04:03:40 -0500
Received: by mail-oi1-f195.google.com with SMTP id j21so17404537oii.8;
        Mon, 26 Nov 2018 14:08:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q3eyIsvlE49HApDccdE4UsL3hXu9tBjvTS3qK3i6Wc4=;
        b=VlZ6rwtLDfKLDa3YeIQ3IcnaQ67R/A7ki1dJBmJ6cDal8uhrUkCTvCYgpHtmV2LU1E
         qXQnrUPHutXJxbbLNWmSE3APlo5OBnT911wdNRi5Y32xQKJk+KeOqPYsRIF5/Se8jApT
         C+vPbufJL2vaRiNX7CmGsJZvGBThc121Zex1n02gkW70XyFcI8MP9tXjHz1kSbvXdIsp
         H5VywCprsV0MoT2D4kDWIwbeWisyGDgv3Kj7MdNJxHOGOB8dDGACK/4u0GfkuDNSGEsy
         OIZW1xXL6chhhpPmN+nHmknpi22fgVdzcDZOQ9uEF5qG9ohEwgBAjbTnHdVvF2QTtK1X
         inMA==
X-Gm-Message-State: AGRZ1gJ2pQRy5em6bGurtL4yDM7jm3mbhgs8EnjwzRs8fhUD81sWrj9o
        RaNTH+rCMLlCiUWgCljYNA==
X-Google-Smtp-Source: AJdET5fGwzMsr3pxVZoa4T/ZnevV7kGtf1LNnLRpBNuC/qEtf0z+SFVliuOmyC1Id+aHUNR1JLak5w==
X-Received: by 2002:aca:5cc6:: with SMTP id q189-v6mr17100455oib.121.1543270085794;
        Mon, 26 Nov 2018 14:08:05 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o2sm1165928otj.2.2018.11.26.14.08.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 14:08:05 -0800 (PST)
Date:   Mon, 26 Nov 2018 16:08:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     thesven73@gmail.com
Cc:     svendev@arcx.com, linus.walleij@linaro.org, lee.jones@linaro.org,
        mark.rutland@arm.com, afaerber@suse.de, treding@nvidia.com,
        david@lechnology.com, noralf@tronnes.org, johan@kernel.org,
        monstr@monstr.eu, michal.vokac@ysoft.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, maxime.ripard@bootlin.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH anybus v4 6/7] dt-bindings: anybuss-host: document
 devicetree binding
Message-ID: <20181126220804.GA23069@bogus>
References: <20181121150709.6030-1-TheSven73@googlemail.com>
 <20181121150709.6030-7-TheSven73@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121150709.6030-7-TheSven73@googlemail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 10:07:08AM -0500, thesven73@gmail.com wrote:
> This patch adds devicetree binding documentation for the
> Arcx Anybus-S host.
> 
> Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
> ---
>  .../bindings/fieldbus/arcx,anybuss-host.txt   | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fieldbus/arcx,anybuss-host.txt
> 
> diff --git a/Documentation/devicetree/bindings/fieldbus/arcx,anybuss-host.txt b/Documentation/devicetree/bindings/fieldbus/arcx,anybuss-host.txt
> new file mode 100644
> index 000000000000..456587f288c1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fieldbus/arcx,anybuss-host.txt
> @@ -0,0 +1,66 @@
> +* Arcx Anybus-S host
> +
> +This host communicates with the SoC over a parallel bus. It is
> +expected that its Device Tree node is specified as the child of a node
> +corresponding to the parallel bus used for communication.
> +
> +Required properties:
> +--------------------
> +
> +  - compatible : The following string:
> +        "arcx,anybuss-host"
> +
> +  - reg : bus memory area where the Anybus-S host dpram is located.
> +
> +  - interrupts : interrupt connected to the Anybus-S host interrupt line.
> +	Generic interrupt client node bindings are described in
> +		interrupt-controller/interrupts.txt
> +
> +  - resets : the reset line associated with the Anybus-S host.
> +
> +Optional: use of subnodes
> +-------------------------
> +
> +The card connected to a host may need additional properties. These can be
> +specified in subnodes to the host node.
> +
> +The subnodes are identified by the standard 'reg' property. Which information
> +exactly can be specified depends on the bindings for the function driver
> +for the subnode.
> +
> +Required host node properties when using subnodes:
> +- #address-cells: should be one.
> +- #size-cells: should be zero.
> +
> +Required subnode properties:
> +- reg: Must contain the fieldbus type of the card this subnode describes.
> +
> +Example of usage:
> +-----------------
> +
> +This example places the Anybus-S host on top of the i.MX WEIM parallel bus, see:
> +Documentation/devicetree/bindings/bus/imx-weim.txt
> +
> +&weim {
> +	anybus-host@0 {
> +		compatible = "arcx,anybuss-host";
> +		reg = <0 0x400000 0x800>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
> +		resets = <&anybus_bridge 0>;

I'm still not clear what a bridge vs. host is. Both examples are on WEIM 
bus CS0?

> +		/* fsl,weim-cs-timing is a i.MX WEIM bus specific property */
> +		fsl,weim-cs-timing = <0x024400b1 0x00001010 0x20081100
> +				0x00000000 0xa0000240 0x00000000>;
> +		/*
> +		 * optional subnode for a profinet card
> +		 * (fieldbus type = 0x0089)
> +		 */
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		profinet@0 {

Unit-addresses are based on 'reg'. So this should either be '89' or 
based on a definition for the bus (e.g. PCI uses dev and func).

> +			reg = <0x0089>;

Is fieldbus type how one addresses a device on the bus?

> +			/* profinet specific properties go here */
> +		};
> +	};
> +
> +};
> -- 
> 2.17.1
> 
