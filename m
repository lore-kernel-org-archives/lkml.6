Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D47DECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA89220647
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA89220647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388114AbeGTSZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:25:54 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34900 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731556AbeGTSZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 14:25:54 -0400
Received: by mail-io0-f195.google.com with SMTP id w11-v6so5029029iob.2;
        Fri, 20 Jul 2018 10:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jromdis0V1vNKO0V5Js1ZgcRURlBw8m2yw/7ErWXca8=;
        b=AVw9ALl51fUlDJpxLirfGB5sa/pAMCkGssk41iPIJ+HBcGzS5sqoP0QMLVY885MQnG
         MNc2iSprgtvDf2/K+rC64hqCAHQqkFexIfy41t0q7k7v5hmd12yfQk4Dv15YAIDkMeNu
         DYfdbQiKr3JbGM5C2xUdAk9KWznNbl5lek9ZtVZZJbwf/HJ9QIl3GwIwCcSV5Kb0ivW7
         DmKR2346joEDK6uRlkQAYfs7wgr2p8WfuKJvpdpPcZzPtLrCu1ZMH9+8lQeMajHQSnpv
         7GlcCE5WeCHgEv1VkAb59miVJRvoJRzM8zEjPUSP5YV3mffI9nZQDBwiVYk8KeIwUskp
         FhzA==
X-Gm-Message-State: AOUpUlFT4KbGrpnTs+V2gNji+QbZ5SJwe5CDtW4oTcrEaHh5aOVYoUFH
        v/EkC7lEGthfa31gxJQpWA==
X-Google-Smtp-Source: AAOMgpeL/rU1gk+1qlG9W3chllk3HDTI0M7TN6m3vh+qNpW1/hW35ZB9YE/JHnDb+Jc7w9z8dhLWig==
X-Received: by 2002:a6b:d812:: with SMTP id y18-v6mr2240756iob.141.1532108196652;
        Fri, 20 Jul 2018 10:36:36 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id b129-v6sm1502712ioa.75.2018.07.20.10.36.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 10:36:36 -0700 (PDT)
Date:   Fri, 20 Jul 2018 11:36:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     jic23@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        jonathan@marek.ca, jmaneyrol@invensense.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mkelly@xevo.com,
        fischerdouglasc@gmail.com, bshah@kde.org, ctatlor97@gmail.com,
        drew.paterson@ams.com
Subject: Re: [PATCH v2 3/7] iio: tsl2772: add support for reading power
 settings from device tree
Message-ID: <20180720173635.GA21241@rob-hp-laptop>
References: <20180717084158.23532-1-masneyb@onstation.org>
 <20180717084158.23532-4-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717084158.23532-4-masneyb@onstation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 04:41:54AM -0400, Brian Masney wrote:
> This patch adds support for optionally reading the prox_diode and
> prox_power settings from device tree. This was tested using a LG
> Nexus 5 (hammerhead) which requires a different diode than the driver
> default for the IR LED.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
> The next patch in the series removes the tsl2772 driver from the
> trivial-devices.txt file. I separated it out so that change can go
> through device tree.
> 
>  .../devicetree/bindings/iio/light/tsl2772.txt | 39 +++++++++++++++++++

Please split DT bindings to separate patch.

>  drivers/iio/light/tsl2772.c                   | 16 ++++++++
>  include/dt-bindings/iio/amstaos,tsl2772.h     | 24 ++++++++++++
>  3 files changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/tsl2772.txt
>  create mode 100644 include/dt-bindings/iio/amstaos,tsl2772.h
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/tsl2772.txt b/Documentation/devicetree/bindings/iio/light/tsl2772.txt
> new file mode 100644
> index 000000000000..ab553d52b9fc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/tsl2772.txt
> @@ -0,0 +1,39 @@
> +* AMS/TAOS ALS and proximity sensor
> +
> +Required properties:
> +
> +  - compatible: Should be one of
> +		"amstaos,tsl2571"
> +		"amstaos,tsl2671"
> +		"amstaos,tmd2671"
> +		"amstaos,tsl2771"
> +		"amstaos,tmd2771"
> +		"amstaos,tsl2572"
> +		"amstaos,tsl2672"
> +		"amstaos,tmd2672"
> +		"amstaos,tsl2772"
> +		"amstaos,tmd2772"
> +  - reg: the I2C address of the device
> +
> +Optional properties:
> +
> +  - amstaos,prox_diode - must be TSL2772_DIODE0, TSL2772_DIODE1, or
> +                         TSL2772_DIODE_BOTH.

s/_/-/

> +  - amstaos,prox_power - must be TSL2772_100_mA, TSL2772_50_mA, TSL2772_25_mA,
> +                         or TSL2772_13_mA.

I wonder if this should be common. Perhaps we should use the existing 
'led-max-microamp' as this is setting the current for an IR LED.

And while called 'power' this setting is current.

> +  - interrupt-parent: should be the phandle for the interrupt controller

Don't need to document this. It's implied by interrupts (and could be in 
a parent node).

> +  - interrupts: the sole interrupt generated by the device
> +
> +  Refer to interrupt-controller/interrupts.txt for generic interrupt client
> +  node bindings.
> +
> +Example:
> +
> +#include <dt-bindings/iio/amstaos,tsl2772.h>
> +
> +tsl2772@39 {
> +	compatible = "amstaos,tsl2772";
> +	reg = <0x39>;
> +	interrupts-extended = <&msmgpio 61 IRQ_TYPE_EDGE_FALLING>;
> +	amstaos,prox_diode = <TSL2772_DIODE0>;
> +};
