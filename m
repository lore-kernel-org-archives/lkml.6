Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EE8C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 15:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA442177E
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 15:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549206447;
	bh=Jfs/7TZD7Dt6pob7pVeQFmN4YeMF4UVpP6WK8aXKfrY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Wwj+N9dEGYYJpLCDaBv7GtqnIN+4XEzuI8krlOUD5E4wtVzlKvVW/vpUtz+mUpIRg
	 i/Xu3KY5G3H0HlOt4NkQp3wHBNhZ3ujplP0BXcY+2K/MhxatW1bgXz3MhYJuQFl/qu
	 GBAQ2UrhSRUOUCLxpEcl+AUG6gexlJjt+qWYVAxM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfBCPHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 10:07:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:48252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfBCPHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 10:07:25 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 280E32177E;
        Sun,  3 Feb 2019 15:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549206443;
        bh=Jfs/7TZD7Dt6pob7pVeQFmN4YeMF4UVpP6WK8aXKfrY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1H7zl/N+aKOQb1vGR0xo0iV7406nz3fwmiFO9wK+zgiIqyN5U3UlOAml7b0ESJDFK
         M0tOG22fjSuh+jy4jGVl5E7SGoc4KqKExWLUbtn8mQZLH7nl7v8Md6VcJnuSsGm05R
         PYcx6PoJbNwy9UKBrdM4tQx4iIK59NQHOzJ8eYjU=
Date:   Sun, 3 Feb 2019 16:07:09 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Mathieu Malaterre <malat@debian.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 9/9] mtd: rawnand: jz4780-bch: Add support for the
 JZ4740
Message-ID: <20190203160709.29d7d721@bbrezillon>
In-Reply-To: <1549205792.1588.0@crapouillou.net>
References: <20190202231926.2444-1-paul@crapouillou.net>
        <20190202231926.2444-10-paul@crapouillou.net>
        <20190203083505.4dc52278@bbrezillon>
        <1549202293.1950.2@crapouillou.net>
        <20190203151604.23061e2a@bbrezillon>
        <1549205792.1588.0@crapouillou.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Feb 2019 11:56:32 -0300
Paul Cercueil <paul@crapouillou.net> wrote:

> Le dim. 3 f=C3=A9vr. 2019 =C3=A0 11:16, Boris Brezillon <bbrezillon@kerne=
l.org>=20
> a =C3=A9crit :
> > On Sun, 03 Feb 2019 10:58:13 -0300
> > Paul Cercueil <paul@crapouillou.net> wrote:
> >  =20
> >>  Le dim. 3 f=C3=A9vr. 2019 =C3=A0 4:35, Boris Brezillon=20
> >> <bbrezillon@kernel.org>
> >>  a =C3=A9crit : =20
> >>  > On Sat,  2 Feb 2019 20:19:26 -0300
> >>  > Paul Cercueil <paul@crapouillou.net> wrote:
> >>  > =20
> >>  >>  Add the backend code for the jz4780-bch driver to support the  =20
> >> JZ4740 =20
> >>  >>  SoC from Ingenic.
> >>  >>
> >>  >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> >>  >>  ---
> >>  >>
> >>  >>  Changes:
> >>  >>
> >>  >>  v2: New patch
> >>  >>
> >>  >>   drivers/mtd/nand/raw/ingenic/Makefile         |   2 +-
> >>  >>   drivers/mtd/nand/raw/ingenic/jz4740_bch.c     | 173
> >>  >> ++++++++++++++++++
> >>  >>   .../mtd/nand/raw/ingenic/jz4780_bch_common.c  |   1 +
> >>  >>   .../nand/raw/ingenic/jz4780_bch_internal.h    |   1 +
> >>  >>   4 files changed, 176 insertions(+), 1 deletion(-)
> >>  >>   create mode 100644 drivers/mtd/nand/raw/ingenic/jz4740_bch.c
> >>  >>
> >>  >>  diff --git a/drivers/mtd/nand/raw/ingenic/Makefile
> >>  >> b/drivers/mtd/nand/raw/ingenic/Makefile
> >>  >>  index f38b467490cf..d16c96113a93 100644
> >>  >>  --- a/drivers/mtd/nand/raw/ingenic/Makefile
> >>  >>  +++ b/drivers/mtd/nand/raw/ingenic/Makefile
> >>  >>  @@ -1,3 +1,3 @@
> >>  >>   obj-$(CONFIG_MTD_NAND_JZ4740) +=3D jz4740_nand.o
> >>  >>   obj-$(CONFIG_MTD_NAND_JZ4780) +=3D jz4780_nand.o  =20
> >> jz4780_bch_common.o =20
> >>  >> \
> >>  >>  -				 jz4780_bch.o jz4725b_bch.o
> >>  >>  +				 jz4780_bch.o jz4725b_bch.o jz4740_bch.o =20
> >>  >
> >>  > I still don't see the point of the jz4780_bch_common/jz47xxx_bch
> >>  > separation. You seem to always embed all objects anyway, so you  =20
> >> can =20
> >>  > just put the code for both engines in the same source file and  =20
> >> decide =20
> >>  > which one to use based on the compat (which you already do  =20
> >> anyway).
> >>=20
> >>  Each SoC has a different set of registers for the BCH hardware. I=20
> >> can
> >>  try to
> >>  cram everything into one file, but it won't be that much cleaner. =20
> >=20
> > Then maybe they deserve separate drivers/modules.
> >=20
> > BTW, didn't you say that one IP uses Reed-Salomon instead of BCH. I'd
> > suggest prefixing structs and functions with jz47xx_ecc instead of
> > jz47xx_bch and naming the common part jz47xx_ecc.c to reflect that. =20
>=20
> Would it be a good idea to make a generic ECC API that the jz47xx_nand
> driver could use? Then the three jz47xx BCH codepaths could be separate
> drivers that register with the generic ECC core.

Definitely. Actually, Miquel is already working on that, but I don't
think it's a good idea to wait for this new framework to be finished to
get your changes merged. So I'd recommend having a jz specific ECC API
(pretty much the one you have in the common file expect it would be
prefixed with _ecc instead of _bch) and convert it to the generic
approach afterwards. Given the size of the common.c file, you can even
put everything in jz47xx_ecc.h as inline funcs to avoid having yet
another module.
