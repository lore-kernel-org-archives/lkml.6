Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A907C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 131E42084E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550098125;
	bh=iDBePjW76XDHfw2KHfuJfieAzZUDzVDU1QNQdkZTHX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FwmxCBBLRQlZzANIpKmAUzdU96avhE6V+ETx+me8gyuotMG/SQDlrHFAgZKzQ62g+
	 W5RcruL2HtWG6jEpg0HU8IHRv2vg6utlleDwUSsmp0FjyVrlld3L6gb1IkzzpbC9kA
	 Y+U2Pree5EvIhBUa1+E3vYB2y4SGJV391dSQj4Rc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391606AbfBMWsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:48:43 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42475 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfBMWsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:48:43 -0500
Received: by mail-ot1-f67.google.com with SMTP id i5so7221990oto.9;
        Wed, 13 Feb 2019 14:48:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CeXdmIB/dDTm/UbvWolm3AJVk5yxKdzvkeF5uRY6XV0=;
        b=Eh8ZrJMsVG/9PqYzAf5dxVB785QBRcxii/rkqZMc4PDRlTLeVnLk+5Fy0oBP59OIp9
         yQAIAx8lJimH67AW1ocmEmfcWvErVXkceY38Nd5PP4LpLFAvhQ68x+Lz21pMMAkZqqLM
         tSktUSRz3BPR07DFEbCdqDmqHh8DMKve9rC1FGdE6FBw/puvIwKCAf69uNhvI86yel/A
         SsoGCe65PTDhV68CK5ET+giNLa7hw/VGUIRtM1C9GLUPE3ClkxrSwXNNLpxaclfSWo61
         GpXqdqbvI2wpKLFQGfp+WWHoZVk8D4vRkMdsH8p6U9cL9v61NrRaL+GR40Z3Vgh4sa6b
         YrTQ==
X-Gm-Message-State: AHQUAubWocv1YOeBhYg7w9fORpmjplRblgz7D86Plt2/vMkWVa4zsZsQ
        TjE3FRyG6yXsl25XseVbYw==
X-Google-Smtp-Source: AHgI3IaXXZsN1Hb0b6dgc49WNI/KdqV0zEepNNVi4X1gm2dMd0QXbd1uOCxXmcilXYy5TYYvnR0S4g==
X-Received: by 2002:aca:4d49:: with SMTP id a70mr339078oib.135.1550098122165;
        Wed, 13 Feb 2019 14:48:42 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a20sm234493otf.50.2019.02.13.14.48.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 14:48:41 -0800 (PST)
Date:   Wed, 13 Feb 2019 16:48:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        mark.rutland@arm.com, linux-usb@vger.kernel.org,
        hdegoede@redhat.com, heikki.krogerus@linux.intel.com,
        andy.shevchenko@gmail.com, rogerq@ti.com,
        linux-kernel@vger.kernel.org, jbergsagel@ti.com, nsekhar@ti.com,
        nm@ti.com, sureshp@cadence.com, peter.chen@nxp.com,
        pjez@cadence.com, kurahul@cadence.com
Subject: Re: [PATCH v3 1/6] dt-bindings: add binding for USBSS-DRD controller.
Message-ID: <20190213224841.GA9319@bogus>
References: <1548935553-452-1-git-send-email-pawell@cadence.com>
 <1548935553-452-2-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548935553-452-2-git-send-email-pawell@cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 11:52:28AM +0000, Pawel Laszczak wrote:
> This patch aim at documenting USB related dt-bindings for the
> Cadence USBSS-DRD controller.
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  .../devicetree/bindings/usb/cdns-usb3.txt     | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/cdns-usb3.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/cdns-usb3.txt b/Documentation/devicetree/bindings/usb/cdns-usb3.txt
> new file mode 100644
> index 000000000000..6dc38be77f5c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/cdns-usb3.txt
> @@ -0,0 +1,33 @@
> +Binding for the Cadence USBSS-DRD controller
> +
> +Required properties:
> +  - reg: Physical base address and size of the controller's register areas.
> +	 Controller has 3 different regions:
> +	 region 1 - HOST registers area
> +	 region 2 - DEVICE registers area
> +	 region 3 - OTG/DRD registers area
> +  - reg-names - register memory area names:
> +	"xhci" - for HOST registers space
> +	"dev" - for DEVICE registers space
> +	"otg" - for OTG/DRD registers space
> +  - compatible: Should contain: "cdns,usb3-1.0.0" or "cdns,usb3-1.0.1"
> +  - interrupts: Interrupt specifier. Refer to interrupt bindings.
> +		Driver supports only single interrupt line.

Driver supports or h/w only has 1 interrupt?

> +                This single interrupt is shared between Device,
> +		host and OTG/DRD part of driver.
> +
> +Optional properties:
> + - maximum-speed : valid arguments are "super-speed", "high-speed" and
> +                   "full-speed"; refer to usb/generic.txt
> + - dr_mode: Should be one of "host", "peripheral" or "otg".
> + - phys: reference to the USB PHY
> +
> +Example:
> +	usb@f3000000 {
> +		compatible = "cdns,usb3";

Doesn't match above.

> +		interrupts = <USB_IRQ  7 IRQ_TYPE_LEVEL_HIGH>;
> +		reg = <0xf3000000 0x10000	/* memory area for HOST registers */
> +			0xf3010000 0x10000	/* memory area for DEVICE registers */
> +			0xf3020000 0x10000>;	/* memory area for OTG/DRD registers */

Are these really 64KB long? That wastes virtual address space on 32-bit 
systems if not.

> +		reg-names = "xhci", "dev", "otg";
> +	};
> -- 
> 2.17.1
> 
