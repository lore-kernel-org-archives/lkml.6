Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625F2C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198D220665
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 198D220665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbeJZDTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 23:19:55 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44291 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbeJZDTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 23:19:55 -0400
Received: by mail-ot1-f67.google.com with SMTP id p23so10123358otf.11;
        Thu, 25 Oct 2018 11:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F4GWN3Mn/u1ggaUQqNv4rOGAVBIMU1JA0RM0j/uF1MQ=;
        b=j/28j0QWaG9pgzXggRtry3aSBMZnPFMbwn2YQHFnajjxSphATMkqt6wwQnxU6whaUS
         qpOOIEMKP+Hq6Rz0Njdlvcsg9dP7ckiPW+h9y/CNbxkeR6jL6cnRdNQGcJuqKq/70Gw5
         FjL9Obm4ef7O8f7+SOghnQjhbR58c3B9LXAk0Wv2RpbhhjwLk47Cb3BnEumYX3Dap0Fv
         IqRMpu2hB82CPoXFtZaIwrAdfnM57vE68kXbn8aEMbJWDchhKMFsjqEjAqyZjB13GURw
         5l5te/ExTFdUWQn6+72xPQkRwetWYkNFDu1Z+pGFbrLuvIBN7z6+bMwKZ3KAQGQYJJxC
         gg5Q==
X-Gm-Message-State: AGRZ1gL1ohmZBGZrBNe92sNEhsV9qlp9COp5jBbh4XoNoTmQtjxk8CeF
        SOckrQP7QUzmE9yMQTL26w==
X-Google-Smtp-Source: AJdET5cqMK9s1v9HLSaJjlkqBSk4e1ED9qVtzBuuqYh/CuO9fPm5bn4GnMhUuG0NXSFMWIBKdriPdg==
X-Received: by 2002:a9d:2847:: with SMTP id h7mr285785otd.214.1540493158258;
        Thu, 25 Oct 2018 11:45:58 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j50sm2245493otc.54.2018.10.25.11.45.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 11:45:57 -0700 (PDT)
Date:   Thu, 25 Oct 2018 13:45:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 06/10] dt-bindings: irqchip: Introduce TISCI Interrupt
 router bindings
Message-ID: <20181025184556.GA19597@bogus>
References: <20181018154017.7112-1-lokeshvutla@ti.com>
 <20181018154017.7112-7-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018154017.7112-7-lokeshvutla@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 09:10:13PM +0530, Lokesh Vutla wrote:
> Add the DT binding documentation for Interrupt router driver.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
> Changes since v1:
> - Drop dependency on GIC
> - Updated supported interrupt types.
> 
>  .../interrupt-controller/ti,sci-intr.txt      | 81 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
> new file mode 100644
> index 000000000000..276bb4f0ad12
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
> @@ -0,0 +1,81 @@
> +Texas Instruments K3 Interrupt Router
> +=====================================
> +
> +The Interrupt Router (INTR) module provides a mechanism to mux M
> +interrupt inputs to N interrupt outputs, where all M inputs are selectable
> +to be driven per N output. There is one register per output (MUXCNTL_N) that
> +controls the selection.
> +
> +
> +                                 Interrupt Router
> +                             +----------------------+
> +                             |  Inputs     Outputs  |
> +        +-------+            | +------+             |
> +        | GPIO  |----------->| | irq0 |             |       Host IRQ
> +        +-------+            | +------+             |      controller
> +                             |    .        +-----+  |      +-------+
> +        +-------+            |    .        |  0  |  |----->|  IRQ  |
> +        | INTA  |----------->|    .        +-----+  |      +-------+
> +        +-------+            |    .          .      |
> +                             | +------+      .      |
> +                             | | irqM |    +-----+  |
> +                             | +------+    |  N  |  |
> +                             |             +-----+  |
> +                             +----------------------+
> +
> +Configuration of these MUXCNTL_N registers is done by a system controller
> +(like the Device Memory and Security Controller on K3 AM654 SoC). System
> +controller will keep track of the used and unused registers within the Router.
> +Driver should request the system controller to get the range of GIC IRQs
> +assigned to the requesting hosts. It is the drivers responsibility to keep
> +track of Host IRQs.
> +
> +Communication between the host processor running an OS and the system
> +controller happens through a protocol called TI System Control Interface
> +(TISCI protocol). For more details refer:
> +Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
> +
> +TISCI Interrupt Router Node:
> +----------------------------
> +- compatible:		Must be "ti,sci-intr".
> +- interrupt-controller:	Identifies the node as an interrupt controller
> +- #interrupt-cells:	Specifies the number of cells needed to encode an
> +			interrupt source. The value should be 3.
> +			First cell should contain the TISCI device ID of source
> +			Second cell should contain the interrupt source offset
> +			within the device
> +			Third cell specifies the trigger type as defined
> +			in interrupts.txt in this directory. Only level
> +			sensitive trigger types are supported.
> +- interrupt-parent:	phandle of irq parent for TISCI intr.

This is implied and could be in a parent node.

> +- ti,sci:		Phandle to TI-SCI compatible System controller node.
> +- ti,sci-dst-id:	TISCI device ID of the destination IRQ controller.
> +- ti,sci-rm-range-girq:	TISCI subtype id representing the host irqs assigned
> +			to this interrupt router.

These need a better explanation and there's still some questions on v1 
asked of me that I tried to answer.

> +
> +Example:
> +--------
> +The following example demonstrates both interrupt router node and the consumer
> +node(main gpio) on the AM654 SoC:
> +
> +main_intr: interrupt-controller@1 {
> +	compatible = "ti,sci-intr";
> +	interrupt-controller;
> +	interrupt-parent = <&gic>;
> +	#interrupt-cells = <3>;
> +	ti,sci = <&dmsc>;
> +	ti,sci-dst-id = <56>;
> +	ti,sci-rm-range-girq = <0x1>;
> +};
> +
> +main_gpio0:  main_gpio0@600000 {

gpio@...

> +	...
> +	interrupt-parent = <&main_intr>;
> +	interrupts = <57 256 IRQ_TYPE_EDGE_RISING>,
> +			<57 257 IRQ_TYPE_EDGE_RISING>,
> +			<57 258 IRQ_TYPE_EDGE_RISING>,
> +			<57 259 IRQ_TYPE_EDGE_RISING>,
> +			<57 260 IRQ_TYPE_EDGE_RISING>,
> +			<57 261 IRQ_TYPE_EDGE_RISING>;
> +	...
> +};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 06966772cad4..710cf728b9d0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14686,6 +14686,7 @@ F:	Documentation/devicetree/bindings/reset/ti,sci-reset.txt
>  F:	Documentation/devicetree/bindings/clock/ti,sci-clk.txt
>  F:	drivers/clk/keystone/sci-clk.c
>  F:	drivers/reset/reset-ti-sci.c
> +F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>  
>  THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
>  M:	Hans Verkuil <hverkuil@xs4all.nl>
> -- 
> 2.19.1
> 
