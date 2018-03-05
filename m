Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753039AbeCEVtb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 16:49:31 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:42550 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751275AbeCEVt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 16:49:29 -0500
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To: "robh@kernel.org" <robh@kernel.org>,
        "vinod.koul@intel.com" <vinod.koul@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "wan.ahmad.zainie.wan.mohamad@intel.com"
        <wan.ahmad.zainie.wan.mohamad@intel.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: Document the Synopsys DW AXI DMA
 bindings
Thread-Topic: [PATCH v2 2/2] dt-bindings: Document the Synopsys DW AXI DMA
 bindings
Thread-Index: AQHTrxIPnicNe7clKkuHCzSXAZ6+oqO8jfgAgAAFEwCABIThAIABBTeAgAALmQA=
Date: Mon, 5 Mar 2018 21:49:23 +0000
Message-ID: <1520286562.4366.13.camel@synopsys.com>
References: <20180226145628.11892-1-Eugeniy.Paltsev@synopsys.com>
         <20180226145628.11892-3-Eugeniy.Paltsev@synopsys.com>
         <20180302081408.GK15443@localhost> <1519979538.4430.7.camel@synopsys.com>
         <20180305053256.GN15443@localhost>
         <20180305210751.7wzo2lqvyldijkot@rob-hp-laptop>
In-Reply-To: <20180305210751.7wzo2lqvyldijkot@rob-hp-laptop>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.225.15.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF78EA1C8FD37B4ABE3B4AD3B15F45BA@internal.synopsys.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w25Lncig020851

Hi Rob,

On Mon, 2018-03-05 at 15:07 -0600, Rob Herring wrote:
> On Mon, Mar 05, 2018 at 11:02:56AM +0530, Vinod Koul wrote:
> > On Fri, Mar 02, 2018 at 08:32:20AM +0000, Alexey Brodkin wrote:
> > > Hi Vinod,
> > > 
> > > On Fri, 2018-03-02 at 13:44 +0530, Vinod Koul wrote:
> > > > On Mon, Feb 26, 2018 at 05:56:28PM +0300, Eugeniy Paltsev wrote:
> > > > > This patch adds documentation of device tree bindings for the Synopsys
> > > > > DesignWare AXI DMA controller.
> > > > > 
> > > > > Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> > > > > ---
> > > > >  .../devicetree/bindings/dma/snps,dw-axi-dmac.txt   | 41 ++++++++++++++++++++++
> > > > >  1 file changed, 41 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
> > > > > new file mode 100644
> > > > > index 0000000..f237b79
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
> > > > > @@ -0,0 +1,41 @@
> > > > > +Synopsys DesignWare AXI DMA Controller
> > > > > +
> > > > > +Required properties:
> > > > > +- compatible: "snps,axi-dma-1.01a"
> > > > > +- reg: Address range of the DMAC registers. This should include
> > > > > +  all of the per-channel registers.
> > > > > +- interrupt: Should contain the DMAC interrupt number.
> > > > > +- interrupt-parent: Should be the phandle for the interrupt controller
> > > > > +  that services interrupts for this device.
> > > > > +- dma-channels: Number of channels supported by hardware.
> > > > > +- snps,dma-masters: Number of AXI masters supported by the hardware.
> > > > > +- snps,data-width: Maximum AXI data width supported by hardware.
> > > > > +  (0 - 8bits, 1 - 16bits, 2 - 32bits, ..., 6 - 512bits)
> > > > > +- snps,priority: Priority of channel. Array size is equal to the number of
> > > > > +  dma-channels. Priority value must be programmed within [0:dma-channels-1]
> > > > > +  range. (0 - minimum priority)
> > > > > +- snps,block-size: Maximum block size supported by the controller channel.
> > > > > +  Array size is equal to the number of dma-channels.
> > > > > +
> > > > > +Optional properties:
> > > > > +- snps,axi-max-burst-len: Restrict master AXI burst length by value specified
> > > > > +  in this property. If this property is missing the maximum AXI burst length
> > > > > +  supported by DMAC is used. [1:256]
> > > > > +
> > > > > +Example:
> > > > > +
> > > > > +dmac: dma-controller@80000 {
> > > > > +	compatible = "snps,axi-dma-1.01a";
> > > > 
> > > > do we need "snps here..?
> > > 
> > > Synopsys is this IP-block vendor so shouldn't we put it that way?
> > 
> > Not a DT expert but why should vendor name come here, you can read the
> > properties from device node, vendor name seems redundant to me
> 
> I don't follow...
> 
> In any case, yes, it must have a vendor prefix. It should also have a 
> compatible for the vendor(s) that integrate the block because they all 
> break it in different ways. Speaking of which, we already have 
> snps-dma.txt and at least Analog Devices binding using a Synopsys DMA. 
> What's the difference?
> 

There's indeed some confusion.

1. As a part of a _new_driver_ submission we're preparing DT bindings docs where we
   need to require some compatible string... well at least many other binding docs
   do so if I'm not mistaken. And so we propose to require "snps,axi-dma-1.01a"
   where version matches implementation in an SoC we currently have.

2. In that string we mention Synopsys as a vendor but for driver alone (without any particular SoC)
   it is relaeted to IP-block which might end-up being used in many different SoCs.

3. Synopsys has 2 completely different DMAC IP-blocks. Well-known AHB DMAC, see [1], [2]
   and AXI DMAC, see [3] which is not yet used anywhere and that's the one we're discussing
   currently.

4. This DW AXI DMAC seems to have nothing to do with mentioned "dma-axi-dmac.c" which
   BTW has compatible = "adi,axi-dmac-1.00.a".
   
As an underline I don't see any other option for "default" compatible for that
brand new DMAC driver, though once we start adding SoC that really use that IP-block
we may get more compatible strings if implementations differ from what we have now.

[1] https://www.synopsys.com/dw/ipdir.php?c=DW_ahb_dmac
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/dma/dw
[3] https://www.synopsys.com/dw/ipdir.php?c=DW_axi_dmac

Regards,
Alexey
