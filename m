Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9753C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E4992081C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4992081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeKIWes convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 17:34:48 -0500
Received: from mail.bootlin.com ([62.4.15.54]:44794 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727676AbeKIWer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 17:34:47 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 497372072A; Fri,  9 Nov 2018 13:54:16 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-30-49.w90-88.abo.wanadoo.fr [90.88.15.49])
        by mail.bootlin.com (Postfix) with ESMTPSA id E485A2071E;
        Fri,  9 Nov 2018 13:54:05 +0100 (CET)
Date:   Fri, 9 Nov 2018 13:54:05 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Naga Sureshkumar Relli <nagasure@xilinx.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nagasuresh12@gmail.com" <nagasuresh12@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>
Subject: Re: [LINUX PATCH v12 1/3] dt-bindings: mtd: arasan: Add device tree
 binding documentation
Message-ID: <20181109135405.3b93b267@xps13>
In-Reply-To: <MWHPR02MB26235AB9959635CAA1B2B878AFC60@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1541739641-17789-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1541739641-17789-2-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <20181109072857.75e86cb6@bbrezillon>
        <MWHPR02MB26235AB9959635CAA1B2B878AFC60@MWHPR02MB2623.namprd02.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naga,

[...]

> > > diff --git a/Documentation/devicetree/bindings/mtd/arasan_nand.txt
> > > b/Documentation/devicetree/bindings/mtd/arasan_nand.txt
> > > new file mode 100644
> > > index 0000000..b522daf
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mtd/arasan_nand.txt
> > > @@ -0,0 +1,32 @@
> > > +Arasan NAND Flash Controller with ONFI 3.1 support
> > > +
> > > +Required properties:
> > > +- compatible:		Should be "xlnx,zynqmp-nand", "arasan,nfc-v3p10"
> > > +- reg:			Memory map for module access
> > > +- interrupts:		Should contain the interrupt for the device
> > > +- clock-name:		List of input clocks - "sys", "flash"
> > > +			(See clock bindings for details)
> > > +- clocks:		Clock phandles (see clock bindings for details)
> > > +
> > > +Required properties for child node:
> > > +- nand-ecc-mode: see nand.txt  
> > 
> > Why is it required? Can't you fallback to HW when this prop is missing?  
> Yes, we can.
> Do you want me to update that in driver now? 
> Looks like you have some comments in driver as well, so while addressing those I will update the code to fallback to HW ECC when 
> It is missing.

Yes, please.

> 
> > Oh, and reg is not listed in the required props.  
> Which reg?
> I already mention this " reg:	Memory map for module access " in required properties.
> 
> Thanks,
> Naga Sureshkumar Relli
> >   
> > > +
> > > +For NAND partition information please refer the below file
> > > +Documentation/devicetree/bindings/mtd/partition.txt
> > > +
> > > +Example:
> > > +	nfc: nand@ff100000 {
> > > +		compatible = "xlnx,zynqmp-nand", "arasan,nfc-v3p10";
> > > +		reg = <0x0 0xff100000 0x1000>;
> > > +		clock-name = "sys", "flash";
> > > +		clocks = <&misc_clk &misc_clk>;
> > > +		interrupt-parent = <&gic>;
> > > +		interrupts = <0 14 4>;
> > > +		#address-cells = <1>;
> > > +		#size-cells = <0>;
> > > +
> > > +		nand@0 {
> > > +			reg = <0>;

This one, for the CS line(s).

> > > +			nand-ecc-mode = "hw";
> > > +		};
> > > +	};  
> 


Thanks,
Miquèl
