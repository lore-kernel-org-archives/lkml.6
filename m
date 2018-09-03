Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2656C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 11:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D7620645
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 11:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="b253noL5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D7620645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeICPgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 11:36:13 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58720 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbeICPgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 11:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hy5ZjyDKQT9y3+w3V8UINFKUtSyqvyyuBkLoxwMx7UU=; b=b253noL5z7WUlNmMM7VHdCYVY
        fBkLOVyh3zcEVokl1bNOyspX/ErWVWuc6zH6TqatOybEL9cKF/qiqTNnazb1khKw2JvlMGhi4SryK
        gznjmN6cU2E3QankBvQxoQJDxPAcelGaR9uoDxKs1+rEfMki/B7/RVwlZCt1bJYSdW+3Q=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fwmqJ-0000BE-B8; Mon, 03 Sep 2018 11:16:27 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E2EA411227AE; Mon,  3 Sep 2018 12:16:26 +0100 (BST)
Date:   Mon, 3 Sep 2018 12:16:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sasha Levin <Alexander.Levin@microsoft.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Akshu Agrawal <akshu.agrawal@amd.com>
Subject: Re: [PATCH AUTOSEL 4.18 043/131] ASoC: soc-pcm: Use delay set in
 component pointer function
Message-ID: <20180903111626.GC10302@sirena.org.uk>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
 <20180902064601.183036-43-alexander.levin@microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CblX+4bnyfN0pR09"
Content-Disposition: inline
In-Reply-To: <20180902064601.183036-43-alexander.levin@microsoft.com>
X-Cookie: Inside, I'm already SOBBING!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 02, 2018 at 01:03:55PM +0000, Sasha Levin wrote:
> From: Akshu Agrawal <akshu.agrawal@amd.com>
>=20
> [ Upstream commit 9fb4c2bf130b922c77c16a8368732699799c40de ]
>=20
> Take into account the base delay set in pointer callback.
>=20
> There are cases where a pointer function populates
> runtime->delay, such as:
> ./sound/pci/hda/hda_controller.c
> ./sound/soc/intel/atom/sst-mfld-platform-pcm.c

I'm worried that if anyone notices this at all they will have already
compensated for the delays in userspace and therefore this will cause
them to see problems as they get double compenstation for delays.

--CblX+4bnyfN0pR09
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluNGAoACgkQJNaLcl1U
h9D4KAf/WEpG66GEu/Nt3vsarOLjudyUDLScLRtNYaMRi1LS3EMsHFWfgQ7Ysebr
eaX6wxQM2ZAVmUKzlxy8vJrJ3PvTIfRQBHwAMman8Em3HR8sdmY4EEmpVSpSd52P
jnS5ke5jdURP6gfsWOU0ho3QOT5Fil1GJTYlZGGnX/aqERwKuC2oddDLO3GltIOl
VnsqQeUUSsk4m6EKvA25DRr1xxeb+3Hj3st5C9I8cq8D+7MF6qQDZPIKEra2/x/L
+dl+bqf+jmHXIi7uq3krYYko2pVEaqb+gkTGe3XsVR7RK8Yt2K5jcxYnAj4rZz7q
STWJV9Vxo5ULTKQ+EjT8CPWTbJTu+Q==
=Wo/o
-----END PGP SIGNATURE-----

--CblX+4bnyfN0pR09--
