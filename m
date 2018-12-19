Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B60C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 03:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87AF9218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 03:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Sfqe3t8t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeLSDo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 22:44:27 -0500
Received: from ozlabs.org ([203.11.71.1]:60063 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbeLSDo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 22:44:27 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43KLNm2ZkLz9sCr;
        Wed, 19 Dec 2018 14:44:24 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545191064;
        bh=jhBBzKEqOzwz+UXsWq4GXOHsPgtq4Qc1pOgxM0a8wMQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Sfqe3t8tQAwWBW/V4lYkoNBWO+Dd4fUkr5p1G11mocX5STf2KeGOZuqBsbPsd9bZW
         K9wSg7+0ou9jyqtJfRH17VJeMAZAFooKgJSrxT1LczGaOpBQBnuPxlyXNWEZbXiyHs
         NndT3DzDDmIAly2CglmukZ3x8SUlGzPq0t4XpRZEoYqGnb8AmBK8UIZ+UkscgODMUC
         eSlaKZwNQMCORNoGi9niEL0mRPmitluAV9tNmM2peeNP7clfbZ8S4dzEY59ImKlqeN
         yJFPmtIr/yJUyDf6xPy1My4QczI7ZB/lyGr4TwMYwjYnCjAB7hL9lBEnt0OdxbBsSh
         P0j2KVxsnHLzQ==
Date:   Wed, 19 Dec 2018 14:44:23 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: linux-next: Tree for Dec 11
Message-ID: <20181219144423.089e46b9@canb.auug.org.au>
In-Reply-To: <20181212093632.774c0603@canb.auug.org.au>
References: <20181211182627.42b79e40@canb.auug.org.au>
        <20181211173851.GA29028@roeck-us.net>
        <20181211180437.GA28010@flashbox>
        <20181212093632.774c0603@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/O2rkDmhjeE=BWL8=zuE09Qt"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/O2rkDmhjeE=BWL8=zuE09Qt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 12 Dec 2018 09:36:32 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Tue, 11 Dec 2018 11:04:37 -0700 Nathan Chancellor <natechancellor@gmai=
l.com> wrote:
> >
> > On Tue, Dec 11, 2018 at 09:38:51AM -0800, Guenter Roeck wrote: =20
> > > Build results:
> > > 	total: 152 pass: 150 fail: 2
> > > Failed builds:=20
> > > 	arm:allmodconfig=20
> > > 	arm64:allmodconfig=20
> > > Qemu test results:
> > > 	total: 337 pass: 137 fail: 200
> > >=20
> > > Build failures:
> > >=20
> > > arm:
> > >=20
> > > In file included from drivers/media/pci/ddbridge/ddbridge.h:22:0,
> > >                  from drivers/media/pci/ddbridge/ddbridge-ci.c:19:
> > > arch/arm/include/asm/irq.h:35:50: error: unknown type name 'cpumask_t'
> > >    =20
> >=20
> > Just FYI, I noticed this one yesterday on next-20181210 and sent a patc=
h:
> > https://lore.kernel.org/linux-media/20181210233514.3069-1-natechancello=
r@gmail.com/ =20
>=20
> I have added that patch after the v4l-dvb tree for today.

I am still applying that patch ...

--=20
Cheers,
Stephen Rothwell

--Sig_/O2rkDmhjeE=BWL8=zuE09Qt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwZvpcACgkQAVBC80lX
0Gw0Tgf/VjsVzhkRc3iFtCzf51Ei59QGW7MzBU7OLXZe5jSRDc4iF47ShDOQEPk4
8q1RXR9kl74z34yp+8uFKtO9sP1wkVfT+qXPxKLNtcEgKa+K8cQe5zUNLjZllACj
mw0TzVSS2y43LkqTbefCYiH2a5DFxrcsCmEXwWfatKAFZW5yapSxSpBI9PE/pB62
o/Bmn+dG1JxraSEyO2pvodut/oSg3u1d8vjfpLP1N6uBHbSTUlUmPOPiTuBqTQzn
Rep07w8gHPrDvWwTNLTHnDbvJexAWQCxBcRC+oJTokI6wfqZKdgtZhfoH1rtvTHj
274ocTfDOLz75lOQWNLZMru/BMEv0Q==
=wEjz
-----END PGP SIGNATURE-----

--Sig_/O2rkDmhjeE=BWL8=zuE09Qt--
