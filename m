Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C11C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E10B921473
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E10B921473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbeJFD7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 23:59:25 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35513 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbeJFD7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 23:59:25 -0400
Received: by mail-oi1-f195.google.com with SMTP id 22-v6so10497893oiz.2;
        Fri, 05 Oct 2018 13:58:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jdoivrIFjA+DlX68dFQAMvzD8Si7g4NRaOpqI2iXIMQ=;
        b=JbVnPF8ACZbJLKGYrXDdUwVt/AmgNzIp3J6F663k9ntgmvw7XQoBqcZWLyIBT8mceK
         KY63pUxcGC8QSe3FqK56D8QkRfl6WxIC+UDTRUmcpOjqEz/sKggnsR9QKRzRRMfzUHVg
         aMNNvN5TleSHr5rsxnvsPDmgHQ3wfzgBYxLL4+21y5NCIcry0zZE1B9QZ6syOWP3Teq8
         g8y6pv/gGpVIHzGPfSRNaEOrIoSOctTqxHmOwJHiio3hWkozRKO/l0GBlJWj1vOf2wmf
         1YTKbElbMyUds2IkspEGeGF4CeXS1pbaMdEUwrgrI3C9YklgK2YZcrEqMZt+tXgFCiNR
         +LKw==
X-Gm-Message-State: ABuFfojEsg9xpKl9MPcryYbBoXl1IMQcAKWaPIAPdlSzR68F40opdFYK
        Ej5zGHwru+qaGx5Tmnyvgw==
X-Google-Smtp-Source: ACcGV61E9eUVQSLiF9v7GYkwxU1VklwQSskfzvyXRJS84A+meM7w1t/cVBtDXCV2iYeK2vuuu7pwZw==
X-Received: by 2002:aca:ce07:: with SMTP id e7-v6mr360654oig.54.1538773136888;
        Fri, 05 Oct 2018 13:58:56 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b8sm3097914otd.50.2018.10.05.13.58.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 13:58:56 -0700 (PDT)
Date:   Fri, 5 Oct 2018 15:58:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 07/10] dt-bindings: phy: add binding for Allwinner
 USB3 PHY
Message-ID: <20181005205855.GA2458@bogus>
References: <20181004122855.22981-1-icenowy@aosc.io>
 <20181004122855.22981-8-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004122855.22981-8-icenowy@aosc.io>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 08:28:52PM +0800, Icenowy Zheng wrote:
> The new Allwinner H6 SoC contains a USB3 PHY that is wired to the
> external USB3 pins of the SoC.
> 
> Add a device tree binding for the PHY.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> ---
> Changes in v4:
> - Changed Vbus regulator property to vbus-supply.
> 
> Changes in v3:
> - Added Chen-Yu's Review tag.
> 
> No changes in v2, v1.
> 
>  .../bindings/phy/sun50i-usb3-phy.txt          | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt b/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
> new file mode 100644
> index 000000000000..9f49c6b8c7e7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
> @@ -0,0 +1,23 @@
> +Allwinner sun50i USB3 PHY
> +-----------------------
> +
> +Required properties:
> +- compatible : should be one of
> +  * allwinner,sun60i-h6-usb3-phy
> +- reg : a list of offset + length pairs
> +- #phy-cells : from the generic phy bindings, must be 0
> +- clocks : phandle + clock specifier for the phy clock
> +- resets : phandle + reset specifier for the phy reset
> +
> +Optional Properties:
> +- vbus-supply : a phandle to a regulator that provides power to VBUS.

This belongs in a connector node as it is part of the connector unless 
the phy physically needs Vbus for power.

But others have done this, so all the phys can just be wrong...

> +
> +Example:
> +	usb3phy: phy@5210000 {

usb-phy@

> +		compatible = "allwinner,sun50i-h6-usb3-phy";
> +		reg = <0x5210000 0x10000>;
> +		clocks = <&ccu CLK_USB_PHY1>;
> +		resets = <&ccu RST_USB_PHY1>;
> +		#phy-cells = <0>;
> +		status = "disabled";

Don't show status in examples.

> +	};
> -- 
> 2.18.0
> 
