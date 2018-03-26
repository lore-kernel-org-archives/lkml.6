Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751091AbeCZBcc (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 21:32:32 -0400
Received: from ozlabs.org ([103.22.144.67]:46151 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750832AbeCZBca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 21:32:30 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 26 Mar 2018 12:31:43 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: linux-next: build failure after merge of the pci tree
Message-ID: <20180326123143.38630ea3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/L79H_nkXR/UMWki4toIs6c9"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/L79H_nkXR/UMWki4toIs6c9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

After merging the pci tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

In file included from /home/sfr/next/next/drivers/pci/host/pcie-iproc.c:16:=
0: =20
/home/sfr/next/next/include/linux/irqchip/arm-gic-v3.h:560:10: fatal error:=
 asm/arch_gicv3.h: No such file or directory
 #include <asm/arch_gicv3.h>
          ^~~~~~~~~~~~~~~~~~

Caused by commit

  af3c73473d10 ("PCI: Improve host drivers compile test coverage")

I used the pci tree from next-20180323 for today.



--=20
Cheers,
Stephen Rothwell

--Sig_/L79H_nkXR/UMWki4toIs6c9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlq4TX8ACgkQAVBC80lX
0Gy5hwgAi/xRcCmWvcTfCwjQARDpRh2xb07XoWph9iUwKiFdBdlzIUjaTDya4cve
h6R3S9ahj00PdTud8lEQZURhT/2xtyZVhuxbfaQF+EJoBPU5fwp5L8+Bk3wFwzMx
GnMDnZkq6vwF5Fwcd+h1gs9nr+Ji3V8U9uGVbH8+4r3GaDjrnOSqVjm9+bHxk1Xn
F6OkW/p8T8BN7MAxryOBYEhNj7tevnzk7TaaaQqpXxnPQiwL2LOlo+nYCdIfVTs7
rId+uRlliLVLK9XeNUqsQl4jqN/9vYNYKttxJ6SFuWW/XBOTB9/nEJkr+SemKoYV
OSqjjZ2mwPqZdnstm5uet9benRpp7Q==
=y6+H
-----END PGP SIGNATURE-----

--Sig_/L79H_nkXR/UMWki4toIs6c9--
