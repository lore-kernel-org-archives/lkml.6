Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADCEC677E8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 16:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3F3F208E7
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 16:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vi12rti+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3F3F208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbeJFXeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 19:34:09 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42046 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725266AbeJFXeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 19:34:09 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w96GTV2i022913;
        Sat, 6 Oct 2018 11:29:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538843371;
        bh=Mx+k+8UlU6t+lRSMyrxqshCbhbVL3if/0SY8ujaZ/Ng=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=vi12rti+ZyCjHpEkI1Wn32HPx1g4tNFX9KdgvgdrcmXwzq2y/dOUjo4oLcSJ6r5fx
         kAOK9Dgwx6CQTwx4DFDJCHmNlaVzvbSqDBwM1RI6Vye6G6zPztXXxSzqvtaV7aK+RB
         QixRAOHi8vq4UqeZrb6CcaR42nFXgN2cMdm8Zu9s=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w96GTVB8000928;
        Sat, 6 Oct 2018 11:29:31 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Sat, 6 Oct
 2018 11:29:31 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Sat, 6 Oct 2018 11:29:31 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w96GTUMq012991;
        Sat, 6 Oct 2018 11:29:30 -0500
Date:   Sat, 6 Oct 2018 11:29:29 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Lokesh Vutla <lokeshvutla@ti.com>
CC:     Tero Kristo <t-kristo@ti.com>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 1/2] dt-bindings: irqchip: Introduce TISCI Interrupt
 router bindings
Message-ID: <20181006162929.u6uh4ffn6gm3incf@akan>
References: <20181006072812.15814-1-lokeshvutla@ti.com>
 <20181006072812.15814-2-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181006072812.15814-2-lokeshvutla@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12:58-20181006, Lokesh Vutla wrote:
> Add the DT binding documentation for Interrupt router driver.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>  .../interrupt-controller/ti,sci-intr.txt      | 83 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
> new file mode 100644
> index 000000000000..681ca53cc5fb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
> @@ -0,0 +1,83 @@
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
> +        +-------+            |    .        |  0  |  |----->|  GIC  |
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
> +track of GIC IRQs.
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
> +			in interrupts.txt in this directory.
> +- interrupt-parent:	phandle of irq parent for TISCI intr. The parent must
> +			use the same interrupt-cells format as GIC.
> +- ti,sci:		Phandle to TI-SCI compatible System controller node.
> +- ti,sci-dst-id:	TISCI device ID of the destination IRQ controller.
> +- ti,sci-rm-range-girq:	Tuple corresponding to unique TISCI resource type that
> +			defines the dst host irq ranges assigned to this
> +			interrupt router from this host context.
> +			Tuple should be of format <type subtype>.
> +

Rob, DT maintainers,

I'd like a feedback from DT maintainers on this 'range' topic.

TISCI Firmware [1] currently seems to define a type corresponding to a
device ID[2]. in AM6 device, for example, this is different, however
have a 1 to 1 correspondence. However, there is expectation that type will
end up as device ID in a future SoC.

While this is subject to much debate internally, I'd like some feedback if this
is OK from Device tree representation - it is true that Firmware does
look at it as type, however in some future SoC, it could be that the
values themselves may correspond one to one with a device id -> The
original wish was that types might be something reusable across SoCs,
but that is turning out to be more of a theoretical wish than any thing
practical.

[1]http://software-dl.ti.com/tisci/esd/latest/5_soc_doc/am6x/resasg_types.html
[2]http://software-dl.ti.com/tisci/esd/latest/5_soc_doc/am6x/devices.html
-- 
Regards,
Nishanth Menon
