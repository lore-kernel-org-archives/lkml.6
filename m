Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D735C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 05:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA992172D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 05:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DA992172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbeHUJSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:18:32 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58697 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbeHUJSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:18:32 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DF9D5204AE; Tue, 21 Aug 2018 07:59:48 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 80E2E204AE;
        Tue, 21 Aug 2018 07:59:48 +0200 (CEST)
Date:   Tue, 21 Aug 2018 07:59:48 +0200
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
Message-ID: <20180821075948.28962170@bbrezillon>
In-Reply-To: <MWHPR02MB2623F315C6D4C9775CDA08D8AF310@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1534511964-20342-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1534511964-20342-2-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <20180820143324.61af9027@bbrezillon>
        <MWHPR02MB2623F315C6D4C9775CDA08D8AF310@MWHPR02MB2623.namprd02.prod.outlook.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2018 05:47:18 +0000
Naga Sureshkumar Relli <nagasure@xilinx.com> wrote:

> > > +Required properties:
> > > +- compatible:		Should be "xlnx,zynqmp-nand" or "arasan,nfc-v3p10"  
> > 
> > In your example it's not an "or" since both are defined.  
> In our previous discussion (https://lore.kernel.org/patchwork/patch/748901/)
> We decided to have compatible strings like " compatible = "<soc-vendor>,<ip-revision>", "arasan,<ip-revision>";"
> So it should be either of these.
> so I will write something like below
> "Possible values are  "xlnx,zynqmp-nand" 
> 			"arasan,nfc-v3p10"
> And in example I will mention any one compatible.
> Is it ok?

Hm, why do you need arasan,nfc-v3p10 at all if it's supposed to be
overloaded by a soc specific compat?

> > > +
> > > +Optional properties:
> > > +- arasan,has-mdma: Enables DMA support  
> > 
> > Can't you detect that based on the compatible (or thanks to a register). If it's something you
> > choose when configuring the IP and can't detect at runtime I guess it's fine.  
> There is no way to select DMA when configuring the IP.
> But it has internal DMA and there is a register to select PIO or DMA while starting a transfer.
> So if user really don't want DMA, then we will never set DMA in the code based on DT property.

If it's a purely SW choice, then is shouldn't be described in the DT.
You can use a module param, but I'm not even sure why one would want to
disable DMA.
