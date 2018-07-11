Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE08C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D00320C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D00320C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387645AbeGKQTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:19:02 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45549 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeGKQTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:19:01 -0400
Received: by mail-oi0-f68.google.com with SMTP id q11-v6so24697204oic.12;
        Wed, 11 Jul 2018 09:13:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rf+KFP9/vKTT9tNDSOvQo+yL3mBTv8YWYMmXOWihs7c=;
        b=GibmGAkr8w7RlCjJZoU8z0gm+CiYUp9GTuGJmvezgziopr5F47LGACOIVaV+7tJMXw
         1yjhXbeYAMETtlYwml3ZBCDmK3YP75qVHFZa3GPIDmqOWX4MFkzQIXKaOG08g4fo8ulm
         X7CSBCBVy+8ZAnwWYV7MmzNJUodqogRiCBWbuXlh+V/hVxBj7UJNyU/O0tcHUCOkwcHS
         gOlnztA1+miiet1CsZutCikTp37hBzmO2lZqpTM370JHJjc3Al32T+KI+1tNr9uqx5Cb
         lTC25zMxt7W15u5a7YRWjQaKCVUJhGcWOI/D+qnafaRtgykpoNJOlulyMicMMtVuMAKx
         JzGw==
X-Gm-Message-State: APt69E3byadknBrwa8qVyDpYJXDnIbPRy83c9rz1bA5XKiHal2DiLqAW
        DDDcVevruK7KJakSLxvMnQ==
X-Google-Smtp-Source: AAOMgpc00i/BQO4wOBNwEUmcdQrYGZeCOKNgbYazfHr4hMYTlzJbMq2HEqcCH3SYT0GiZl5zMAA7UQ==
X-Received: by 2002:aca:3882:: with SMTP id f124-v6mr6280445oia.195.1531325638314;
        Wed, 11 Jul 2018 09:13:58 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id e202-v6sm43039789oih.8.2018.07.11.09.13.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 09:13:57 -0700 (PDT)
Date:   Wed, 11 Jul 2018 10:13:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 6/9] dt-bindings: phy: add binding for Allwinner USB3
 PHY
Message-ID: <20180711161356.GA4685@rob-hp-laptop>
References: <20180706153805.25842-1-icenowy@aosc.io>
 <20180706153805.25842-7-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706153805.25842-7-icenowy@aosc.io>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 11:38:02PM +0800, Icenowy Zheng wrote:
> The new Allwinner H6 SoC contains a USB3 PHY that is wired to the
> external USB3 pins of the SoC.
> 
> Add a device tree binding for the PHY.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Splitted from the PHY driver patch in v1.
> 
>  .../bindings/phy/sun50i-usb3-phy.txt          | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt b/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
> new file mode 100644
> index 000000000000..912d55f9f69d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
> @@ -0,0 +1,24 @@
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
> +- phy-supply : from the generic phy bindings, a phandle to a regulator that
> +	       provides power to VBUS.

Power to the phy or Vbus? If the latter only, then this property should 
be elsewhere (like a connector node).

> +
> +Example:
> +	usb3phy: phy@5210000 {
> +		compatible = "allwinner,sun50i-h6-usb3-phy";
> +		reg = <0x5210000 0x10000>;
> +		clocks = <&ccu CLK_USB_PHY1>;
> +		resets = <&ccu RST_USB_PHY1>;
> +		#phy-cells = <0>;
> +		status = "disabled";
> +	};
> -- 
> 2.17.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
