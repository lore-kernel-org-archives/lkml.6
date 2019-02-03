Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58705C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BAAD20823
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549202768;
	bh=CZB1HG99ZKUihx74HfI9K8BuEfDO2OnvC61as8LmKeE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=eDNqhZ5Hrtq7JbbQ0ZRiRh8FYRVEpaFzXN5p3zvToetneqVGLAp0bf4IhZhRlXy50
	 5M62HedKN0eERlCNPWfT+2pk8EqmbMMRhEQveTI0rbBzZid+aLueOL92TbfBH3mMNq
	 IBrO6qr1U8cdL119njEtHMMHbn5Tw3Sskj6JIwnQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbfBCOGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:06:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:40878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729631AbfBCOFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:05:06 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29C882082C;
        Sun,  3 Feb 2019 14:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549202705;
        bh=CZB1HG99ZKUihx74HfI9K8BuEfDO2OnvC61as8LmKeE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u34E0pEkXE3Ly4z10xciKB8c+H2wTDEQni8gVWfWAEyVkpamg3Nkax17xsptBR/nB
         Goe43A+d3+LBYeXa6x+e4tSyTGQhLRCVGuGupoQpwQdRfP/7t9cYdpKm+kwMdQuqBW
         XTmeAeK/cv0s58mX6u2wiUFHYlkDQ/ERtAidSTuw=
Date:   Sun, 3 Feb 2019 15:04:53 +0100
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
Subject: Re: [PATCH v2 0/9] Ingenic JZ4780 NAND patchset v2
Message-ID: <20190203150453.43732f7c@bbrezillon>
In-Reply-To: <1549198896.1950.0@crapouillou.net>
References: <20190202231926.2444-1-paul@crapouillou.net>
        <20190203082032.6e37c523@bbrezillon>
        <1549198896.1950.0@crapouillou.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Feb 2019 10:01:36 -0300
Paul Cercueil <paul@crapouillou.net> wrote:

> Hi,
>=20
> Le dim. 3 f=C3=A9vr. 2019 =C3=A0 4:20, Boris Brezillon <bbrezillon@kernel=
.org>=20
> a =C3=A9crit :
> > On Sat,  2 Feb 2019 20:19:17 -0300
> > Paul Cercueil <paul@crapouillou.net> wrote:
> >  =20
> >>  Hi,
> >>=20
> >>  As requested by Boris, I added a patch to move all the Ingenic NAND
> >>  drivers to their own directory.
> >>=20
> >>  In this V2 I added support for the JZ4740 SoC. The combo of the
> >>  jz4780-nemc, jz4780-nand and jz4740-bch now obsolete the old and=20
> >> dusty
> >>  jz4740-nand driver. =20
> >=20
> > Any plan to get the old driver removed? I guess you want to migrate=20
> > the
> > boards to DT first. =20
>=20
> Yes, that's the plan - migrate the qi_lb60 board first then drop the old
> driver.

Good, I hate having 2 drivers for the same IP live in parallel for too
long.
