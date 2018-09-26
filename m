Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C458C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FBEA21565
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FBEA21565
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbeI0DuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 23:50:07 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38087 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbeI0DuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 23:50:07 -0400
Received: by mail-oi1-f194.google.com with SMTP id u197-v6so420509oif.5;
        Wed, 26 Sep 2018 14:35:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XpuiZxTm/LyHp68Wieb6rdyIqn1THyhmdL6yKRpa8vY=;
        b=RjTJSa3ZYB2kwVc/nc6mobBg93jCYrKYTN6PuDCNXOwiR5cHhS7yXw2TDZNTIE0iwj
         +gHQnO+t7EZnHQMaqYE0NKSQi50mpv5qlGi+JUOJtCe+K2Oar/YX1/GXBbqtTrM9ekmV
         +b8ORVLjuGlol/guzr86Zrv2LqAekN+OerCdhR9vCEtCi9vJNoNE05hD57K4gNiHFeHc
         1BX8X9lev+RSS4GFSxbkiu7Qm7ur88s7NgpwpTxDCCH/a0patALfqx1IVIQVDlfszWUS
         Qvm00kUkOz2SommEXqnE1VCyEGDPS6kZ2/hqp1c0pkyTHEDvbIAXd7hnXQ52eRmBnXKY
         hhzw==
X-Gm-Message-State: ABuFfogwZ5ZQPwjlItMI+gB2QGr6IA5cEXTY3xTXOMUXihNl6L68R74l
        e/sAYeXysHKZ5XkqIhdrtg==
X-Google-Smtp-Source: ACcGV62UJH5Dzd1JkSxkHJSgwOWCpzSfp3pqKqavLsDYLPGHrfFJxlDJHrTjMOfHf6eGzJJYz/f9lA==
X-Received: by 2002:aca:b154:: with SMTP id a81-v6mr1781307oif.34.1537997711144;
        Wed, 26 Sep 2018 14:35:11 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y26-v6sm44579otk.64.2018.09.26.14.35.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 14:35:10 -0700 (PDT)
Date:   Wed, 26 Sep 2018 16:35:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, mark.rutland@arm.com,
        davem@davemloft.net, kishon@ti.com, andrew@lunn.ch,
        f.fainelli@gmail.com, allan.nielsen@microchip.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next v3 07/11] dt-bindings: phy: add DT binding for
 Microsemi Ocelot SerDes muxing
Message-ID: <20180926213509.GA7454@bogus>
References: <cover.ff40d591b548a6da31716e6e600f11a303e0e643.1536912834.git-series.quentin.schulz@bootlin.com>
 <f392dafca9165800439fc09cd7d16e6a9506d457.1536912834.git-series.quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f392dafca9165800439fc09cd7d16e6a9506d457.1536912834.git-series.quentin.schulz@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 10:16:05AM +0200, Quentin Schulz wrote:
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> ---
>  Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt | 40 +++++++-
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt b/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt
> new file mode 100644
> index 0000000..2a88cc3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt
> @@ -0,0 +1,40 @@
> +Microsemi Ocelot SerDes muxing driver
> +-------------------------------------
> +
> +On Microsemi Ocelot, there is a handful of registers in HSIO address
> +space for setting up the SerDes to switch port muxing.
> +
> +A SerDes X can be "muxed" to work with switch port Y or Z for example.
> +One specific SerDes can also be used as a PCIe interface.
> +
> +Hence, a SerDes represents an interface, be it an Ethernet or a PCIe one.
> +
> +There are two kinds of SerDes: SERDES1G supports 10/100Mbps in
> +half/full-duplex and 1000Mbps in full-duplex mode while SERDES6G supports
> +10/100Mbps in half/full-duplex and 1000/2500Mbps in full-duplex mode.
> +
> +Also, SERDES6G number (aka "macro") 0 is the only interface supporting
> +QSGMII.
> +
> +Required properties:
> +
> +- compatible: should be "mscc,vsc7514-serdes"
> +- #phy-cells : from the generic phy bindings, must be 2.
> +	       The first number defines the input port to use for a given
> +	       SerDes macro. The second defines the macro to use. They are
> +	       defined in dt-bindings/phy/phy-ocelot-serdes.h

You need to define what this is a child of.

> +
> +Example:
> +
> +	serdes: serdes {
> +		compatible = "mscc,vsc7514-serdes";
> +		#phy-cells = <2>;

However, if there are no other resources associated with this, then you 
don't even need this child node. The parent can be a phy provider and 
provider of other functions too.

> +	};
> +
> +	ethernet {
> +		port1 {
> +			phy-handle = <&phy_foo>;
> +			/* Link SERDES1G_5 to port1 */
> +			phys = <&serdes 1 SERDES1G_5>;
> +		};
> +	};
> -- 
> git-series 0.9.1
