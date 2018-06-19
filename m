Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26A0C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D662083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="EIvXLHFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D662083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937335AbeFSE4M (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 00:56:12 -0400
Received: from ozlabs.org ([203.11.71.1]:35581 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937085AbeFSE4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 00:56:09 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 418wdy1fP8z9s3C;
        Tue, 19 Jun 2018 14:56:05 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529384167;
        bh=Krek/O2KW3WHiU0KvWK40uE2H+KntHz0Bozl059YFhs=;
        h=Date:From:To:Cc:Subject:From;
        b=EIvXLHFR6SCFs7dzWzVKBFXRtV/QPrbAlg+QuQsBVUc5REBlFGY5PQiYJwSi2SrGk
         e05MyChmjDeUQuS6x641OEnzKA+VR57tobfr9rmnAn1xEj5F8Gc0OgvXOHTCI0hegl
         P6dfPjAS83cN5VEiuxJ6OfOAXLhk3wqBKjY9kVhEGbtkVTdNXflTPSvMLvZq7mV4a9
         GTy6IWP3Z+1zEPpKs/VugEaGWCTWf009/+3nW0wXPyo6XMMcPpGMLVYuTxCoQZID+9
         0Dty0ESbmRQEa5jOwZdy4qgChDbnDt0PBblxl9eneiNc1QeGid8MRtb1gfR6mYIx+W
         jcE1tDVgVhluw==
Date:   Tue, 19 Jun 2018 14:56:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: linux-next: manual merge of the userns tree with the vfs tree
Message-ID: <20180619145605.1eb8e86f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/59UMffTH7U2/QUbpeeP3iOj"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/59UMffTH7U2/QUbpeeP3iOj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the userns tree got conflicts in:

  fs/proc/inode.c
  fs/proc/root.c

between commits:

  0223e0999be2 ("procfs: Move proc_fill_super() to fs/proc/root.c")
  83cd45075c36 ("proc: Add fs_context support to procfs")

from the vfs tree and commit:

  cc8cda3af2ba ("proc: Simplify and fix proc by removing the kernel mount")

from the userns tree.

I don't know how to fix this up, so I just dropped the userns tree for
today (since it only contained that one commit).

--=20
Cheers,
Stephen Rothwell

--Sig_/59UMffTH7U2/QUbpeeP3iOj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsojOUACgkQAVBC80lX
0Gzugwf+OutsKhrbGfS+oySE/YiolPEO81HpD+GYWQtKZGeaJHQKMAlXfhu4QURE
DnjuN0p6dImod/bJLR+DAJUr3SghNpyu2LLKKqtY5l/8qLdh7Q8bi1IwNNWZx5Ft
KEi16mgHyQBHW9sGW7AzLUtzFsSxCji4Z9LrwtIoSrYUWXCZqsHgVpdnpfWvnTF2
It93bz0ysbY/WfCRHYxSlWstZXDG2wFNeHRyr5jxwIQbHbnRkbK7zuCtQkHbQT9E
hdkARVwrCFhCfqml+e96Ig5JTRCb+hVbjcwc4MEIJvzlzmIg40LS84HNnAAvCZPI
Vx+eFEqEJDLvC0S3U5ubq4QJLf/3Tw==
=Eh/Y
-----END PGP SIGNATURE-----

--Sig_/59UMffTH7U2/QUbpeeP3iOj--
