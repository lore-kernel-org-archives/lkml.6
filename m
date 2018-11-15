Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC52AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 06:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06AFB2087E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 06:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kUcJX4Rl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06AFB2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbeKOQIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 11:08:45 -0500
Received: from ozlabs.org ([203.11.71.1]:44959 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbeKOQIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 11:08:44 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42wW3X1JL3z9s8F;
        Thu, 15 Nov 2018 17:02:15 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1542261736;
        bh=4ubP8d8j6TCAyoUDdx47JQ+5yZReigHrtWe4xxscjaI=;
        h=Date:From:To:Cc:Subject:From;
        b=kUcJX4RlyGt8eel8p8P3dHxjW44brax2TLV5SmC0/sSmmY2juKIfqharHT0vP9h4m
         UcM8Z4Cqw5Sn2lWmMf3Rm2BlUHVUsLZbTxLRItRa0+0CpT7dQDu81p0CivvGIno18Q
         JpuxhvH6dDC9nF4hPHJt0axSLPgluYGFxs9zIJT9vL36CkVJoMwdRvPdBKKGWZcLRG
         GxuChbTFiTbCcv9lOH210dlUM5AZPqghMdjV2l+GWjmI68urwg3lZmr2ul7J3OL3E3
         XpdMzbIyU54z/MKvGAdtThmvXg0KHvGbMUhgpgoowbGsxdYtmANfiPoNHJh4o15Y5U
         AVTX9QBbXzldg==
Date:   Thu, 15 Nov 2018 17:02:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Kalderon <michal.kalderon@cavium.com>
Subject: linux-next: build failure after merge of the net tree
Message-ID: <20181115170215.1eed765d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/th5Use4NHEf+iAk=LU7yZgX"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/th5Use4NHEf+iAk=LU7yZgX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net tree, today's linux-next build (arm allmodconfig
(from KernelCI)) failed like this:

drivers/net/ethernet/qlogic/qed/qed_rdma.h:186:79: error: expected ';' befo=
re '}' token

Caused by commit

  291d57f67d24 ("qed: Fix rdma_info structure allocation")

--=20
Cheers,
Stephen Rothwell

--Sig_/th5Use4NHEf+iAk=LU7yZgX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvtC+cACgkQAVBC80lX
0Gz20gf/R566cv4Iww/MAb/coem2Bty0D1r5/zDKbiN6/QOlT8AUzDlO39VOqNSR
f0PY7G7hVeK1KEV+mojlTU32llCUx9mD5N80qsFOtotphvcrdXanKozL/qmKpWWp
qyp7dyHqdY3Tv9PsEQwrOWLttEiNym9e5Kjlo7MMz9/hxaGOJyJUwdlJMqz8WKKI
gRUN8Uxgj/YgxC+fHT3zV0dNXQdgdtCmB8a5SsWA9JWFzTPfPEwUwLPnY1r3VPyA
4Rtb4hgVE+qdYbVzvf9QZBu4IG7cA48GDEhxJ+3odnQAU3aeoPeBJPAjK5i+ykq3
kf7FBzxrMPS6CbvricuCh+Z+3ofRpw==
=0PCd
-----END PGP SIGNATURE-----

--Sig_/th5Use4NHEf+iAk=LU7yZgX--
