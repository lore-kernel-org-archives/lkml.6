Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF8FC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 19:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E077D2172B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 19:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E077D2172B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbeHNWJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 18:09:35 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37267 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbeHNWJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 18:09:35 -0400
Received: by mail-pg1-f195.google.com with SMTP id n7-v6so9535310pgq.4;
        Tue, 14 Aug 2018 12:20:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QmKT2rgn5MepwWz7JfUMYkwpHNQUz/jo8jAKYuQhdEA=;
        b=qU6+L5+SAPkIu9mzk9F25dCUW/2aimbw96PycsqkpUDq9Olsc8kKwiQp03EB8bPmB8
         HsNoUJ7K37eiZ67fInCiKWUzSqXCihf2iHXFZvJOn3EjSHzPf2dfr/2AQ5uWf+I3b49X
         vIZEhCf4Zy0uVq7a47VZEtZI/7E66axabUcyF8kqlOEhIDrgu8Ddu0mHitnV1/vo0a6L
         eYKLgYghhKBLQLzPUuOoU7CplEK/3Y6ZqNM5UauznV9sJf9uhXTUdAh0HHR16QtojNQW
         zLxhN7uD8sfavxGzpSOg+rvwm5ZPV3by+SCLXl9iRdqhN/urBh1SsfOdCUauUS1nAJqZ
         0wMA==
X-Gm-Message-State: AOUpUlFsuhd4NdU43rko5sJwU/ZmKzri8FQzRTDuCXO/nvQvWUAcGhm2
        UglMetL2ycSItmouZ1C2Tw==
X-Google-Smtp-Source: AA+uWPywY0ZZuavPmEMKaIWe6by0uZVNXTCY9GzA8Gqgl/sqh8WNOva16mZD8ploxS5ZFBXKbwePgw==
X-Received: by 2002:a63:fb07:: with SMTP id o7-v6mr22732142pgh.333.1534274455759;
        Tue, 14 Aug 2018 12:20:55 -0700 (PDT)
Received: from localhost ([74.118.88.158])
        by smtp.gmail.com with ESMTPSA id b76-v6sm41420971pfj.184.2018.08.14.12.20.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 12:20:55 -0700 (PDT)
Date:   Tue, 14 Aug 2018 13:20:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Emmanuel Vadot <manu@freebsd.org>
Cc:     rui.zhang@intel.com, edubezval@gmail.com, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: Add DT bindings documentation for
 Allwinner Thermal Sensor Controller
Message-ID: <20180814192053.GA28118@rob-hp-laptop>
References: <20180804070355.14857-1-manu@freebsd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180804070355.14857-1-manu@freebsd.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04, 2018 at 09:03:49AM +0200, Emmanuel Vadot wrote:
> This patch adds documentation for Device-Tree bindings for the Allwinner
> Thermal Sensor Controller found on the H3, H5 and A64 SoCs
> 
> Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
> ---
>  .../bindings/thermal/allwinner-thermal.txt    | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/allwinner-thermal.txt
> 
> diff --git a/Documentation/devicetree/bindings/thermal/allwinner-thermal.txt b/Documentation/devicetree/bindings/thermal/allwinner-thermal.txt
> new file mode 100644
> index 000000000000..5810d44cf495
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/allwinner-thermal.txt
> @@ -0,0 +1,41 @@
> +* Thermal Sensor Controller on Allwinner SoCs
> +
> +Required properties:
> +- compatible : should be "allwinner,<name>-ths"
> +   "allwinner,sun8i-h3-ths": found on H3 and H2+ SoCs
> +   "allwinner,sun50i-h5-ths": found on H5 SoC
> +   "allwinner,sun50i-a64-ths": found on H5 SoC
> +- reg : physical base address of the controller and length of memory mapped
> +	region.
> +- interrupts : The interrupt number to the cpu. The interrupt specifier format
> +	       depends on the interrupt controller.

Just need to say how many entries (and order if more than one).

> +- clocks : Must contain an entry for each entry in clock-names.
> +- clock-names : Shall be "apb" for the bus, and "ths" for
> +		the peripheral clock.
> +- resets : Must contain an entry for each entry in reset-names.
> +	   See ../reset/reset.txt for details.
> +- reset-names : Must be "apb".
> +- #thermal-sensor-cells : Depend on the SoC
> +   For H3 should be 0
> +   For H5 should be 1
> +   For A64 should be 2
> +   See ./thermal.txt for a description.
> +- nvmem-cells : Phandle to the calibration data
> +- nvmem-cell-names = Should be "ths-calib"
> +
> +Example:
> +
> +ths: thermal_sensor@1c25000 {

thermal-sensor@...

> +	compatible = "allwinner,sun8i-h3-ths";
> +	reg = <0x01c25000 0x100>;
> +	interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> +	clocks = <&ccu CLK_BUS_THS>, <&ccu CLK_THS>;
> +	clock-names = "apb", "ths";
> +	resets = <&ccu RST_BUS_THS>;
> +	reset-names = "apb";
> +	#thermal-sensor-cells = <0>;
> +	status = "disabled";
> +
> +	nvmem-cells = <&ths_calib>;
> +	nvmem-cell-names = "ths-calib";
> +};
> -- 
> 2.18.0
> 
