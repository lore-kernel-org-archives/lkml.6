Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FACC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44BF4224DC
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44BF4224DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754909AbeFYJNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:13:37 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38565 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754729AbeFYJNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:13:34 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0AB5620834; Mon, 25 Jun 2018 11:13:32 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 70F4D20719;
        Mon, 25 Jun 2018 11:13:21 +0200 (CEST)
Date:   Mon, 25 Jun 2018 11:13:21 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Naga Sureshkumar Relli <nagasure@xilinx.com>
Cc:     "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "mmayer@broadcom.com" <mmayer@broadcom.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "ladis@linux-mips.org" <ladis@linux-mips.org>,
        "ada@thorsis.com" <ada@thorsis.com>,
        "honghui.zhang@mediatek.com" <honghui.zhang@mediatek.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "nagasureshkumarrelli@gmail.com" <nagasureshkumarrelli@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [[LINUX PATCH v10] 3/4] Documentation: nand: pl353: Add
 documentation for controller and driver
Message-ID: <20180625111321.652d12ff@bbrezillon>
In-Reply-To: <MWHPR02MB26234FD1B68C2B5ECC6B87F6AF4A0@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1529563351-2241-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1529563351-2241-4-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <20180624225427.67c4d9c3@bbrezillon>
        <MWHPR02MB26234FD1B68C2B5ECC6B87F6AF4A0@MWHPR02MB2623.namprd02.prod.outlook.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2018 08:56:41 +0000
Naga Sureshkumar Relli <nagasure@xilinx.com> wrote:

> Hi Boris,
> 
> > -----Original Message-----
> > From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> > Sent: Monday, June 25, 2018 2:24 AM
> > To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> > Cc: richard@nod.at; dwmw2@infradead.org; computersforpeace@gmail.com;
> > marek.vasut@gmail.com; f.fainelli@gmail.com; mmayer@broadcom.com; rogerq@ti.com;
> > ladis@linux-mips.org; ada@thorsis.com; honghui.zhang@mediatek.com;
> > miquel.raynal@bootlin.com; nagasureshkumarrelli@gmail.com; Michal Simek
> > <michals@xilinx.com>; linux-mtd@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: Re: [[LINUX PATCH v10] 3/4] Documentation: nand: pl353: Add documentation
> > for controller and driver
> > 
> > On Thu, 21 Jun 2018 12:12:30 +0530
> > Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com> wrote:
> >   
> > > Added notes about the controller and driver.
> > >
> > > Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> > > ---
> > > Changes in v10:
> > >  - None
> > > Changes in v9:
> > >  - Addressed the comments given by Miquel and Randy
> > > Changes in v8
> > >  - None
> > > Changes in v7:
> > > - None
> > > Changes in v6:
> > > - None
> > > Changes in v5:
> > > - Fixed the review comments
> > > Changes in v4:
> > > - None
> > > ---
> > >  Documentation/mtd/nand/pl353-nand.txt | 99  
> > +++++++++++++++++++++++++++++++++++  
> > >  1 file changed, 99 insertions(+)
> > >  create mode 100644 Documentation/mtd/nand/pl353-nand.txt  
> > 
> > Can we put these information directly in the driver instead of having
> > yet another place where we have things partially documented? I just
> > discovered a doc for the pxa NAND controller in this directory because
> > of this patch, which kind of proves my point :-).  
> Ok, but could you please explain where to put in driver?
> Do you mean, as comments inside drivers/mtd/raw/pl353-nand.c?

Yes. Either inline, next to the relevant section of code, or at the
beginning of the file.
