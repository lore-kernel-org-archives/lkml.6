Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238ABC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D163B20652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D163B20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbeIFQTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:19:04 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52692 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbeIFQTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:19:03 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E25B420763; Thu,  6 Sep 2018 13:43:57 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-30-219.w90-88.abo.wanadoo.fr [90.88.15.219])
        by mail.bootlin.com (Postfix) with ESMTPSA id 82592206FF;
        Thu,  6 Sep 2018 13:43:57 +0200 (CEST)
Date:   Thu, 6 Sep 2018 13:43:56 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     Frieder Schrempf <frieder.schrempf@exceet.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] spi: spi-mem: Add a driver for NXP FlexSPI
 controller
Message-ID: <20180906134356.10e740fa@bbrezillon>
In-Reply-To: <VI1PR04MB1038AB7497A2FD3E73FBA6D699010@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <1535711404-29528-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1535711404-29528-4-git-send-email-yogeshnarayan.gaur@nxp.com>
        <20180904165842.774ed960@bbrezillon>
        <VI1PR04MB1038CE65EF4E98ACBEA9990B99020@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <add79e8b-1ab7-e465-5f65-eed6b78161e1@exceet.de>
        <VI1PR04MB1038AB7497A2FD3E73FBA6D699010@VI1PR04MB1038.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Sep 2018 11:35:13 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Hi Frieder,
> 
> > -----Original Message-----
> > From: Frieder Schrempf [mailto:frieder.schrempf@exceet.de]
> > Sent: Thursday, September 6, 2018 1:56 PM
> > To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>; Boris
> > Brezillon <boris.brezillon@bootlin.com>
> > Cc: linux-mtd@lists.infradead.org; marek.vasut@gmail.com; linux-
> > spi@vger.kernel.org; devicetree@vger.kernel.org; robh@kernel.org;
> > mark.rutland@arm.com; shawnguo@kernel.org; linux-arm-
> > kernel@lists.infradead.org; computersforpeace@gmail.com; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH 3/7] spi: spi-mem: Add a driver for NXP FlexSPI
> > controller 
> > >> Hi Yogesh,
> > >>
> > >> On Fri, 31 Aug 2018 16:00:00 +0530
> > >> Yogesh Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> > >>  
> > >>> - Add a driver for NXP FlexSPI host controller
> > >>>  
> > >>
> > >> Yep, I had a quick look at the code and they really look
> > >> similar. Why not extending the existing driver instead of
> > >> creating a new one from scratch? 
> > >
> > > FlexSPI is different controller not related to the QuadSPI
> > > controller in its working behavior Both these controller are
> > > having
> > > * Different registers name, registers address, registers
> > > functionality etc, section 30.5.2[1]
> > > * Different programming sequence for initialization of the
> > > controller, section 30.8.1[1]
> > > * Different programming sequence for performing Read and Write
> > > operation using IP, section 30.7.9[1] and AHB mode
> > > * Different programming sequence for checking controller current
> > > state like busy or not
> > > * New mechanism to program for the connected slave device i.e.
> > > flash access mode and flash memory map 30.7.4[1] and 30.7.5[1]
> > > * New entries added for FlexSPI controller for LUT_XX mode for
> > > various commands, section 30.7.8[1]
> > >
> > > There are few similarities between these two like LUT programming
> > > logic is same i.e. LUT needs to be programmed in same sequence of
> > > 'INSTR  
> > PAD  OPCODE', but again LUT register address and LUT command mode
> > values are different.  
> > >
> > > Creating common driver for both FlexSPI and QuadSPI controller,
> > > would  
> > involve creation of one more layer between driver/spi/spi-xxx and
> > the actual controller driver, this layer would going to have less
> > functionality like doing LUT creation programming and then would
> > re-direct calls to the respective controller driver functionality
> > to perform desired programming sequence.  
> > >  
> > >>>
> > >>> (1) The FlexSPI controller is driven by the LUT(Look-up Table)
> > >>> registers.
> > >>>   The LUT registers are a look-up-table for sequences of
> > >>> instructions. A valid sequence consists of four LUT registers.
> > >>>   Maximum 32 LUT sequences can be programmed simultaneously.
> > >>>  
> > >>
> > >> Do we really want to have this level of details in the commit
> > >> message? I mean, this is something you can document in the
> > >> driver, but not here.
> > >>
> > >> BTW, you might want to have a look at [1]. I think we can get
> > >> rid of the ->size field you're adding if this driver implements
> > >> the dirmap hooks. 
> > >
> > > I need size information for the connected device to program the
> > > controller  
> > register FLSHXXCRO as Flash Chip select is determined by flash
> > access address and Flash size setting in register FLSHXXCR0[FLSHz],
> > section 30.7.9[1].
> > 
> > It's the same situation we had with the QSPI driver before. We
> > decided to **not** pass information about flash size directly to
> > the controller for now. That's why we currently don't support
> > mapping the flash device in the implementation of the QSPI driver.
> > 
> > I think we should not start this discussion all over again for the
> > FlexSPI driver, but stick to what we decided for QSPI.
> >   
> 
> There is difference between FlexSPI and QuadSPI controller
> functionality in detecting the current CS.
> 
> As per table-10.32[1] for QuadSPI controller, access to flash is
> being assigned as per the address values provided i.e. it would be
> CS0 if address is between TOP_ADDR_MEMXX and QSPI_AMBA_BASE and CS1
> if access is in between TOP_ADDR_MEMA2 and TOP_ADDR_MEMA1.
> 
> But for case of FlexSPI controller, section 30.7.5[2],  CS is being
> defined as per the address value lies in below range
> - Flash A1 address range: 0x00000000 ~ FA1_SIZE
> - Flash A2 address range: FA1_SIZE ~ (FA1_SIZE + FA2_SIZE)
> - Flash B1 address range: (FA1_SIZE + FA2_SIZE) ~ (FA1_SIZE +
> FA2_SIZE + FB1_SIZE)
> - Flash B2 address range: FA1_SIZE + FA2_SIZE + FB1_SIZE) ~ (FA1_SIZE
> + FA2_SIZE + FB1_SIZE + FB2_SIZE) and FAx_SIZE is determined from
> register FLSHxxCR0[FLASHSZ]
> 
> Thus, for QuadSPI controller we can actually go away with the flash
> size requirement and with the code logic which you have introduced,
> of using 2 * ahb_buf_size data size for TOP_ADDR_MEMXX bits in SFxxD
> register, things are working fine.
> 
> But for FlexSPI controller its required to have the connected slave
> device size to detect the current CS.

I don't see why. You should be able to take an arbitrary (big enough)
size at first, and only extend it on-the-fly when a dirmap request is
done.

> I have tried the quadspi driver
> logic in flexspi driver code, but it gives me failure.

Can you detail a bit what's failing?

> Due, to this
> reason and requirement I have come-up with this solution of getting
> the connected device size and programming correct value in
> FLSHxxCR0[FLASHSZ] register

Alternatively, what we could do is split the memory map in 4 regions
of the same size and stick to it. That works if you can define an
offset to apply to the address when an access is done through the
direct mapping area.

> 
> > >
> > > Link for reference of the driver implementing dirmap hooks was
> > > missing in mail,  
> > please share.
> > 
> > I guess Boris meant to link to his PoC implementation of the direct
> > mapping API [1]. When this is available we can easily add support
> > for direct memory mappings to the QuadSPI and FlexSPI drivers.
> >   
> 
> I have checked the link, found that size value is being derived from
> spi_nor.mtd.size variable. Same being performed in this patch series
> to detect the size of the slave device.

Well, yes, the result is the same, except it does not require adding a
new field to spi_mem and ->attach/detach() hooks to the spi_mem_ops
interface (which your implementation is lacking BTW).

> As per my understanding
> developed with Boris's code implementation, when direct mapping API
> interface are available then both QuadSPI and FlexSPI driver needs to
> be changed as per new introduced ops structure.

It's not a hard requirement, but they would definitely benefit from
this extension (mainly a perf improvement).
