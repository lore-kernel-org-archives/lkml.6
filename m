Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752340AbeCEP0Y (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 10:26:24 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:60584 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751389AbeCEP0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 10:26:20 -0500
From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To: "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
CC: "vinod.koul@intel.com" <vinod.koul@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "wan.ahmad.zainie.wan.mohamad@intel.com"
        <wan.ahmad.zainie.wan.mohamad@intel.com>
Subject: Re: [PATCH v2 1/2] dmaengine: Introduce DW AXI DMAC driver
Thread-Topic: [PATCH v2 1/2] dmaengine: Introduce DW AXI DMAC driver
Thread-Index: AQHTrxIKKwJ+pE4H3kOhh2UUT+cHx6O20tCAgArq1wA=
Date: Mon, 5 Mar 2018 15:26:07 +0000
Message-ID: <1520263566.3152.17.camel@synopsys.com>
References: <20180226145628.11892-1-Eugeniy.Paltsev@synopsys.com>
         <20180226145628.11892-2-Eugeniy.Paltsev@synopsys.com>
         <CAHp75Vc6KtppecYJBtuXTGCzXySOUZiYqxBfb6w69f1j3J0jDQ@mail.gmail.com>
In-Reply-To: <CAHp75Vc6KtppecYJBtuXTGCzXySOUZiYqxBfb6w69f1j3J0jDQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.67]
Content-Type: text/plain; charset="utf-8"
Content-ID: <78788F79FADF0D4D91A0F9E14416F4D6@internal.synopsys.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w25FQUQn024709

On Mon, 2018-02-26 at 18:42 +0200, Andy Shevchenko wrote:
> On Mon, Feb 26, 2018 at 4:56 PM, Eugeniy Paltsev
> <Eugeniy.Paltsev@synopsys.com> wrote:
> > +static int parse_device_properties(struct axi_dma_chip *chip)
> > +{
> > +       ret = device_property_read_u32(dev, "snps,dma-masters", &tmp);
> 
> Why it has prefix?
> 
> > +       ret = device_property_read_u32(dev, "snps,data-width", &tmp);
> 
> Ditto.
> 
> > +       ret = device_property_read_u32_array(dev, "snps,block-size", carr,
> > +                                            chip->dw->hdata->nr_channels);
> 
> (perhaps this one can be moved outside of local namespace)
> 
> > +       ret = device_property_read_u32_array(dev, "snps,priority", carr,
> > +                                            chip->dw->hdata->nr_channels);
> 
> Can you use just "priority"?
> 
> 

Rob Herring asked me to add vendor prefix to this properties.
See http://patchwork.ozlabs.org/patch/719708/

-------------------->8--------------------------
> > +Required properties:
> > +- compatible: "snps,axi-dma"
> 
> Too generic. This needs an IP version at least.
> 
> > +- reg: Address range of the DMAC registers. This should include
> > +  all of the per-channel registers.
> > +- interrupt: Should contain the DMAC interrupt number.
> > +- interrupt-parent: Should be the phandle for the interrupt controller
> > +  that services interrupts for this device.
> > +- dma-channels: Number of channels supported by hardware.
> > +- dma-masters: Number of AXI masters supported by the hardware.
> > +- data-width: Maximum AXI data width supported by hardware.
> > +  (0 - 8bits, 1 - 16bits, 2 - 32bits, ..., 6 - 512bits)
> 
> > +- priority: Priority of channel. Array property. Priority value must be
> > +  programmed within [0:dma-channels-1] range. (0 - minimum priority)
> > +- block-size: Maximum block size supported by the controller channel. Array
> > +  property.
> 
> Other than dma-channels, all these either need vendor prefix.
> 
-------------------->8--------------------------



On Fri, 2018-03-02 at 13:44 +0530, Vinod Koul wrote:
> On Mon, Feb 26, 2018 at 05:56:28PM +0300, Eugeniy Paltsev wrote:
> > +dmac: dma-controller@80000 {
> > +	compatible = "snps,axi-dma-1.01a";
> 
> do we need "snps here..?
> 

Ditto.

-- 
 Eugeniy Paltsev
