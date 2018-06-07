Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id JZxVF3BTGVtUHgAAmS7hNA
	; Thu, 07 Jun 2018 15:47:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CFD25607E7; Thu,  7 Jun 2018 15:47:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 16BAE60590;
	Thu,  7 Jun 2018 15:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 16BAE60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934544AbeFGPrb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:47:31 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50331 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932578AbeFGPra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:47:30 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3DA8520799; Thu,  7 Jun 2018 17:47:28 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-128-7.w90-88.abo.wanadoo.fr [90.88.9.7])
        by mail.bootlin.com (Postfix) with ESMTPSA id C646920012;
        Thu,  7 Jun 2018 17:47:27 +0200 (CEST)
Date: Thu, 7 Jun 2018 17:47:27 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc: <boris.brezillon@bootlin.com>, <richard@nod.at>,
        <wmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <f.fainelli@gmail.com>,
        <mmayer@broadcom.com>, <rogerq@ti.com>, <ladis@linux-mips.org>,
        <ada@thorsis.com>, <honghui.zhang@mediatek.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nagasureshkumarrelli@gmail.com>
Subject: Re: [LINUX PATCH v9 1/4] Devicetree: Add pl353 smc controller
 devicetree binding information
Message-ID: <20180607174727.6fcebde2@xps13>
In-Reply-To: <20180607174203.035f187d@xps13>
References: <1528271382-21690-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1528271382-21690-2-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <20180607174203.035f187d@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On Thu, 7 Jun 2018 17:42:03 +0200, Miquel Raynal
<miquel.raynal@bootlin.com> wrote:

> Hi Naga,
> 
> On Wed, 6 Jun 2018 13:19:39 +0530, Naga Sureshkumar Relli
> <naga.sureshkumar.relli@xilinx.com> wrote:
> 
> > Add pl353 static memory controller devicetree binding information.
> > 
> > Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> > ---
> > Changes in v9:
> >  - Addressed commens given by Randy Dunlap and Miquel Raynal  
> 
> Can you please be more specific in your next changelog? I don't
> remember what I suggested a few months ago :)
> 
> > Changes in v8:
> >  - None
> > Changes in v7:
> > - Corrected clocks description
> > - prefixed '#' for address and size cells 
> > Changes in v6:
> >  - None
> > Changes in v5:
> >  - Removed timing properties
> > Changes in v4:
> >  - none
> > Changes in v3:
> >  - none
> > Changes in v2:
> >  - modified timing binding info as per onfi timing parameters
> >  - add suffix nano second as timing unit
> >  - modified the clock names as per the IP spec
> > ---
> >  .../bindings/memory-controllers/pl353-smc.txt      | 53 ++++++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt b/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
> > new file mode 100644
> > index 0000000..551e66b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
> > @@ -0,0 +1,53 @@
> > +Device tree bindings for ARM PL353 static memory controller
> > +
> > +PL353 static memory controller supports two kinds of memory
> > +interfaces.i.e NAND and SRAM/NOR interfaces.
> > +The actual devices are instantiated from the child nodes of pl353 smc node.
> > +
> > +Required properties:
> > +- compatible		: Should be "arm,pl353-smc-r2p1"  
> 
> I thing Rob prefers:
> 
> - compatible: Must be one of:
>   * arm, pl353-smc-r2p1
> 
> > +- reg			: Controller registers map and length.
> > +- clock-names		: List of input clock names - "ref_clk", "aper_clk"
> > +			  (See clock bindings for details).
> > +- clocks		: Clock phandles (see clock bindings for details).
> > +- address-cells		: Address cells, must be 1.
> > +- size-cells		: Size cells. Must be 1.  
> 
> Please avoid padding, just this is enough:
> 
> - something: And another thing.
> 
> > +
> > +Child nodes:
> > + For NAND the "arm,pl353-nand-r2p1" and for NOR the "cfi-flash" drivers are
> > +supported as child nodes.
> > +
> > +Mandatory timing properties for child nodes:
> > +- arm,nand-cycle-t0	: Read cycle time(t_rc).
> > +- arm,nand-cycle-t1	: Write cycle time(t_wc).
> > +- arm,nand-cycle-t2	: re_n assertion delay(t_rea).
> > +- arm,nand-cycle-t3	: we_n de-assertion delay(t_wp).
> > +- arm,nand-cycle-t4	: Status read time(t_clr)
> > +- arm,nand-cycle-t5	: ID read time(t_ar)
> > +- arm,nand-cycle-t6	: busy to re_n(t_rr)  
> 
> I think this has nothing to do in the DT, you should handle timings
> from the ->setup_data_interface() hook. If you need, you may use
> different compatibles to distinguish different platform data.

Actually these are NAND-chip dependant and should be derived from the
timings given by the core in the SDR interface structure by
->setup_data_interface().
