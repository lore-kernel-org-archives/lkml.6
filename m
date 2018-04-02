Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756796AbeDBUfw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 16:35:52 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58577 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756412AbeDBUfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 16:35:51 -0400
Date: Mon, 2 Apr 2018 22:35:39 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Peter Rosin <peda@axentia.se>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
        Richard Weinberger <richard@nod.at>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] mtd: nand: raw: atmel: add module param to avoid using
 dma
Message-ID: <20180402223539.6dff3f38@bbrezillon>
In-Reply-To: <8e35701f-1bfa-c9c0-62e6-48ed19d7ba37@axentia.se>
References: <20180329131054.22506-1-peda@axentia.se>
        <20180329153322.5e2fc1e7@bbrezillon>
        <ed87cf13-a69a-6115-f0a8-5f51c4957d1d@axentia.se>
        <20180329154416.5c1a0013@bbrezillon>
        <b740406a-e91c-67ad-24a3-cbdbe259d00d@axentia.se>
        <20180402142249.7e076a64@bbrezillon>
        <e0d9bd59-8031-e387-676e-dc5811170a0c@axentia.se>
        <20180402212843.164d5d21@bbrezillon>
        <8e35701f-1bfa-c9c0-62e6-48ed19d7ba37@axentia.se>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Apr 2018 22:23:17 +0200
Peter Rosin <peda@axentia.se> wrote:


> > I don't use devmem2. Is 'readback' information accurate or is it
> > always what's been written? Because when you write 0x33 to 0xFFFFECBC,
> > 0x33 is read back, but just after that, when you read it again it's 0.  
> 
> Looking at the devmem2 source, it seems very likely that the compiler
> optimizes out the read and thus outputs what has been written.

Yep, had a look too, and it's missing a volatile specifier to prevent
that sort of optimizations.

> 
> >> BTW, how do I
> >> know which master is in use for the LCD controller? 8 or 9? Both?  
> > 
> > It's configurable on a per-layer basis through the SIF bit in
> > LCDC_<layer>CFG0. The driver tries to dispatch the load on those 2 AHB
> > masters [1].  
> 
> Ok, I only have one plane (in this case, i.e. no cursor, no overlays etc),
> would that mean that only one master is used?

Yep, it's always using the first one (master 8 on a sama5d3).

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
