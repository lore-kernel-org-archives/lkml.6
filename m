Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40353C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F322064E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="UE2B6mFQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04F322064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeJBPOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:14:03 -0400
Received: from ozlabs.org ([203.11.71.1]:49241 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727315AbeJBPOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:14:03 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42PXSW53MZz9sj6;
        Tue,  2 Oct 2018 18:31:55 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538469115;
        bh=aGg4GPFd0Fz4fKBvHNFeqIL2eDv30ygTS9v5j45kqfU=;
        h=Date:From:To:Cc:Subject:From;
        b=UE2B6mFQ1Ngp/CDweRNUSMVZN8wIa2udZkMpQ/QCxrYy/ZMQOgQHqNaNqj3ATgpV9
         8A4rbfctpyIInhbuLROJtv5jEbwAxQlrmNJsQSuIBM3Z7GKz/PAd1CWx/ebuB90Lqw
         ecQ5gKMZTqY7f0xYwc7BvooBFwaXQlviEwVnJcF0BFcuON9D9cWMIyXSDK8OZDRV4x
         S7sv4nZqmOl0ghXcX5v9oAPpxSIh5wg8OL9ugmGhZDXYdSk6dDc7pT/Z0Ko7p+OLvV
         DyGOUSs4dDFbhq+4QdsXwsFerammeGzEcNk/Vb9pBzYn1GAujWDyqBW9E+4y8d1A7+
         A4Te3ZS96lMbA==
Date:   Tue, 2 Oct 2018 18:31:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: linux-next: manual merge of the akpm tree with the dma-mapping tree
Message-ID: <20181002183139.64a85845@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/68h347dOdn6RQ5pEgHEID3R"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/68h347dOdn6RQ5pEgHEID3R
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm tree got a conflict in:

  arch/unicore32/Kconfig

between commit:

  b733116feab5 ("unicore32: remove swiotlb support")

from the dma-mapping tree and patch:

  "mm: remove CONFIG_HAVE_MEMBLOCK"

from the akpm tree.

I fixed it up (I forgot to generate the patch, sorry) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/68h347dOdn6RQ5pEgHEID3R
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluzLOsACgkQAVBC80lX
0GwzvQf/bzykubWZHEGoY2ho8RPwnlb/pWY4iM4niVbRlfvcQTRvSx7yPs/aCvOR
BC8835RkHkeA4ddnGM3hUaf24I4QZltSkJX+1S1VKByPKjEzXAL2DxnxEBSUVBzh
+54G6UbzDl7YhgemiTdSCtmToVuMUr4dg5+ypmnuxEgAZmvSpi3Tf7Bkfejl+au9
5S89h/ejbbORXCEXhphA2uDZRFZirYkGuC2P5Ia7B75JdCR5Ipy2wzo9MjCJbOrq
3/TYzQuZRC2wuN3/lKMp0a7LuYqwbR7gP4ny1HukndCuY4cfA8q+UmmuKnji9LrV
t0chM6WgkuF7qT6E/mxxOybbRLL6AA==
=c1ND
-----END PGP SIGNATURE-----

--Sig_/68h347dOdn6RQ5pEgHEID3R--
