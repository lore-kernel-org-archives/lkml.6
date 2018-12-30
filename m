Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4EAC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 16:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3FC2084A
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 16:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbeL3Qtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 11:49:55 -0500
Received: from wes1-so2-b.wedos.net ([46.28.106.45]:33347 "EHLO
        wes1-so2.wedos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725954AbeL3Qty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 11:49:54 -0500
Received: from localhost (ip4-46-39-182-135.cust.nbox.cz [46.39.182.135])
        by wes1-so2.wedos.net (Postfix) with ESMTPSA id 43SRHy6XwVzpy;
        Sun, 30 Dec 2018 17:49:50 +0100 (CET)
Date:   Sun, 30 Dec 2018 17:49:45 +0100
From:   Otto Sabart <ottosabart@seberm.com>
To:     linux-doc@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] doc: cgroup: use graphviz code instead of ASCII art
Message-ID: <20181230164945.GA2644@personal>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
X-PGP-Key: http://seberm.com/pubkey.asc
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The graphviz looks better. This patch also fixes multiple build warnings:
"WARNING: Block quote ends without a blank line; unexpected unindent."

Signed-off-by: Otto Sabart <ottosabart@seberm.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 83 ++++++++++++++++++++-----
 1 file changed, 66 insertions(+), 17 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-=
guide/cgroup-v2.rst
index 7bf3f129c68b..80c88a0869e4 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -344,10 +344,21 @@ example, to start a clean-up operation after all proc=
esses of a given
 sub-hierarchy have exited.  The populated state updates and
 notifications are recursive.  Consider the following sub-hierarchy
 where the numbers in the parentheses represent the numbers of processes
-in each cgroup::
+in each cgroup:
=20
-  A(4) - B(0) - C(1)
-              \ D(0)
+.. kernel-render:: DOT
+  :alt: hierarchy
+
+  digraph subhierarchy {
+    edge [
+      arrowhead=3D"none"
+    ];
+    rankdir=3DLR;
+
+    "A(4)" -> "B(0)";
+    "B(0)" -> "C(1)";
+    "B(0)" -> "D(0)";
+  }
=20
 A, B and C's "populated" fields would be 1 while D's 0.  After the one
 process in C exits, B and C's "populated" fields would flip to "0" and
@@ -380,10 +391,21 @@ are specified, the last one is effective.
 Enabling a controller in a cgroup indicates that the distribution of
 the target resource across its immediate children will be controlled.
 Consider the following sub-hierarchy.  The enabled controllers are
-listed in parentheses::
+listed in parentheses:
+
+.. kernel-render:: DOT
+  :alt: hierarchy
=20
-  A(cpu,memory) - B(memory) - C()
-                            \ D()
+  digraph subhierarchy {
+    edge [
+      arrowhead=3D"none"
+    ];
+    rankdir=3DLR;
+
+    "A(cpu,memory)" -> "B(memory)";
+    "B(memory)" -> "C()";
+    "B(memory)" -> "D()";
+  }
=20
 As A has "cpu" and "memory" enabled, A will control the distribution
 of CPU cycles and memory to its children, in this case, B.  As B has
@@ -497,12 +519,30 @@ in from or push out to outside the sub-hierarchy.
=20
 For an example, let's assume cgroups C0 and C1 have been delegated to
 user U0 who created C00, C01 under C0 and C10 under C1 as follows and
-all processes under C0 and C1 belong to U0::
+all processes under C0 and C1 belong to U0:
+
+.. kernel-render:: DOT
+  :alt: cgroup hierarchy
=20
-  ~~~~~~~~~~~~~ - C0 - C00
-  ~ cgroup    ~      \ C01
-  ~ hierarchy ~
-  ~~~~~~~~~~~~~ - C1 - C10
+  digraph hierarchyc0 {
+    edge [
+      arrowhead=3D"none"
+    ];
+
+    "C0" -> "C00";
+    "C0" -> "C01";
+  }
+
+.. kernel-render:: DOT
+  :alt: cgroup hierarchy
+
+  digraph hierarchyc1 {
+    edge [
+      arrowhead=3D"none"
+    ];
+
+    "C1" -> "C10";
+  }
=20
 Let's also say U0 wants to write the PID of a process which is
 currently in C10 into "C00/cgroup.procs".  U0 has write access to the
@@ -1505,12 +1545,21 @@ The limits are only applied at the peer level in th=
e hierarchy.  This means that
 in the diagram below, only groups A, B, and C will influence each other, a=
nd
 groups D and F will influence each other.  Group G will influence nobody.
=20
-			[root]
-		/	   |		\
-		A	   B		C
-	       /  \        |
-	      D    F	   G
-
+.. kernel-render:: DOT
+  :alt: Peer hierarchy
+
+  digraph hierarchy {
+    edge [
+      arrowhead=3D"none"
+    ];
+
+    "[root]" -> "A";
+    "[root]" -> "B";
+    "[root]" -> "C";
+    "A" -> "D";
+    "A" -> "F";
+    "B" -> "G";
+  }
=20
 So the ideal way to configure this is to set io.latency in groups A, B, an=
d C.
 Generally you do not want to set a value lower than the latency your device
--=20
2.17.2

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEb6VOpv2s03VHGoilgjuumfi+HjwFAlwo9ycACgkQgjuumfi+
HjzVOA/9Hjik0L0Nj3QOnVGTMvc9VVqbTYt8kEvoFwT2wuILkZY6dV0cOU9bkIfV
YBfUV9uEBjWop43/ETdR9/xzUJbXgwsPMlQXcUxqcRTy/BWO4cZTIAh5b9+g7HNb
SeZT38/FgFIMGNrmc6eAyoGHySYqLbMqDh05iYda2uZmKWKAkrMVvqJ7E6m6kVrw
U9UEirwhYZAGF8w/EtIPgyM4ezKFBGEVuTDbI5QW795esPZ7meAOK1Fsv2hhHPUJ
j6J4kV1r61fnNgbFyFfZD94yESaXcrOuRrrwuTk6VsassVtwyaTALp/rRhKMSJHo
fjgqBNXwE3yqF+RDQBXd3a7EAi0ZwDRDB67bfoB28Eb4UEPzAJP2WQrKsJVG0pB2
l6ocnFo88gq6p8sCk9BWtycL/wyzAX3PLoQNOy0fkb+uQqpqJBVCgYM7mgV6QzKj
E9hxJJ3uenX6qQGi7kM5PxTvpPO+uVDih3FV695UQhErImHGBMoJ5t/OOiPh0dpC
H5xXq9ILtjxGrx3Jcv5suBlUnFkA0NaCsAxMQL7mAYcDHYKhViwDAL5L0TZ2bhIJ
b9JWL6LWngCjabxHoaRy6HCugmCeyMVG+ijwZ55XIMpyuNrbizexzmQKeOwtJoXx
RCBnRGbmjxEBSdGfYn8iTTRsRQahwXVWgoz4giYNVkJl5WJpPAk=
=mFbc
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
