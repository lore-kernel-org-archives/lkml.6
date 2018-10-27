Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URI_TRY_3LD autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28966C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 16:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB80B20843
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 16:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB80B20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tronnes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbeJ1Awb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 20:52:31 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:44128 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728643AbeJ1Awb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 20:52:31 -0400
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:58864 helo=[192.168.10.175])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1gGRB0-0007mL-ED; Sat, 27 Oct 2018 18:11:02 +0200
Subject: Re: [PATCH 1/3] dt-bindings: new binding for Himax HX8357D display
 panels
To:     Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>
References: <20181024184313.2967-1-eric@anholt.net>
 <20181024184313.2967-2-eric@anholt.net>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <0d208d10-c24b-74a6-c7ce-1c826ded1bde@tronnes.org>
Date:   Sat, 27 Oct 2018 18:10:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181024184313.2967-2-eric@anholt.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Den 24.10.2018 20.43, skrev Eric Anholt:
> This adds a new binding for Himax HX8357D display panels. It includes
> a compatible string for one display (more can be added in the future).
>
> The YX350HV15 panel[1] is found in the Adafruit PiTFT 3.5" Touch
> Screen for Raspberry Pi.
>
> [1] https://learn.adafruit.com/adafruit-pitft-3-dot-5-touch-screen-for-raspberry-pi/downloads
>
> This binding is closely modeled after the ili9341 binding, for a
> similar product from adafruit.  The primary difference is that the
> hx8367d doesn't have a reset line that I can find in the schematics.

Typo s/hx8367d/hx8357d/

The adafruit display has an AXP803 that resets the controller.

Acked-by: Noralf Trønnes <noralf@tronnes.org>

> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>   .../bindings/display/himax,hx8357d.txt        | 25 +++++++++++++++++++
>   1 file changed, 25 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/display/himax,hx8357d.txt
>
> diff --git a/Documentation/devicetree/bindings/display/himax,hx8357d.txt b/Documentation/devicetree/bindings/display/himax,hx8357d.txt
> new file mode 100644
> index 000000000000..48586e570be0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/himax,hx8357d.txt
> @@ -0,0 +1,25 @@
> +Himax HX8357D display panels
> +
> +This binding is for display panels using a Himax HX8357D controller in SPI
> +mode, such as the Adafruit 3.5" TFT for Raspberry Pi.
> +
> +Required properties:
> +- compatible:	"adafruit,yx350hv15", "himax,hx8357d"
> +- dc-gpios:	D/C pin
> +
> +The node for this driver must be a child node of a SPI controller, hence
> +all mandatory properties described in ../spi/spi-bus.txt must be specified.
> +
> +Optional properties:
> +- rotation:	panel rotation in degrees counter clockwise (0,90,180,270)
> +- backlight:	phandle of the backlight device attached to the panel
> +
> +Example:
> +	display@0{
> +		compatible = "adafruit,yx350hv15", "himax,hx8357d";
> +		reg = <0>;
> +		spi-max-frequency = <32000000>;
> +		dc-gpios = <&gpio0 25 GPIO_ACTIVE_HIGH>;
> +		rotation = <90>;
> +		backlight = <&backlight>;
> +	};

