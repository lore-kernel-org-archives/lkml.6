Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619CAC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 202D0219E8
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 202D0219E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbeHHPcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 11:32:46 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51789 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbeHHPcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 11:32:45 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt.kanzenbach@linutronix.de>)
        id 1fnOGh-0003Ch-NA; Wed, 08 Aug 2018 15:12:51 +0200
Date:   Wed, 8 Aug 2018 15:12:51 +0200
From:   Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Jane Wan <Jane.Wan@nokia.com>,
        Jagdish Gediya <jagdish.gediya@nxp.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mtd: nand: fsl-ifc: fixup SRAM init for newer ctrl
 versions
Message-ID: <20180808131250.kmw2r6rco3huxeig@linutronix.de>
References: <20180806092137.9287-1-kurt@linutronix.de>
 <20180806092137.9287-3-kurt@linutronix.de>
 <20180808114832.61d31c29@xps13>
 <20180808100909.anfi3qlfjnzb74p2@linutronix.de>
 <20180808143352.2f5b999c@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808143352.2f5b999c@xps13>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On Wed, Aug 08, 2018 at 02:33:52PM +0200, Miquel Raynal wrote:
> Hi Kurt,
>
>
> > > > +		u32 ncfgr, status;
> > > > +		int ret;
> > > > +
> > > > +		/* Trigger auto initialization */
> > > > +		ncfgr = ifc_in32(&ifc_runtime->ifc_nand.ncfgr);
> > > > +		ifc_out32(ncfgr | IFC_NAND_NCFGR_SRAM_INIT_EN, &ifc_runtime->ifc_nand.ncfgr);
> > > > +
> > > > +		/* Wait until done */
> > > > +		ret = readx_poll_timeout(ifc_in32, &ifc_runtime->ifc_nand.ncfgr,
> > > > +					 status, !(status & IFC_NAND_NCFGR_SRAM_INIT_EN),
> > > > +					 10, 1000);
> > >
> > > Nit: I always prefer when delays/timeouts are defined (and may be
> > > reused).
> >
> > Me too. I've missed that there is already a timeout constant
> > IFC_TIMEOUT_MSECS (500). As it's huge, I'll add a second one.
>
> Well, I'm not bothered with huge timeouts, it's in the error path so we
> don't really care.

okay. I'll send a v2 next week addressing your comments.

Thanks,
Kurt
