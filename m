Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB524C6786F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 01:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973C82082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 01:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ouPUfeWe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 973C82082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbeJ2KHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 06:07:46 -0400
Received: from ozlabs.org ([203.11.71.1]:57565 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbeJ2KHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 06:07:46 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42jxdG2PTLz9s7W;
        Mon, 29 Oct 2018 12:21:22 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1540776083;
        bh=/lmHZu8aKt1yoMfM7pxg69RVGRW2fPshv33X1a+LW+w=;
        h=Date:From:To:Cc:Subject:From;
        b=ouPUfeWe0UDuMMz03Mbr1W3MNw65Nexpw+gHQ/k1aSdAACXYTHGu0PkbA3e3bwWzl
         zZe2oFx5/5wdZJMa78qmwncGIwKMHbZ94JLOJ/DTq0lW4/rVVKd+vihxxBwEPT8ME8
         hSI3u/2CQlLe1SyONjhr0Y37DfzmgnDw3NX1jKXgbp9AJKmBTB/p9q13+dYWWgOLqG
         5h/2ynEgso2Hv7HzQyCf4AXdGC5i5THpvoHuc5VsFaPX7OIKuLYqoM5KRPxHG6n3a1
         eU7rsjYubBQIlhUH9MpGcMXwoj4xXy8lbyeIkQMnir1okLfFfmQscPG8yKuGsMi79O
         f5473hcEPA0dw==
Date:   Mon, 29 Oct 2018 12:21:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Trond Myklebust <trondmy@gmail.com>
Subject: linux-next: manual merge of the vfs tree with the nfsd tree
Message-ID: <20181029122121.7758fed4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/JwbZf_S2Jf4g9Wdt8hUZGPH"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JwbZf_S2Jf4g9Wdt8hUZGPH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Al,

Today's linux-next merge of the vfs tree got a conflict in:

  net/sunrpc/svcsock.c

between commit:

  64dbf4dc5496 ("SUNRPC: Simplify TCP receive code")

from the nfsd tree and commit:

  aa563d7bca6e ("iov_iter: Separate type from direction and use accessor fu=
nctions")

from the vfs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc net/sunrpc/svcsock.c
index 3b525accaa68,0b46ec0bf74e..000000000000
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@@ -336,12 -338,8 +336,12 @@@ static ssize_t svc_recvfrom(struct svc_
  	rqstp->rq_xprt_hlen =3D 0;
 =20
  	clear_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
- 	iov_iter_kvec(&msg.msg_iter, READ | ITER_KVEC, iov, nr, buflen);
+ 	iov_iter_kvec(&msg.msg_iter, READ, iov, nr, buflen);
 -	len =3D sock_recvmsg(svsk->sk_sock, &msg, msg.msg_flags);
 +	if (base !=3D 0) {
 +		iov_iter_advance(&msg.msg_iter, base);
 +		buflen -=3D base;
 +	}
 +	len =3D sock_recvmsg(svsk->sk_sock, &msg, MSG_DONTWAIT);
  	/* If we read a full record, then assume there may be more
  	 * data to read (stream based sockets only!)
  	 */

--Sig_/JwbZf_S2Jf4g9Wdt8hUZGPH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvWYJEACgkQAVBC80lX
0GwsyAf9HrTAWirnIzF0M1o5QLWkmRqa+ZH08+xp6fuKg76SAQwNKxtPU2V6bGsI
q8IjXiAwxSOksrhA5Uk4TgW62pTN8leXi2afJ4bb3WaRVJ1agLC96KzFi8U7dbXG
fN++soXaSSSIy4mp/szKUi2/jDG+zAlIOhVS4vv+6qD54qKGAdVLnX8bAwadqMm5
ReKDJEV7zqG9hIU4zTra/OvSbFogzHh4RdEkGIyBjuy8sH91YyZda3AUd0b8pPtn
4AKJVxqJr2AmajwVQEObdqhvOV23EphlbmQztP9QwpTt1ZHrfVaX2mSCZH7VzqwJ
kB9ySaVHj3V9DGcVFLz7zZgz2cd+9Q==
=BQDe
-----END PGP SIGNATURE-----

--Sig_/JwbZf_S2Jf4g9Wdt8hUZGPH--
