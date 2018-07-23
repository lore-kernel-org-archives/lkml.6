Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46311ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 05:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F0520779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 05:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TFC4afi+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F0520779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387831AbeGWGip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 02:38:45 -0400
Received: from ozlabs.org ([203.11.71.1]:39843 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728188AbeGWGip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 02:38:45 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Yr026t3Rz9s2g;
        Mon, 23 Jul 2018 15:39:14 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532324356;
        bh=lt8ZWdDrXGozgDJ41qYlVT+whl9bi2Grip3Un/ONAxs=;
        h=Date:From:To:Cc:Subject:From;
        b=TFC4afi+iFwO5rlk0dpwmox8cZpvYo9ZUlVnLmnMP6KeitCqTKPvUnJnYW7XBBhZ8
         Pl+gOCXM8JMxI4BdjISq6QcMoVBdsSdCLu1SBM2ghgipiQAY+4aoFuC7CUNfpwrW94
         XygKUk84fjjyxSICCpmv9CpM9J0Li0hTmeLvS+yttfcjs1mcGCvLU0gEywcf02+zDF
         iQr3alDmdKPIxDGtruvcHszmRURODK2+kAsjXIKySGQo1A7hwMQE1a29xdmJz2+Uue
         /njpz+grLTD7OKvI12K30UJ8n6ewBxZiwwBP68EqVGNXETyjnycoYaE6DE20gJ7Ifc
         d1gUZJuBJZQqA==
Date:   Mon, 23 Jul 2018 15:39:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: linux-next: build warning after merge of the tty tree
Message-ID: <20180723153914.563af11c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/JThGx3CUaLtSkoddMj+oiW4"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JThGx3CUaLtSkoddMj+oiW4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

After merging the tty tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

drivers/tty/serial/8250/8250_exar.c: In function 'pci_xr17v35x_setup':
drivers/tty/serial/8250/8250_exar.c:380:31: warning: unused variable 'board=
' [-Wunused-variable]
  const struct exar8250_board *board =3D priv->board;
                               ^~~~~

Introduced by commit

  328c11f24b57 ("serial: 8250_exar: Remove useless has_slave member")

--=20
Cheers,
Stephen Rothwell

--Sig_/JThGx3CUaLtSkoddMj+oiW4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltVagIACgkQAVBC80lX
0Gw7egf/Wu5CCVzZk+VPQvsuw/2M8rL1UtId6v08Gb8Pmt5M4FMrzwPdzO92udyK
Cf8+JHJGmLQkzE6V4fKxpRdb/cKxhSeff/JtM3edrfctwKIUDKUkoLaMJIWzSSp4
jEv0Xq4pV1BJeWdXcyk6kgUPtPAYcsYY19rsMHA4jlzRLhpCC8F/X9jduyN2nVHW
eYX+EK5VWGd0hjRh7xLkaku3zxXZ0VFSCptXTDLa24xF8187XWxZ0qVrqPG2wsTV
QGXTO0oUpV9dSA5GZM1EZs8MAq0O4UtdOvJoqkQPbFSnr/f6vcP7j53cPAAaDBb6
f5y5DmBnxD/5FSG27mLEs6hWr0gr9w==
=Za2y
-----END PGP SIGNATURE-----

--Sig_/JThGx3CUaLtSkoddMj+oiW4--
