Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18117C67872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF5F52098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF5F52098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbeJMAAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:00:21 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42815 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729086AbeJMAAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:00:20 -0400
Received: by mail-ot1-f67.google.com with SMTP id c23so11139657otl.9;
        Fri, 12 Oct 2018 09:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6md0d6feXZ9A5OvA+mxWRUenpPTkCJmol8/AUm1HgPQ=;
        b=Sviq+XYJdmzJ8ZRFpOarqb0AAa44sOZ/tc4Ne/5FFd7bje9VG9XTSs8Qv4St5FWveR
         cgJZFD73vWd3e3jYFqfSdG4Q2NFIh+sn0Sa+5qHCcT7fj+yZz1hrewwgy3sJ0i6o3Ju0
         zCBam4FMK8YYLOkRFRgox2vjgZKTvUz0m0JVpFL70DZWSEQCTqHwAbFLlSnuCUaCWky3
         WC6e0dfIssn+xScCBNpQU4Rj39vrBWNvRK5jeXpapR8S0yAMvIdDtDrVftP0SRu/Z8K5
         YPmsJjgmG0oVTf1PdP3gJcmZVcoDArAyFQoCeI5RGXsIDghn84Nrvv+kNL39iNfJ7qDE
         0wkQ==
X-Gm-Message-State: ABuFfojX9zjHX4JDqHtZO+jZCzHCZcXiTzqbN1ILkBzsC0FlrhpUJLIk
        z8jLTqFgZ93ACUK1AYgMBA==
X-Google-Smtp-Source: ACcGV60HHN/TngAyjyXVFUfBMsNxsvoWNeAraeQRJcvtA3cTC8/G8cWWTtbRSTSE8uzHdVUOEJgSHA==
X-Received: by 2002:a9d:286e:: with SMTP id h43mr3902420otd.89.1539361623948;
        Fri, 12 Oct 2018 09:27:03 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l60-v6sm434569otl.52.2018.10.12.09.27.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 09:27:03 -0700 (PDT)
Date:   Fri, 12 Oct 2018 11:27:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, lee.jones@linaro.org,
        tony@atomide.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v3 4/9] dt-bindings: leds: Add bindings for lm3697 driver
Message-ID: <20181012162702.GA5672@bogus>
References: <20181011165123.32198-1-dmurphy@ti.com>
 <20181011165123.32198-5-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011165123.32198-5-dmurphy@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 11:51:18AM -0500, Dan Murphy wrote:
> Add the device tree bindings for the lm3697
> LED driver for backlighting and display.

Bindings are for h/w, not drivers...

> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  .../devicetree/bindings/leds/leds-lm3697.txt  | 98 +++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3697.txt
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-lm3697.txt b/Documentation/devicetree/bindings/leds/leds-lm3697.txt
> new file mode 100644
> index 000000000000..4bb2ed51025b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-lm3697.txt
> @@ -0,0 +1,98 @@
> +* Texas Instruments - LM3697 Highly Efficient White LED Driver
> +
> +The LM3697 11-bit LED driver provides high-
> +performance backlight dimming for 1, 2, or 3 series
> +LED strings while delivering up to 90% efficiency.
> +
> +This device is suitable for display and keypad Lighting
> +
> +Required properties:
> +	- compatible:
> +		"ti,lm3697"
> +	- reg :  I2C slave address
> +	- #address-cells : 1
> +	- #size-cells : 0
> +
> +Optional properties:
> +	- enable-gpios : GPIO pin to enable/disable the device
> +	- vled-supply : LED supply
> +
> +Required child properties:
> +	- reg : 0 - LED is Controlled by bank A
> +		1 - LED is Controlled by bank B
> +	- led-sources : Indicates which HVLED string is associated to which
> +			control bank.  Each element in the array is associated
> +			with a specific HVLED string.  Element 0 is HVLED1,
> +			element 1 is HVLED2 and element 2 HVLED3.
> +			Additional information is contained
> +			in Documentation/devicetree/bindings/leds/common.txt
> +			0 - HVLED is not active in this control bank
> +			1 - HVLED string is controlled by this control bank
> +
> +Optional child properties:
> +	- runtime-ramp-up-msec: Current ramping from one brightness level to
> +				the a higher brightness level.
> +				Range from 2048 us - 117.44 s
> +	- runtime-ramp-down-msec: Current ramping from one brightness level to
> +				  the a lower brightness level.
> +				  Range from 2048 us - 117.44 s
> +	- label : see Documentation/devicetree/bindings/leds/common.txt
> +	- linux,default-trigger :
> +	   see Documentation/devicetree/bindings/leds/common.txt
> +
> +Example:
> +
> +HVLED string 1 and 3 are controlled by control bank A and HVLED 2 string is
> +controlled by control bank B.
> +
> +led-controller@36 {
> +	compatible = "ti,lm3697";
> +	reg = <0x36>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	enable-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
> +	vled-supply = <&vbatt>;
> +
> +	led@0 {
> +		reg = <0>;
> +		led-sources = <1 0 1>;
> +		runtime-ramp-up-msec = <5000>;
> +		runtime-ramp-down-msec = <1000>;
> +		label = "white:first_backlight_cluster";
> +		linux,default-trigger = "backlight";
> +	};
> +
> +	led@1 {
> +		reg = <1>;
> +		led-sources = <0 1 0>;
> +		runtime-ramp-up-msec = <500>;
> +		runtime-ramp-down-msec = <1000>;
> +		label = "white:second_backlight_cluster";
> +		linux,default-trigger = "backlight";
> +	};
> +}
> +
> +All HVLED strings controlled by control bank A
> +
> +led-controller@36 {
> +	compatible = "ti,lm3697";
> +	reg = <0x36>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	enable-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
> +	vled-supply = <&vbatt>;
> +
> +	led@0 {
> +		reg = <0>;
> +		led-sources = <1 1 1>;
> +		runtime-ramp-up-msec = <500>;
> +		runtime-ramp-down-msec = <1000>;
> +		label = "white:backlight_cluster";
> +		linux,default-trigger = "backlight";
> +	};
> +}
> +
> +For more product information please see the link below:
> +http://www.ti.com/lit/ds/symlink/lm3697.pdf
> -- 
> 2.19.0
> 
