Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFF2C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 05:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4281F2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 05:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HWj3F8Ti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4281F2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbeK3QiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 11:38:19 -0500
Received: from ozlabs.org ([203.11.71.1]:55555 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbeK3QiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 11:38:19 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 435jdZ0x1Jz9s8r;
        Fri, 30 Nov 2018 16:30:10 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543555810;
        bh=Mar1U4eQMRyAMBTMzEHuATYmMpXDxcJ6OdOP+x8O/cs=;
        h=Date:From:To:Cc:Subject:From;
        b=HWj3F8TiInBVPhVniN4IQg/Gxj7PsoKVOJ6HtTeIYm3XCPp8BOBpkPnxHBQbjMwNq
         7DUOPfAMFann9QaLiDI3/J8e6v5czMi7XN/oZWP8UI1nWybd0pqSzsu1p9mV02q/64
         /4wgjAtW+AqLMIk7povHqCtaylsL6iXor17vhvsFlonvMHMx9VWdy0eaJrV0dfdQHF
         dEiY4MzfH4PR/3UnH1kxTnkkxfohSO81xSt9O9yuF0eE3lG+vfs1n+NFhFZOwA+oLe
         xwg5KCKnusseIn+7DazmiC0JFp0AFwVpqWBgzbwzS5QWEl0agT/iMszdDHPyDhjugM
         bhamIPrBywQ+g==
Date:   Fri, 30 Nov 2018 16:30:08 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: linux-next: build failure after merge of the akpm tree
Message-ID: <20181130163008.7d2b213f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zEZ9CCD=V0c1j7VEH4Vzx+Q"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zEZ9CCD=V0c1j7VEH4Vzx+Q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

After merging the akpm tree, today's linux-next build (powerpc_le perf)
failed like this:

bench/numa.c: In function 'bind_to_node':
bench/numa.c:301:21: error: 'NUMA_NO_NODE' undeclared (first use in this fu=
nction); did you mean 'NUMA_NUM_NODES'?
  if (target_node =3D=3D NUMA_NO_NODE) {
                     ^~~~~~~~~~~~
                     NUMA_NUM_NODES
bench/numa.c:301:21: note: each undeclared identifier is reported only once=
 for each function it appears in
bench/numa.c: In function 'bind_to_memnode':
bench/numa.c:342:14: error: 'NUMA_NO_NODE' undeclared (first use in this fu=
nction); did you mean 'NUMA_NUM_NODES'?
  if (node =3D=3D NUMA_NO_NODE)
              ^~~~~~~~~~~~
              NUMA_NUM_NODES
bench/numa.c: In function 'init_thread_data':
bench/numa.c:1366:19: error: 'NUMA_NO_NODE' undeclared (first use in this f=
unction); did you mean 'NUMA_NUM_NODES'?
   td->bind_node =3D NUMA_NO_NODE;
                   ^~~~~~~~~~~~
                   NUMA_NUM_NODES

Caused by patch

  "mm: replace all open encodings for NUMA_NO_NODE"

I applied the following partial revert for today:

=46rom 765f2fd3d18ca1d4d0783b888d127af784929e3e Mon Sep 17 00:00:00 2001
From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 30 Nov 2018 16:26:32 +1100
Subject: [PATCH] partial revert (perf) of "mm: replace all open encodings f=
or NUMA_NO_NODE"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 tools/perf/bench/numa.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index e0ad5f1de226..44195514b19e 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -298,7 +298,7 @@ static cpu_set_t bind_to_node(int target_node)
=20
 	CPU_ZERO(&mask);
=20
-	if (target_node =3D=3D NUMA_NO_NODE) {
+	if (target_node =3D=3D -1) {
 		for (cpu =3D 0; cpu < g->p.nr_cpus; cpu++)
 			CPU_SET(cpu, &mask);
 	} else {
@@ -339,7 +339,7 @@ static void bind_to_memnode(int node)
 	unsigned long nodemask;
 	int ret;
=20
-	if (node =3D=3D NUMA_NO_NODE)
+	if (node =3D=3D -1)
 		return;
=20
 	BUG_ON(g->p.nr_nodes > (int)sizeof(nodemask)*8);
@@ -1363,7 +1363,7 @@ static void init_thread_data(void)
 		int cpu;
=20
 		/* Allow all nodes by default: */
-		td->bind_node =3D NUMA_NO_NODE;
+		td->bind_node =3D -1;
=20
 		/* Allow all CPUs by default: */
 		CPU_ZERO(&td->bind_cpumask);
--=20
2.19.1

--=20
Cheers,
Stephen Rothwell

--Sig_/zEZ9CCD=V0c1j7VEH4Vzx+Q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwAyuAACgkQAVBC80lX
0Gw8jwf/TGAM09PCWuxA17iufNK75CA590m1YTGG1wrNdeoenoM6zZhuXhjiVnMN
V1OiGEsFtNvI0dRQaZ0O2ni8I2ju+FD5HYmVq5quBUfKWdBfc/qokkNsnQnqyP8u
JFHHWeMkxbtio4B6tdcKZb4M1cn8WuPnYsO50Zlm7dqxCvb/w1biETKKNLtJeET1
fEE29IxV20XpwBU70dCtXaVNCHdIbzL36OOzID5rq02YZKpV/KPrddjpdSQGRqNV
9fNdfBS0Ub8K1is48Ns1kUXtMb32nuFMpTWzDKhV5HmlWTYBZ0Bk1YgZ3GAf5EzM
QoP3S5B5EOqMy0N8MWpd9PnDRcnliw==
=qIWt
-----END PGP SIGNATURE-----

--Sig_/zEZ9CCD=V0c1j7VEH4Vzx+Q--
