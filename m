Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1511BC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 11:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1DB214D5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 11:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC1DB214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbeHUOaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 10:30:06 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39143 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbeHUOaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 10:30:06 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 625232072F; Tue, 21 Aug 2018 13:10:20 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id DFB1E20618;
        Tue, 21 Aug 2018 13:10:19 +0200 (CEST)
Date:   Tue, 21 Aug 2018 13:10:20 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Naga Sureshkumar Relli <nagasure@xilinx.com>
Cc:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>,
        "absahu@codeaurora.org" <absahu@codeaurora.org>,
        "peterpandong@micron.com" <peterpandong@micron.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "nagasureshkumarrelli@gmail.com" <nagasureshkumarrelli@gmail.com>
Subject: Re: [LINUX PATCH v10 1/2] dt-bindings: mtd: arasan: Add device tree
 binding documentation
Message-ID: <20180821131020.5db46548@bbrezillon>
In-Reply-To: <MWHPR02MB2623E78222225D1CE8167463AF310@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1534511964-20342-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1534511964-20342-2-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <20180820143324.61af9027@bbrezillon>
        <MWHPR02MB2623F315C6D4C9775CDA08D8AF310@MWHPR02MB2623.namprd02.prod.outlook.com>
        <20180821075948.28962170@bbrezillon>
        <MWHPR02MB2623E78222225D1CE8167463AF310@MWHPR02MB2623.namprd02.prod.outlook.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2018 09:22:07 +0000
Naga Sureshkumar Relli <nagasure@xilinx.com> wrote:

> Hi Boris,
> 
> > -----Original Message-----
> > From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> > Sent: Tuesday, August 21, 2018 11:30 AM
> > To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> > Cc: miquel.raynal@bootlin.com; richard@nod.at; dwmw2@infradead.org;
> > computersforpeace@gmail.com; marek.vasut@gmail.com; kyungmin.park@samsung.com;
> > absahu@codeaurora.org; peterpandong@micron.com; frieder.schrempf@exceet.de; linux-
> > mtd@lists.infradead.org; linux-kernel@vger.kernel.org; Michal Simek <michals@xilinx.com>;
> > nagasureshkumarrelli@gmail.com
> > Subject: Re: [LINUX PATCH v10 1/2] dt-bindings: mtd: arasan: Add device tree binding
> > documentation
> > 
> > On Tue, 21 Aug 2018 05:47:18 +0000
> > Naga Sureshkumar Relli <nagasure@xilinx.com> wrote:
> >   
> > > > > +Required properties:
> > > > > +- compatible:		Should be "xlnx,zynqmp-nand" or "arasan,nfc-v3p10"  
> > > >
> > > > In your example it's not an "or" since both are defined.  
> > > In our previous discussion
> > > (https://lore.kernel.org/patchwork/patch/748901/)
> > > We decided to have compatible strings like " compatible = "<soc-vendor>,<ip-revision>",  
> > "arasan,<ip-revision>";"  
> > > So it should be either of these.
> > > so I will write something like below
> > > "Possible values are  "xlnx,zynqmp-nand"
> > > 			"arasan,nfc-v3p10"
> > > And in example I will mention any one compatible.
> > > Is it ok?  
> > 
> > Hm, why do you need arasan,nfc-v3p10 at all if it's supposed to be overloaded by a soc specific
> > compat?  
> Actually we put these compatible strings based on the comments on v7 series.
> Anyway I will just keep "xlnx,zynqmp-nand" as compatible.

If Rob said you should have both, then keep both, but the description
should match, because "arasan,nfc-v3p10" cannot be used alone, it has
to be placed next to a "<vendor>,nfc-<soc>" string.
