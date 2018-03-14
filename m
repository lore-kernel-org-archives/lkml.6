Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933322AbeCNC7I (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 22:59:08 -0400
Received: from ozlabs.org ([103.22.144.67]:41595 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932809AbeCNC7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 22:59:07 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 14 Mar 2018 13:58:31 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Changbin Du <changbin.du@intel.com>
Subject: linux-next: manual merge of the tip tree with the jc_docs tree
Message-ID: <20180314135831.065098e8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/7E9w2lhE+yYZiPnX1eTpgF."; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7E9w2lhE+yYZiPnX1eTpgF.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  Documentation/trace/ftrace.txt

between commit:

  1f198e22bc3a ("trace doc: convert trace/ftrace.txt to rst format")

from the jc_docs tree and commit:

  92af4dcb4e1c ("tracing: Unify the "boot" and "mono" tracing clocks")

from the tip tree.

I fixed it up (the former moved the file, so I added the following patch)
and can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 14 Mar 2018 13:53:45 +1100
Subject: [PATCH] trace doc: merge fix for "tracing: Unify the "boot" and
 "mono" tracing clocks"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 Documentation/trace/ftrace.rst | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 0bc33ad4a3f9..55637926abdc 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -461,17 +461,9 @@ of ftrace. Here is a list of some of the key files:
 		and ticks at the same rate as the hardware clocksource.
=20
 	boot:
-		This is the boot clock (CLOCK_BOOTTIME) and is based on the
-		fast monotonic clock, but also accounts for time spent in
-		suspend. Since the clock access is designed for use in
-		tracing in the suspend path, some side effects are possible
-		if clock is accessed after the suspend time is accounted before
-		the fast mono clock is updated. In this case, the clock update
-		appears to happen slightly sooner than it normally would have.
-		Also on 32-bit systems, it's possible that the 64-bit boot offset
-		sees a partial update. These effects are rare and post
-		processing should be able to handle them. See comments in the
-		ktime_get_boot_fast_ns() function for more information.
+		Same as mono. Used to be a separate clock which accounted
+		for the time spent in suspend while CLOCK_MONOTONIC did
+		not.
=20
 		To set a clock, simply echo the clock name into this file::
=20
--=20
2.16.1

--=20
Cheers,
Stephen Rothwell

--Sig_/7E9w2lhE+yYZiPnX1eTpgF.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqoj9cACgkQAVBC80lX
0GxmoAgAkFbnnhPVItWXocGHwB+39kSmCRCrOV6lSLfdzmBzygrwBcwK/GpxwU0k
tzs4awTazeyYG3IiO90IW1QAC2iyCxlQqzjD0a4G6z96G5EjvKLbaCSmiYaAxLwF
Se8kfU7R2+jv5w8hp08F7ctm+nZypFRpUkJ5G3jtGniU2xew+BZjD/Zu5nfAWkql
jgVjQ7XzcgIfyPdGgF7F6Ek6hEY/cJOgGfobrY/d0qYQ8ETu6VkJT0Rp+matZDpW
6JYNu24UMZQCAjV7ftusjIL8DiRXGJmzTBJONLDNkPyEyxh8qwMgzjo/EOBXTzdk
5m+CkHOtEuEnzHPRlEendPyWfM6I9Q==
=2zUb
-----END PGP SIGNATURE-----

--Sig_/7E9w2lhE+yYZiPnX1eTpgF.--
