Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URI_TRY_3LD,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55D3C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA122075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA122075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbeJZGRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 02:17:00 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41249 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbeJZGRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 02:17:00 -0400
Received: by mail-oi1-f193.google.com with SMTP id i10-v6so5213282oik.8;
        Thu, 25 Oct 2018 14:42:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1aPiDDdJnf8RViC2kOJQCwXDogwlVAbtY3LCAcV5/ZI=;
        b=MKJFUXLrNahtr+4JPOLdLrnJ75grVtdj5IzmFPzJA+z5imZJ3ACNnGoA4I5vaio1ty
         myYkrobTYnlLLuq4NF8o/8wQSEadZDc05polGv+yztYzppSbC74A98lXcOoP7/0Fpzw6
         KU3RrkriIBGNpdMLvXw4W0q8EhfRHRJsO4fyl0UIA5FYilP9T4HwkErQfzY4rsAjyGiZ
         5PKBvqhWYtMKX8pOpIXOrQJZ1oJDzapQKxMs8taDNxewg4djnUHLT5fPojVwMSdaTyMF
         jD9BTlGe5X/Wc4tqOn2jL+d8V2tkZWmpcwMrCciJxvDha3GuengN486mwwfNHXQ2s56h
         A/yA==
X-Gm-Message-State: AGRZ1gLPJCOIebYwx5TxfT74gEas2I6U5y3l41Hf+XMemPYhYh2ankJS
        pwRXC1bTTbsGdIKbQTHveQ==
X-Google-Smtp-Source: AJdET5daOovfReNdP3IqdoDPviaUN0mfIGRzlP1ruJ2ZmLFuGXjOJ+NXoV497L571rgRmex4yFRshA==
X-Received: by 2002:aca:c743:: with SMTP id x64-v6mr551591oif.139.1540503756392;
        Thu, 25 Oct 2018 14:42:36 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t11sm3075174oti.21.2018.10.25.14.42.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 14:42:35 -0700 (PDT)
Date:   Thu, 25 Oct 2018 16:42:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: new binding for Himax HX8357D display
 panels
Message-ID: <20181025214234.GA5036@bogus>
References: <20181024184313.2967-1-eric@anholt.net>
 <20181024184313.2967-2-eric@anholt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024184313.2967-2-eric@anholt.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 11:43:11AM -0700, Eric Anholt wrote:
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
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  .../bindings/display/himax,hx8357d.txt        | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/himax,hx8357d.txt
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

You forgot reg. Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

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
> -- 
> 2.19.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
