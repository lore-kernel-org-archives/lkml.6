Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FD9ECDE5F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 01:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497892084C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 01:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="IwzWhXzt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 497892084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbeGTBs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 21:48:56 -0400
Received: from ozlabs.org ([203.11.71.1]:60715 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730349AbeGTBs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 21:48:56 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Wt0t4rK1z9s5c;
        Fri, 20 Jul 2018 11:03:10 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532048591;
        bh=N3WcJ5mTcxwHdQ6OyMrtP26suS60O17nVrD1TB1P0MA=;
        h=Date:From:To:Cc:Subject:From;
        b=IwzWhXztF3md6ntOzMTGu3dhvaivUVEv9S/J5zWUdBdIfl+/4fvCRXTl54eXMOoLY
         62K6ge97IRscWaRgNSsBThMkALVDku1kTKbpE6aB5jyP1XYmDXte//H3f+VUDjWHtt
         dSDlCIrX5ePBHZA9EQhwQts32KCRpOHLpELAsm9sr0Cabgi/M1/6JjRAEQVzjX149w
         KxLnKQkQhJazsS8BlcKyEy0uvZTFZ50ebjfI8E5yX/MeaeO+m4KwS4CV4sJuH0BIk9
         WqQr2qSswqkpq2l5qTJZpJS20hUrkV7GXGhbG5OHE2nPYzem1rYKRH/MWBlGmir9dG
         fje3XaEiHqaBA==
Date:   Fri, 20 Jul 2018 11:03:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Evan Wang <xswang@marvell.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: linux-next: manual merge of the pci tree with Linus' tree
Message-ID: <20180720110310.6d07e86e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/X2ehTojAadPModQngJYUH7O"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/X2ehTojAadPModQngJYUH7O
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the pci tree got a conflict in:

  drivers/pci/controller/pci-aardvark.c

between commit:

  1df3e5b3feeb ("PCI: aardvark: Fix I/O space page leak")

from Linus' tree and commit:

  6df6ba974a55 ("PCI: aardvark: Remove PCIe outbound window configuration")

from the pci tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/pci/controller/pci-aardvark.c
index 0fae816fba39,d5030cd06197..000000000000
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@@ -843,13 -809,7 +809,7 @@@ static int advk_pcie_parse_request_of_p
 =20
  		switch (resource_type(res)) {
  		case IORESOURCE_IO:
- 			advk_pcie_set_ob_win(pcie, 1,
- 					     upper_32_bits(res->start),
- 					     lower_32_bits(res->start),
- 					     0,	0xF8000000, 0,
- 					     lower_32_bits(res->start),
- 					     OB_PCIE_IO);
 -			err =3D pci_remap_iospace(res, iobase);
 +			err =3D devm_pci_remap_iospace(dev, res, iobase);
  			if (err) {
  				dev_warn(dev, "error %d: failed to map resource %pR\n",
  					 err, res);

--Sig_/X2ehTojAadPModQngJYUH7O
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltRNM4ACgkQAVBC80lX
0GzuSgf3f+bamRU7gw2KJLxSFzsbIaW3XtrwlURFfagQ5qq3Dn5o3e22cjX8TFc3
JN/Ha6/qVWNRKPaRwPJQV8C1ms7+Ea9uVogIz0U/Y7qDtCtvy/3Q9jpyTz9kUinZ
bwvXemoSq1079TjIOrzPpKZ/QF3iRMk7m5Sw9GTpeJiAvdKsq25Gbu+8iEy5QPVM
J37gD+mFiFORauxC47PVQNJCnCpWOtXrz9y788DguVFg1H3RqPQhYMeq6U9x1nxg
Ikdor2LwwuH6YkAExJ2+DRLE3hWrDIBnjqLLEjk3XsSuiCre3LN8OrDCYcmUenuj
Xbd6D7XmKbf2cdKQZFAv0yblelg2
=sD9w
-----END PGP SIGNATURE-----

--Sig_/X2ehTojAadPModQngJYUH7O--
