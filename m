Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2AEC282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 02:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937B5218A1
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 02:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lY1DM9np"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfAXC2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 21:28:05 -0500
Received: from ozlabs.org ([203.11.71.1]:43017 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbfAXC2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 21:28:04 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43lR005X45z9s7h;
        Thu, 24 Jan 2019 13:28:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548296881;
        bh=un2TaHg+h+YLbd3ugAxMgNj9vMNeAdTwFPET3UIi9UE=;
        h=Date:From:To:Cc:Subject:From;
        b=lY1DM9nphPpUgpESpHRAcnYI2GRIJ4s+L9OPvlElChFnWwKHcVZ6Hjm2H0HrgVz7g
         bA5EfFal4ifPky/8PdndzVrt4KnWGGTwvmXmzCIPPo/FYJnQ5SfZwUMkEla70615Vu
         /i3dXpD3XQyHQEkykZaWvempthmXL9osPy7yt3vvV1RwsHz+NxJ1r/OkxJ5Gyw3ryd
         C3Za9VpM0wtoN2JF8hg+/oztT1TowRonMq63UpSrrtQ2jQmcNIxUw+A2wNv0ct88wk
         bk6pD/Ck+0PDfSUvDKyXvCAkGXAphjpoBC8Cgy2WwujN8+cVWxHP4QqcjGo59tlYCH
         7Y6qNjwrkeS6Q==
Date:   Thu, 24 Jan 2019 13:27:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Crispin <john@phrozen.org>,
        Paul Burton <paul.burton@mips.com>, Alban Bedel <albeu@free.fr>
Subject: linux-next: manual merge of the spi tree with the mips tree
Message-ID: <20190124132759.1416fec0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/yeSH+FhAFozHcaFoh=H1CTs"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yeSH+FhAFozHcaFoh=H1CTs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

Today's linux-next merge of the spi tree got a conflict in:

  arch/mips/ath79/dev-spi.h

between commit:

  85b9686dae30 ("MIPS: ath79: drop platform device registration code")

from the mips tree and commit:

  b172fd0c8980 ("spi: ath79: Enable support for compile test")

from the spi tree.

I fixed it up (the former removed the file so I did that) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/yeSH+FhAFozHcaFoh=H1CTs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxJIq8ACgkQAVBC80lX
0GxHoQgAiDHn82GV+RjZoF7MpPbTKbNJRhOwevlepdE+CxrYAinRjp6ixmhSr5/Y
tAelTyGzjt63Ds1gDVbuz2gtLGsb6SIIZagQ7zAUIttL1PtEcyCBviKJ1yril2+L
3LXtUFp0NQP141MEv7yUtEUF30TAg/aN3g4gBS+a2sJvL8C/JEefO2TNyz4mkq0L
YFhPOEb78Zx/BIrEzmHn+6wA727KIY5IxP71R4e47SYobWkk0qNhtZovPBA07NBh
vTIMOALtRhGWipjGLVmsp9WqIX7X8wsMyUMnA9i1FD5KbxDkxm8TvX/qwoBxLUXm
gn1jW0XirkEWNc4zw2WJhZznX/+f4Q==
=TWqE
-----END PGP SIGNATURE-----

--Sig_/yeSH+FhAFozHcaFoh=H1CTs--
