Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CE7C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9BDC2083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9BDC2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbeKGICD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 03:02:03 -0500
Received: from mail.bootlin.com ([62.4.15.54]:39324 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730835AbeKGICD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 03:02:03 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C5E7C20712; Tue,  6 Nov 2018 23:34:32 +0100 (CET)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7336A2039F;
        Tue,  6 Nov 2018 23:34:32 +0100 (CET)
Date:   Tue, 6 Nov 2018 23:34:32 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Linus Walleij <linus.walleij@linaro.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH next] mtd: maps: physmap: Fix infinite loop crash in ROM
 type probing
Message-ID: <20181106233432.76df6bbf@bbrezillon>
In-Reply-To: <CAMuHMdUQhsikcBzRFAvrCwZwzFK_Coh=fqpSihFP6jEtugCMQw@mail.gmail.com>
References: <20181106214416.11342-1-geert@linux-m68k.org>
        <20181106225829.5ecbe19e@bbrezillon>
        <CAMuHMdUQhsikcBzRFAvrCwZwzFK_Coh=fqpSihFP6jEtugCMQw@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Nov 2018 23:19:14 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Boris,
> 
> On Tue, Nov 6, 2018 at 10:58 PM Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> > On Tue,  6 Nov 2018 22:44:16 +0100
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:  
> > > On Toshiba RBTX4927, where map_probe is supposed to fail:
> > >
> > >     Creating 2 MTD partitions on "physmap-flash.0":
> > >     0x000000c00000-0x000001000000 : "boot"
> > >     0x000000000000-0x000000c00000 : "user"
> > >     physmap-flash physmap-flash.1: physmap platform flash device: [mem 0x1e000000-0x1effffff]
> > >     CPU 0 Unable to handle kernel paging request at virtual address 00000000, epc == 80320f40, ra == 80321004
> > >     ...
> > >     Call Trace:
> > >     [<80320f40>] get_mtd_chip_driver+0x30/0x8c
> > >     [<80321004>] do_map_probe+0x20/0x90
> > >     [<80328448>] physmap_flash_probe+0x484/0x4ec
> > >
> > > The access to rom_probe_types[] was changed from a sentinel-based loop
> > > to an infinite loop, causing a crash when reaching the sentinel.  
> >
> > Oops. Do you mind if I fix that in-place (squash your changes in
> > Ricardo's original commit)?

Done.

> 
> No problem. Thanks!

Thanks for reporting/fixing the bug.

Boris

