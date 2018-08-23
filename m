Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCDAC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 22:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EADBE2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 22:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jIuBLl/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EADBE2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeHXCJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 22:09:03 -0400
Received: from ozlabs.org ([203.11.71.1]:42937 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbeHXCJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 22:09:03 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41xK6J2C3xz9s47;
        Fri, 24 Aug 2018 08:37:11 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1535063833;
        bh=4eoCH+ywd7cwNF1u2hndNVxeAxo54/JNi7sTE+nHPOE=;
        h=Date:From:To:Cc:Subject:From;
        b=jIuBLl/FL1rZ+5TSvNd1b1prPYyMPNesG6goh4ZzqDpnnQeTg5hY9eMban2saO0/n
         /MLjiLPKAJolRlkUnn682wyol09PhhsRx7vu1QDXx0COtYfx5AuWYdjlCB5L7lggcH
         3jDXpmm+/WB2RUjMB5FgXxuNig6FhrsEvE1OMJnXaCGjOUOIijYmvD2fjBK1XjweuM
         cNsa2fBjH1SCzHjLDlH3ZShm9TW0fTdVHAcENTRDHidlagKHVeox0MP6WFH7MA1qP/
         drLvdAJecuo6I9km/viWLyX+TBXIyPjNOr0RQNfjMJpJY/cKM4fJW0BA/utJ9Zif13
         BRPknSFZBXlpw==
Date:   Fri, 24 Aug 2018 08:37:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: linux-next: manual merge of the mips tree with Linus' tree
Message-ID: <20180824083705.3c88e3ff@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/.ir.1uaE6CUGpUgHVaVzhX+"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.ir.1uaE6CUGpUgHVaVzhX+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mips tree got a conflict in:

  include/linux/compiler_types.h

between commit:

  815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually excl=
usive")

from Linus' tree and commit:

  04f264d3a8b0 ("compiler.h: Allow arch-specific asm/compiler.h")

from the mips tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/compiler_types.h
index 90479a0f3986,4be464a07612..000000000000
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@@ -54,20 -54,44 +54,32 @@@ extern void __chk_io_ptr(const volatil
 =20
  #ifdef __KERNEL__
 =20
 -#ifdef __GNUC__
 -#include <linux/compiler-gcc.h>
 -#endif
 -
 -#if defined(CC_USING_HOTPATCH) && !defined(__CHECKER__)
 -#define notrace __attribute__((hotpatch(0,0)))
 -#else
 -#define notrace __attribute__((no_instrument_function))
 -#endif
 -
 -/* Intel compiler defines __GNUC__. So we will overwrite implementations
 - * coming from above header files here
 - */
 -#ifdef __INTEL_COMPILER
 -# include <linux/compiler-intel.h>
 -#endif
 -
 -/* Clang compiler defines __GNUC__. So we will overwrite implementations
 - * coming from above header files here
 - */
 +/* Compiler specific macros. */
  #ifdef __clang__
  #include <linux/compiler-clang.h>
 +#elif defined(__INTEL_COMPILER)
 +#include <linux/compiler-intel.h>
 +#elif defined(__GNUC__)
 +/* The above compilers also define __GNUC__, so order is important here. =
*/
 +#include <linux/compiler-gcc.h>
 +#else
 +#error "Unknown compiler"
  #endif
 =20
+ /*
+  * Some architectures need to provide custom definitions of macros provid=
ed
+  * by linux/compiler-*.h, and can do so using asm/compiler.h. We include =
that
+  * conditionally rather than using an asm-generic wrapper in order to avo=
id
+  * build failures if any C compilation, which will include this file via =
an
+  * -include argument in c_flags, occurs prior to the asm-generic wrappers=
 being
+  * generated.
+  */
+ #ifdef CONFIG_HAVE_ARCH_COMPILER_H
+ #include <asm/compiler.h>
+ #endif
+=20
  /*
 - * Generic compiler-dependent macros required for kernel
 + * Generic compiler-independent macros required for kernel
   * build go below this comment. Actual compiler/compiler version
   * specific implementations come from the above header files
   */

--Sig_/.ir.1uaE6CUGpUgHVaVzhX+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlt/NxEACgkQAVBC80lX
0Gyk0QgAlBS17g8mECivuUMvkRpTBZIeCbqkeT3Cd2D6Hb70OFTA0dTFcNRpugPs
W6P8lpmYmBjpFBy865lDheeCsDyftDQmobKOhKgWQDUeXP8DU+5JACVsEACuDh5X
Xz3UWz2uNJz8kDBnzDxq9LIsAPFJILJYN2REUxO+ettWu2/M3GUyykHx0hzw8MxG
+okOlxP+nebfNsSJ1JbgndKJsyMcKBuwH1GMKXSV/Oy6KQEKVI30yi/sqQyDzYAI
sTtUKJa/O02c8YtiX/vzXoHkUWvqadBLr17dlo35WGWeMfEtEu+X4KKkh4i4+7HI
/X2PNrvFAvqmbikGMFuGuzyi8VIWmw==
=TS9U
-----END PGP SIGNATURE-----

--Sig_/.ir.1uaE6CUGpUgHVaVzhX+--
