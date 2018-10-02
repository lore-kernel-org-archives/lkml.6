Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DBFC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93582089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MTKOOTM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D93582089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbeJBNVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 09:21:17 -0400
Received: from ozlabs.org ([203.11.71.1]:52273 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbeJBNVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 09:21:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42PTyv26PTz9sj0;
        Tue,  2 Oct 2018 16:39:35 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538462375;
        bh=bOrze7tzFddrQuz0m9F63XsgGNWR8yJ5kk3Qco+HGCQ=;
        h=Date:From:To:Cc:Subject:From;
        b=MTKOOTM+b6knit336bzhsz6MYCEFWibeK/LF2Pw8YVoycuJCg0rWx/OIu5pcV9mhP
         4ew+5Oa3L9LBY+W2lAc3eBIrcCIhtelpUyF7uuTiyRH7APOmynaLAkLKGNhhroVgR3
         vJwCsCkBxZeoexIkNIzkvmsm7ElpsStLokLVoHheAARMpxkP8rKcuhd1kjLnE6HIp4
         iv5QNtBd1VE4kZQILjl+g3HMUvtd0PqKU19v7/13j39oinhdNIiRgV/B6PmcHsZVS7
         PCWU5VtiBkjKrjFrRonXuNkGfuFdMUNrctGVQJyE/LkYC10JXt92Y8iDEgxDfVbqMB
         FwbxW57aIvyrA==
Date:   Tue, 2 Oct 2018 16:39:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>
Subject: linux-next: manual merge of the xarray tree with Linus' tree
Message-ID: <20181002163934.32aeee62@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/vw9bzuR363NXV3RCgNa3_ua"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vw9bzuR363NXV3RCgNa3_ua
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Matthew,

Today's linux-next merge of the xarray tree got a conflict in:

  fs/dax.c

between commit:

  f52afc93cd01 ("dax: Fix deadlock in dax_lock_mapping_entry()")

from Linus' tree and commit:

  a31521132da6 ("dax: Convert dax_lock_mapping_entry to XArray")

from the xarray tree.

I fixed it up (I just used the latter version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/vw9bzuR363NXV3RCgNa3_ua
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluzEqYACgkQAVBC80lX
0Gy1owf7BJ3gob7WbtYou4hmlpB0yfKArPQ1QJonX0fV4550sz59XJ209qpSodo+
++DdNXeUjFsrgPdkHjDKCdOw3GP78UVCbXXPrueHWe8VmrfQuo+UMLHEPnXwFLQL
fnDCNLQUhRweh037pXLIihU8xAmVxiyyaBys48EV04/CnWMqCafzP4hTeMurKUvT
HyxWDjEy82jfuSfYkluFJkwzyqPFnB97GPXCUnFqIy5TUkn+VwuPwTH85PhVVJmU
cYuRKWdTzDUC2exQjqte2EHmgTMDRN8EzgTmv/n7nO0ycnI1sXeT/4YhIC+kVERr
xlSPo9Ce6QELPP8O1Rz+3cKw3uyFNg==
=ReJk
-----END PGP SIGNATURE-----

--Sig_/vw9bzuR363NXV3RCgNa3_ua--
