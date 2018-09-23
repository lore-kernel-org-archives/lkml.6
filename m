Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04758ECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 11:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A8D320C0A
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 11:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A8D320C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbeIWRly convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 13:41:54 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40276 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbeIWRlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 13:41:53 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2ADE62089C; Sun, 23 Sep 2018 13:44:39 +0200 (CEST)
Received: from xps13 (AToulouse-657-1-1019-69.w90-11.abo.wanadoo.fr [90.11.225.69])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7DA79207CA;
        Sun, 23 Sep 2018 13:44:38 +0200 (CEST)
Date:   Sun, 23 Sep 2018 13:44:37 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] mtd: rawnand: denali: add DT property to specify
 skipped bytes in OOB
Message-ID: <20180923134437.283b5dda@xps13>
In-Reply-To: <CAK7LNAR0=1zAWkf9c4mYgLrJNmKR=8=mi6idWaaeuN4uHQVjug@mail.gmail.com>
References: <1536317783-4942-1-git-send-email-yamada.masahiro@socionext.com>
        <20180907160822.319047c8@bbrezillon>
        <CAK7LNAQJOD3mxwbiOSn5wpDsU23DhZcx9QB_ufFZB8LUnh1KdQ@mail.gmail.com>
        <20180907165348.3e0027ee@bbrezillon>
        <CAK7LNAT3ZjdW3ENekNJq=26SAh=tXdirmhHyA9qDGnwpXQ6Arg@mail.gmail.com>
        <20180922094111.1c2969e8@xps13>
        <20180922101116.7c9b4767@bbrezillon>
        <CAK7LNAR0=1zAWkf9c4mYgLrJNmKR=8=mi6idWaaeuN4uHQVjug@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Sun, 23 Sep
2018 06:38:40 -0400:

> 2018-09-22 4:11 GMT-04:00 Boris Brezillon <boris.brezillon@bootlin.com>:
> > On Sat, 22 Sep 2018 09:41:11 +0200
> > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >  
> >> Hi Masahiro,
> >>
> >> Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Sat, 8 Sep
> >> 2018 01:10:25 +0900:
> >>  
> >> > Hi Boris,
> >> >
> >> > 2018-09-07 23:53 GMT+09:00 Boris Brezillon <boris.brezillon@bootlin.com>:  
> >> > > On Fri, 7 Sep 2018 23:42:53 +0900
> >> > > Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> >> > >  
> >> > >> Hi Boris,
> >> > >>
> >> > >> 2018-09-07 23:08 GMT+09:00 Boris Brezillon <boris.brezillon@bootlin.com>:  
> >> > >> > Hi Masahiro,
> >> > >> >
> >> > >> > On Fri,  7 Sep 2018 19:56:23 +0900
> >> > >> > Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> >> > >> >  
> >> > >> >> NAND devices need additional data area (OOB) for error correction,
> >> > >> >> but it is also used for Bad Block Marker (BBM).  In many cases, the
> >> > >> >> first byte in OOB is used for BBM, but the location actually depends
> >> > >> >> on chip vendors.  The NAND controller should preserve the precious
> >> > >> >> BBM to keep track of bad blocks.
> >> > >> >>
> >> > >> >> In Denali IP, the SPARE_AREA_SKIP_BYTES register is used to specify
> >> > >> >> the number of bytes to skip from the start of OOB.  The ECC engine
> >> > >> >> will automatically skip the specified number of bytes when it gets
> >> > >> >> access to OOB area.
> >> > >> >>
> >> > >> >> The same value for SPARE_AREA_SKIP_BYTES should be used between
> >> > >> >> firmware and the operating system if you intend to use the NAND
> >> > >> >> device across the control hand-off.
> >> > >> >>
> >> > >> >> In fact, the current denali.c code expects firmware to have already
> >> > >> >> set the SPARE_AREA_SKIP_BYTES register, then reads the value out.
> >> > >> >>
> >> > >> >> If no firmware (or bootloader) has initialized the controller, the
> >> > >> >> register value is zero, which is the default after power-on-reset.
> >> > >> >>
> >> > >> >> In other words, the Linux driver cannot initialize the controller
> >> > >> >> by itself.  You cannot support the reset control either because
> >> > >> >> resetting the controller will get register values lost.
> >> > >> >>
> >> > >> >> This commit adds a way to specify it via DT.  If the property
> >> > >> >> "denali,oob-skip-bytes" exists, the value will be set to the register.  
> >> > >> >
> >> > >> > Hm, do we really need to make this config customizable? I mean, either
> >> > >> > you have a large-page NAND (page > 512 bytes) and the 2 first bytes
> >> > >> > must be reserved for the BBM or you have a small-page NAND and the BBM
> >> > >> > is at position 4 and 5. Are you sure people configure that differently?
> >> > >> > Don't you always have SPARE_AREA_SKIP_BYTES set to 6 or 2?  
> >> > >>
> >> > >>
> >> > >> As I said in the patch description,
> >> > >> I need to use the same SPARE_AREA_SKIP_BYTES value
> >> > >> across firmware, boot-loader, Linux, and whatever.
> >> > >>
> >> > >> I want to set the value to 8 for my platform
> >> > >> because the on-chip boot ROM expects 8.
> >> > >> I cannot change it since the boot ROM is hard-wired.
> >> > >>
> >> > >>
> >> > >> The boot ROM skips 8 bytes in OOB
> >> > >> when it loads images from the on-board NAND device.
> >> > >>
> >> > >> So, when I update the image from U-Boot or Linux,
> >> > >> I need to make sure to set the register to 8.
> >> > >>
> >> > >> If I update the image with a different value,
> >> > >> the Boot ROM fails to boot.
> >> > >>
> >> > >>
> >> > >>
> >> > >> When the system has booted from NAND,
> >> > >> the register is already set to 8.  It works.
> >> > >>
> >> > >> However, when the system has booted from eMMC,
> >> > >> the register is not initialized by anyone.
> >> > >> I am searching for a way to set the register to 8
> >> > >> in this case.  
> >
> > Maybe there's a solution which does not involve attaching a per-compat
> > value or adding a DT prop. If the FW/bootloader has not initialized this
> > register the value is 0, right? Why not testing the value and
> > assigning it to the default (8) if it's not been initialized by the
> > bootloader. That shouldn't break existing platforms since I don't think
> > 0 is a valid value anyway.
> >
> >         denali->oob_skip_bytes = ioread32(denali->reg +
> >                                           SPARE_AREA_SKIP_BYTES);
> >         if (!denali->oob_skip_bytes) {
> >                 denali->oob_skip_bytes = DEFAULT_OOB_SKIP_BYTES;
> >                 iowrite32(denali->oob_skip_bytes,
> >                           denali->reg + SPARE_AREA_SKIP_BYTES);
> >         }
> >  
> 
> 
> I prefer per-compatible values to a fixed default.
> 
> 
> I'd like to set the register to 8 unless set otherwise
> because the boot ROM on my platform (Socionext UniPhier SoCs)
> uses that value.
> 
> Other platforms like Altera SOCFPGA may want to use a different value
> (at least, I do not know what is the preferred value).
> 
> 

Well, for now we can just have a default to 8, and if someone complains
have a per-compatible default?


Thanks,
Miquèl
