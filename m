Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B1EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCAF3208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="uzPCavfo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCAF3208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbeK0Lsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 06:48:51 -0500
Received: from ozlabs.org ([203.11.71.1]:54955 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727536AbeK0Lsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 06:48:51 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 433lcv5DMkz9s3C;
        Tue, 27 Nov 2018 11:52:47 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543279968;
        bh=GaKJen0KztifuuFAuNe0IQq9WLzSXe+vIhAVImpJ0i8=;
        h=Date:From:To:Cc:Subject:From;
        b=uzPCavfo2d83JQAEO8B7lBx9rG4JRDkwFUFWstkWSAH+DaSRR2oKukn905g38IxIc
         I+Jhvp72sc9LrhIqMsCbVxqClZgq4asa0HJtwjp3ZQ4kWVh9XaS/7leQ8FEBPrUmWe
         x4lRZLukkZilYInQs3aHWdDv5RaNCRVoVlCsLGjVlJCWAWosarEPIhIo7hXpxbS79A
         Eln21/VjVgNjok1v5EWnb1VTm5OL/R1RNTJi7XM8MJmFhVnVAK61qKjI6k5M5e1mZA
         Lem8M6exi7Hu2XDIApdWqLuh6pY66hk8foPHFfgpPr31qiq/AOllVeIhYcwywu883M
         g7C0CEHj1hD2Q==
Date:   Tue, 27 Nov 2018 11:52:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paul Moore <paul@paul-moore.com>, Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        David Howells <dhowells@redhat.com>
Subject: linux-next: manual merge of the selinux tree with the vfs tree
Message-ID: <20181127115246.00967523@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/AwPieLJlQ0s7/md85VE7dS3"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/AwPieLJlQ0s7/md85VE7dS3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paul,

Today's linux-next merge of the selinux tree got a conflict in:

  security/selinux/hooks.c

between commit:

  0472421f47a9 ("vfs: Remove unused code after filesystem context changes")

from the vfs tree and commit:

  2cbdcb882f97 ("selinux: always allow mounting submounts")

from the selinux tree.

I fixed it up (the former removed the function updated by the latter -
I am not sure if there are further changes necessary) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/AwPieLJlQ0s7/md85VE7dS3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlv8lV4ACgkQAVBC80lX
0GzmNQf+PYsp3VMenibDZWFRGsjP4FClRFLbTGQ3KZ79glrpDgl7fjWyB3HyGCmV
ezN9j1a+/Bz5oagt8/c29qxQq7s1EG36+GcRff4SsY8fisanxpvBM4FyLQR39078
iiX5W605TX6aIxR2gg8K1WKlJc6xhmCWQuLvdPGlZIQWto17GXDciJEwKuQ0rlr+
cuMVCYJ6n4hNTsibhs9DwZt4dQS0uKv+gDrag34Cca0Wp4aOE1Ad2t3mEnWPzLFN
EmQVcSTCzC373RyDsUEpUtxpe8o7GsGqdTvf2rv8tyQ6RSiyKdkRpMo//JmL4b7W
a2u9i00KGbTDZzkCtdqVVMIkO0A3bA==
=3cUg
-----END PGP SIGNATURE-----

--Sig_/AwPieLJlQ0s7/md85VE7dS3--
