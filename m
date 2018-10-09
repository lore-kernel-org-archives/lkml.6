Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CC6C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 04:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98D5214DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 04:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MQEF1aS8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E98D5214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbeJIMOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 08:14:51 -0400
Received: from ozlabs.org ([203.11.71.1]:55265 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbeJIMOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 08:14:51 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42TlQV1tJWz9s8T;
        Tue,  9 Oct 2018 15:59:45 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539061186;
        bh=alk0cvMj8WCYa/bgvtJzko5Bnm/wTtbLoj/5IJLbiew=;
        h=Date:From:To:Cc:Subject:From;
        b=MQEF1aS8ryGox3hwy7crGI0+OhMvqcEQUopEopn4Rsbgl0K7uElXp+/cd9xHnyaWb
         JS4M7lwPn19UR5WyPGBldTcQjimIz7arymdSMmT2yJMoMaKyI9tBRTAtLE9Pu4/Cbl
         T5lSYR0n8H5Zm7xkjkKiuH0RqCOSqNtogk4DiIrVdUQBcT1eT6LBPMfVIEDXF0XZmJ
         gSk5/ZkwbfKFNyePmc/+x4aeHVYruWZmNFgnjQJttvR8esqQViJgYM3jhl3kiCe/YW
         e1455i98nSh9hoxtoUfRpGETXudXoDfHH0X8kLcDG/DMg+m8lKYkZtd2vTGvZZ6Ca2
         vCgipRuuWXMGQ==
Date:   Tue, 9 Oct 2018 15:59:45 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the staging tree with the vfs tree
Message-ID: <20181009155945.1b66ee78@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/rW1RL+ZHGmb._dGidBpSDgv"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rW1RL+ZHGmb._dGidBpSDgv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the staging tree got a conflict in:

  drivers/staging/dgnc/dgnc_tty.c

between commits:

  b68166ef8fd9 ("dgnc: leave TIOC[GS]SOFTCAR to ldisc")
  e002c6f1ccb9 ("dgnc: don't bother with (empty) stub for TCXONC")
  79273fc94ee9 ("dgnc: break-related ioctls won't reach ->ioctl()")
  246d394c9cc5 ("dgnc: TIOCM... won't reach ->ioctl()")

from the vfs tree and commit:

  3268357865d6 ("staging: dgnc: delete the driver")

from the staging tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/rW1RL+ZHGmb._dGidBpSDgv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu8NcEACgkQAVBC80lX
0GztIAf8DRmuJi7tmXbQdDwLaR0QARuSHLOCWY/oRHzCYx3Z1SLvORVZHjsk31us
ZSUwFo0nJgastQZaR0JzNK6edEfw45kq8MbtzW/Z0IOpglx5obc8MgT5/e0FZZoM
HBOVpnTC4RCrxX4G9VkyVrQl6ZUjdNlFgm6o1giIol5mGJNx6FYOz7OMTsXHnOeC
gCFZfwq2DFFLMpyT9et/Fb1u/SKH8u4eHRwdcD4bMAM3JVPAXJ4W3fW3ki+mjJXm
eVifGKcLYwuo2zHLV9QySTJlWS0Uw4WREl4nHEzH2kIJ3HSjGsoM5eaaO/tTMyHK
VS31LjwpwBFLVy9MZOTO4XrCfuXgWQ==
=Kir6
-----END PGP SIGNATURE-----

--Sig_/rW1RL+ZHGmb._dGidBpSDgv--
