Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932485AbeCMDLx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 23:11:53 -0400
Received: from ozlabs.org ([103.22.144.67]:42391 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932294AbeCMDLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 23:11:51 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 13 Mar 2018 14:11:18 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: linux-next: manual merge of the tip tree with the arm-soc tree
Message-ID: <20180313141118.41cd6419@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/62QK8zv9iQLslRFcHWl.Fux"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/62QK8zv9iQLslRFcHWl.Fux
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  drivers/bus/arm-cci.c

between commit:

  3de6be7a3dd8 ("drivers/bus: Split Arm CCI driver")

from the arm-soc tree and commit:

  8343aae66167 ("perf/core: Remove perf_event::group_entry")

from the tip tree.

I fixed it up (I have added the following merge fix patch) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 13 Mar 2018 14:08:01 +1100
Subject: [PATCH] perf/core: merge fix for "drivers/bus: Split Arm CCI drive=
r"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/perf/arm-cci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index 67a74c48c7c2..192d23b760a0 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -1265,7 +1265,7 @@ static int validate_group(struct perf_event *event)
 	if (!validate_event(event->pmu, &fake_pmu, leader))
 		return -EINVAL;
=20
-	list_for_each_entry(sibling, &leader->sibling_list, group_entry) {
+	list_for_each_entry(sibling, &leader->sibling_list, sibling_list) {
 		if (!validate_event(event->pmu, &fake_pmu, sibling))
 			return -EINVAL;
 	}
--=20
2.16.1

--=20
Cheers,
Stephen Rothwell

--Sig_/62QK8zv9iQLslRFcHWl.Fux
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqnQVYACgkQAVBC80lX
0Gxc6Qf9H3xh6Frqe6kdcZIek9QjZ7wJIlKK42WzXFVR6OVlPZ5OkLZfjmWzt+8n
MWNb18KJPW2H0aUYId2nDQ95G8SPizE5x3DtWKLaBOUN5Gqk7skr7t9jEHphHyrV
2MKJYoE42kTzp+srjLDZ1jJ3LjGl1giH2fpcQKx5RE74IbRSsoy5cuGXuiAlIvjq
EtTwBTLiu92LXmqmzeyRh/w6dsV2zeaUvy6mdNUfRGfQTZVlTPOzx8Dt4whHaTbX
25fmDfyVOM5z3KGPl9+IQ+yonahVFFdTcj839wDB6/rMzG47Lquj1m1hLPNOiN3N
qG9xKYtN4nJm7KjMVKZkVX1/a33zBQ==
=7QJ0
-----END PGP SIGNATURE-----

--Sig_/62QK8zv9iQLslRFcHWl.Fux--
