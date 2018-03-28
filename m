Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752267AbeC1HQ0 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 03:16:26 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48822 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751038AbeC1HQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 03:16:25 -0400
Date: Wed, 28 Mar 2018 09:16:13 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, dwmw2@infradead.org,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: Replace typedef with struct
Message-ID: <20180328091613.7a867a0f@bbrezillon>
In-Reply-To: <2234121.GJlN6YpY6x@blindfold>
References: <20180318175122.GA15004@seema-Inspiron-15-3567>
        <2234121.GJlN6YpY6x@blindfold>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2018 21:32:19 +0200
Richard Weinberger <richard@nod.at> wrote:

> Am Sonntag, 18. März 2018, 18:51:23 CEST schrieb Arushi Singhal:
> > Using typedef for a structure type is not suggested in Linux kernel
> > coding style guidelines. Hence, occurrence of typedefs has been
> > removed.
> > 
> > Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> > ---
> >  drivers/mtd/ssfdc.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/mtd/ssfdc.c b/drivers/mtd/ssfdc.c
> > index 95f0bf9..8bae672 100644
> > --- a/drivers/mtd/ssfdc.c
> > +++ b/drivers/mtd/ssfdc.c
> > @@ -54,15 +54,15 @@ SumSector	2,000	4,000	8,000	16,000	32,000	64,000	128,000	256,000
> >  SectorSize	512	512	512	512	512	512	512	512
> >  **/
> >  
> > -typedef struct {
> > +struct chs_entry {
> >  	unsigned long size;
> >  	unsigned short cyl;
> >  	unsigned char head;
> >  	unsigned char sec;
> > -} chs_entry_t;
> > +};
> >  
> >  /* Must be ordered by size */
> > -static const chs_entry_t chs_table[] = {
> > +static const struct chs_entry chs_table[] = {
> >  	{ MiB(  1), 125,  4,  4 },
> >  	{ MiB(  2), 125,  4,  8 },
> >  	{ MiB(  4), 250,  4,  8 },
> >   
> 
> Didn't we already talk about coding style fixes on existing code? ;-)

I'll add one thing to Richard's complaint: please stop sending new
coding style or cosmetic changes until the previous ones have been
accepted.

There's a reason I don't apply those patches right away even though
they are simple. Those patches have a low priority in my review list
and improvements or fixes usually get reviewed before them. The reason
I do that is:

1/ I want to reward contributors who submit things that actually matter
   to the subsystem
2/ It tends to discourage drive-by contributors whose only interest is
   to get a lot of trivial patches in the kernel

Note that I'm not saying never, but you have to accept to wait longer
for this kind of patches, and more importantly, if you keep sending
only coding style patches, we might decide to ignore your contributions
at some point.

Regards,

Boris

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
