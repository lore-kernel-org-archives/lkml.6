Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621DFC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C3572082C
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549202924;
	bh=m578Ap1IUsphbWMvNDrbrmxIuE2xsjsUOTEcjHWuwH4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KCDsOt4ahm4w8i8r9rDHOWMuET1zwmZ0bgRqaxJyk3SMlmJMIFkfd10Y+FmxDPJCc
	 NGOSc9EF1LORh/8ccFPBFrxJJLKartDdNuWMdzkn0+5JYSkZdGe7s1gdvk3jEgQb2w
	 LPOPfrIWJoLVVYWt2/0LBvMI3AUQXWA2HPa4RdC4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfBCOIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:08:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:42864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727800AbfBCOIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:08:41 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E044520823;
        Sun,  3 Feb 2019 14:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549202921;
        bh=m578Ap1IUsphbWMvNDrbrmxIuE2xsjsUOTEcjHWuwH4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BANXZKK+cidl6/sTGKBGEB2LRUXnKPhKCYwUENqEkDdcgHVSwFCtZgGkt6fTA/ptF
         39En1pB+Q79lBOQEVEJv9BCVt6VVenAz2ve0efFnfQ0F00d8QQvNJYphMK182A/rJ3
         u3HTarSmSrrLcVoglAY19VjzeS7q7iH88/FbXcCc=
Date:   Sun, 3 Feb 2019 15:08:27 +0100
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
Subject: Re: [PATCH v2 4/9] mtd: rawnand: jz4780: Add support for the JZ4740
Message-ID: <20190203150827.401ac31d@bbrezillon>
In-Reply-To: <1549202213.1950.1@crapouillou.net>
References: <20190202231926.2444-1-paul@crapouillou.net>
        <20190202231926.2444-5-paul@crapouillou.net>
        <20190203083151.4fc29c5b@bbrezillon>
        <1549202213.1950.1@crapouillou.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Feb 2019 10:56:53 -0300
Paul Cercueil <paul@crapouillou.net> wrote:

> Le dim. 3 f=C3=A9vr. 2019 =C3=A0 4:31, Boris Brezillon <bbrezillon@kernel=
.org>=20
> a =C3=A9crit :
> > On Sat,  2 Feb 2019 20:19:21 -0300
> > Paul Cercueil <paul@crapouillou.net> wrote:
> >  =20
> >>  Add support for probing the jz4780-nand driver on the JZ4740 SoC=20
> >> from
> >>  Ingenic.
> >>=20
> >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> >>  ---
> >>=20
> >>  Changes:
> >>=20
> >>  v2: - Add support for the JZ4740 and not the JZ4725B: they behave=20
> >> the
> >>        same, and JZ4740 is fully upstream while JZ4725B is not. The
> >>        JZ4725B devicetree will then simply use the=20
> >> "ingenic,jz4740-nand"
> >>        compatible string.
> >>      - Fix the number of bytes for the ECC when the ECC strength is=20
> >> 4.
> >>        This is needed for the JZ4740, which uses Reed-Solomon=20
> >> instead of
> >>        BCH.
> >>=20
> >>   drivers/mtd/nand/raw/ingenic/jz4780_nand.c | 48=20
> >> +++++++++++++++++----- =20
> >=20
> > If we're going to make the driver compatible with jz4740 and jz4725b
> > maybe we should rename the source files jz47xx_{nand,bch}.{c,h}. =20
>=20
> I don't know about that. Adding support for new hardware isn't a good=20
> reason to
> rename the driver, or so I've been told around here, as you then make=20
> it harder
> to review the git history of the driver.

You already move files to a sub-directory so that doesn't make a huge
difference, history will be hard to follow because of this move anyway.
