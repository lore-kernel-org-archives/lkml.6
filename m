Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E4CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 06:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E463222D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 06:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Iqifbe5I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfBPGWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 01:22:12 -0500
Received: from ozlabs.org ([203.11.71.1]:50607 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbfBPGWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 01:22:12 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 441g5Q74V4z9s7T;
        Sat, 16 Feb 2019 17:22:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550298129;
        bh=iHpNKem2HNQGfNgnRALLLbllqNJ3AW/b2p/hv8V8fQE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Iqifbe5I0imB2U5W+MMz/HO5RFNMV2Qp7RBqR6L4ZFuv0hbRwtsHKm+nH8/M06N5z
         6LuWTAeL8HN91eAQGLiQpTgO9sTN5boyURoLhMd1ySr83QVYoTClCIZFFt6fZb7RJT
         DDvbSsHJKv4Ylfe+HurjfzlkmKtTVh7KKfT3lU4HoR6mc7C2S439MQdLy5wM2qVavp
         Gle16O+yA+H21i0+zLa5HRogtYzLs3QIOroDrexRwxOIGULyOKeSbsbK11I7kd/tDE
         3mrqZkeZOb9xYztszSTPwAVW2YHOGq87iukx/snkPjfaVqeXpHK4OLhzHkZRsUrXIa
         rRHXVMEIhSepg==
Date:   Sat, 16 Feb 2019 17:21:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mark Brown <broonie@kernel.org>,
        "kernelci.org bot" <bot@kernelci.org>, tomeu.vizoso@collabora.com,
        guillaume.tucker@collabora.com,
        Dan Williams <dan.j.williams@intel.com>,
        matthew.hart@linaro.org, khilman@baylibre.com,
        enric.balletbo@collabora.com, Nicholas Piggin <npiggin@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Adrian Reber <adrian@lisas.de>, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michal Hocko <mhocko@suse.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: next/master boot bisection: next-20190215 on beaglebone-black
Message-ID: <20190216172157.77f0883c@canb.auug.org.au>
In-Reply-To: <20190215110024.011197d86e3ab8642a9bbecf@linux-foundation.org>
References: <5c6702da.1c69fb81.12a14.4ece@mx.google.com>
        <20190215104325.039dbbd9c3bfb35b95f9247b@linux-foundation.org>
        <20190215185151.GG7897@sirena.org.uk>
        <20190215110024.011197d86e3ab8642a9bbecf@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/2N.6XtaAhi3SXj.PGoC+_32"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2N.6XtaAhi3SXj.PGoC+_32
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Fri, 15 Feb 2019 11:00:24 -0800 Andrew Morton <akpm@linux-foundation.org=
> wrote:
>
> On Fri, 15 Feb 2019 18:51:51 +0000 Mark Brown <broonie@kernel.org> wrote:
>=20
> > On Fri, Feb 15, 2019 at 10:43:25AM -0800, Andrew Morton wrote: =20
> > > On Fri, 15 Feb 2019 10:20:10 -0800 (PST) "kernelci.org bot" <bot@kern=
elci.org> wrote: =20
> >  =20
> > > >   Details:    https://kernelci.org/boot/id/5c666ea959b514b017fe6017
> > > >   Plain log:  https://storage.kernelci.org//next/master/next-201902=
15/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-7/lab-collabora/boot-am335x-bo=
neblack.txt
> > > >   HTML log:   https://storage.kernelci.org//next/master/next-201902=
15/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-7/lab-collabora/boot-am335x-bo=
neblack.html =20
> >  =20
> > > Thanks. =20
> >  =20
> > > But what actually went wrong?  Kernel doesn't boot? =20
> >=20
> > The linked logs show the kernel dying early in boot before the console
> > comes up so yeah.  There should be kernel output at the bottom of the
> > logs. =20
>=20
> OK, thanks.
>=20
> Well, we have a result.  Stephen, can we please drop
> mm-shuffle-default-enable-all-shuffling.patch for now?

Dropped.

--=20
Cheers,
Stephen Rothwell

--Sig_/2N.6XtaAhi3SXj.PGoC+_32
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxnrAUACgkQAVBC80lX
0Gy7pAf/ajVfxnCsd6WEXykRPKeQW0zW2HCw9jXiyMYLK9YsKiR35PMkr3Bq7i+p
wFr+eG5Ktc93thjmc6bWE2x+LN1wOIeoeTOAJkbg3rRY7WJW8Ns3TkBxVAFP6sLF
MUZjeG+W7UDtzqu82nJX0bT7Tcil/drbjB+kNpY+qxOgy5SzKcKVh1lBcC2vGzs3
prrhsTUssLHAqcI5gGHQO3eIQG1UuEmKpxJj31vtZpJvOPejlm4vIW+IMGUEkd2x
XlGY+AjiLgdMh68d8IA4kwoNDQVtBWCdiwuCvH/hoqGsrERiqJyACmIckgSEr4PD
pdtHOS3bbduTQvtxTetk16P1drHNqw==
=l+na
-----END PGP SIGNATURE-----

--Sig_/2N.6XtaAhi3SXj.PGoC+_32--
