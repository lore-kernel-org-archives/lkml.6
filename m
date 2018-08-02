Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD14C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 02:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7119720894
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 02:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="o7D51I4p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7119720894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732212AbeHBDxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 23:53:51 -0400
Received: from ozlabs.org ([203.11.71.1]:38927 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730217AbeHBDxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 23:53:51 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41gtmJ35nsz9s3q;
        Thu,  2 Aug 2018 12:05:04 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533175504;
        bh=kIz9Dqw6Re7jPs5yMOLtIprOwp6nGCnMjZjwIEhGpNM=;
        h=Date:From:To:Cc:Subject:From;
        b=o7D51I4pGM5DaLRu/AOK65sP3b3Blku+zIfJli+jvuW3CDCp5RSoe1vQYYTqAc8B/
         6ID7lQ5/Bw4W3g0pu2tsTaqRi1Lha2Z2gPlNc3zqMPa9XnSVyoJugqx/PnQ0DTuo7M
         DEDQ0G8foUBHqtJ6VR2h5OzyogV4EFoqSHO4VGajGR1yPP7GXSAPVwxyBO1c46W0j0
         Hh4Wb0YHpBFhv0C6Gup5K07NrSetsDooKtz83VkwEoaHGUlhhypudSO31RCdgBfmER
         4ER8FzsWtXrNHP0OTRRfcCn40QBT4JbEgUqBsyr2aUF72WYvQaE7/UJmhdqfcKQxJn
         3qkfbcDYEK5DA==
Date:   Thu, 2 Aug 2018 12:05:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: linux-next: manual merge of the net-next tree with the rdma tree
Message-ID: <20180802120503.7b7e116f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/fsXgdrzl56NJq_q07LgxuFO"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fsXgdrzl56NJq_q07LgxuFO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/rds/ib_send.c

between commit:

  d34ac5cd3a73 ("RDMA, core and ULPs: Declare ib_post_send() and ib_post_re=
cv() arguments const")

from the rdma tree and commit:

  87f70132b08e ("rds: remove redundant variable 'rds_ibdev'")

from the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc net/rds/ib_send.c
index 8ac80c1b051e,c8dd3125d398..000000000000
--- a/net/rds/ib_send.c
+++ b/net/rds/ib_send.c
@@@ -758,8 -758,7 +758,7 @@@ int rds_ib_xmit_atomic(struct rds_conne
  {
  	struct rds_ib_connection *ic =3D conn->c_transport_data;
  	struct rds_ib_send_work *send =3D NULL;
 -	struct ib_send_wr *failed_wr;
 +	const struct ib_send_wr *failed_wr;
- 	struct rds_ib_device *rds_ibdev;
  	u32 pos;
  	u32 work_alloc;
  	int ret;

--Sig_/fsXgdrzl56NJq_q07LgxuFO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltiZs8ACgkQAVBC80lX
0GzfcggAl3p9lIPkl54CfgTX65bIKbypibZIn0hBprPcjZfcbuZhmCpFcXuL4ZC8
3m2N111XId66ttxwttmVdF2SEzhy0PfNiQsWMwa4rlS5nIlze0Sn00XQ9bD6A2xC
6RYSgRs8D7yKyiglaIr2OVZrc/LnaOT+Ft8VzDf7SfVpZX+OGm0Vpp5UQYbotbe+
uuiIN/mneecMulHfuC3p4MP8tsirQnWo3HhMeC2UGSPaosw3W8AZO4+AFmobfOyl
xB4hBwsbt/nl+bH7J98z3jpOVH1brhqpkY1plKV1AZ+yXyb7K3e1A0u4aRtbGspA
HFCChy+ry31mrjHiRV3IGMS4DgWbsQ==
=UJDA
-----END PGP SIGNATURE-----

--Sig_/fsXgdrzl56NJq_q07LgxuFO--
