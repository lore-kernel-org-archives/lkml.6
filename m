Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC28C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A964206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="oWOJEDpf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A964206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeILBgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:36:01 -0400
Received: from ozlabs.org ([203.11.71.1]:52797 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbeILBgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:36:01 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 428xVR1Jppz9rxp;
        Wed, 12 Sep 2018 06:34:55 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1536698099;
        bh=vjdVvDlqZdws3ZiAndCh6mfZ7wqbLtDVnjavoLqVY9E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oWOJEDpfHRfHBefTJ2L5idaSmo9IzW75P5a8rpPN8EZRCc2uzfXbgjRpGznbt0qi6
         ntv16WrsVvLvieS5Za3EfKIeQt5xz9GEbsTQ7hQk7bg5EUyLBCXnm/UXBlR9pI0zau
         sNv+PFyIqn9nnDkt3WoO76qFjLVCCzoUWfn3F8QMCsvo8povy/dVS7qNTrUiuP9cIP
         XD3aI07wTnLR5WYobFZxENJYAVbj+zEMDa5J5wOwC70s5mW4XxQ+aSH18fSjPZoizu
         eyQnsYj8YbV7FMW3J7W6pC79qVY3vB7fCUBZIiue6RxKO9MiuUKE5blTp3l74okVM1
         /X5rRLd6q3leg==
Date:   Wed, 12 Sep 2018 06:34:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+762a577f56cfb1574647@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Levin, Alexander" <alexander.levin@verizon.com>,
        LKML <linux-kernel@vger.kernel.org>, linux@dominikbrodowski.net,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        nikolaus.voss@loewensteinmedical.de,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: linux-next boot error (2)
Message-ID: <20180912063454.0620abb4@canb.auug.org.au>
In-Reply-To: <23632.1536696987@warthog.procyon.org.uk>
References: <CACT4Y+ajxhUaRg+XSuqQZN8rD96S820yMTWx2GpRVRb9Maz50g@mail.gmail.com>
        <0000000000006082bd05752f92bb@google.com>
        <29979.1536223287@warthog.procyon.org.uk>
        <23632.1536696987@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/adwzyDkyVxgLUkfoLuD1JIv"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/adwzyDkyVxgLUkfoLuD1JIv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

On Tue, 11 Sep 2018 21:16:27 +0100 David Howells <dhowells@redhat.com> wrot=
e:
>
> Andrei Vagin spotted a missing change to apparmor:
> apparmor_fs_context_parse_param() needs to return -ENOPARAM, not 0.

I will apply this fix until the proper fix arrives in the vfs tree:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 12 Sep 2018 06:27:43 +1000
Subject: [PATCH] apparmor: fix a return value

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 security/apparmor/lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index c316d4237d94..416204ea713d 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -602,7 +602,7 @@ static int apparmor_fs_context_parse_param(struct fs_co=
ntext *fc,
=20
 	afc->saved_options =3D p;
 	afc->saved_size +=3D 1 + len;
-	return 0;
+	return -ENOPARAM;
 }
=20
 static int apparmor_sb_mountpoint(struct fs_context *fc, struct path *moun=
tpoint,
--=20
2.19.0.rc2

--=20
Cheers,
Stephen Rothwell

--Sig_/adwzyDkyVxgLUkfoLuD1JIv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluYJu4ACgkQAVBC80lX
0Gz5xwf/Ts3R4xX3Q4y+5dB74NlnzE0UGWqQa398XpUGiw8DYs9BFG7qKeNDLzQo
jiLmW0E9ZYyqmccwBuGPRR9H2M2Ly0G4VXxv5v64LSIzDy3zmM+sYdCEF1ovZaQz
0MkVZd+LDW8FOtVoONXr/Xgb4UFo+vlFSJLaF2WV64kvMWN6L+ZPDC1pDnAeylLv
+uvbJmzI99ppXyPWXbeI+ZRqkZLInicC/jizzTEAaC4cKM49hzq5XER6OvlXzwrf
mbmxdVojLoJ4e67aMV0SPjBRIGaVu6zogEc9+Yd49NJbFg3wC8FgsYC9XLpKOJmt
0W7Mo+qB9zArbQEGm9K4RMQzYI4gTg==
=loEL
-----END PGP SIGNATURE-----

--Sig_/adwzyDkyVxgLUkfoLuD1JIv--
