Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF9AC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E93A214ED
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="aHwyOOEY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E93A214ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731344AbeHPCwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 22:52:42 -0400
Received: from ozlabs.org ([203.11.71.1]:39313 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729419AbeHPCwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 22:52:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41rRHN46Svz9s0R;
        Thu, 16 Aug 2018 09:58:08 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534377488;
        bh=yYF/86+PF+QX90aQztGmURL++Gx9ctpyo6C1lCfmNy0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aHwyOOEYDH3gGl/jQZzUw1uHCl4YS20P9dtwZ2GuRLOR2sevbNb6yuK6S7sG0DLj8
         wgxGB7eo6CpRSZryHhzKcCiOG9jlRznnv4Pc+DMjSkmimpyEtkqD2y9d23NlJAWDod
         amtL0nH8LRhmjq0qkc1nXXkL+huKhR2lISvrSnkdbbtZkJJWdeIvn5LGj1v+jL3h/2
         PctJvSwqRTz/8JsSMZab+LfPCYGfHF2PdRDteiz/UqTsOMhnUEZTWSvpS2F3BAWuEQ
         WRIkDwFHScz5JkC2UYgUy6SJhh69G9l9TgeA0v9VuD4dsO8iZr2iZwnTMB3CAPLVKm
         L2on+m0HfVZTA==
Date:   Thu, 16 Aug 2018 09:58:08 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@google.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: manual merge of the kspp tree with the kbuild tree
Message-ID: <20180816095808.00b54eff@canb.auug.org.au>
In-Reply-To: <20180816095628.686cba3a@canb.auug.org.au>
References: <20180803173020.6ec4014b@canb.auug.org.au>
        <20180816095628.686cba3a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/9a9AnTljfiGO._XwC8ITnN4"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9a9AnTljfiGO._XwC8ITnN4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 16 Aug 2018 09:56:28 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Fri, 3 Aug 2018 17:30:20 +1000 Stephen Rothwell <sfr@canb.auug.org.au>=
 wrote:
> >
> > Today's linux-next merge of the kspp tree got a conflict in:
> >=20
> >   arch/Kconfig
> >=20
> > between commit:
> >=20
> >   22471e1313f2 ("kconfig: use a menu in arch/Kconfig to reduce clutter")
> >=20
> > from the kbuild tree and commit:
> >=20
> >   45332b1bdfdc ("gcc-plugins: split out Kconfig entries to scripts/gcc-=
plugins/Kconfig")
> >=20
> > from the kspp tree.
> >=20
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> >=20
> > --=20
> > Cheers,
> > Stephen Rothwell
> >=20
> > diff --cc arch/Kconfig
> > index 6cf1b17a8df2,43f315b84c8f..000000000000
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@@ -984,4 -836,4 +847,6 @@@ config REFCOUNT_FUL
> >  =20
> >   source "kernel/gcov/Kconfig"
> >  =20
> > + source "scripts/gcc-plugins/Kconfig"
> > ++
> >  +endmenu =20
>=20
> This is now a conflict between Linus' tree and the kspp tree.

Ignore this, the kspp tree has been merged by Linus as well.

--=20
Cheers,
Stephen Rothwell

--Sig_/9a9AnTljfiGO._XwC8ITnN4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlt0vhAACgkQAVBC80lX
0Gz3Xwf/bqKXB/f8HjEPq+H2LwS0A1EAQF0j+LrtAbHZxKEg7MmgSy6iirwau+I+
SrzoCJMD4JyEwQ1D9uKJ3fJilo0pYXrfEIjjtSGnjSWOAoct38Jp3H1+T6DoDu2g
3PnqwJ+IaEJQHz1fvLSgiQZ7eevdVtUQc0I1PRCuXZA1QrF/6xyRml8rnc2OeDXT
H7ZWnGz4qb0hbnl3pJKurFDIsRTdqCSTVcykCS+w8wuvdTUNl9S23OTjpI7xIyER
8rpSbfOKdN17ZZuFhS4AWEeZl89D/AUg1xp0XubOsY7rlp4ozAnyVbchs4OtPD18
b1h90UBEviF+FcrUzYej/73BIvPFLA==
=YMc2
-----END PGP SIGNATURE-----

--Sig_/9a9AnTljfiGO._XwC8ITnN4--
