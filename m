Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0EAC676C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D34E2075C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D34E2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbeJHTQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 15:16:39 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42358 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726995AbeJHTQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 15:16:39 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9858D207C4; Mon,  8 Oct 2018 14:05:11 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id D29F820726;
        Mon,  8 Oct 2018 14:05:10 +0200 (CEST)
Date:   Mon, 8 Oct 2018 14:05:11 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Peter Rosin <peda@axentia.se>, mshettel@codeaurora.org,
        swboyd@chromium.org
Subject: Re: [PATCH v8 07/10] i3c: master: Add driver for Cadence IP
Message-ID: <20181008140511.153392d1@bbrezillon>
In-Reply-To: <CAK8P3a3Sck0yYzH-Ks=CvHJLgZ1VrUjHvzw2XL7C_GC515=VVg@mail.gmail.com>
References: <20181003132212.12619-1-boris.brezillon@bootlin.com>
        <20181003132212.12619-8-boris.brezillon@bootlin.com>
        <CAK8P3a21t7pQ2uYWgu2+VZZNYc+pz_w3WCL7YVUEzqqyOFLvnA@mail.gmail.com>
        <20181008122101.7b391070@bbrezillon>
        <CAK8P3a3Sck0yYzH-Ks=CvHJLgZ1VrUjHvzw2XL7C_GC515=VVg@mail.gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2018 12:36:44 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Mon, Oct 8, 2018 at 12:21 PM Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> >
> > On Mon, 8 Oct 2018 12:06:30 +0200
> > Arnd Bergmann <arnd@arndb.de> wrote:
> >  
> > > On Wed, Oct 3, 2018 at 3:22 PM Boris Brezillon
> > > <boris.brezillon@bootlin.com> wrote:  
> > > >
> > > > Add a driver for Cadence I3C master IP.
> > > >
> > > > Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> > > > ---  
> > >  
> > > > Changes in v7:
> > > > - Fix readsl/writesl() usage
> > > > - Add a depends on ARM || ARM64 || XTENSA to forbid selection of this
> > > >   driver on platforms that are not implementing readsl/writesl  
> > >
> > > Most architectures include asm-generic/io.h, which contains a generic
> > > implementation of readsl(). Maybe that #ifdef could be extended here?
> > > I remember discussing this with you not so long ago, which led to
> > > commit 0bbf47eab469 ("ia64: use asm-generic/io.h"). Do we have
> > > a list of architectures that don't include asm-generic/io.h? Maybe
> > > the 'depends on' could be for the set of architectures that fail here.  
> >
> > Well, we started patching 2 archs (ia64 and sparc) based on kbuild
> > robots failure report, and then I received other reports (still from
> > kbuild robots) long after the initial ones. I can't tell for sure which
> > archs are not implementing those functions, hence the conservative
> > approach taken here.  
> 
> I think it's a fairly safe assumption that architectures which include
> asm-generic/io.h will be fine here. If one of them is broken, that
> can be fixed individually. Looking at the ones that don't include this
> file:
> 
> grep -L asm-generic/io.h arch/*/include/asm/io*.h
> arch/alpha/include/asm/io.h        # missing readsl
> arch/hexagon/include/asm/io.h   # has its own readsl
> arch/mips/include/asm/io.h         # missing readsl (but used from ide.h?)
> arch/parisc/include/asm/io.h       # missing readsl
> arch/powerpc/include/asm/io.h   # has its own readsl
> arch/sh/include/asm/io.h             # has its own readsl
> arch/sparc/include/asm/io.h        # has its own readsl
> 
> Based on this, I would try what happens on mips, and make it depend
> on !(ALPHA || PARISC)

Okay, I'll try with that.
