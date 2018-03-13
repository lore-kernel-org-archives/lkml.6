Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753201AbeCMU6b (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 16:58:31 -0400
Received: from ozlabs.org ([103.22.144.67]:50089 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752592AbeCMU63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 16:58:29 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 14 Mar 2018 07:58:00 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20180314075800.49fc10e5@canb.auug.org.au>
In-Reply-To: <20180313124434.6f91b499b16080e766ab070f@linux-foundation.org>
References: <20180313205119.6ca3c1aa@canb.auug.org.au>
        <20180313124434.6f91b499b16080e766ab070f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/m.dZac+qbtJxaFjAizv+2eg"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/m.dZac+qbtJxaFjAizv+2eg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Tue, 13 Mar 2018 12:44:34 -0700 Andrew Morton <akpm@linux-foundation.org=
> wrote:
>
> On Tue, 13 Mar 2018 20:51:19 +1100 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
>=20
> > After merging the akpm-current tree, today's linux-next build (lots of
> > configuations) failed like this:
> >=20
> > (from the i386 defconfig build)
> >=20
> > In file included from include/linux/memcontrol.h:29:0,
> >                  from include/linux/swap.h:9,
> >                  from include/linux/suspend.h:5,
> >                  from arch/x86/kernel/asm-offsets.c:13:
> > include/linux/mm.h: In function 'get_mm_hiwater_rss':
> > include/linux/mm.h:1569:9: error: first argument to '__builtin_choose_e=
xpr' not a constant
> > include/linux/mm.h: In function 'get_mm_hiwater_vm':
> > include/linux/mm.h:1574:9: error: first argument to '__builtin_choose_e=
xpr' not a constant
> >=20
> > and many more ...
> >=20
> > Caused by commit
> >=20
> >   c7c133f3d5ff ("kernel.h: skip single-eval logic on literals in min()/=
max()")
> > (and perhaps the folloups)
> >=20
> > Just a few of my builds actaully worked (including those I do
> > during the day).  For complete logs see
> > http://kisskb.ellerman.id.au/kisskb/head/13556/ .
> >=20
> > I guess it could be compiler version specific.  The failing ones are
> > done with gcc 4.6.3.  My successful ones with gcc 7.3.1. =20
>=20
> Yes, this is being a pain in the butt.  I guess we should drop the
> patches for now.

OK, I have removed them from my copy of your tree (rather than add
reverts on top).

--=20
Cheers,
Stephen Rothwell

--Sig_/m.dZac+qbtJxaFjAizv+2eg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqoO1gACgkQAVBC80lX
0GwErAf/b9mDemDFZRPlflJQJt/k6uZc20pHlSDz+FtXVmHeGJ8UHir4WYghxhAd
M1PpSA7TKYJBPt4YR0nrXgsvvpNZOLBcYr3GPp+Qb47t44UA/D4iCUG0nGfbUCrz
imkwVxonj/BWGR7Bm78mT4ioF0dZ84DfJqQFmLOzDB/9AHGkQHEAGAZ6XPY0mDqA
JSL7XqLTuzTEkcS9KLhi9dFdlCI6uCAHSbi0RrhJgiv0JPm6ZOZCXvfhqrkviL/E
zuTyCDImfVLZED/4ZK+/kMULqf7RbfbPMDKO/K60feRoiTeYoyjnnHR0h6LdGwlg
+4hfXlIKfOhnr3XUGegnyisDa0Nk/Q==
=oXPu
-----END PGP SIGNATURE-----

--Sig_/m.dZac+qbtJxaFjAizv+2eg--
