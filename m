Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6ED49C004E4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA1D208AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pvVgSCeH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA1D208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934850AbeFLAqM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 20:46:12 -0400
Received: from ozlabs.org ([203.11.71.1]:43535 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934772AbeFLAqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 20:46:11 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 414WQn2N66z9rxs;
        Tue, 12 Jun 2018 10:46:09 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1528764369;
        bh=cXLwWvIhC45BO5k5Z6vKm8cxiddwLXhDiI8HOq9pkHk=;
        h=Date:From:To:Cc:Subject:From;
        b=pvVgSCeH89DL5M3B3WD4SmuTBd+JKrCJGo3QAwsWeXv+MP3FVb51KcxagHfYFXw3o
         Ni7bA8zB0eAsJhxukWizwGQTmJ8Ns/guV6G8kLdiZ0rY7/c75/KFPSglAtzJCoIGKs
         jZMWU+xQKpHZJCAbWQO45F3wBD2JUt1qCAoFcRlTcE9+Bh229csP8FvILkC/Y1q7+y
         xAGSIGZ4nDx/j0Pvfa0Zf/6qnBFjBKReAc4cccHZNu7ByJrovlOXjU9Vfczvy2Dw4x
         qhLCnwQJv4oig8cfIQlniFlQPnhQsYn6I+t/ISPSlh8+KZsOPeNnlCfloTUn8Zs24w
         DlckKBuP0p4ow==
Date:   Tue, 12 Jun 2018 10:46:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <jroedel@suse.de>
Subject: linux-next: manual merge of the rcu tree with Linus' tree
Message-ID: <20180612104607.69f6f15b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Xe_ZIm0.oPtMX4pwaSiGPFi"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Xe_ZIm0.oPtMX4pwaSiGPFi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paul,

Today's linux-next merge of the rcu tree got a conflict in:

  drivers/iommu/amd_iommu.c

between commit:

  94c793accacd ("iommu/amd: Hide unused iommu_table_lock")

from Linus' tree and commit:

  1df9bb146146 ("EXP iommu: Placeholder for fix in mainline")

from the rcu tree.

I fixed it up (they share some code change) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/Xe_ZIm0.oPtMX4pwaSiGPFi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsfF88ACgkQAVBC80lX
0GyiGAf+Mac6oviilt+vgKrO4FeFtt3BiSCmcIZdK99igAz+xN2+4XCRRmTO+CGE
SazbMWIF8K2OojMX8azPN0IOJ0blCGZKRWhem8cMflfglDPb0LEwX4HfrpKB9vtS
vEZul54gpBnPvTguvkLoo15z8VWvMX2xfMOTl5XTgfVu+gT6u4MIYiUv2ADZfqNM
U/WD25J8yc2q79Javr1R0yDL2ulXX826C1vVBLNFTeh5S8JvdmboXLsw/5RRsD6w
4wP1WTNF0soTYsQh0av8OJ8d8oV38qJ9hliUedWF29sd7yJGBCMEZSDG1HiDKW+C
xEi4cDS6GBTn93m8QnpioLqpLiZbSQ==
=LL9W
-----END PGP SIGNATURE-----

--Sig_/Xe_ZIm0.oPtMX4pwaSiGPFi--
