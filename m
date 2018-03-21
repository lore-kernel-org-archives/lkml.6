Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751697AbeCUEcJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 00:32:09 -0400
Received: from ozlabs.org ([103.22.144.67]:48773 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750810AbeCUEcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 00:32:06 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 21 Mar 2018 15:31:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: linux-next: manual merge of the ftrace tree with the jc_docs tree
Message-ID: <20180321153127.23737f6e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/1=QtCQ0IlHt9VsoAl=+RIx3"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1=QtCQ0IlHt9VsoAl=+RIx3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Steven,

Today's linux-next merge of the ftrace tree got a conflict in:

  Documentation/trace/ftrace.txt
  (converted to Documentation/trace/ftrace.rst)

between commit:

  1f198e22bc3a ("trace doc: convert trace/ftrace.txt to rst format")

from the jc_docs tree and commit:

  2c1ea60b195d ("tracing: Add timestamp_mode trace file")

from the ftrace tree.

I fixed it up (I deleted the file and added the merge fix patch below -
which probably needs more work) and can carry the fix as necessary.
This is now fixed as far as linux-next is concerned, but any non
trivial conflicts should be mentioned to your upstream maintainer when
your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 21 Mar 2018 15:29:08 +1100
Subject: [PATCH] trace doc: merge fix for rst conversion of ftrace.txt

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 Documentation/trace/ftrace.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 55637926abdc..8aad686ff9a5 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -543,6 +543,30 @@ of ftrace. Here is a list of some of the key files:
=20
 	See events.txt for more information.
=20
+  timestamp_mode:
+
+	Certain tracers may change the timestamp mode used when
+	logging trace events into the event buffer.  Events with
+	different modes can coexist within a buffer but the mode in
+	effect when an event is logged determines which timestamp mode
+	is used for that event.  The default timestamp mode is
+	'delta'.
+
+	Usual timestamp modes for tracing:
+
+	  # cat timestamp_mode
+	  [delta] absolute
+
+	  The timestamp mode with the square brackets around it is the
+	  one in effect.
+
+	  delta: Default timestamp mode - timestamp is a delta against
+	         a per-buffer timestamp.
+
+	  absolute: The timestamp is a full timestamp, not a delta
+                 against some other value.  As such it takes up more
+                 space and is less efficient.
+
   hwlat_detector:
=20
 	Directory for the Hardware Latency Detector.
--=20
2.16.1

--=20
Cheers,
Stephen Rothwell

--Sig_/1=QtCQ0IlHt9VsoAl=+RIx3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqx4B8ACgkQAVBC80lX
0GxNuQf/VrKxhYa3EvK6bAZAIWavV06HUE22feu0TxbmlBUmuWKpOX41p1DfPW2g
rp52RD7Wufm5sZgIQWwn02Hd88VKhdtVFcV7DpoY3YTTgnpQLZm6nkFJGjc+QtLj
Xptk5YKxCt0949S313chUL740DqlMq+Fajg+0hiGLe/nHmzMBQ2VZ0Kj+dCV7S1G
SvKBKuQDiFHr/9pgvYjxAYo7f+VAL0LqciCCvc6j6C4AfvKOfbS1FcsJurnFHcC4
q49LaOmks4F5pvV5fh73Yrcc7PsyPfHJLvkf4IuAopt3l1EKRStsbRfe7S4pGcnG
3iJ+E0vVKB7lb+16PuJV3nVZaSUlMw==
=aLoC
-----END PGP SIGNATURE-----

--Sig_/1=QtCQ0IlHt9VsoAl=+RIx3--
