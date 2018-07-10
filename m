Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FC2C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 07:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEFA72089D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 07:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="cr3rWPSj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEFA72089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751230AbeGJH0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 03:26:24 -0400
Received: from ozlabs.org ([203.11.71.1]:34953 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750937AbeGJH0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 03:26:22 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Ptzc47dyz9rvt;
        Tue, 10 Jul 2018 17:26:19 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531207580;
        bh=jwjkTpi4mWtASbmvN6inf5YS+xuMWOkGUe2OF9z1mgc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cr3rWPSj4fcR4e/iGNanKAGv1uwLi3nMefUFtg9VvMMXEXUdmmQ4dWk1D0aOLRz5s
         WiFZN/pQrggbOFofuONXXmP0tMgLn0ZAmlS9klPiGjKhXByAWIo0PRZFuggIQrGZG4
         90QsWIqhBRfJRF/71/ejnYeKx+NhecZFlTD7HX4uRDqiaW3EH+QpT6oju4DmiX3yXo
         b/ePjAqwuLZVR+jFKG4ZGPIPcoswZcp7kpAg74ClhwHYCWQ6IiFC71o75cNKDzrGFZ
         j7qidNAcgp1vgByRrnBZvgQJQX6cvdLQRDWsm4KEYqNGF2JAJQGKnyjcZ1JindMKed
         aiEvraEoKQ85g==
Date:   Tue, 10 Jul 2018 17:26:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     "Tobin C. Harding" <me@tobin.cc>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the random tree
Message-ID: <20180710172619.45e290a2@canb.auug.org.au>
In-Reply-To: <20180618052900.GA4579@eros>
References: <20180608133748.58a272d5@canb.auug.org.au>
        <20180618133523.30db3ba0@canb.auug.org.au>
        <20180618052900.GA4579@eros>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/H55fNMiWsX4Atmo=EKYh.Lq"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/H55fNMiWsX4Atmo=EKYh.Lq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 18 Jun 2018 15:29:00 +1000 "Tobin C. Harding" <me@tobin.cc> wrote:
>
> On Mon, Jun 18, 2018 at 01:35:23PM +1000, Stephen Rothwell wrote:
> >=20
> > On Fri, 8 Jun 2018 13:37:48 +1000 Stephen Rothwell <sfr@canb.auug.org.a=
u> wrote: =20
> > >
> > > After merging the random tree, today's linux-next build (arm
> > > multi_v7_defconfig) produced this warning:
> > >=20
> > > lib/vsprintf.c:1668:13: warning: 'have_filled_random_ptr_key' defined=
 but not used [-Wunused-variable]
> > >  static bool have_filled_random_ptr_key __read_mostly;
> > >              ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > >=20
> > > Introduced by commit
> > >=20
> > >   bfe80ed3d7c7 ("vsprintf: add command line option debug_boot_weak_ha=
sh") =20
> >=20
> > I am still getting this ... =20
>=20
> This is fixed in:
>=20
> 	[PATCH v7 0/4] enable early printing of hashed pointers
>=20
>=20
> FYI v8 to come with unrelated change removing EXPORT_SYMBOL() (as suggest=
ed
> on LKML in response to v7)

Still getting this warning ...

--=20
Cheers,
Stephen Rothwell

--Sig_/H55fNMiWsX4Atmo=EKYh.Lq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltEX5sACgkQAVBC80lX
0Gyqmgf/RHgGjnLbREECJ1WUC0Vi1jsbkSm3sPMHcKFSJntJ2AAnE2qOGKTdXQFO
kVQpVgTiklTnzayjVCYHrWlHBA/4wgxYgsDRv+mLDszCcPyTg4AsHSNSDUHwAffY
uIxWJTWfCtqmGZKjP44l6eQRUrrPDPB41tdG0d4swFCYTFfx888LAQ9lB6Z5hbRu
HBDUdpuMZ6pq3VYBNd21JuwaXagOCEMDRfUYeY3Vi6M25GMaYvn52x1Z6/lTsgWw
caOpl9CTBHBBXxGsWFNSCAl1zti947G9LRG4VBe4G7aN7FrnzNKd1U4njuMRkC0n
bNUlAxArrbRMzxbgp7LMTKN+bwcAGQ==
=Ke9K
-----END PGP SIGNATURE-----

--Sig_/H55fNMiWsX4Atmo=EKYh.Lq--
