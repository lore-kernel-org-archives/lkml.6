Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C30C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E406F2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E406F2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbeLMQ4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:56:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:16140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727511AbeLMQ4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 11:56:13 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ED9483082135;
        Thu, 13 Dec 2018 16:56:12 +0000 (UTC)
Received: from haswell-e.nc.xsintricity.com (ovpn-112-56.rdu2.redhat.com [10.10.112.56])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 19D0D1974F;
        Thu, 13 Dec 2018 16:56:11 +0000 (UTC)
Message-ID: <267101dbb3beb8883efe614e099e7ac4c7a84f37.camel@redhat.com>
Subject: [PULL REQUEST] Please pull rdma.git
From:   Doug Ledford <dledford@redhat.com>
To:     "Torvalds, Linus" <torvalds@linux-foundation.org>
Cc:     "Gunthorpe, Jason" <jgg@ziepe.ca>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Thu, 13 Dec 2018 11:56:10 -0500
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-D9i8SVO0+y+hI6fdaMxC"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 13 Dec 2018 16:56:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-D9i8SVO0+y+hI6fdaMxC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

We have 5 small fixes for this pull request.  One is a performance
regression, so not necessarily strictly a fix, but it was small and
reasonable and claimed to avoid thrashing in the scheduler, so I took
it.  The remaining are all legitimate fixes that match the "we take
fixes any time" criteria.

Here's the boilerplate:

The following changes since commit 7bca603a69c0c239654a8f0bcb99e1a60b30040c=
:

  RDMA/mlx5: Initialize return variable in case pagefault was skipped (2018=
-11-29 15:16:45 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linu=
s

for you to fetch changes up to 37fbd834b4e492dc41743830cbe435f35120abd8:

  IB/core: Fix oops in netdev_next_upper_dev_rcu() (2018-12-12 12:14:49 -05=
00)

----------------------------------------------------------------
Pull request for 4.20-rc

- One performance regression for hfi1
- One kasan fix for hfi1
- A couple mlx5 fixes
- A core oops fix

----------------------------------------------------------------
Artemy Kovalyov (1):
      IB/mlx5: Fix implicit ODP interrupted page fault

Mark Zhang (1):
      IB/core: Fix oops in netdev_next_upper_dev_rcu()

Michael J. Ruhl (1):
      IB/hfi1: Fix a latency issue for small messages

Piotr Stankiewicz (1):
      IB/hfi1: Fix an out-of-bounds access in get_hw_stats

Yishai Hadas (1):
      IB/mlx5: Block DEVX umem from the non applicable cases

 drivers/infiniband/core/roce_gid_mgmt.c | 3 +++
 drivers/infiniband/hw/hfi1/chip.c       | 3 ++-
 drivers/infiniband/hw/hfi1/hfi.h        | 2 ++
 drivers/infiniband/hw/hfi1/qp.c         | 7 +++++++
 drivers/infiniband/hw/hfi1/verbs.c      | 2 +-
 drivers/infiniband/hw/mlx5/devx.c       | 4 +++-
 drivers/infiniband/hw/mlx5/odp.c        | 9 ++++-----
 7 files changed, 22 insertions(+), 8 deletions(-)



--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-D9i8SVO0+y+hI6fdaMxC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlwSjyoACgkQuCajMw5X
L93AAhAArQcB28UZwypl9TI2eVIXg+zNQqnHIppGrx2TmV20yDRHyDSiWJASVgI5
SWicp0a8wurPZoWzK9Z8zjnwI8F1PvvnyWMD5r2wZ6LJQhiFN4pVC4zQvG/lb+7G
gPVSiSaUOgOTMqNZqgCj9uyhk20gdB9+tfn+R6yHo2EgIq2Z4Ppo6qkv2kBRS4FD
/AUaabt7Dt1Lc4HaQbZDSq9j5hK8OwBCEdZCR4Rv5Z+rAUr69jqQ3XYgwmPQakC/
fAnI/sLgmma11vnNKhAuSzXyoI0C0EebCUnl5extMaQqS4fXyyh3cK844XmiunR1
1G0Edm115GQOSOhAh8kF5J/1SYBN32cLpkMtBIISrcCrZx5Ryk5qVRePmw5g8Xbs
QWqbE0rSnSXP7x6bynbSYWUotl9y3HdmCDH689MJREmcBbP5qvR1q09sI8WO1XPb
LDlYcF7VWrxRLX5mr2Max8DZmarkwwGU8Aq3bnDrCHeonUy7rR0YRM5wlGKQQ25b
/ydczd+dBie34lo+Rri1b/Osdb1wPfAt8/HCVbK9GKsF7kHpzWzL5u8KHIOP0W7C
hZmnq3OPddohsHmxM0Fkl12+xZzyJkDoEhoE0JXti/h9b00+buG8gwE3sn5b89AA
+YCTpZ8eEWvVvzs64bL0V/1LsGzz9S+iWcK46kTyj3h8mxPQF8E=
=Rd0N
-----END PGP SIGNATURE-----

--=-D9i8SVO0+y+hI6fdaMxC--

