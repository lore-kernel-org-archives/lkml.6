Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA17CC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 01:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6223D20BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 01:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="VMIxyVj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6223D20BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390279AbeGLBoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 21:44:32 -0400
Received: from ozlabs.org ([203.11.71.1]:60923 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388351AbeGLBoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 21:44:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Qz846Jc1z9s19;
        Thu, 12 Jul 2018 11:37:24 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531359445;
        bh=CeyyKoOPdaJ6T5h6d/42Yz7mLSYkXbqlDFzz++A6mI8=;
        h=Date:From:To:Cc:Subject:From;
        b=VMIxyVj2ZPfr38294HbH+F1n9Cuf2EC3DrVgwO1qI4sGKO8T8hGWRN4q+qcREi8Kr
         qlFgmMTdN2vDHLxJxM40MkVLQAiXdFRXbgB/WrXzK7NO1Mupjtfznjm1n+GBj6xXz2
         VTxejNTJv7rJsITpIRBnh0sC6wKDypZjwOAE0tkrkjmDjhfiGTkve6xIe9x1JOaKs5
         OORD+KD0R8Q0nikZSXAoWKQW7q/1VhotcQKbSKSv8PJ73QB9jZl4Lluoqbxg0QjUcL
         J6aiOyajmzz7VnRCv5BFsYenncuobc7wOUSdU95aoG17wWn5RAWzKKtWpbH39U779P
         m4tqMt35H+gFA==
Date:   Thu, 12 Jul 2018 11:37:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        David Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: linux-next: duplicate patches in the gfs2 and xfs trees
Message-ID: <20180712113724.413e4a3f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/sdbwM7O_eY_PRfZf2lltwSo"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sdbwM7O_eY_PRfZf2lltwSo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

It looks like part of the xfs tree (the iomap-4.19-merge branch) that
was merge into the gfs2 tree has been rebased and the gfs2 tree has not
been updated to cope.  The rebase commits are exactly the same patches
(though I didn't check to see if any of the commit messages had changed).

--=20
Cheers,
Stephen Rothwell

--Sig_/sdbwM7O_eY_PRfZf2lltwSo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltGsNQACgkQAVBC80lX
0Gx08QgAozmrQsiGero9EERUw0sFmVKqE4e/0tRTd0eXS40a4fVE8SUedCtX2das
IGFgSDCM8IRPhu2SG7YtPdUkaiyGRfjfKHmdm+sHaTfmluqzoSFMEvdDtzP97Oje
AuXXLCNRTUPjfxvUxOhMNuYF/lFYJCbhEmsV9CppkJ7LHPCIrVHB6Vp26adlahFF
NPXUNCAfzWijePD//YoM5/ZOO8LVg2U+Q3zw7jqtI46Vg+h20qwXshP/kmufsby6
NRVC/bsBwk7cbbhtjGOYM0mejV7FLZrMv+xhRZhghK8J651v/Do/tgEdiRu6Ly+p
T55IHfu/E4nnfS6Tc/MMm1qfzbea7Q==
=OKPe
-----END PGP SIGNATURE-----

--Sig_/sdbwM7O_eY_PRfZf2lltwSo--
