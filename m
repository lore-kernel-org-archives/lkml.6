Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242A6ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C730E205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C730E205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbeJQVpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:45:16 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34988 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeJQVpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:45:16 -0400
Received: by mail-oi1-f196.google.com with SMTP id 22-v6so21125655oiz.2;
        Wed, 17 Oct 2018 06:49:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dglbM1S1hBqJQYWWQpWxlZTAGqfDaXFS74Vo46ffhJI=;
        b=HeQHHyPMWHIpK2bfIZZ/z14bH6iJ25DZyKtP2xwhzONqGj99Yxv6nIQKJ1i1Sp4qKz
         gOYdy4cjjGHR65ZART/BvyGo1AbwzquPnJYBolEw8wvkmlh+prwKT6O4k1HP0blIWtVP
         ET3KjA9r9t5lm9DQd1rztqX9FokVYsCI99YHFaM0w39ZqC9YuujebQTWqhZZI7id0rw6
         gx15v447pQiQ3mtFm1O+edLTkJv3bQWUU27nmBxYhurYgOS/xL+lYdbuFD72RQT18CN0
         XewTNpDOV+Zn+SOxUXeeyq57Ow3y2ecbL+UVWtfqqpH7o0az8622AZUQ6VN8WxS/6U7C
         vLhg==
X-Gm-Message-State: ABuFfojz+2QGloC6peHzxen0alIWqWnzvoxrqu/ZZqNoRlDW7pN4clK/
        hxsOXP99Yvp/R+mhCSofqQ==
X-Google-Smtp-Source: ACcGV62wKR3SX9wmviwDaKVBu2WQv/ofWDqydub+Xfmp0CBVwofZvEwlVBTMoLnfVdWlRAnY+S9htA==
X-Received: by 2002:aca:68c5:: with SMTP id o66-v6mr8928901oik.96.1539784167321;
        Wed, 17 Oct 2018 06:49:27 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o82-v6sm5050104oif.37.2018.10.17.06.49.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 06:49:26 -0700 (PDT)
Date:   Wed, 17 Oct 2018 08:49:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Lokesh Vutla <lokeshvutla@ti.com>, Tero Kristo <t-kristo@ti.com>,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 1/2] dt-bindings: irqchip: Introduce TISCI Interrupt
 router bindings
Message-ID: <20181017134925.GA7084@bogus>
References: <20181006072812.15814-1-lokeshvutla@ti.com>
 <20181006072812.15814-2-lokeshvutla@ti.com>
 <20181006162929.u6uh4ffn6gm3incf@akan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181006162929.u6uh4ffn6gm3incf@akan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 06, 2018 at 11:29:29AM -0500, Nishanth Menon wrote:
> On 12:58-20181006, Lokesh Vutla wrote:
> > Add the DT binding documentation for Interrupt router driver.
> > 
> > Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> > ---
> >  .../interrupt-controller/ti,sci-intr.txt      | 83 +++++++++++++++++++
> >  MAINTAINERS                                   |  1 +
> >  2 files changed, 84 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
> > new file mode 100644
> > index 000000000000..681ca53cc5fb
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
> > @@ -0,0 +1,83 @@
> > +Texas Instruments K3 Interrupt Router
> > +=====================================
> > +
> > +The Interrupt Router (INTR) module provides a mechanism to mux M
> > +interrupt inputs to N interrupt outputs, where all M inputs are selectable
> > +to be driven per N output. There is one register per output (MUXCNTL_N) that
> > +controls the selection.
> > +
> > +
> > +                                 Interrupt Router
> > +                             +----------------------+
> > +                             |  Inputs     Outputs  |
> > +        +-------+            | +------+             |
> > +        | GPIO  |----------->| | irq0 |             |       Host IRQ
> > +        +-------+            | +------+             |      controller
> > +                             |    .        +-----+  |      +-------+
> > +        +-------+            |    .        |  0  |  |----->|  GIC  |
> > +        | INTA  |----------->|    .        +-----+  |      +-------+
> > +        +-------+            |    .          .      |
> > +                             | +------+      .      |
> > +                             | | irqM |    +-----+  |
> > +                             | +------+    |  N  |  |
> > +                             |             +-----+  |
> > +                             +----------------------+
> > +
> > +Configuration of these MUXCNTL_N registers is done by a system controller
> > +(like the Device Memory and Security Controller on K3 AM654 SoC). System
> > +controller will keep track of the used and unused registers within the Router.
> > +Driver should request the system controller to get the range of GIC IRQs
> > +assigned to the requesting hosts. It is the drivers responsibility to keep
> > +track of GIC IRQs.
> > +
> > +Communication between the host processor running an OS and the system
> > +controller happens through a protocol called TI System Control Interface
> > +(TISCI protocol). For more details refer:
> > +Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
> > +
> > +TISCI Interrupt Router Node:
> > +----------------------------
> > +- compatible:		Must be "ti,sci-intr".
> > +- interrupt-controller:	Identifies the node as an interrupt controller
> > +- #interrupt-cells:	Specifies the number of cells needed to encode an
> > +			interrupt source. The value should be 3.
> > +			First cell should contain the TISCI device ID of source
> > +			Second cell should contain the interrupt source offset
> > +			within the device
> > +			Third cell specifies the trigger type as defined
> > +			in interrupts.txt in this directory.
> > +- interrupt-parent:	phandle of irq parent for TISCI intr. The parent must
> > +			use the same interrupt-cells format as GIC.
> > +- ti,sci:		Phandle to TI-SCI compatible System controller node.
> > +- ti,sci-dst-id:	TISCI device ID of the destination IRQ controller.
> > +- ti,sci-rm-range-girq:	Tuple corresponding to unique TISCI resource type that
> > +			defines the dst host irq ranges assigned to this
> > +			interrupt router from this host context.
> > +			Tuple should be of format <type subtype>.
> > +
> 
> Rob, DT maintainers,
> 
> I'd like a feedback from DT maintainers on this 'range' topic.
> 
> TISCI Firmware [1] currently seems to define a type corresponding to a
> device ID[2]. in AM6 device, for example, this is different, however
> have a 1 to 1 correspondence. However, there is expectation that type will
> end up as device ID in a future SoC.
> 
> While this is subject to much debate internally, I'd like some feedback if this
> is OK from Device tree representation - it is true that Firmware does
> look at it as type, however in some future SoC, it could be that the
> values themselves may correspond one to one with a device id -> The
> original wish was that types might be something reusable across SoCs,
> but that is turning out to be more of a theoretical wish than any thing
> practical.

I'm not sure I follow all the terminology here of type, subtype, "dst 
host irq", etc. It looks to me like you should be using interrupt-map property.

Rob

> 
> [1]http://software-dl.ti.com/tisci/esd/latest/5_soc_doc/am6x/resasg_types.html
> [2]http://software-dl.ti.com/tisci/esd/latest/5_soc_doc/am6x/devices.html
> -- 
> Regards,
> Nishanth Menon
