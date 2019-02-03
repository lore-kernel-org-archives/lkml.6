Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BF8C282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C925B2084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549203392;
	bh=fqlKxu6hC/LlcgpY7oFMpeGGedZGIO72wvaf6VO46aA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=W59Yu7iBxC/C85nOx/nqRN+rU3TEyo1iks80Q4XqB22Fihg2su+7V/LhljWrZ5nbp
	 pLISDg/f/hvlWMMMl7serIlM7u2f/63VF66SxnHG5XDuMZ078l47OJx0DTFRdngytw
	 xRtWDqpla5suGAtICLhdEFhN5XycS34fTYBD+eck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfBCOQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:16:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:45754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726709AbfBCOQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:16:17 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C9342084A;
        Sun,  3 Feb 2019 14:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549203376;
        bh=fqlKxu6hC/LlcgpY7oFMpeGGedZGIO72wvaf6VO46aA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nc1vYNH2aiPeOvUIMecerWMyQFFu2HFGF4st653jxRukQ+zYIXWHYS/cwGAN0LduS
         VOTfAAQ0Ub4IriSrxnVCP5BClu0iZ42xGibKkjrBHVFlvxVSqlGUqH5gsNPHdKqubJ
         7Mexw2WmFGqOPUDf5LiInN5OqnLhyt/ZSkNnmuhE=
Date:   Sun, 3 Feb 2019 15:16:04 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Mathieu Malaterre <malat@debian.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 9/9] mtd: rawnand: jz4780-bch: Add support for the
 JZ4740
Message-ID: <20190203151604.23061e2a@bbrezillon>
In-Reply-To: <1549202293.1950.2@crapouillou.net>
References: <20190202231926.2444-1-paul@crapouillou.net>
        <20190202231926.2444-10-paul@crapouillou.net>
        <20190203083505.4dc52278@bbrezillon>
        <1549202293.1950.2@crapouillou.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Feb 2019 10:58:13 -0300
Paul Cercueil <paul@crapouillou.net> wrote:

> Le dim. 3 f=C3=A9vr. 2019 =C3=A0 4:35, Boris Brezillon <bbrezillon@kernel=
.org>=20
> a =C3=A9crit :
> > On Sat,  2 Feb 2019 20:19:26 -0300
> > Paul Cercueil <paul@crapouillou.net> wrote:
> >  =20
> >>  Add the backend code for the jz4780-bch driver to support the JZ4740
> >>  SoC from Ingenic.
> >>=20
> >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> >>  ---
> >>=20
> >>  Changes:
> >>=20
> >>  v2: New patch
> >>=20
> >>   drivers/mtd/nand/raw/ingenic/Makefile         |   2 +-
> >>   drivers/mtd/nand/raw/ingenic/jz4740_bch.c     | 173=20
> >> ++++++++++++++++++
> >>   .../mtd/nand/raw/ingenic/jz4780_bch_common.c  |   1 +
> >>   .../nand/raw/ingenic/jz4780_bch_internal.h    |   1 +
> >>   4 files changed, 176 insertions(+), 1 deletion(-)
> >>   create mode 100644 drivers/mtd/nand/raw/ingenic/jz4740_bch.c
> >>=20
> >>  diff --git a/drivers/mtd/nand/raw/ingenic/Makefile=20
> >> b/drivers/mtd/nand/raw/ingenic/Makefile
> >>  index f38b467490cf..d16c96113a93 100644
> >>  --- a/drivers/mtd/nand/raw/ingenic/Makefile
> >>  +++ b/drivers/mtd/nand/raw/ingenic/Makefile
> >>  @@ -1,3 +1,3 @@
> >>   obj-$(CONFIG_MTD_NAND_JZ4740) +=3D jz4740_nand.o
> >>   obj-$(CONFIG_MTD_NAND_JZ4780) +=3D jz4780_nand.o jz4780_bch_common.o=
=20
> >> \
> >>  -				 jz4780_bch.o jz4725b_bch.o
> >>  +				 jz4780_bch.o jz4725b_bch.o jz4740_bch.o =20
> >=20
> > I still don't see the point of the jz4780_bch_common/jz47xxx_bch
> > separation. You seem to always embed all objects anyway, so you can
> > just put the code for both engines in the same source file and decide
> > which one to use based on the compat (which you already do anyway). =20
>=20
> Each SoC has a different set of registers for the BCH hardware. I can=20
> try to
> cram everything into one file, but it won't be that much cleaner.

Then maybe they deserve separate drivers/modules.

BTW, didn't you say that one IP uses Reed-Salomon instead of BCH. I'd
suggest prefixing structs and functions with jz47xx_ecc instead of
jz47xx_bch and naming the common part jz47xx_ecc.c to reflect that.
