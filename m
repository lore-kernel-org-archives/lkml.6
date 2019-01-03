Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF77C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02127217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546553665;
	bh=Ru7TNFleavO2+VOTQ+4RMaQqsHQxkzwL9ZNLGVNDVoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dAomiVCkzkMT4MnpDq/GRyhwi6YnNRMKsWwrTjGqiHoGq5qMh8nKDrODK1rQjd7Pk
	 +1Y+MBKXj0f4bh0WALzKFKs2h6wE6fXmOomOnQB2SG8JB5wOl2/SkGLqlB2a8Ht3fA
	 R9NWtfJ2RKY4uVJRE0DuixM/3kU3QSgnnoup9S1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbfACWOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 17:14:24 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:34425 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728281AbfACWOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 17:14:23 -0500
Received: by mail-io1-f65.google.com with SMTP id b16so8529085ior.1;
        Thu, 03 Jan 2019 14:14:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ovSnMbD1E39AJ/98MPK0U0qQKO0yuxyA6BNQxBzrVXQ=;
        b=la0isOySmdXVgFq9Ssd5jusUtfGKjnpBDpeOXImE96ajz1o6vV4nCfK/77GiTRoTsS
         b5hDVit7mEtlWN8X7R+BIPvGPpnnO+bo+6Yus46RZLR+btvDcl2FdR8Rz+XJOBQpIgdB
         2362w8RjMF0llKP5t9KQDbzjxIiShBQjxk/BOyvdii5fzn+vKoA0Nz/teFopY/uhdAIx
         Y6TWSpKxrwyOWTQ+bt13GdNiHS8BG3OkSFdpohlYWla5rujzLfr4tTKxI/M4cGIHm2LH
         C855F9qrV0ai82uqVeJcYM1qBV+bzS0InZwS1VbifCDjrVczoBVXk0kvD4PhVqyMaxdo
         n6gw==
X-Gm-Message-State: AJcUukczu59vMk3vZDS6hLCgwI/ww4OSmonIr3OmOvvkJuGj7+NsYK0K
        Kw4Tjoo95Rmnalz7QWwAjw==
X-Google-Smtp-Source: ALg8bN6UaXH4R6ckBYLcvfX6DnJ1RXML5ytsgkTANta6ZlKq+7VpsiRE3dpzLybX55GIuYt54w4iXA==
X-Received: by 2002:a6b:600b:: with SMTP id r11mr37145144iog.259.1546553662285;
        Thu, 03 Jan 2019 14:14:22 -0800 (PST)
Received: from localhost ([24.51.61.172])
        by smtp.gmail.com with ESMTPSA id t6sm26742728ioc.87.2019.01.03.14.14.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 14:14:21 -0800 (PST)
Date:   Thu, 3 Jan 2019 16:14:14 -0600
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
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/4] dt-bindings: usb: musb: Add support for MediaTek
 musb controller
Message-ID: <20190103221414.GA14639@bogus>
References: <1545896066-897-1-git-send-email-min.guo@mediatek.com>
 <1545896066-897-2-git-send-email-min.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545896066-897-2-git-send-email-min.guo@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2018 at 03:34:23PM +0800, min.guo@mediatek.com wrote:
> From: Min Guo <min.guo@mediatek.com>
> 
> This adds support for MediaTek musb controller in
> host, peripheral and otg mode
> 
> Signed-off-by: Min Guo <min.guo@mediatek.com>
> ---
>  .../devicetree/bindings/usb/mediatek,musb.txt      | 49 ++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/mediatek,musb.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,musb.txt b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
> new file mode 100644
> index 0000000..e899c9b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
> @@ -0,0 +1,49 @@
> +MediaTek musb DRC/OTG controller
> +-------------------------------------------
> +
> +Required properties:
> + - compatible      : should be "mediatek,<soc-model>-musb",
> +   "mediatek,mtk-musb", soc-model is the name of SoC, such as
> +   mt2701, when using "mediatek,mtk-musb" compatible string, you
> +   need SoC specific ones in addition, one of:
> +   - "mediatek,mt2701-musb"

This isn't very clear. Just drop the <soc-model and enumerate the SoCs:

compatible: should be one of:
    "mediatek,mt2701-musb"
    ...
  followed by "mediatek,mtk-musb"

> + - reg             : specifies physical base address and size of
> +   the registers
> + - interrupts      : interrupt used by musb controller
> + - interrupt-names : must be "mc"

-names is pointless when there is only one.

> + - phys            : PHY specifier for the OTG phy
> + - phy-names       : should be "usb2-phy"

Same here.

> + - dr_mode         : should be one of "host", "peripheral" or "otg",
> +   refer to usb/generic.txt
> + - clocks          : a list of phandle + clock-specifier pairs, one for
> +   each entry in clock-names
> + - clock-names     : must contain "main","mcu","univpll"

space needed after each comma.

> +   for clocks of controller
> +
> +Optional properties:
> + - extcon : external connector for VBUS and IDPIN changes detection,
> +   needed when supports dual-role mode.

Don't use extcon for new bindings. The usb-connector binding should be 
used instead.

> + - vbus-supply : reference to the VBUS regulator, needed when supports
> +   dual-role mode.

The controller is powered from Vbus? Probably not. This belongs in the 
connector or maybe the phy (if the phy is powered from Vbus).

> + - power-domains   : a phandle to USB power domain node to control USB's
> +   MTCMOS
> +
> +Example:
> +
> +usb2: usb@11200000 {
> +	compatible = "mediatek,mt2701-musb";
> +		"mediatek,mtk-musb";
> +	reg = <0 0x11200000 0 0x1000>;
> +	interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
> +	interrupt-names = "mc";
> +	phys = <&u2port2 PHY_TYPE_USB2>;
> +	phy-names = "usb2-phy";
> +	vbus-supply = <&usb_vbus>;
> +	extcon = <&extcon_usb>;
> +	dr_mode = "otg";
> +	clocks = <&pericfg CLK_PERI_USB0>,
> +		 <&pericfg CLK_PERI_USB0_MCU>,
> +		 <&pericfg CLK_PERI_USB_SLV>;
> +	clock-names = "main","mcu","univpll";
> +	power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
> +};
> -- 
> 1.9.1
> 
