Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A82BC43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 23:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08C02536D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 23:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="T1CIHrXf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B08C02536D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752038AbeFXXPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 19:15:42 -0400
Received: from ozlabs.org ([203.11.71.1]:42665 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751482AbeFXXPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 19:15:40 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41DSpK5QCCz9ry1;
        Mon, 25 Jun 2018 09:15:37 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529882137;
        bh=IQLan94XEryrwJkYQDYLa8ILJ8eYKDdHAEo3uoizgwM=;
        h=Date:From:To:Cc:Subject:From;
        b=T1CIHrXfxcSlcjAc7WL3OT/PXays9aGWtr2/7oZq4mA/GbZrCjRkTdRyW3/k++8mS
         pySWf2BREIRzlSO5RM/xISGvp7XSILdBRQU2L8kM5D2VWk+ygQot1nvaX8/fgb4U93
         +F4+KjDYGrKE3J0XI84BBBGkAywI2QVRaq23QNwQfaokrBl/2wkhg8oh0UIzsm4F9R
         QOC3Iy8a14jvfFv6gZYLqiwcj0aY2MceNfEXFByknhYmvPnJu5zF0pqEh44iOcSTXL
         lHkBaSKDSs6Thgbu9uvWVnYzjGtTyySLs50efFODEOHv8/34YLnJxHu29jacaGbPG4
         b5/0WB/PNbWmA==
Date:   Mon, 25 Jun 2018 09:15:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aurelien Aptel <aaptel@suse.com>
Subject: linux-next: build failure after merge of the cifs tree
Message-ID: <20180625091531.60fe90e9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/TBAvP483fDhCQS/v8MsLHSl"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TBAvP483fDhCQS/v8MsLHSl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the cifs tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

fs/cifs/smb2ops.c: In function 'smb311_queryfs':
fs/cifs/smb2ops.c:1543:11: error: 'struct cifs_tcon' has no member named 'p=
osix_extensions'
  if (!tcon->posix_extensions)
           ^~
At top level:
fs/cifs/smb2ops.c:1534:1: warning: 'smb311_queryfs' defined but not used [-=
Wunused-function]
 smb311_queryfs(const unsigned int xid, struct cifs_tcon *tcon,
 ^~~~~~~~~~~~~~

Caused by commit

   ("smb3: add support for statfs for smb3.1.1 posix extensions")

# CONFIG_CIFS_SMB311 is not set

I have used the cifs tree from next-20180622 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/TBAvP483fDhCQS/v8MsLHSl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlswJhMACgkQAVBC80lX
0GzXSwf6AzHV6J1Eh3MwNgqgtrlt7OY7JSC0e14fCb+qtukbZORzOqX9/jfBhdXL
4BC3dXYvQP5dd4yOITl5uGo3kCxheCqYTmyeGUMQe08vlkNtSuG9TsVA4kWJEcN5
TkEJnuvxeZl5/urYs+jItpf2R+b/LfseE1iyNW035KbEYwITwbWY2GMBdJpigapO
1d05JLS1eTyZWNU1j1cns+7nN8HsTm52jgpgtYhKFdjIcJiMcC78VyXHYxgO3hZT
bHEiOmq2uYjoYltumlDNYQheZkTwdufgq0XbAA0g8JNz8ebYTda0b9uYY6Dm/UuQ
MLCpzPNwoso40PqSudVBh+D8usZTOg==
=PNzG
-----END PGP SIGNATURE-----

--Sig_/TBAvP483fDhCQS/v8MsLHSl--
