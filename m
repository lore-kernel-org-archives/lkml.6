Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BC4C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F350F20873
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="I3Llkz6E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F350F20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933023AbeGJG5X (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 02:57:23 -0400
Received: from ozlabs.org ([203.11.71.1]:55213 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751214AbeGJG5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 02:57:14 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41PtL030QRz9rxs;
        Tue, 10 Jul 2018 16:57:12 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531205832;
        bh=iXoHMPTdHndI01fRU1U5oJfVP8Py7lmfyh7Rut6W0yY=;
        h=Date:From:To:Cc:Subject:From;
        b=I3Llkz6EBbiZ0f1cA7/UzKHpxWvNx7muFoPmAkgQzUGgDuLnZdNDimJFACAcjHz/x
         /O7LZt0ZDo8KWkQN+3MasKHSKsRouYjBJliK+Kj04VUrrj8azbm88aAVaqnEtZVm5z
         BJyvpx+NGE34rO//BWh8bTtmFD9FvC2Kj7s/GYReeJy09QnhE7YRJ6X1/SYjVoTADN
         f5AsXpnZ8qxl0PyUO+YoJ6ExDqsQ3m0+MiWojOfiP/leev6ySbueo6YgejB2nznA2j
         IGXSVU8UkbxEI9T45uHSPjTmMEA5JRk1+k+8ZUUuLqAfmaLr/fkj6K4fY/dlg8w3U7
         Kl3rzT0FfljOg==
Date:   Tue, 10 Jul 2018 16:57:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Doug Meyer <dmeyer@gigaio.com>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: linux-next: manual merge of the akpm-current tree with the pci tree
Message-ID: <20180710165711.0e618002@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/_qaZzBCzhS_iCNt8GQN0syz"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_qaZzBCzhS_iCNt8GQN0syz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  drivers/ntb/hw/mscc/ntb_hw_switchtec.c

between commit:

  cfdfc14e7fb8 ("switchtec: Use generic PCI Vendor ID and Class Code")

from the pci tree and commit:

  a2a35435484e ("ntb: ntb_hw_switchtec: cleanup 64bit IO defines to use the=
 common header")

from the akpm-current tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index 5ee5f40b4dfc,f403da24b833..000000000000
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@@ -13,13 -13,13 +13,14 @@@
   *
   */
 =20
- #include <linux/switchtec.h>
- #include <linux/module.h>
+ #include <linux/interrupt.h>
+ #include <linux/io-64-nonatomic-lo-hi.h>
  #include <linux/delay.h>
  #include <linux/kthread.h>
- #include <linux/interrupt.h>
+ #include <linux/module.h>
  #include <linux/ntb.h>
 +#include <linux/pci.h>
+ #include <linux/switchtec.h>
 =20
  MODULE_DESCRIPTION("Microsemi Switchtec(tm) NTB Driver");
  MODULE_VERSION("0.1");

--Sig_/_qaZzBCzhS_iCNt8GQN0syz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltEWMcACgkQAVBC80lX
0Gx61ggAnJ1X3hV2AEuz18IrRl31FFYD/DRRT0aMAqVEs2E2WdyggJAGwXKRJAEC
+pqiWGr/PvJ0zhFTe2vwaePv0wryWxc03sHsx2GSpIB7VnUlmJgP2An7dMGDCaAr
EKr+pZfWyaAIuIBEoVv854dljn8akZUpCknjKywRSlwsfZoJW89CIhHtBJij4a27
G1ZE+i/gmplN898OO720xsqADxIaKrUzkHlvwtGDapEvnbtXORcM1qWTKMRx7xJf
mLakct+PhSL2vQdx0cCRRpoVGQdwKPEecCsFElFbRMYpIdi5pRqyoOzf+ADCwB2R
crZzEEGo0yZ7dyfVubCsFh57pQwR7w==
=qq1B
-----END PGP SIGNATURE-----

--Sig_/_qaZzBCzhS_iCNt8GQN0syz--
