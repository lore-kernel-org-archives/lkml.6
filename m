Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D40C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 04:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7781620672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 04:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mIQ1alvE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7781620672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbeLJErr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 23:47:47 -0500
Received: from ozlabs.org ([203.11.71.1]:52617 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbeLJErr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 23:47:47 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43CrD04gNGz9s47;
        Mon, 10 Dec 2018 15:47:44 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544417264;
        bh=BMIpQttFdmxNQHx7fbOHjbYu2F+9REtWIYGnS7/1LH0=;
        h=Date:From:To:Cc:Subject:From;
        b=mIQ1alvEl5lIunxpsm9F+CUUvSxzqOtbt6qCZPdacYm62iTaiYjt/CfXB4bWJQuTn
         tFN7mSmiVt02HkYKknMs7aIlBUqicemzbhc2EU60J59AZwg+IoTXJUQ6HfFIpbJXgs
         x7bLCFaDK5KPxHpLYzBar5h1Fx+dOMHzyQHPwDf2Q6vC3yWU1BewIFtJADIab46jT0
         +qBCFc6ETEUJNS2Y0IEIu+SufKlCZAi63MNusZEazGTQSsxciFCpKpKYW8SMcEh9f1
         LukRcO4obW3u+2wz61ZMgf15EQFmLD02flu8Dzbfp2xAEyi9//geyu0Br6Fk/GAm51
         KqotjC0//LI5Q==
Date:   Mon, 10 Dec 2018 15:47:44 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>
Subject: linux-next: manual merge of the rcu tree with the crypto tree
Message-ID: <20181210154744.3b35b1c7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Sp=m+yLKQPSA2bvAXElh/JG"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Sp=m+yLKQPSA2bvAXElh/JG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rcu tree got a conflict in:

  MAINTAINERS

between commit:

  c97e4df573f2 ("MAINTAINERS: change NX/VMX maintainers")

from the crypto tree and commit:

  1dfddcdb95c4 ("MAINTAINERS: Update from @linux.vnet.ibm.com to @linux.ibm=
.com")

from the rcu tree.

I fixed it up (I used the crypto tree version of teh changes) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/Sp=m+yLKQPSA2bvAXElh/JG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwN7/AACgkQAVBC80lX
0Gz51AgAoaYhnPYoNsLPgwkdHBZERlcgjqF2QIkgo9VQxnU3ac9nw3MWnR1TQTAh
foU9VWFyqnpcsUb/AKp7rKYV8ldQ5L9Zp/VrZ/lcocSO5/k0fvjp2Pf/HyKtqqfi
PTBqBN95vmH3R2o9vf2k3LfigAN9Ty1QpNdWLnKbiJRHuoMFrMD3vEUfyNkbHgTH
Oek65avHoVtn2wKpmy+MnmG4G7wLRbcJZ+SA/VdyGFW3NyKzFDW+E9+PhMWY3gh4
fHceBt0nmSfXwaTHb+mDNp/PrHyIsVD9cD/YyNSBfrRRt49HzOHBpALDXh2tMBCU
PZvzTOqzrsezk3XfwwxpNuLCj+zOXg==
=zZNT
-----END PGP SIGNATURE-----

--Sig_/Sp=m+yLKQPSA2bvAXElh/JG--
