Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74ACDECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4678D2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4678D2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbeJYXIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:08:10 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42733 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbeJYXIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:08:10 -0400
Received: by mail-ot1-f66.google.com with SMTP id c23so9308175otl.9;
        Thu, 25 Oct 2018 07:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fNuX5a4hIqmhZ+hlrxfjYcf4r+Xg0w6mLnMjXvPEcFY=;
        b=Gw+iprncuaQjXdgDnsDZg2TxNhJ+BAg8NWX4L8SuN5wxUOti25Zk13ou13uThOeGqz
         tFhSv6+oc8lGhVaY4nI7YGkIL88pmT6qD0VroBGgZ5iXjOjA/iF5M7IYj9LZbxz859u8
         QM4BpOgJyh9wewJcqbaBoUzf9FG7pCKa2MVb/GuPidnyS/+IZXXnJPdWqQ6lMbs51ryY
         1B4OPxBDcdbcwDd/z4Hh/jHvdxchsvmmEJb1vpYVX+zdxblH+k7En3nmwimhYa/WhDTc
         AolJCq0FrJWN9egSgvcPpKedK+un/2lnBdkELInxI+Sxod0jD8mSgUu6a0xzdQMlyEc9
         z5rw==
X-Gm-Message-State: AGRZ1gLNLsw+s66Ba/DOh8AVRCcFitheC+8d65G4kKjWGQKlkwCA8YDU
        sd8V0Nc5PxOl0VhEnUkl1w==
X-Google-Smtp-Source: AJdET5eXmgZpgAZnVb29HFuZ1ALX7e+s2IZfDZh3acYvoFMfydKpRRCQbJJKCZHegAoZU4IE5I1epw==
X-Received: by 2002:a9d:2a67:: with SMTP id t94mr1636366ota.203.1540478106037;
        Thu, 25 Oct 2018 07:35:06 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 65sm2773211ott.63.2018.10.25.07.35.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 07:35:05 -0700 (PDT)
Date:   Thu, 25 Oct 2018 09:35:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de, patchwork-lst@pengutronix.de
Subject: Re: [PATCH 1/2] dt-bindings: irq: add binding for Freescale IRQSTEER
 multiplexer
Message-ID: <20181025143504.GA9673@bogus>
References: <20181016164218.3736-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016164218.3736-1-l.stach@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 06:42:17PM +0200, Lucas Stach wrote:
> This adds the DT binding for the Freescale IRQSTEER interrupt
> multiplexer found in the i.MX8 familiy SoCs.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  .../interrupt-controller/fsl,irqsteer.txt     | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
> new file mode 100644
> index 000000000000..ed2b18165591
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
> @@ -0,0 +1,39 @@
> +Freescale IRQSTEER Interrupt multiplexer
> +
> +Required properties:
> +
> +- compatible: should be:
> +	- "fsl,imx8m-irqsteer"
> +	- "fsl,imx-irqsteer"
> +- reg: Physical base address and size of registers.
> +- interrupts: Should contain the parent interrupt line used to multiplex the
> +  input interrupts.
> +- clocks: Should contain one clock for entry in clock-names
> +  see Documentation/devicetree/bindings/clock/clock-bindings.txt
> +- clock-names:
> +   - "ipg": main logic clock
> +- interrupt-controller: Identifies the node as an interrupt controller.
> +- #interrupt-cells: Specifies the number of cells needed to encode an
> +  interrupt source. The value must be 2.
> +
> +Optional properties:
> +- fsl,channel: Number of channels managed by this controller. Each channel
> +  contains up to 32 interrupt sources. If absent defaults to 1.

What's a channel? Why isn't this implied by the compatible?

> +- fsl,endian:

The standard property for endianness doesn't work for you?

> +  0: controller registers are little endian
> +  1: controller registers are big endian
> +  If absent defaults to 0.
> +
> +Example:
> +
> +	interrupt-controller@32e2d000 {
> +		compatible = "fsl,imx8m-irqsteer", "fsl,imx-irqsteer";
> +		reg = <0x32e2d000 0x1000>;
> +		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&clk IMX8MQ_CLK_DISP_APB_ROOT>;
> +		clock-names = "ipg";
> +		fsl,channel = <2>;
> +		fsl,endian = <1>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> -- 
> 2.19.0
> 
