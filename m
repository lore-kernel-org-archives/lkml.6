Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73DFC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46FD6208AC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="oB9YiDed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46FD6208AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733112AbeHAHRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 03:17:36 -0400
Received: from ozlabs.org ([203.11.71.1]:44065 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731897AbeHAHRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 03:17:35 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41gMRY3sfNz9s0R;
        Wed,  1 Aug 2018 15:33:45 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533101625;
        bh=WRugDvmS1IF/oxyUoNxUffJezI3mwiAHJGjS2wd+dRc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oB9YiDedWL6wx4euokMnDytvfqNvza+P41jV3RRdr4YE09ulsALJjsEd3MoIGb9bE
         VQ1DW8imU4s72YRAOGbO5MsZXFTdpm40mf6Ee0vaenH2hvKg+hzLtJBkqBcsFhqpgj
         91q3RYQ5VJuujIrmbOb3vozOSlVwgUVR+qUWEECptJkNjjC/gps5gF6A4C1zRTFnlx
         DVwGn82+V1/bC681iMCr4g6xbv4Ru05KCc9jZweecNG//HJw0XS2VETR4u4Addxk3h
         +o101PBffUquhgn96qd87j2H+OBdiv9tFIFp83uBS4QRL3DhS85hdiTRbOMZ8NTtmp
         45lzN7kWFF+MQ==
Date:   Wed, 1 Aug 2018 15:33:45 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Parav Pandit <parav@mellanox.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: linux-next: manual merge of the net-next tree with the rdma
 tree
Message-ID: <20180801153345.22692adb@canb.auug.org.au>
In-Reply-To: <VI1PR0502MB3008076016496152D4898D8ED12E0@VI1PR0502MB3008.eurprd05.prod.outlook.com>
References: <20180727123301.3ac97ddc@canb.auug.org.au>
        <20180727024832.GA30023@mellanox.com>
        <20180727132847.2be8563b@canb.auug.org.au>
        <VI1PR0502MB3008702AFA64F44DE57DC9F5D12A0@VI1PR0502MB3008.eurprd05.prod.outlook.com>
        <20180727150903.0f2816ba@canb.auug.org.au>
        <VI1PR0502MB3008076016496152D4898D8ED12E0@VI1PR0502MB3008.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/dDQdiXnugJklB1/GrWVKH5K"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/dDQdiXnugJklB1/GrWVKH5K
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Parav,

On Tue, 31 Jul 2018 21:12:00 +0000 Parav Pandit <parav@mellanox.com> wrote:
>
> You might want to consider this compatibility patch in Linux-rdma
> tree to avoid a merge conflict of smc.
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=
=3Dfor-next&id=3D7aaa1807e698f73094b78f0ef25b1a37a4409a55

Ok, since commit that is now in the rdma tree, my resolution of the
original conflicts comes down to dropping all the changes to
net/smc/smc_core.c net/smc/smc_ib.c that come from the rdma tree and
adding

#include <rdma/ib_cache.h>

to net/smc/smc_ib.c.

--=20
Cheers,
Stephen Rothwell

--Sig_/dDQdiXnugJklB1/GrWVKH5K
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlthRjkACgkQAVBC80lX
0GyjwggAk3Mmdj+p/qwxlJS9NnJ8IwCPYvSGfbGVRKNun/AwSGSJO60X57M8Ne00
KN+8uJrqwwtxSfrfdPlVeTZhODK55vePIIaUbmAxUvcKvOQvNGSwPajCFXzXA1IC
mJUAV5w2vq5RReJWfKX0dusZZJKf2VvGzDxbu9JEeE05hMNy94A8r4lRJX7zN8cQ
QPvS22C42D02UbnhjTeBDkQstbZdHvbu4NMkckdajU1p9eXIL73zQVCWtfBPe5op
zNmHq0jPu9R5GyysqU+By88pbtPqJRnfoA8LriKuEk64Hznc3t82V7Ygbg3VlCRL
YRysMdLWiLTfc2rXqeCyCGd75Iq0yg==
=dBjF
-----END PGP SIGNATURE-----

--Sig_/dDQdiXnugJklB1/GrWVKH5K--
