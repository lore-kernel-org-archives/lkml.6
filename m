Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841E1ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22BA420779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="T25T3FOo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22BA420779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387936AbeGWIRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 04:17:05 -0400
Received: from ozlabs.org ([203.11.71.1]:40983 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387872AbeGWIRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 04:17:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Yt975RkPz9s3Z;
        Mon, 23 Jul 2018 17:17:15 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532330235;
        bh=uidyT3nDjeqq1C9IxOYSECcLJzNS2bdw/9Qann/XI7s=;
        h=Date:From:To:Cc:Subject:From;
        b=T25T3FOoGzt+WKYWuEcYK67A0Gq+yCTrPeGKcgaX6CZN+f6KJPbLAFQVxXYJQ5FcJ
         MFl/pgUqics4K5wfXY9DYCLvtm1CmLLZruP3SfGyTZxmifSVaZbIaisjrgStpL3TgG
         UBDnKP/xXp80QLm2LI64DvdHyvY0exkpE+Z2wRPoy5uu29LkLf4xyTWqXAvWo3ZOBd
         vgREeO30QR7WYNGz/RBVDUWsC3MD43/nAFltvN5nrBS10CXkXZLy9mz/KWO0Q6RUg2
         cs48qxwk2psvobNxAutKZLLaYKj/Mz3SbXwEVdrAvjxj3f1x16+63qou3ijYhr+dNZ
         JKKcKf/5k7WPg==
Date:   Mon, 23 Jul 2018 17:17:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Subject: linux-next: manual merge of the xarray tree with the nvdimm tree
Message-ID: <20180723171715.23328c84@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/JpRRr9Nbzc+rmYndEKCelr6"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JpRRr9Nbzc+rmYndEKCelr6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the xarray tree got a conflict in:

  fs/dax.c

between commit:

  55f25ced654c ("filesystem-dax: Introduce dax_lock_mapping_entry()")

from the nvdimm tree and several commits from the xarray tree.

I have no idea how to fix this up, please discuss it and give me a
resolution (or better yet, create a command branch that both trees can
merge so that the conflicts do not exist any more).

I have temporarily dropped the xarray and ida trees for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/JpRRr9Nbzc+rmYndEKCelr6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltVgPsACgkQAVBC80lX
0GyyUQf/X4AMiibk7ze8FxWUQ7dNo/m8/IAPR/O1jE3lY61egKC2bxUYAU4+rHzu
gPw5Rd2PmCs/yjGqMjcr6uYy+nVmp+sqNzgn2oMOnpVGa3QLVJA387yHFp1sZiw+
WSqurdDPcCA7RwZMRyxYqUtSDIae/DYb7/OIhfa9V0OVE6g0UJfvhVbwI353Mt9W
iM19Ob9RF9NqZhdIWpSGjwtR2T0UQljVQxQWR6sj8dMj4LwAhWjhagmiJ0foezSw
MvJXxZKDNvJhniQUHRuGB2BIFJDhWRt9kl1enkx7IVHEq9dRheB69EfMHXWKxvqO
16UH3VC6xfnOKgw8d2xdMsyKmsKK2w==
=u46T
-----END PGP SIGNATURE-----

--Sig_/JpRRr9Nbzc+rmYndEKCelr6--
