Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14888C67879
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 01:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A7720C0A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 01:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="H5AJz8KM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A7720C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbeJIIfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 04:35:46 -0400
Received: from ozlabs.org ([203.11.71.1]:48005 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbeJIIfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 04:35:46 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42TfZN6JRlz9s3C;
        Tue,  9 Oct 2018 12:21:14 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539048078;
        bh=YcT2F9ekyURgyNeC4cFEl+IvLpWRRf6h0rEh4iGLgks=;
        h=Date:From:To:Cc:Subject:From;
        b=H5AJz8KMv4cSToB3NLNLQ3XXnYEM3z8QmnjDANrCDM0lthgsWsxsxGMo1Y+7Oob4E
         ngmF0NRbCoKIv5CJfeoAr5WwfS0WgT4JEUuFcfG/pGZgugLX5Y5rhhtI7oEAe2XwCv
         lcVdwpNz7eS9ZOEro+6uDZ7ZtrjJCmQyGahgVcsjsprmpqjixUmghhziPmqHmL9F5M
         OdBCYOTh5iDVnZirWK/ThsKT58RnIbEgn2hZZv8Flc42DAUMrl1XDbCSoUzgzmfRuj
         SuysGQidBoYJELBOyw4RG2cb3+DPVVijnFp1ruX89PgTuw9sH/PDGRTDY8sBbnIa3v
         R1AZz4iOVXwGw==
Date:   Tue, 9 Oct 2018 12:21:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jamal Hadi Salim <jhs@mojatatu.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20181009122113.05fbf12a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ksmFf./sUIVCigUxh1ESQ.Y"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ksmFf./sUIVCigUxh1ESQ.Y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/sched/cls_u32.c

between commit:

  6d4c407744dd ("net: sched: cls_u32: fix hnode refcounting")

from the net tree and commit:

  a030598690c6 ("net: sched: cls_u32: simplify the hell out u32_delete() em=
ptiness check")

from the net-next tree.

I fixed it up (I reverted the net tree commit as I could not tell
wich parts of it, if any, are still needed) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/ksmFf./sUIVCigUxh1ESQ.Y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu8AokACgkQAVBC80lX
0GwQEgf/RaP9DHjICf/RIPnuGarpgfSaFxHWmH2MFA3FEYFYGgX69V81hAofrfER
Vqz5Bumis6QPg6VHf2mrV66wEnEl9Ztf39KWRQzntfMtYYlhb2r+yVXnxpvyTNHy
d/HRC9X80SwotO1Y8PC9alG8g8ryRhgTBj9ci3ikYe6U0BPOUHxGUlbONulzjGzr
nrFF8T/Hjaw13/W6UcqWxj9opGtrMXOrot3ADL7/kV1qNny+1sK35U3YusBaG4wV
lyckh+SLZVJjHSYg3morS1WoMDngXM/5zFLH4OQq/ycWMsu2aQ1oys8MENP8kNDP
V+yQvH6eHPvcZOXc5cIah7VjozCk3w==
=ueao
-----END PGP SIGNATURE-----

--Sig_/ksmFf./sUIVCigUxh1ESQ.Y--
