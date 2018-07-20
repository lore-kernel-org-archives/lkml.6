Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664A9ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 01:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174312084C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 01:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="A1+fhfNL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174312084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731554AbeGTCfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 22:35:21 -0400
Received: from ozlabs.org ([203.11.71.1]:53523 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730514AbeGTCfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 22:35:20 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Wv2G50nYz9s3Z;
        Fri, 20 Jul 2018 11:49:26 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532051368;
        bh=e7YcXkWikWPPRYlnoFurrp84hZXue9eWaRER0NVMPUw=;
        h=Date:From:To:Cc:Subject:From;
        b=A1+fhfNLGqy4z5sUHJlp4xR6grjczEQtEQO2skRRrJKXCvJvP0IG+Y/hGga01Z4Lq
         lMHFu9JAnYAC19v8Q0Kdvd+UaoFzz4Wx5WUvmQDfNbJuhuCuTzLwYrPlnOf7FaNtqo
         7Y0v77YftMsCWKg9YKYj0/Houh7+Qn40Y++6tT7cOzHOIBTwWmSCo2PX1cxZMJEzto
         WzlYpcUfHDGZkxCxiWn6DKqwYhMmo3R9L0IbSRxA9LEG03C1roKhzliOByRNbpHbng
         XecN/WwE8oku3FWGSQoydD/UaP6ppM9nqnOoGc4ILzsfSD9wftqYiGCHPWSm2vrnMC
         fxNiUlbcclICA==
Date:   Fri, 20 Jul 2018 11:49:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: linux-next: manual merge of the net-next tree with Linus' tree
Message-ID: <20180720114925.3ae30654@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//79q4MkxEoDJ1QAHe4ctpbp"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//79q4MkxEoDJ1QAHe4ctpbp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/ethernet/cavium/Kconfig

between commit:

  e40562abdf81 ("net: cavium: Add fine-granular dependencies on PCI")

from Linus' tree and commit:

  74525cc5f5f7 ("net: cavium: add missing PCI dependencies")

from the net-next tree.

I fixed it up (I used the latter version, but they were logically
identical) and can carry the fix as necessary. This is now fixed as far as
linux-next is concerned, but any non trivial conflicts should be mentioned
to your upstream maintainer when your tree is submitted for merging.
You may also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_//79q4MkxEoDJ1QAHe4ctpbp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltRP6UACgkQAVBC80lX
0GyMTgf/YV1hxo0WBuRGtOO3nrP2m7x7c6yh/jonTBIrX+aviHTxw1wwv6KL0QYG
NgoH1sdwcntHqVDUM8gOFyJKbbdUD5CSLZvHJOnEs+ufyRRmcFE4etBj8WjhmzQo
2XnnTD86xGywgK4eRrxqaMgGcJ9+n+OI9kCjW/m+KuF6DCrn38X7WBChBh621KU8
hpAulMSXb7Ft4pDwMNnrgvTHQhbNKhUFWgfBblvDe75b7djjEwRsEun171r3NaH7
bYEtMNT/+TgsM14yHUwuDaJpYHKeM/o5tEl31pt3c6QvTC3mqdlEDIfPcL0l10Yi
tbIdYXFBaUFy6QUVkWqhHUCxjPOfOg==
=roZu
-----END PGP SIGNATURE-----

--Sig_//79q4MkxEoDJ1QAHe4ctpbp--
