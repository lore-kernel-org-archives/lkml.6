Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D275AC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 07:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A36820870
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 07:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="sgworIYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfBBHoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 02:44:10 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:51521 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbfBBHoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 02:44:09 -0500
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x127hpHV004370
        for <linux-kernel@vger.kernel.org>; Sat, 2 Feb 2019 16:43:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x127hpHV004370
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549093432;
        bh=o5XJ2ECRk8BWbnRrI7uZM9xD7J7ipfeFnnDAdsZvXtA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sgworIYaKMS2mF9rN6HAgtBEuQANbjKOWspOJl5DhNKOHy0h8qFJ02ZBX9lW5XPxO
         8J3zitXjqZ2zct5b99hbWl6D5BqX+wql2ClpyIVGJBWND3Jnw/Fkp59o/GY8Cu9UVY
         PlMt3GacgOfpZGRKaIceEhf8UdhNz2GT5xJymU9Y36KMGdv73CJfOHWNd8Mb8zg5aK
         h2jV3m3e/No9h0t0ABHvz2651e+bkN8Ze/GpSpr138jQZLKbLiavoZN12uFr0rw1R5
         SH8nkhY5VuDIuSyG89oyPLqfBPqfEw6Ft1qrA9OIk+k412hiqYqwYLRNvpo0ExmxgD
         bM3NmdC0kxHmQ==
X-Nifty-SrcIP: [209.85.222.54]
Received: by mail-ua1-f54.google.com with SMTP id n7so2975765uao.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 23:43:51 -0800 (PST)
X-Gm-Message-State: AHQUAub9vb6kAaEi1fL7IfbC0E6syKvmXdUZkMfp1u0q2vc37xtBGzvW
        af30+Wym20RsyEzSVVdHQKNWF7ZS2Oc5F8jvC9s=
X-Google-Smtp-Source: AHgI3IZJVKcL3bkVIoxgje8UpdZuD4W8P8f6UW37jtlpAk/BKzEUl+yXH5wZ2iwf1du20xfEbj19oiRLbi9d7dWcovc=
X-Received: by 2002:a9f:3193:: with SMTP id v19mr13218135uad.55.1549093430648;
 Fri, 01 Feb 2019 23:43:50 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNAQLzvW-zDaR8qkDaxEXxmiCj7XQDK-G57sPhvZu1_eBdA@mail.gmail.com>
 <20190201165218.22a0ac21@bbrezillon>
In-Reply-To: <20190201165218.22a0ac21@bbrezillon>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 2 Feb 2019 16:43:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNASQrd_1qT8BQJBewBA65KeeETXdFpap00JuhhBV277Syw@mail.gmail.com>
Message-ID: <CAK7LNASQrd_1qT8BQJBewBA65KeeETXdFpap00JuhhBV277Syw@mail.gmail.com>
Subject: Re: [Question] setup_data_interface() hook when switching to a
 different type of NAND chip
To:     Boris Brezillon <bbrezillon@kernel.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On Sat, Feb 2, 2019 at 12:53 AM Boris Brezillon <bbrezillon@kernel.org> wrote:
>
> Hi Masahiro,
>
> On Fri, 1 Feb 2019 19:27:46 +0900
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>
> > Hi.
> >
> >
> > When I was looking into the NAND controller/chips separation,
> > this question popped up in my mind.
> >
> >
> > Commit 2d472aba15ff169 provides us a more flexibility
> > about the controller/chips connection.
> > The connected NAND chips do not need to be homogeneous
> > any more.
> >
> >
> > My question is about the ->setup_data_interface() hook
> > when switching between NAND chips with different speed (timing mode).
> >
> >
> > Think about the case below:
> >
> > {
> >         compatible = "foo-nand-controller";
> >         reg = <...>;
> >         #address-cells = <1>;
> >         #size-cells = <0>;
> >
> >         nand@0 {
> >                   reg = <0>;
> >                   /* Slow NAND chip */
> >         }
> >
> >         nand@1 {
> >                   reg = <1>;
> >                   /* Fast NAND chip */
> >         }
> >
> > }
> >
> >
> >
> > In this case, two devices /dev/mtdblock0 and /dev/mtdblock1
> > will appear.
> >
> > If a user gets access to those two devices in turns,
> > I think ->setup_data_interface() should be invoked somehow
> > in order to update the timing registers on the controller side.
> >
> > Currently, ->setup_data_interface() is invoked in nand_scan_tail()
> > and that's it.
> >
> > So, both nand@0 and nand@1 are accessed by the timing mode of nand@1
> > (assuming nand@0 and nand@1 are initialized in this order)
> >
> >
> > Of course, it depends on the controller.
> >
> > If a controller has a register set for every chip select,
> > the hardware will be able to change the access speed automatically.
> >
> >
> > I think most of controllers just have a single set of timing registers.
> > So, when switching between different types of chips,
> > the driver must update the timing registers.
> >
> >
> > If this is a worthwhile usecase,
> > should it be taken care of by the NAND framework,
> > or by drivers ?
> >
> >
> > I just thought we could do something in
> > nand_get_device() / nand_release_device().
> >
> >
> > If this should be done per driver,
> > drivers can update registers in select_target or select_chip.
> >
> >
> > Thought?
>
> It should be done by the driver in its select_target() handler.
> Actually, it's already done like that in several drivers (marvell,
> sunxi, ...).
> ->setup_data_interface() is not required to apply timings right away.
> What it should do is convert the NAND timings into controller timings.
> Of course, if the controller has one set of timing regs per CS, the
> driver can apply timings right away, but when that's not the case,
> controller timings should be stored in the private nand data and
> applied when the chip is selected.


I see.

I will do so because the Denali controller
has just a single set of timing registers.

I will need some more time, but I am working on it.


Thanks for your advice!



> Feel free to enhance the ->setup_data_interface() doc if you think it's
> not clear enough.
>
> Regards,
>
> Boris
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/


--
Best Regards
Masahiro Yamada
