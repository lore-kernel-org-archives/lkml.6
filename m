Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6C5C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB4220663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbfANI5s convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 03:57:48 -0500
Received: from mail.bootlin.com ([62.4.15.54]:40373 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbfANI5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 03:57:48 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EBF12209C2; Mon, 14 Jan 2019 09:57:46 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr [90.88.163.241])
        by mail.bootlin.com (Postfix) with ESMTPSA id 943B620728;
        Mon, 14 Jan 2019 09:57:46 +0100 (CET)
Date:   Mon, 14 Jan 2019 09:57:45 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Olof Johansson <olof@lixom.net>
Cc:     Jens Axboe <axboe@kernel.dk>, john.hubbard@gmail.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Rob Herring <robh@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/1] phy: fix build breakage: add PHY_MODE_SATA
Message-ID: <20190114095745.04027f37@xps13>
In-Reply-To: <CAOesGMjiYkThVa5BQo0w3B1wC3NJpmsrYFwXVCN0VQqYqF_MWg@mail.gmail.com>
References: <20190113012909.11986-1-jhubbard@nvidia.com>
        <20190113012909.11986-2-jhubbard@nvidia.com>
        <9518922c-ab17-ba06-0670-f0202b436a8c@kernel.dk>
        <CAOesGMjiYkThVa5BQo0w3B1wC3NJpmsrYFwXVCN0VQqYqF_MWg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof,

Olof Johansson <olof@lixom.net> wrote on Sat, 12 Jan 2019 19:57:12
-0800:

> On Sat, Jan 12, 2019 at 6:05 PM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > On 1/12/19 6:29 PM, john.hubbard@gmail.com wrote:  
> > > From: John Hubbard <jhubbard@nvidia.com>
> > >
> > > Commit 49e54187ae0b ("ata: libahci_platform: comply to PHY framework") uses
> > > the PHY_MODE_SATA, but that enum had not yet been added. This caused a
> > > build failure for me, with today's linux.git.
> > >
> > > Also, there is a potentially conflicting (mis-named) PHY_MODE_SATA, hiding
> > > in the Marvell Berlin SATA PHY driver.
> > >
> > > Fix the build by:
> > >
> > >     1) Renaming Marvell's defined value to a more scoped name,
> > >        in order to avoid any potential conflicts: PHY_BERLIN_MODE_SATA.
> > >
> > >     2) Adding the missing enum, which was going to be added anyway as part
> > >        of [1].
> > >
> > > [1] https://lkml.kernel.org/r/20190108163124.6409-3-miquel.raynal@bootlin.com
> > >
> > > Fixes: 49e54187ae0b ("ata: libahci_platform: comply to PHY framework")  
> >
> > Linus, this is probably a better option in terms of what should go in to
> > fix that commit.  
> 
> I'm OK with this, but it does beg the question how the patch was
> tested before submitting, if it didn't build.
> 
> Is there functional breakage behind it? I currently lack online
> hardware to test myself, unfortunately.

This is my mistake, I forgot to tell Jens about this dependency,
I am very sorry about that. As reported by John, this patch depends on
the addition of PHY_MODE_SATA in the PHY type enumeration. This series
([1]) has been delayed and I should have warned Jens about it. I'm fine
with the above fix though.

Kishon, will you be able to base phy-next on top of this fix? It will
be needed for the addition of the COMPHY driver.


Thanks and again, sorry for the troubles.
Miquèl
