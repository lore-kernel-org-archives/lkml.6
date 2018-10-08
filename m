Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E579FC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7D32084D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="be0Z2t1q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7D32084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeJHOX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 10:23:29 -0400
Received: from ozlabs.org ([203.11.71.1]:36965 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbeJHOX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 10:23:28 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42TBQs0w6Lz9sCr;
        Mon,  8 Oct 2018 18:13:08 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538982789;
        bh=1mmtn5IeW5+rOILF8IIcgD/sMoF3iWunO4W4ihX05pw=;
        h=Date:From:To:Cc:Subject:From;
        b=be0Z2t1qf82e/oht1Dts8mhITUSw3ZqnLG/aGZs/PI0i0TT1lqKDa9NTZQ2+inj00
         5tVB2ZAgR0o+vG0Kg3TOgqfdmvnFq3go2sojjPSxBhGFsRvyBhvBmXhT+EgZyyk1ww
         it99PVVCZgRLLASZpgWVPZiLBH3JbwKau0HzwMHSiO/Abhv1YU345CCJ6zW3huWx7+
         YrQlpcQ9l05172EeiQyGgC95qJM0dOXDTQ/hMKYEhMNxg2nyAPyP4RoxxK+PYcCTT6
         45C68MoMBcTV71lZn7ABmkVt3r+Tbe5VvbyJP43qqAXW7xAxyuKPlBvdfSuQ2H1svW
         1VUSZmNb7lfMw==
Date:   Mon, 8 Oct 2018 18:12:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: linux-next: manual merge of the akpm-current tree with the
 compiler-attributes tree
Message-ID: <20181008181237.7c9d093c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/V/sCH/SXNhUzwvWUubp4XZU"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/V/sCH/SXNhUzwvWUubp4XZU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got conflicts in:

  include/linux/compiler-gcc.h
  include/linux/compiler_types.h

between commit:

  a3f8a30f3f00 ("Compiler Attributes: use feature checks instead of version=
 checks")

from the compiler-attributes tree and commit:

  b6fbc7334215 ("include/linux/compiler*.h: add version detection to asm_vo=
latile_goto")

from the akpm-current tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/compiler-gcc.h
index cfac027e1625,d8d314bfc23e..000000000000
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@@ -116,8 -130,34 +116,8 @@@
  #define randomized_struct_fields_end	} __randomize_layout;
  #endif
 =20
 -/*
 - * When used with Link Time Optimization, gcc can optimize away C functio=
ns or
 - * variables which are referenced only from assembly code.  __visible tel=
ls the
 - * optimizer that something else uses this function or variable, thus pre=
venting
 - * this.
 - */
 -#define __visible	__attribute__((externally_visible))
 -
 -/* gcc version specific checks */
 -
 -#if GCC_VERSION >=3D 40900 && !defined(__CHECKER__)
 -/*
 - * __assume_aligned(n, k): Tell the optimizer that the returned
 - * pointer can be assumed to be k modulo n. The second argument is
 - * optional (default 0), so we use a variadic macro to make the
 - * shorthand.
 - *
 - * Beware: Do not apply this to functions which may return
 - * ERR_PTRs. Also, it is probably unwise to apply it to functions
 - * returning extra information in the low bits (but in that case the
 - * compiler should see some alignment anyway, when the return value is
 - * massaged by 'flags =3D ptr & 3; ptr &=3D ~3;').
 - */
 -#define __assume_aligned(a, ...) __attribute__((__assume_aligned__(a, ## =
__VA_ARGS__)))
 -#endif
 -
  /*
-  * GCC 'asm goto' miscompiles certain code sequences:
+  * GCC < 4.8.2 'asm goto' miscompiles certain code sequences:
   *
   *   http://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D58670
   *
diff --cc include/linux/compiler_types.h
index 3439d7d0249a,c2ded31a4cec..000000000000
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@@ -130,6 -140,21 +130,10 @@@ struct ftrace_likely_data=20
  # define randomized_struct_fields_end
  #endif
 =20
 -#ifndef __visible
 -#define __visible
 -#endif
 -
 -/*
 - * Assume alignment of return value.
 - */
 -#ifndef __assume_aligned
 -#define __assume_aligned(a, ...)
 -#endif
 -
+ #ifndef asm_volatile_goto
+ #define asm_volatile_goto(x...) asm goto(x)
+ #endif
+=20
  /* Are two types/vars the same type (ignoring qualifiers)? */
  #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(=
b))
 =20

--Sig_/V/sCH/SXNhUzwvWUubp4XZU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu7A2UACgkQAVBC80lX
0GxeqQf/VT4bJ0LrlupMBLGwyXU7VslHQtuH5fQQ4FCMzEIwku+To+ELCdabCWuo
xi5rfM3PTS5m+/0nwuLClS01hp19yQ1KCGJiZ3LXyy9a0NvmlBw71drO6ZJx0n+3
ZPOfBTiH8U+DIq6sOFq9lTFALBjdePdIIHKw75fFNhUx1RrdmmAnUkMRfRKGfKtI
oWYUZnMkG+duGqEoHWzP8A6LqPs9+xwXvzlaPwTCMNz6lKv2IolFPsWbCfwwKAQv
Cuw9YfeQ4Tnv2r5mC+vwSjATUzWR4UJibkyAVl2JLWcF+Ga/icnEKvgPMbCoAnBS
qAbnAqTFh3KKnealUpBDetO3gqYZmg==
=2W9u
-----END PGP SIGNATURE-----

--Sig_/V/sCH/SXNhUzwvWUubp4XZU--
