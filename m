Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752974AbeCEVH4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 16:07:56 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:41296 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752063AbeCEVHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 16:07:54 -0500
X-Google-Smtp-Source: AG47ELsX8k8JX8S8pj504CYQfYfbzmV7h3aMvsHUjlqvGNzg83eHbvapCyNMqfPXXIC6agl7964UQQ==
Date: Mon, 5 Mar 2018 15:07:51 -0600
From: Rob Herring <robh@kernel.org>
To: Vinod Koul <vinod.koul@intel.com>
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Message-ID: <20180305210751.7wzo2lqvyldijkot@rob-hp-laptop>
References: <20180226145628.11892-1-Eugeniy.Paltsev@synopsys.com>
 <20180226145628.11892-3-Eugeniy.Paltsev@synopsys.com>
 <20180302081408.GK15443@localhost>
 <1519979538.4430.7.camel@synopsys.com>
 <20180305053256.GN15443@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305053256.GN15443@localhost>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 11:02:56AM +0530, Vinod Koul wrote:
> On Fri, Mar 02, 2018 at 08:32:20AM +0000, Alexey Brodkin wrote:
> > Hi Vinod,
> > 
> > On Fri, 2018-03-02 at 13:44 +0530, Vinod Koul wrote:
> > > On Mon, Feb 26, 2018 at 05:56:28PM +0300, Eugeniy Paltsev wrote:
> > > > This patch adds documentation of device tree bindings for the Synopsys
> > > > DesignWare AXI DMA controller.
> > > > 
> > > > Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> > > > ---
> > > >  .../devicetree/bindings/dma/snps,dw-axi-dmac.txt   | 41 ++++++++++++++++++++++
> > > >  1 file changed, 41 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
> > > > new file mode 100644
> > > > index 0000000..f237b79
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
> > > > @@ -0,0 +1,41 @@
> > > > +Synopsys DesignWare AXI DMA Controller
> > > > +
> > > > +Required properties:
> > > > +- compatible: "snps,axi-dma-1.01a"
> > > > +- reg: Address range of the DMAC registers. This should include
> > > > +  all of the per-channel registers.
> > > > +- interrupt: Should contain the DMAC interrupt number.
> > > > +- interrupt-parent: Should be the phandle for the interrupt controller
> > > > +  that services interrupts for this device.
> > > > +- dma-channels: Number of channels supported by hardware.
> > > > +- snps,dma-masters: Number of AXI masters supported by the hardware.
> > > > +- snps,data-width: Maximum AXI data width supported by hardware.
> > > > +  (0 - 8bits, 1 - 16bits, 2 - 32bits, ..., 6 - 512bits)
> > > > +- snps,priority: Priority of channel. Array size is equal to the number of
> > > > +  dma-channels. Priority value must be programmed within [0:dma-channels-1]
> > > > +  range. (0 - minimum priority)
> > > > +- snps,block-size: Maximum block size supported by the controller channel.
> > > > +  Array size is equal to the number of dma-channels.
> > > > +
> > > > +Optional properties:
> > > > +- snps,axi-max-burst-len: Restrict master AXI burst length by value specified
> > > > +  in this property. If this property is missing the maximum AXI burst length
> > > > +  supported by DMAC is used. [1:256]
> > > > +
> > > > +Example:
> > > > +
> > > > +dmac: dma-controller@80000 {
> > > > +	compatible = "snps,axi-dma-1.01a";
> > > 
> > > do we need "snps here..?
> > 
> > Synopsys is this IP-block vendor so shouldn't we put it that way?
> 
> Not a DT expert but why should vendor name come here, you can read the
> properties from device node, vendor name seems redundant to me

I don't follow...

In any case, yes, it must have a vendor prefix. It should also have a 
compatible for the vendor(s) that integrate the block because they all 
break it in different ways. Speaking of which, we already have 
snps-dma.txt and at least Analog Devices binding using a Synopsys DMA. 
What's the difference?

Rob
