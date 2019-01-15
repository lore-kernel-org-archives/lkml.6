Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07CBC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9181120657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pcrtRpJh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390047AbfAOUzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 15:55:44 -0500
Received: from ozlabs.org ([203.11.71.1]:45423 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730050AbfAOUzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 15:55:44 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43fN0G2j9Rz9s2P;
        Wed, 16 Jan 2019 07:55:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547585742;
        bh=bnqlXb8AkTNqS4P9hOt2TGs1V3pB3t37Na5reakmrZY=;
        h=Date:From:To:Cc:Subject:From;
        b=pcrtRpJhvepUOozhMbBtoCYrwYA66jU0PZYQZAmg3gHfHMSfuNGHbqoEClzFuqKP+
         QYaddF8ix+jPAvt2M0m7pzCelLxxM9XJOYyKovYX92RDy75ToBnCOPpRwdn8usfhiH
         G8u/dCD6qTys7XeIUXFgke7bBi4kXCs2bjv9XsdwV0nBMMJe5j8ojxNhUgV25P16X2
         myefWkPae/aB2MgRqWB3RV1pRlV/6gZjO7d3jwoRUfJxuJYFHLTlf6nVYEieDq8bu9
         EfUd6FbKLx2y2iRGbjtUqvH059+Wtdj++irjd0dgQieKoelLDc21wnIbW+1f7/sJwj
         gNEE0fGkgRN1Q==
Date:   Wed, 16 Jan 2019 07:55:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sinan Kaya <okaya@kernel.org>
Subject: linux-next: Fixes tags need some work in the pm tree
Message-ID: <20190116075540.78cff44e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ewciBN5rwJ4y3iGwf7XWmyg"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ewciBN5rwJ4y3iGwf7XWmyg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

[I am experimenting with checking the Fixes tags in commits in linux-next.
Please let me know if you think I am being too strict.]

Hi Rafael,

Commits

  62b33d57c534 ("drivers: thermal: int340x_thermal: Make PCI dependency exp=
licit")
  cd793ab22a93 ("x86/intel/lpss: Make PCI dependency explicit")
  42ac19e7b81e ("ACPI: EC: Look for ECDT EC after calling acpi_load_tables(=
)")
  6c29b81b5695 ("platform/x86: apple-gmux: Make PCI dependency explicit")
  34783dc0182a ("platform/x86: intel_pmc: Make PCI dependency explicit")
  704658d1d3ae ("platform/x86: intel_ips: make PCI dependency explicit")
  5df37f3a1aa9 ("vga-switcheroo: make PCI dependency explicit")
  da1df6ee4296 ("ata: pata_acpi: Make PCI dependency explicit")
  ce97a22a596b ("ACPI / LPSS: Make PCI dependency explicit")

Have malformed Fixes tags:

There should be double quotes around the commit subject.

--=20
Cheers,
Stephen Rothwell

--Sig_/ewciBN5rwJ4y3iGwf7XWmyg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw+SMwACgkQAVBC80lX
0GxIpAf/bcC3N9uGGIXP1nw6Of8LKN18uMRPIERRNs/1xJtbMzsJf4jzT7vFITlm
VCbNgu1nI3yckOxz7g2Bt3k2/3DR+K21ck5pRGRBk9I8vfVp1/hM5f4k/NOreqAO
gWXhCMOjtsy/sm9BzRJfT3k0NPBpXUZ6WE25MTlpCjIQwV9vhyV0f5pXnrS082Qw
QSQem6GzhIyDJLkrz1JZWmh/mq83+oRJOIu7iO9YPRzGSRiq57jHFHeNWbAEJLqD
WwePv8qal6zdp0wHRKAec+YLdo0PaBG2taPXSqlha3jL4vtSCKpT+2Gevy2Kc0pm
gdZNSNRXa8LzuFKDA2PhovQkqueYMw==
=4Ona
-----END PGP SIGNATURE-----

--Sig_/ewciBN5rwJ4y3iGwf7XWmyg--
