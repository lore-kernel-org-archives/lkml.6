Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E609EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC49A20700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550868056;
	bh=oBukqQtBW+ZrMvBSCOAjWVkr6ppl1KXH21LFcxxqIzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jpoDvRIlR+gK3GEc/Fsy+ozlLnSV/7y1/mPrgvQKr85pXtJt3a9xqRnictGiphYDe
	 DRHGoB+K/xsIj0bSE/TEMF4XrnYjE7Hb1OACjCoIgJ4Vks5Z3Aixy8TQTY0vDJBTA8
	 P6UiTz6Osa8EFW/VfwjfRsDuVTmkT+pq6bZZdKP0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbfBVUkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:40:55 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41414 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfBVUky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:40:54 -0500
Received: by mail-oi1-f194.google.com with SMTP id e7so2757302oia.8;
        Fri, 22 Feb 2019 12:40:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k6Nt+rTOyhB130p46hK42kJOh3SKIT6oOPXdqmBAy3o=;
        b=q8gpzZl5mFt42d2SawQ9ZLibYskoTvLoq49r3sSCSJ/btP+Os8c7rCegiZJ/JIQYlC
         SwZ3DJ1As4/NaqNyoRAV5/oK9c45WVZ2mwnoyFeUkGk3lzP5jMEnmeMP2JmZJ2FvOr1i
         IiA1dAd55GdjZ1/nifH1CRC11rVpTRq8sNsy6Eo+1CGyx0sIYPkFIn94H6aAC7zOrom2
         hUQqPNaP27keSK2cplXrGQwTNF+QhBwNSWgXRaKeUwqfIwQOsXLabbiBIYTqGPGUnltW
         tT/WaULU+2UAJT7gjeAusKjFfnQxWdoUPmbPWKUaqKAnvbPYtozxKXk4z5z/Xax3e5lc
         PQew==
X-Gm-Message-State: AHQUAuamwIKGytgYcivEkJqdpw6ZWyf+VJ4OU8w84qQAde4UDuEB1QjH
        tyrDpfd/E2cx2piJ3AzV9IFk0Hg=
X-Google-Smtp-Source: AHgI3IaqrNVvawQBQViDikdq4pTP15svOkBv9yidlw1+l3Pn8ReksMlRhHHkzfezp1KJ3TcRUheUZQ==
X-Received: by 2002:a54:4606:: with SMTP id p6mr3572245oip.162.1550868053511;
        Fri, 22 Feb 2019 12:40:53 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n76sm1123335ota.51.2019.02.22.12.40.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 12:40:52 -0800 (PST)
Date:   Fri, 22 Feb 2019 14:40:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Piotr Sroka <piotrs@cadence.com>
Cc:     linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        BrianNorris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: nand: Add Cadence NAND controller
 driver
Message-ID: <20190222204052.GA17855@bogus>
References: <20190219161406.4340-1-piotrs@cadence.com>
 <20190219161920.26602-1-piotrs@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219161920.26602-1-piotrs@cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 04:19:20PM +0000, Piotr Sroka wrote:
> Signed-off-by: Piotr Sroka <piotrs@cadence.com>
> ---
> Changes for v2:
> - remove chip dependends parameters from dts bindings
> - add names for register ranges in dts bindings
> - add generic bindings to describe NAND chip representation
>   under the NAND controller node 
> ---
>  .../bindings/mtd/cadence-nand-controller.txt       | 48 ++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt b/Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
> new file mode 100644
> index 000000000000..3d9b4decae24
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
> @@ -0,0 +1,48 @@
> +* Cadence NAND controller
> +
> +Required properties:
> +  - compatible : "cdns,hpnfc"

Only one version of IP or is that discoverable?

> +  - reg : Contains two entries, each of which is a tuple consisting of a
> +	  physical address and length. The first entry is the address and
> +	  length of the controller register set. The second entry is the
> +	  address and length of the Slave DMA data port.
> +  - reg-names: should contain "cadence_reg" and "cadence_sdma"

'cadence_' part is pointless.

> +  - interrupts : The interrupt number.
> +  - clocks: phandle of the controller core clock (nf_clk).
> +  - Children nodes represent the available NAND chips.

Need a blank line and remove the '-' as it's not a property.

> +
> +Required properties of NAND chips:
> +  - reg: shall contain the native Chip Select ids from 0 to max supported by
> +    the cadence nand flash controller
> +
> +Optional properties:

For child nodes? If not move before child nodes.

> +  - dmas: shall reference DMA channel associated to the NAND controller
> +  - cdns,board-delay : Estimated Board delay. The value includes the total
> +    round trip delay for the signals and is used for deciding on values
> +    associated with data read capture. The example formula for SDR mode is
> +    the following:
> +    board_delay = RE#PAD_delay + PCB trace to device + PCB trace from device
> +    + DQ PAD delay

Units? Use unit suffix as defined in property-units.txt.

> +
> +See Documentation/devicetree/bindings/mtd/nand.txt for more details on
> +generic bindings.
> +
> +Example:
> +
> +nand_controller: nand-controller @60000000 {

space                              ^

> +	  compatible = "cdns,hpnfc";
> +	  reg = <0x60000000 0x10000>, <0x80000000 0x10000>;
> +	  reg-names = "cadence_reg", "cadence_sdma";
> +	  clocks = <&nf_clk>;
> +	  cdns,board-delay = <4830>;
> +	  interrupts = <2 0>;
> +	  nand@0 {
> +	      reg = <0>;
> +	      label = "nand-1";
> +	  };
> +	  nand@1 {
> +	      reg = <1>;
> +	      label = "nand-2";
> +	  };
> +
> +};
> -- 
> 2.15.0
> 
