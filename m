Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC80C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A09220665
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g29Zw37W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbfBWVh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:37:59 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46972 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfBWVh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:37:59 -0500
Received: by mail-pg1-f195.google.com with SMTP id 196so2689813pgf.13;
        Sat, 23 Feb 2019 13:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TqZhjk20IEN4ppFRi6jBT+P2e0h/M6OSrxVK8faWc9o=;
        b=g29Zw37WZvpd5KeRZJYMbE60SYsHV6tE/xpNfxY1KV7zw+aDul/Q6k3P7lfkUuGB0T
         5Cw+/cI8jaDRAAgn3MGhmzfGC4Zh5E02tG0LnDLHR/Jin+3bYn4QVkNuzEjCweXQS1YF
         zdAvodQwJ3o5BzZp5a3jgAuLzBYcWawO0/TbJeRV1d+B+zFuL5+ktWwUKC2guJAXHMy4
         8VYI+ixIbF26sQYFBIon8c9WkyzHKEj/oWl8BujGHxzDRcyyZeUrlGa1M1x4wz8DtPZV
         xizfBAUBhxHbR/4KRrvufGosL5klu65WjO0+FmhPLf28GI19HpzDuyqq0vddi9nSBmK6
         gM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TqZhjk20IEN4ppFRi6jBT+P2e0h/M6OSrxVK8faWc9o=;
        b=Psn6pdmmwAx5acfq+9OIK/YxGPhmBpBFOpY3PijNgjRByQx3TbgIj15BT6kYKjki6P
         4bOBFb7hh/Q0+eKD+ThBRwElW5e+kX0AeDr5DOAkdn0I74BFfFPKoii0olIy02o6xJMF
         1iUzv5KBdlv+4CR1m55vMg4HC98gh4yjf0jka1Zq2/0YsOZzEIYBZ48d3t9kR/vncDSU
         6aAyFcrndlfw6UX9j1xzR3qo5OvF6wlnC2UIg1a4hvtOUhHn9OyBAe5e7ppjF9WPJBxy
         orYHoD++BZLEtnQfRhtAM2H8UBLeLlyPkiy2PmO1LNMG2x+OHt3DuEfnDeg804gmZ2Nd
         shbg==
X-Gm-Message-State: AHQUAuY23963YZnOtZNnMc5jUZ28LC3Oo2MnayvBl1GYGMHJo4/26rVc
        bZqcuXrZvUYZRuUaBBfCjG48utAa0iA=
X-Google-Smtp-Source: AHgI3IbFgXLJftfIqh33Q/q1k85psQG5cy4TFeMAo+OiIrM7PADHAF0H7a7NWSeRMzzIECZzTc/zlw==
X-Received: by 2002:a65:6553:: with SMTP id a19mr10506228pgw.267.1550957878446;
        Sat, 23 Feb 2019 13:37:58 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id p78sm7902889pfa.84.2019.02.23.13.37.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 13:37:56 -0800 (PST)
Date:   Sat, 23 Feb 2019 13:38:00 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V8 1/4] dt-bindings: fsl: scu: add thermal binding
Message-ID: <20190223213759.GA1472@localhost.localdomain>
References: <1550730831-14995-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550730831-14995-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 06:38:30AM +0000, Anson Huang wrote:
> NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
> system controller, the system controller is in charge of system
> power, clock and thermal sensors etc. management, Linux kernel
> has to communicate with system controller via MU (message unit)
> IPC to get temperature from thermal sensors, this patch adds
> binding doc for i.MX system controller thermal driver.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes since V7:
>         - remove unused property "tsens-num";
>         - improve the compatible description;
>         - update examples according to latest dts file.
> ---
>  .../devicetree/bindings/arm/freescale/fsl,scu.txt     | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> index 72d481c..d89147e 100644
> --- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> @@ -122,6 +122,19 @@ RTC bindings based on SCU Message Protocol
>  Required properties:
>  - compatible: should be "fsl,imx8qxp-sc-rtc";
>  
> +Thermal bindings based on SCU Message Protocol
> +------------------------------------------------------------
> +
> +Required properties:
> +- compatible:			Should be :
> +				  "fsl,imx8qxp-sc-thermal"
> +				followed by "fsl,imx-sc-thermal";
> +
> +- #thermal-sensor-cells:	See Documentation/devicetree/bindings/thermal/thermal.txt
> +				for a description.
> +
> +- imx,sensor-resource-id: 	Property array to specify each thermal zone's sensor resource ID.

If this is an array...

> +
>  Example (imx8qxp):
>  -------------
>  lsio_mu1: mailbox@5d1c0000 {
> @@ -168,6 +181,12 @@ firmware {
>  		rtc: rtc {
>  			compatible = "fsl,imx8qxp-sc-rtc";
>  		};
> +
> +		tsens: thermal-sensor {
> +			compatible = "fsl,imx8qxp-sc-thermal", "fsl,imx-sc-thermal";
> +			#thermal-sensor-cells = <0>;
> +			imx,sensor-resource-id = <IMX_SC_R_SYSTEM>;

then this example should have an array, to be better express how this is
supposed to work. Can you please resend this with an array instead?

> +		};
>  	};
>  };
>  
> -- 
> 2.7.4
> 
