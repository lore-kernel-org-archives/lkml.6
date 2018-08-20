Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA992C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62CC520856
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:24:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62CC520856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbeHTPkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 11:40:06 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39308 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbeHTPkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 11:40:06 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 02AAD20DE0; Mon, 20 Aug 2018 14:24:33 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 80EAB20618;
        Mon, 20 Aug 2018 14:24:22 +0200 (CEST)
Date:   Mon, 20 Aug 2018 14:24:22 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Naga Sureshkumar Relli <nagasure@xilinx.com>
Cc:     "richard@nod.at" <richard@nod.at>,
        "absahu@codeaurora.org" <absahu@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "nagasureshkumarrelli@gmail.com" <nagasureshkumarrelli@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "peterpandong@micron.com" <peterpandong@micron.com>
Subject: Re: [LINUX PATCH v10 2/2] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Message-ID: <20180820142422.73288ff7@bbrezillon>
In-Reply-To: <MWHPR02MB2623C6F80AC8DB81A9791EA4AF320@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1534511964-20342-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1534511964-20342-3-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <20180817195903.49963b25@bbrezillon>
        <MWHPR02MB2623D48B5DBAFCE2B5D03747AF3C0@MWHPR02MB2623.namprd02.prod.outlook.com>
        <20180820105355.11bd50a8@bbrezillon>
        <MWHPR02MB2623218B2BD3D102B07AC862AF320@MWHPR02MB2623.namprd02.prod.outlook.com>
        <20180820141026.0e7208ae@bbrezillon>
        <MWHPR02MB2623C6F80AC8DB81A9791EA4AF320@MWHPR02MB2623.namprd02.prod.outlook.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Aug 2018 12:21:12 +0000
Naga Sureshkumar Relli <nagasure@xilinx.com> wrote:

> Hi Boris,
> 
> > -----Original Message-----
> > From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> > Sent: Monday, August 20, 2018 5:40 PM
> > To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> > Cc: richard@nod.at; absahu@codeaurora.org; linux-kernel@vger.kernel.org;
> > marek.vasut@gmail.com; kyungmin.park@samsung.com; frieder.schrempf@exceet.de; linux-
> > mtd@lists.infradead.org; miquel.raynal@bootlin.com; nagasureshkumarrelli@gmail.com;
> > Michal Simek <michals@xilinx.com>; computersforpeace@gmail.com; dwmw2@infradead.org;
> > peterpandong@micron.com
> > Subject: Re: [LINUX PATCH v10 2/2] mtd: rawnand: arasan: Add support for Arasan
> > NAND Flash Controller
> > 
> > On Mon, 20 Aug 2018 10:49:38 +0000
> > Naga Sureshkumar Relli <nagasure@xilinx.com> wrote:
> >   
> > >
> > > Thanks for your suggestion and are you saying something like Marvell parser patterns for  
> > nfcv1 as below?  
> > >
> > > static const struct nand_op_parser marvell_nfcv1_op_parser = NAND_OP_PARSER(
> > > 	/* Naked commands not supported, use a function for each pattern */
> > > 	NAND_OP_PARSER_PATTERN(
> > > 		marvell_nfc_read_id_type_exec,
> > > 		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> > > 		NAND_OP_PARSER_PAT_ADDR_ELEM(false,  
> > MAX_ADDRESS_CYC_NFCV1),  
> > > 		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 8)),
> > > 	NAND_OP_PARSER_PATTERN(
> > > 		marvell_nfc_erase_cmd_type_exec,
> > > 		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> > > 		NAND_OP_PARSER_PAT_ADDR_ELEM(false,  
> > MAX_ADDRESS_CYC_NFCV1),  
> > > 		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> > > 		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false)),
> > > 	);
> > > That means, a separate hook for each pattern, is that you are suggesting?  
> > 
> > Yes.  
> 
> Ok, I will update the driver and will send next version.

Wait a bit before sending a new version, there were other things I
wanted to comment on, this one was just the main issue.
