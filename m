Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6220C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 04:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1D22146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 04:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PAsyYYkA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1D22146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbeLDEfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 23:35:17 -0500
Received: from ozlabs.org ([203.11.71.1]:51365 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbeLDEfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 23:35:17 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4388DL0wQwz9s6w;
        Tue,  4 Dec 2018 15:35:13 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543898114;
        bh=+xIeqUIOrAz2nzFT2hKzgFtOg7FqMR4l8AQ+SrGnCmk=;
        h=Date:From:To:Cc:Subject:From;
        b=PAsyYYkAHaplLWGiKn+PG5yEe5b2IFSygvvRjSrUBqkjMKi20Z8rMTJT1LUCyrB8a
         MOtyf+gSFeIeFPOGYS0/utv3Zkb9+dIOKQOvPXF+YcX8AtB1IAm8bog6/dXtHxnPjg
         nigwxE7kb6biBU5mvHfH6fGOPchcw/KEkEApZ6bBhWQJ8bILpbs2X/gw5Nf7EI1Vqh
         u9kqcA+GZCku/n+Nav6DZwqreaQkjRE2u9HxmjwKw8GDe80C+5HJlz635AwyfrOMsZ
         UaejXYBdtnGHnkqCOgo6BYTgwxXuQDR8QYT/MVNQG1jYvxlmTuERbFUh0RLBZvTiWH
         CD2NDo43CkyaQ==
Date:   Tue, 4 Dec 2018 15:35:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>
Subject: linux-next: manual merge of the char-misc tree with the
 char-misc.current tree
Message-ID: <20181204153513.1e799336@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/F2a2ZLdv1BQwUDiogvsvK2o"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/F2a2ZLdv1BQwUDiogvsvK2o
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the char-misc tree got a conflict in:

  drivers/hv/channel_mgmt.c

between commit:

  37c2578c0c40 ("Drivers: hv: vmbus: Offload the handling of channels to tw=
o workqueues")

from the char-misc.current tree and commit:

  4d3c5c69191f ("Drivers: hv: vmbus: Remove the useless API vmbus_get_outgo=
ing_channel()")

from the char-misc tree.

I fixed it up (I used the former version where they conflicted) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/F2a2ZLdv1BQwUDiogvsvK2o
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwGBAEACgkQAVBC80lX
0GyNTwf+Lms5sKywsYFNlg0hXRdSPdBjsz4pfJzqbzjUdzg2DpqkwurYBKTgfYvb
LmRTBu3Oeb6dL8K3kuM+wGPvbakkug2JFhE0vf3e7uMlPqTEdPBIZ/+37n9A0ikk
P8L9sgneUo05K0VWq+/Xd22AnP0Nk+Ly6m5vZFnmlS3hpurJ+gnw+9LulGNRtM2C
kg4ItWUw1dcPt4MFJwrD1fufIZ+aQ/5blDq+nruiChzFLwy6mhUBH8aeZYV/NdGf
0Cf19ddVX64gwkVb3bv4XtpT1jCf8c1oJ92U2BWPKeHM8k1OIgEfbiXcpe2eBGDp
aJjd7Iqr9OM6hJD+p+ht/eVgMswp+w==
=KXbh
-----END PGP SIGNATURE-----

--Sig_/F2a2ZLdv1BQwUDiogvsvK2o--
