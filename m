Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A830C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4A620700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550854168;
	bh=lCu3+argO3jLgDyHK7yjUiXpk4heiPtP4u0GtCsHSWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z9frGLmD6L4/Y3j7kCLGlX5PDQFZbLjXQE7vei4O3ChV4LZ1+NW86ZnWZUEHcDRsb
	 mn211YR6PfV3uX7gi8q2GpCLm2toDX6jBZSdnMYxcJ1TmBSFkLm006tUV020sR8O5O
	 76fZcUHH3KT9HmzLZcp9FIBwJLkT30QM6/3yCk/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfBVQt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 11:49:26 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43657 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbfBVQt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 11:49:26 -0500
Received: by mail-ot1-f67.google.com with SMTP id n71so2372971ota.10;
        Fri, 22 Feb 2019 08:49:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nInQa3zpTbobzahcniRHckH6ZQbSax0wZ5W2+6AK304=;
        b=rvi9M5AZ95tA+nGPNJLH9V0K0UyXRowWCE/7L4rqvsyNCRDFJgqvaT4lGndR1ElO4l
         RXe9O3fUD/I7VDyODRaiBElZjxuniw6y+hxF+fBw13fMvJ5QsUGY1Ds9GyNLgZsD+sO8
         jT/znGVWeAdUmV8Lh0KDWt5gRJdrPVLEZoWP0e34SG2KewyqPt9MRVMQhOK6IpD3LgSQ
         TwP4ExRZGTRSc8oghGUX/Ih0UxhRqFzywbIVVcekhNr6TKsNKzDb55xw9lxSMLOpDuhE
         Ues1fWTPTJvV8KN/mcAi3D+48cP8fyRRq6AL1RuIqqeWmdYIXHXV/5T2hbSP5DyzDmgS
         Pk9Q==
X-Gm-Message-State: AHQUAuZxw38Xt8x2YHF8rpshShGZFSqaebbKfh08/7ZECtFFYNdMi9QW
        XSa14sXYshrPQVtOI+k69Q==
X-Google-Smtp-Source: AHgI3IZwsSonHxCqImx6181/oMIhgphzQELpQJrUWz9v8CkWgH0W82mWpsAf8QjiPWVI9Ol9QIJlYA==
X-Received: by 2002:a9d:6082:: with SMTP id m2mr3197472otj.209.1550854165178;
        Fri, 22 Feb 2019 08:49:25 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h205sm755452oib.11.2019.02.22.08.49.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 08:49:24 -0800 (PST)
Date:   Fri, 22 Feb 2019 10:49:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     min.guo@mediatek.com
Cc:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        chunfeng.yun@mediatek.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, tony@atomide.com,
        hdegoede@redhat.com
Subject: Re: [PATCH v5 1/6] dt-bindings: usb: musb: Add support for MediaTek
 musb controller
Message-ID: <20190222164923.GA26413@bogus>
References: <1550561795-31132-1-git-send-email-min.guo@mediatek.com>
 <1550561795-31132-2-git-send-email-min.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550561795-31132-2-git-send-email-min.guo@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 03:36:30PM +0800, min.guo@mediatek.com wrote:
> From: Min Guo <min.guo@mediatek.com>
> 
> This adds support for MediaTek musb controller in
> host, peripheral and otg mode.
> 
> Signed-off-by: Min Guo <min.guo@mediatek.com>
> ---
> changes in v5:
> suggested by Rob:
> 1. Modify compatible as 
> - compatible : should be one of:
>                "mediatek,mt-2701"
>                ...
>                followed by "mediatek,mtk-musb"
> 2. Add usb connector child node
> 
> changes in v4:
> suggested by Sergei:
> 1. String alignment
> 
> changes in v3:
> 1. no changes
> 
> changes in v2:
> suggested by Bin:
> 1. Modify DRC to DRD
> suggested by Rob:
> 2. Drop the "<soc-model>-musb" in compatible
> 3. Remove phy-names
> 4. Add space after comma in clock-names
> ---
>  .../devicetree/bindings/usb/mediatek,musb.txt      | 54 ++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/mediatek,musb.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,musb.txt b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
> new file mode 100644
> index 0000000..0632e6e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
> @@ -0,0 +1,54 @@
> +MediaTek musb DRD/OTG controller
> +-------------------------------------------
> +
> +Required properties:
> + - compatible      : should be one of:
> +                     "mediatek,mt-2701"

That looks like a top-level SoC compatible and doesn't match the 
example.

> +                     ...
> +                     followed by "mediatek,mtk-musb"
> + - reg             : specifies physical base address and size of
> +                     the registers
> + - interrupts      : interrupt used by musb controller
> + - interrupt-names : must be "mc"

Not much point in a name when there is only 1.

> + - phys            : PHY specifier for the OTG phy
> + - dr_mode         : should be one of "host", "peripheral" or "otg",
> +                     refer to usb/generic.txt
> + - clocks          : a list of phandle + clock-specifier pairs, one for
> +                     each entry in clock-names
> + - clock-names     : must contain "main", "mcu", "univpll"
> +                     for clocks of controller
> +
> +Optional properties:
> + - power-domains   : a phandle to USB power domain node to control USB's
> +                     MTCMOS
> +
> +Required child nodes:
> + usb connector node as defined in bindings/connector/usb-connector.txt
> + - extcon          : for VBUS and ID pin changes detection, needed when
> +                     supports dual-role mode
> + - vbus-supply     : reference to the VBUS regulator, needed when supports
> +                     dual-role mode
> +
> +Example:
> +
> +usb2: usb@11200000 {
> +	compatible = "mediatek,mt2701-musb",
> +		     "mediatek,mtk-musb";
> +	reg = <0 0x11200000 0 0x1000>;
> +	interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
> +	interrupt-names = "mc";
> +	phys = <&u2port2 PHY_TYPE_USB2>;
> +	dr_mode = "otg";
> +	clocks = <&pericfg CLK_PERI_USB0>,
> +		 <&pericfg CLK_PERI_USB0_MCU>,
> +		 <&pericfg CLK_PERI_USB_SLV>;
> +	clock-names = "main","mcu","univpll";
> +	power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
> +	usb_con: connector{
> +		compatible = "usb-b-connector";
> +		label = "micro-USB";
> +		type = "micro";
> +		extcon = <&extcon_usb>;

The connector node should replace 'extcon'. Add what you need here 
directly (e.g. id-gpios). What you add needs to be defined in 
usb-connector.txt.

> +		vbus-supply = <&usb_vbus>;
> +	};
> +};
> -- 
> 1.9.1
> 
