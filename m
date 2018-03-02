Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753192AbeCBFHt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 00:07:49 -0500
Received: from ozlabs.org ([103.22.144.67]:38487 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753155AbeCBFHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 00:07:47 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 2 Mar 2018 16:07:32 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Petr Mladek <pmladek@suse.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>
Subject: linux-next: build failure after merge of the printk tree
Message-ID: <20180302160732.12691fbc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/yoqieWGv87Mi0RcsMD8bxDF"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yoqieWGv87Mi0RcsMD8bxDF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Petr,

After merging the printk tree, today's linux-next build (bfin
BF518F-EZBRD_defconfig) failed like this:

lib/dump_stack.o: In function `dump_stack':
lib/dump_stack.c:122: multiple definition of `dump_stack'
arch/blackfin/kernel/dumpstack.o:arch/blackfin/kernel/dumpstack.c:166: firs=
t defined here

Presumably caused by commit

  8040af489957 ("printk: move dump stack related code to lib/dump_stack.c")

(Though it is not immediately obvious why.)

This fails all the blackfin builds.  nds32 (a new architecture) also
has a dump_stack function.

--=20
Cheers,
Stephen Rothwell

--Sig_/yoqieWGv87Mi0RcsMD8bxDF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqY3BQACgkQAVBC80lX
0GygNQf+IRQoifxVZuc0RnIl0ixRgCPwQA/9e0XnKOSupZbQX2WvNs6Anm89O14R
EblB3JzPU/BcGtCqPeVfrsCC5ILM9YniTecd97W6yjaASdcxG+GZc3lATb7Ao7vY
VS9oJoH1zQH/BE8tQ+TVl6tNA0r+Avx9HDekwEXtj5CyzHHcWdnPfkhKY9Vcpi7d
2/og4vXKsjeDTwvnhkzX9Bmg5YBpJnSoLKlOLpSAt2uXWzPVO9rfZos42XyTHX95
2CHkjEd3A2epgx+ggP9Pc/6vOxIvFhuJYx86Zz4j6qWlCkB5X2aymTT7NE7N6HpR
lOH/u1Zb6WqMyNHP0HYQxWVU0P5OdA==
=EiWY
-----END PGP SIGNATURE-----

--Sig_/yoqieWGv87Mi0RcsMD8bxDF--
