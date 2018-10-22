Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77918C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 994B720651
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 994B720651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbeJVWP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 18:15:29 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51475 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727146AbeJVWP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 18:15:29 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A872520DFC; Mon, 22 Oct 2018 15:56:45 +0200 (CEST)
Received: from bbrezillon (aaubervilliers-681-1-25-52.w90-88.abo.wanadoo.fr [90.88.145.52])
        by mail.bootlin.com (Postfix) with ESMTPSA id 59E4F20DE6;
        Mon, 22 Oct 2018 15:56:35 +0200 (CEST)
Date:   Mon, 22 Oct 2018 15:56:35 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "richard@nod.at" <richard@nod.at>
Subject: Re: [PATCH v2 0/2] MTD: spi-nor: add support for sst26wf016,
 sst26wf032
Message-ID: <20181022155635.2175a595@bbrezillon>
In-Reply-To: <1540216028.19916.6.camel@synopsys.com>
References: <20180910114628.19156-1-Eugeniy.Paltsev@synopsys.com>
        <1540216028.19916.6.camel@synopsys.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Tudor

Hi Eugeniy,

On Mon, 22 Oct 2018 13:47:09 +0000
Eugeniy Paltsev <eugeniy.paltsev@synopsys.com> wrote:

> Hi!
> 
> Maybe you have any comments or remarks about this patch?And if you don't could you please apply it. Thanks!

Sorry, it's already too late for 4.20, and I won't apply patches to the
spi-nor/next branch before 4.20-rc1 is out.

Tudor, Marek, can I have a Reviewed-by/Acked-by on this patchset?

Thanks,

Boris

> 
> On Mon, 2018-09-10 at 14:46 +0300, Eugeniy Paltsev wrote:
> > Add support for the SST sst26wf016 and sst26wf032 flash IC:
> > 
> > sst26wf*** flash series block protection implementation differs from other
> > SST series, so we add implementation for sst26wf*** lock/unlock/is_locked
> > functions.
> > 
> > Add sst26wf016 and sst26wf032 flash IC info to spi_flash_ids list.
> > 
> > NOTE:
> > these patches is basically following mine u-boot commits port:
> > http://git.denx.de/?p=u-boot.git;a=commitdiff;h=3d4fed87a5fa3ffedf64ff2811cd95c5ac4503ac
> > http://git.denx.de/?p=u-boot.git;a=commitdiff;h=a19e97157c3721ef9c4b15c68c1773467a3b4a98
> > 
> > Changes v1->v2:
> >  * Check return value of {read | write}_reg callbacks.
> > 
> > Eugeniy Paltsev (2):
> >   mtd: spi-nor: Add support of sst26wf* flash ICs protection ops
> >   mtd: spi-nor: add support for sst26wf016, sst26wf032
> > 
> >  drivers/mtd/spi-nor/spi-nor.c | 179 ++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/mtd/spi-nor.h   |   4 +
> >  2 files changed, 183 insertions(+)
> >   

