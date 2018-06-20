Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD45C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 03:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1837820693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 03:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LtBl3J5g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1837820693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754381AbeFTDzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 23:55:09 -0400
Received: from ozlabs.org ([203.11.71.1]:60963 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754304AbeFTDzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 23:55:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 419WDz4L6lz9s2t;
        Wed, 20 Jun 2018 13:54:58 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529466902;
        bh=Xw727UV2rJpFfONrecTz5fxXHCNTThycVMJlKqCWPV0=;
        h=Date:From:To:Cc:Subject:From;
        b=LtBl3J5grh3k7asb8W6yC2dN+8FqQq4udw/QOTV6ImFKOP5PB9egixnDmNcYAEfQ8
         3qn3QQjBafzY5ePlrQNdx0/vraFVI3J/S+f30YHWC/RCX/v8yMaPp/gi5yBnhfEsIV
         GPgumoHA96bPaVsyIpKxMazQEDNla602WmVipzEvA70btbPjyDpR8KVYeUg65HUwZO
         rBd2MvrfKcEXm5agzhUEsCByN0dnFw+8efosEPBYGDWmr//ogAEl3S3JVT4Ui4B32F
         Rkg2Pa2yrxWt6/JiFVK5KJHeN7NwLkv+6x7D9KIq5W75v9Jtk7Bt+yIIf6oFqkxhma
         SHBoiV9Qyxm6Q==
Date:   Wed, 20 Jun 2018 13:54:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Matthew Wilcox <willy@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: linux-next: manual merge of the akpm-current tree with the scsi
 tree
Message-ID: <20180620135458.7cc22318@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/tZ_iyskd9HJPiUe8mw42WyT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tZ_iyskd9HJPiUe8mw42WyT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  lib/percpu_ida.c

between commit:

  acf3ff616ee2 ("scsi: Remove percpu_ida")

from the scsi tree and commit:

  0c4d6e08c775 ("lib/percpu_ida.c: don't do alloc from per-CPU list if ther=
e is none")

from the akpm-current tree.

I fixed it up (I just removed the file, but clearly the akpm-current
tree commit could be removed) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/tZ_iyskd9HJPiUe8mw42WyT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsp0BIACgkQAVBC80lX
0Gy8yQgAhEZt8CFANxAzBTjJQw8vBnrH6CdW3lwPUcy+F5Yzy0mBb+S8gEHtNBxN
sa03TslDp/9ewgxYlGAMGpZ5lHhkEil1O+7jWCX5pgW/K7XSAGfByIsXCR8P9xpi
tzkaMK1Fb1j1fBpqILCZN35GqMRz2KDWuE1/w6qtWdCxo8V9ReQ/bC29uuDUtRWN
BxqLt+Bt2Ec+NcGldnYOkKKVcSFKhn2RScc2B6NCkavJ6Dvqj7b56dycVllKsklp
C0RLvIPsLLgV94OtUyuAAdk3Z66pyTBSRPRZfsiRgi2hNtss3krrqLY6Gg5IvPug
p54N0y5oDsyr+4D+ebmHOds+yjDwZA==
=qfiD
-----END PGP SIGNATURE-----

--Sig_/tZ_iyskd9HJPiUe8mw42WyT--
