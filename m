Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797FEC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 440C420870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 440C420870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbeLLJJo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:09:44 -0500
Received: from mail.bootlin.com ([62.4.15.54]:54503 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbeLLJJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 04:09:43 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 92FA220C4D; Wed, 12 Dec 2018 10:09:41 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr [90.88.30.7])
        by mail.bootlin.com (Postfix) with ESMTPSA id 27C9820763;
        Wed, 12 Dec 2018 10:09:31 +0100 (CET)
Date:   Wed, 12 Dec 2018 10:09:31 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Naga Sureshkumar Relli <nagasure@xilinx.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "nagasuresh12@gmail.com" <nagasuresh12@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
Subject: Re: [LINUX PATCH v12 3/3] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Message-ID: <20181212100931.149b0cac@xps13>
In-Reply-To: <MWHPR02MB26236CEF8A2110B20C825198AFA70@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1541739641-17789-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1541739641-17789-4-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <MWHPR02MB26234433484426F333E9B60EAFDC0@MWHPR02MB2623.namprd02.prod.outlook.com>
        <20181118204324.373ca9cc@bbrezillon>
        <MWHPR02MB2623AAEC160F40F061E23194AFD80@MWHPR02MB2623.namprd02.prod.outlook.com>
        <20181119090246.49060019@bbrezillon>
        <BN6PR02MB2610C7D048E4A192E041BE14AFD90@BN6PR02MB2610.namprd02.prod.outlook.com>
        <20181120120244.7d2442b5@bbrezillon>
        <20181120133624.3fa4742d@xps13>
        <MWHPR02MB26238A2271B33470ABFA1023AFD40@MWHPR02MB2623.namprd02.prod.outlook.com>
        <MWHPR02MB26239C2B2A7050310BEF1E9CAFA70@MWHPR02MB2623.namprd02.prod.outlook.com>
        <20181212091135.1d0cc9a6@xps13>
        <MWHPR02MB26236CEF8A2110B20C825198AFA70@MWHPR02MB2623.namprd02.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naga,

Naga Sureshkumar Relli <nagasure@xilinx.com> wrote on Wed, 12 Dec 2018
09:04:16 +0000:

> Hi Miquel,
> 
> > -----Original Message-----
> > From: Miquel Raynal [mailto:miquel.raynal@bootlin.com]
> > Sent: Wednesday, December 12, 2018 1:42 PM
> > To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> > Cc: Boris Brezillon <boris.brezillon@bootlin.com>; robh@kernel.org; richard@nod.at; linux-
> > kernel@vger.kernel.org; marek.vasut@gmail.com; linux-mtd@lists.infradead.org;
> > nagasuresh12@gmail.com; Michal Simek <michals@xilinx.com>;
> > computersforpeace@gmail.com; dwmw2@infradead.org
> > Subject: Re: [LINUX PATCH v12 3/3] mtd: rawnand: arasan: Add support for Arasan
> > NAND Flash Controller
> > 
> > Hi Naga,
> > 
> > Naga Sureshkumar Relli <nagasure@xilinx.com> wrote on Wed, 12 Dec 2018
> > 05:27:03 +0000:
> >   
> > > Hi Boris & Miquel,
> > >
> > > An update to my comments on thread https://lkml.org/lkml/2018/11/15/656.
> > > In this I said, will take a default error count value as 16 and during
> > > page read, will check the error count Register value with this and if
> > > it is equal to or greater than the default count(16) then I am checking for Erased pages.
> > > But bit[7:0] in ECC_Error_Count_Register(0x38) will update for each error occurred.
> > > Link:
> > > https://www.xilinx.com/html_docs/registers/ug1087/ug1087-zynq-ultrascale-  
> > registers.html and check for NAND module, ECC_Error_Count_Register.  
> > >
> > > I mean previously I dependent on Total error count value (bit[16:8]),
> > > but we can simply check for bit[7:0] To see the error occurred or not.
> > > I tried with this approach and I don't see any issues with that.
> > > I ran ubifs with this and I am able to see the bit[7:0] count is
> > > updated for erased page read and then will Use nand_chech_erased_ecc_chunk() to see the  
> > bitflips.  
> > >
> > > If it is ok, I will update the driver and will send new patch, but do you have any other  
> > comments on v12?
> > 
> > Is 'nandbiterrs -i' running correctly now?  
> Yes, but with some changes in driver.
> I have added the log and changes done in https://lkml.org/lkml/2018/11/23/705.

No, I don't see a working nandbiterrs there, sorry.


Thanks,
Miquèl
