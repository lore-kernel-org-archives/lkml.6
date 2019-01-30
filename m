Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D3FC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA52221473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548863421;
	bh=f9eUobC1VsZ90U7dWwfPWz4IuNQfa+BPjW3Th2m1JS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pg0OlkQRFBAEAm70UY5E/QrUq9zXtnF9ePWe4r+P1LmNb7DkSlISCMTOpY8uIH5sM
	 5T7bSQkbGKokSrXszkddtpOi1Jcb36WoX16mfx9LzRAmgjjufq/KbYyf2H3bdOWdHZ
	 /Us6CBdi5Pze3ujgLqG85IuEHA7aH6Y9uZW2nnwY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731616AbfA3PuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:50:19 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43219 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbfA3PuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:50:19 -0500
Received: by mail-oi1-f196.google.com with SMTP id u18so19547569oie.10;
        Wed, 30 Jan 2019 07:50:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P2qq8+E4g/m+cCmMeaSfpaPEUpdAovlDLmemICtL6O4=;
        b=q0nUslTyT5ZV9gGtv4qtB087U72h2Xu+hjxLWnmbJ9+ClkgxVAYqDx+R55aeh9/1Bk
         RmwKPtSpU90B/02eFCzPBwgSrp4g7YS228P5cO6Wpz/MCOER/IW1UYfzpN2nKo+Rcbd1
         X7DCz5I1vpO9qHFhB7Dn5/PCIGHiydbfIPhX92JSNdOF4O3W6zkjVeYnitae2rKIVDfp
         Fkn9Ob1eZJfHfNhXeOvg70co6Zuc6I+u8eJtvyN7rljQvpgBlaA/7fHxAN104SZk4lD5
         cINGiH5y6Woa0pYEZsQ/OI7HIwyqEZzyZ9CX1D1HvVFDqN7UrRQX/YKYNmgq0kyS6nPr
         Ly3A==
X-Gm-Message-State: AJcUukfa/AnoUbH0UJoxpKz6sQ8o0P6IO1DpWrxAnQoNOZr4Un+GRr3w
        5x2J8MxbgV1B68gPS6J6Mw==
X-Google-Smtp-Source: ALg8bN7YUdJsKMpCX953MaNa6vxwhOhFB2rvS6C+vX5gSNPtizkLZmOQ0v4ZTva+YKvus3IQry/J6A==
X-Received: by 2002:aca:ba02:: with SMTP id k2mr13254932oif.177.1548863417913;
        Wed, 30 Jan 2019 07:50:17 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t201sm751720oie.37.2019.01.30.07.50.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 07:50:17 -0800 (PST)
Date:   Wed, 30 Jan 2019 09:50:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Loys Ollivier <lollivier@baylibre.com>
Cc:     devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: gnss: add mediatek binding
Message-ID: <20190130155016.GA26536@bogus>
References: <1548693481-1162-1-git-send-email-lollivier@baylibre.com>
 <1548693481-1162-3-git-send-email-lollivier@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548693481-1162-3-git-send-email-lollivier@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 05:37:59PM +0100, Loys Ollivier wrote:
> Add binding for Mediatek-based GNSS receivers.
> 
> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> ---
> 
> v3:
> Removed the I2C and SPI interfaces references.
> Removed the "mediatek,mt3339" compatible line.
> Added the optional propertied (reset, fix)
> Added the pin names for the optional properties.
> 
> v2:
> Renamed bindings from Globaltop/gtop to Mediatek/mtk.
> Moved current-speed as an optional propertie.
> Removed the status line in the example.
> Added "mediatek,mt3339" compatible.
> 
>  .../devicetree/bindings/gnss/mediatek.txt          | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gnss/mediatek.txt
> 
> diff --git a/Documentation/devicetree/bindings/gnss/mediatek.txt b/Documentation/devicetree/bindings/gnss/mediatek.txt
> new file mode 100644
> index 000000000000..00650d81c5c8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gnss/mediatek.txt
> @@ -0,0 +1,37 @@
> +Mediatek-based GNSS Receiver DT binding
> +
> +Mediatek chipsets are used in GNSS-receiver modules produced by several
> +vendors and can use an UART interface.
> +
> +Please see Documentation/devicetree/bindings/gnss/gnss.txt for generic
> +properties.
> +
> +Required properties:
> +
> +- compatible	: Must be
> +
> +			"globaltop,pa6h"
> +
> +- vcc-supply	: Main voltage regulator (pin name: VCC)
> +
> +Optional properties:
> +
> +- gtop,reset-gpios	: GPIO used to reset the device
> +  			  (pin name: RESET, NRESET)

reset-gpios is the standard name.

> +- gtop,fix-gpios	: GPIO used to determine device position fix state
> +			  (pin name: FIX, 3D_FIX)
> +- timepulse-gpios	: Time pulse GPIO (pin name: PPS1, 1PPS)
> +- v-bckp-supply		: Backup voltage regulator
> +  			  (pin name: VBAT, VBACKUP)
> +- current-speed		: Default UART baud rate
> +
> +Example:
> +
> +serial@1234 {
> +	compatible = "ns16550a";
> +
> +	gnss {
> +		compatible = "globaltop,pa6h";
> +		vcc-supply = <&vcc_3v3>;
> +	};
> +};
> -- 
> 2.7.4
> 
