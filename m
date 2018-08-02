Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5938C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 23:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5099E215E5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 23:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JG1ib+ua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5099E215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbeHCBOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 21:14:31 -0400
Received: from ozlabs.org ([203.11.71.1]:49703 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726949AbeHCBOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 21:14:31 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41hR4f678wz9ryn;
        Fri,  3 Aug 2018 09:21:06 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533252067;
        bh=pLpBH9ULz0g9CL5ewps1Zl6lEp64Df0JT6PyA/26x5Q=;
        h=Date:From:To:Cc:Subject:From;
        b=JG1ib+ua++PtoYF8sjL6nFCxDZJ2JPPKe4V1tKW+64D+sjn1z7JE95MWBdkOjcKQT
         B6G6x7wdJTBdoUaZf9s8k4RxsH9gGgqpmytyEGZ/EWYQM7oqkqEmEOt0MVH5w3KTGI
         TnfYdqRWc6EFQhsTAjGLTOfudj0I+zJlEF2OpN7bURS1+uBFF5wh06AZs7prvZgRQ7
         WmDbsWAO3FY4OFKzzJ+Sn5EqIIZSRd+jiJhwYYUj4KQZWl0a3qBMU3XlC1e82kZw5P
         6bU64TkkjZXF8Rxq6/FsQQU5h0b4jM08mj8dmI7oYNPoH8eCr+cm8dF+JxfIrt+T44
         4wY1yXHhEjafQ==
Date:   Fri, 3 Aug 2018 09:21:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Christoph Hellwig <hch@lst.de>
Subject: linux-next: manual merge of the mips tree with the kbuild tree
Message-ID: <20180803092100.7d0fda13@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/PmmDsB5b_QxAFqt+v6nQgWg"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PmmDsB5b_QxAFqt+v6nQgWg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mips tree got a conflict in:

  arch/mips/Kconfig

between commit:

  1572497cb0e6 ("kconfig: include common Kconfig files from top-level Kconf=
ig")

from the kbuild tree and commit:

  6c359eb1dcdb ("MIPS: Allow auto-dection of ARCH_PFN_OFFSET & PHYS_OFFSET")

from the mips tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/PmmDsB5b_QxAFqt+v6nQgWg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltjkdwACgkQAVBC80lX
0Gw7mAf/bEpGIEqvEnMW6HacXt7rRsGKW3cvnV/Q9WlG4iHRx9rsWVpNzpO8DVMj
hPXzuolrjYi22F+xBO8qgydJIln5kRSVGEWYfcxrBBLqIB8h0F6Le02Rqkezeme+
V1ilhtLnrO2SH6le+4Hp6a617KTk6yFmqtW1TqCEI5A9MgiQBukht++01JU9Uj13
c7oFJhmT2QxZfkqA5JRu+pPvNQan4Lh4n94ePJOy25kL/cjBwO+kApOtR4X1Y/eF
sczQZyintbe9JxwXX6huwmiH9uBhowKdei+AiDWhKWYHXxuLMGbvGmhxYhyIU0uy
g1sS2BCSsEDUOLZZISEhcFhRTaeTfA==
=FGRC
-----END PGP SIGNATURE-----

--Sig_/PmmDsB5b_QxAFqt+v6nQgWg--
