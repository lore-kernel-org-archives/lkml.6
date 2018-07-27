Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24606C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 02:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D98120891
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 02:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pNqeeWvB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D98120891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732173AbeG0Dwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 23:52:42 -0400
Received: from ozlabs.org ([203.11.71.1]:60967 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731587AbeG0Dwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 23:52:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41cCgM2kZlz9ryl;
        Fri, 27 Jul 2018 12:33:01 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532658784;
        bh=uzPz66I+TyXMpAglaRKSl2sRKVfVwL7nq3epTyAefmE=;
        h=Date:From:To:Cc:Subject:From;
        b=pNqeeWvBhSIVERNF/pCj/sseTctSvlC3SvSV2RjxqlJyss6L/1G+cTkixu7CUx9RE
         oiE7h+FjB4LQYc4AgB7Zu+CwL/puXFe240TytCSJYCghFFMAZE97PiCMX4K5NJtqHA
         Z63lCvdMwjVAiX9LXwHGPilEKLwQ4LEoyCupGZ0DffsK61k8/LAYV6ClaTCnvO+wIa
         bjL+Ys99XhzEaxUbvujQxVpl3OaZID7W9UETnjPzRLkbJvLXbTxh+isHeGxRAoSlKJ
         uuIN0Q2dv3VuGxfxl7OBSg8vfff8tjbMCiXh9OhN4lFJxNOcjBpYB7m+3OSsRBIESy
         Xw7ZePFqX+rHA==
Date:   Fri, 27 Jul 2018 12:33:01 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: linux-next: manual merge of the net-next tree with the rdma tree
Message-ID: <20180727123301.3ac97ddc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/obtSygckK1wuZX/oWMFIP+z"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/obtSygckK1wuZX/oWMFIP+z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got conflicts in:

  net/smc/smc_core.c
  net/smc/smc_ib.c

between commit:

  ddb457c6993b ("net/smc: Replace ib_query_gid with rdma_get_gid_attr")

from the rdma tree and commit:

  7005ada68d17 ("net/smc: use correct vlan gid of RoCE device")
(and maybe others)

from the net-next tree.

I fixed it up (I wasn't sure how to fix this up as so much has changed
in the net-next tree and both modified functions had been (re)moved,
so I effectively reverted the rdma tree commit) and can carry the fix
as necessary.  Please come to some arrangement about this.

--=20
Cheers,
Stephen Rothwell

--Sig_/obtSygckK1wuZX/oWMFIP+z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltahF0ACgkQAVBC80lX
0GwnXQf/Y+fXHWI6aGm6LUXQeoHVB++6qxfQuMtudcwQdCr6FSm7nFWpXsS31G3/
ONe5F4QH0aFtFfrsV9iuxhmT0h4yAe7PN4uR64Kr2+wmffcPuMPgOQiJX1IfFsOo
hIHwatLR6HyFS0SLMnpEWD0MpUcU8pf+t/LPE7kbnXyNlbmKswIBz7qWGDA0ucau
ogafC8tOc+Zu4XKy1Y0azDjBPSqhSAk/qZ8mAjJv+EaCFUxfQ0ri0OuVo6vJ/YX4
/vXwYAxAKMkQH4l1+xHZ67WRb+oh0kJzGfPhXynvANAn4EeiCNjMWIcZnl5hHhe5
iaY3HPgtXrp3CxpRjmWKCj4R6joR7g==
=WdDR
-----END PGP SIGNATURE-----

--Sig_/obtSygckK1wuZX/oWMFIP+z--
