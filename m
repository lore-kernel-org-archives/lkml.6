Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423001AbeCBIc3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 03:32:29 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:42691 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422901AbeCBIcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 03:32:24 -0500
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To: "vinod.koul@intel.com" <vinod.koul@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>,
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
Thread-Index: AQHTrxIPnicNe7clKkuHCzSXAZ6+oqO8jfgAgAAFEwA=
Date: Fri, 2 Mar 2018 08:32:20 +0000
Message-ID: <1519979538.4430.7.camel@synopsys.com>
References: <20180226145628.11892-1-Eugeniy.Paltsev@synopsys.com>
         <20180226145628.11892-3-Eugeniy.Paltsev@synopsys.com>
         <20180302081408.GK15443@localhost>
In-Reply-To: <20180302081408.GK15443@localhost>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.225.15.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBD9BA228095204CB9DA256D7E8097A1@internal.synopsys.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w228WpuY014910

Hi Vinod,

On Fri, 2018-03-02 at 13:44 +0530, Vinod Koul wrote:
> On Mon, Feb 26, 2018 at 05:56:28PM +0300, Eugeniy Paltsev wrote:
> > This patch adds documentation of device tree bindings for the Synopsys
> > DesignWare AXI DMA controller.
> > 
> > Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> > ---
> >  .../devicetree/bindings/dma/snps,dw-axi-dmac.txt   | 41 ++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
> > new file mode 100644
> > index 0000000..f237b79
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
> > @@ -0,0 +1,41 @@
> > +Synopsys DesignWare AXI DMA Controller
> > +
> > +Required properties:
> > +- compatible: "snps,axi-dma-1.01a"
> > +- reg: Address range of the DMAC registers. This should include
> > +  all of the per-channel registers.
> > +- interrupt: Should contain the DMAC interrupt number.
> > +- interrupt-parent: Should be the phandle for the interrupt controller
> > +  that services interrupts for this device.
> > +- dma-channels: Number of channels supported by hardware.
> > +- snps,dma-masters: Number of AXI masters supported by the hardware.
> > +- snps,data-width: Maximum AXI data width supported by hardware.
> > +  (0 - 8bits, 1 - 16bits, 2 - 32bits, ..., 6 - 512bits)
> > +- snps,priority: Priority of channel. Array size is equal to the number of
> > +  dma-channels. Priority value must be programmed within [0:dma-channels-1]
> > +  range. (0 - minimum priority)
> > +- snps,block-size: Maximum block size supported by the controller channel.
> > +  Array size is equal to the number of dma-channels.
> > +
> > +Optional properties:
> > +- snps,axi-max-burst-len: Restrict master AXI burst length by value specified
> > +  in this property. If this property is missing the maximum AXI burst length
> > +  supported by DMAC is used. [1:256]
> > +
> > +Example:
> > +
> > +dmac: dma-controller@80000 {
> > +	compatible = "snps,axi-dma-1.01a";
> 
> do we need "snps here..?

Synopsys is this IP-block vendor so shouldn't we put it that way?

-Alexey
