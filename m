Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA09C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D9AA20863
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549974046;
	bh=0LOEqXAkEOHarCbBQyBZo8Gaw8Lp/aLkjuDLANJDE0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fuLk+DyQaSZEOzVS2RGhulLBrBEn9jYXKMcnetFKPr07al5ZP1Ej93/Q+++P3aAH4
	 bi5P3J0VtjsFiLWeGYlGlD1MOCIbiMC2+YMhH4UVj1WPblY1v/+u4O9mnUVn04gbhI
	 FJukSmYDmtCcRcu+rkJluAlcT1OtzwTJULlO+R1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbfBLMUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:20:44 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49194 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbfBLMUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:20:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pcbX4d63ha7+7nhkF9F1CGVCOceyvWkG7gXc7YiQ5hU=; b=lAKXtO/+eAVfgdb9imAMNULFB
        Azu0H0Km+jQloik3MANZgOcASa9L8c5eeO4U2aVeorfpHaemNFcOkSlZrXE2h3TDFmP7aWwcjF67R
        khFDqSFZW2y6LfXpgY+A5dTEdAO9VAlXt3qZyu80ZANJQwA9KtPfxKpMGEKCdbOEEFqgM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gtX3E-0003zb-4s; Tue, 12 Feb 2019 12:20:36 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 7D0981128113; Tue, 12 Feb 2019 12:20:35 +0000 (GMT)
Date:   Tue, 12 Feb 2019 12:20:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        DTML <devicetree@vger.kernel.org>, arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] Add new device nodes for Spreadtrum SC9860 platform
Message-ID: <20190212122035.GA20635@sirena.org.uk>
References: <cover.1548052878.git.baolin.wang@linaro.org>
 <CAK8P3a3UROFLTtEcNXKtMUN283UQ6auQUOXCR=6e3BdLu5K8Nw@mail.gmail.com>
 <CAMz4kuLotnNom9kx2EmdfVEb+gvWfEbxoh6+hiqk87EjmtYJwA@mail.gmail.com>
 <20190201130519.GH20797@sirena.org.uk>
 <CAMz4kuJdPts31Ak-H=VAivvoqqPtxO5M1RdqrNPwTLT5d1h_7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <CAMz4kuJdPts31Ak-H=VAivvoqqPtxO5M1RdqrNPwTLT5d1h_7w@mail.gmail.com>
X-Cookie: tax office, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 12, 2019 at 04:40:10PM +0800, Baolin Wang wrote:
> On Fri, 1 Feb 2019 at 21:05, Mark Brown <broonie@kernel.org> wrote:

> > You can just list all the individual device names in the of_match_table
> > for the MFD and then it can bind to any of them.  You can always map
> > them onto the same behaviour in the MFD driver if they are identical
> > from a software point of view.

> If I understood correctly, as you suggested, we should add new
> mfd_cell groups to list all different PMICs' device names. Something
> like:

I do think this is a good idea (registering the components of the MFD
using mfd_cell), though it wasn't quite the point I was making.  Having
individual device names matters less for Linux-internal names like this.

> But from my point, they are just some meaningless duplication, and
> will waste lots of code there.

I was more thinking of the of_match table that has the IDs that appear
in DT - they're the one that's the ABI.  Look at something like wm8994
where the driver has several IDs listed in the main table then selects
function drivers based on that.

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxiuhAACgkQJNaLcl1U
h9AIrwf/duaHeW8vd49sPs90dsantq17G7uAI3r2j6QKJdcp6vMTcKRvlq0qahnh
ekHZkwL66Xqn+T0Hy58zRp2HKMmXOgTZAomEYQiLeZ1fAulq92j8jUROqQY5bNAh
V8/55At5oa/BmfWu75pwqMahTHThP5F82XXtaE9jCSJmYwg19Fmy69WkoIm2uMUG
2aSSqZI2kmELBUxWoErbVhqq0V0+BrgkLNxBtOZ1vmGqecV7eduAJqVls8jztS0k
N4knC7ebvKAhQ8B/HvbbpCrg65jyZa59y/BdJ0eAGsyiVczLeL2PoO9dz+pG+04E
/tGLg0VNm8KDei4/kDw2P6FtY/uZag==
=QmcW
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
