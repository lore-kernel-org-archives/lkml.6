Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C204ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 07:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B502154C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 07:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10B502154C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbeIVNqb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 09:46:31 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56967 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbeIVNqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 09:46:31 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 441BE20731; Sat, 22 Sep 2018 09:53:52 +0200 (CEST)
Received: from xps13 (unknown [37.168.24.12])
        by mail.bootlin.com (Postfix) with ESMTPSA id 31C3920795;
        Sat, 22 Sep 2018 09:53:50 +0200 (CEST)
Date:   Sat, 22 Sep 2018 09:53:40 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Naga Sureshkumar Relli <nagasure@xilinx.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
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
Subject: Re: [LINUX PATCH v10 2/2] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Message-ID: <20180922095340.4fe373f8@xps13>
In-Reply-To: <MWHPR02MB2623A761C40745AD4AE2A295AF040@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1534511964-20342-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1534511964-20342-3-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <20180820184013.57fd7b5c@bbrezillon>
        <MWHPR02MB2623A761C40745AD4AE2A295AF040@MWHPR02MB2623.namprd02.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naga,

Naga Sureshkumar Relli <nagasure@xilinx.com> wrote on Tue, 11 Sep 2018
05:23:09 +0000:

> Hi Boris,
> 
> > -----Original Message-----
> > From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> > Sent: Monday, August 20, 2018 10:10 PM
> > To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> > Cc: miquel.raynal@bootlin.com; richard@nod.at; dwmw2@infradead.org;
> > computersforpeace@gmail.com; marek.vasut@gmail.com; kyungmin.park@samsung.com;
> > absahu@codeaurora.org; peterpandong@micron.com; frieder.schrempf@exceet.de; linux-
> > mtd@lists.infradead.org; linux-kernel@vger.kernel.org; Michal Simek <michals@xilinx.com>;
> > nagasureshkumarrelli@gmail.com
> > Subject: Re: [LINUX PATCH v10 2/2] mtd: rawnand: arasan: Add support for Arasan NAND
> > Flash Controller
> > 
> > Hi Naga,
> > 
> > On Fri, 17 Aug 2018 18:49:24 +0530
> > Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com> wrote:
> > 
> > 
> > I haven't finished reviewing the driver but there are still a bunch of things that look strange, for
> > instance, your ->read/write_page() implementation looks suspicious. Let's discuss that before
> > you send a new version.  
> Could you please review the remaining stuff?
> I have the changes ready with me which will address all your comments given to this series.
> 
> Thanks,
> Naga Sureshkumar Relli

Please submit the new version that is ready, the rest of the review will
come.


Thanks,
Miquèl
