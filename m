Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFFFC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 01:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90277208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 01:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jzF1FaJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90277208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754380AbeFRBaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 21:30:08 -0400
Received: from ozlabs.org ([203.11.71.1]:46861 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752651AbeFRBaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 21:30:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 418D6g12vhz9s1B;
        Mon, 18 Jun 2018 11:30:01 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529285403;
        bh=l5edeDWE5l4ZXif9QNY7F6i5WIVLl3rfOpODOl2ZXOY=;
        h=Date:From:To:Cc:Subject:From;
        b=jzF1FaJSBpCW6Pib47FNljtErwsx7hrHvZzzR7Kigkh29Y0W3E0UM0L+Tkj4bjCfq
         1ZqQIfvX2Zh/vZzYGxZfBeAOeB+gk0onhlPjtzHNYLBXpa2kGWlPCVvpizMaci4ZaN
         QveMTkRMG7rJMjTbvVz2mn9WazJ7HpX/P6h0a0De0vNxzcTHqaeCXxyGFr8WVFmKzo
         6V+4En3olKsQoTvWvev62pSgObFMJVqeUUAjdtBjCX2+3i3Vp+UVeT4lbS3Jxq33Lh
         jkTZdcNTmzvh8J7ILAUJ1TtSsS14Ic1Z1BGWxmjVhNRgDhp4+Q8cT/Hf38f1lNIjZ5
         22lZg5+omWfTw==
Date:   Mon, 18 Jun 2018 11:29:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: linux-next: manual merge of the mac80211-next tree with Linus' tree
Message-ID: <20180618112943.4ceadf24@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/T4UnYjLzyJs=UM7dPDwrnvl"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/T4UnYjLzyJs=UM7dPDwrnvl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mac80211-next tree got a conflict in:

  net/mac80211/scan.c

between commit:

  6396bb221514 ("treewide: kzalloc() -> kcalloc()")

from Linus' tree and commit:

  b9771d41aee7 ("mac80211: support scan features for improved scan privacy")

from the mac80211-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc net/mac80211/scan.c
index 2e917a6d239d,ae77d1c12856..000000000000
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@@ -1157,7 -1197,10 +1197,10 @@@ int __ieee80211_request_sched_scan_star
  		}
  	}
 =20
+ 	if (req->flags & NL80211_SCAN_FLAG_MIN_PREQ_CONTENT)
+ 		flags |=3D IEEE80211_PROBE_FLAG_MIN_CONTENT;
+=20
 -	ie =3D kzalloc(num_bands * iebufsz, GFP_KERNEL);
 +	ie =3D kcalloc(iebufsz, num_bands, GFP_KERNEL);
  	if (!ie) {
  		ret =3D -ENOMEM;
  		goto out;

--Sig_/T4UnYjLzyJs=UM7dPDwrnvl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsnCwcACgkQAVBC80lX
0GyqXgf9He+f7tztUphMYK0BvO1ZXCa9ZTbKoUvzy973dn07ZgaJFAgF5dbwcr+9
8XvLxHWbzUEwXYUSxTqZIQQdqFEnBlSeY58sxKoBYCOzQCWHH8CdZTnKEwAoZrDX
LYBtLob2E1UTHQoCti7Mtf3Pd6SuuPsLkmxnGEVuKFcA16tu7H/n62Cw3Y2FpiXx
+tQrMpIX16D9YYbwnFw7QEdzaqphZV4Rvf019CHCVHElKMFZBR5W6P0wXKD8nAX/
Mn9DapfLBrvqs/X7ShYZZcVWoSrZ7uvqnyC9o+JTx/I1518lTJy9hU9wL6vQRsIy
2xLfbvPxnxhYPivIAUklSzF676UzJA==
=6zxy
-----END PGP SIGNATURE-----

--Sig_/T4UnYjLzyJs=UM7dPDwrnvl--
