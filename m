Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165ACC28CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 23:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD3FF2086A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 23:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RHNGFfEU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD3FF2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbeJLHXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 03:23:09 -0400
Received: from ozlabs.org ([203.11.71.1]:57731 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbeJLHXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 03:23:09 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42WSTk1ZjQz9s8J;
        Fri, 12 Oct 2018 10:53:30 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539302010;
        bh=2xRmY/q1yGtghX/gTkl8wEm0n35VRZSKZFtIO47nZm8=;
        h=Date:From:To:Cc:Subject:From;
        b=RHNGFfEUuBolWAfwcgoIJETSUQ9tO7xVyW6VDNiFNv1dn63DaAJmBl1aoRkLZEt76
         gUEPBvOpWlTP+jzBIyJQb0XnpaehEG9/AbXcERczb2xGQLV+T/e/tjnTCEZNRO7VBO
         zQwR13H07qrybMfMVM8itDqXebFuebszspk5q5gkZ1Ybp87oE4r5jCpNbspd0jdVrS
         No6f6Wl/9DuahQQvYp5fJGgGB/tGad5ygfbVNzLxy4wONdxcohEOecRSVmHQJ3lnOz
         MpiHDbesSHWKP+UFcvNTQP/3rIeTUqQJ172mq6mAAP6TCXhja/kuUGFg5jSCK0yIq1
         ojXMqCjBWLvHA==
Date:   Fri, 12 Oct 2018 10:53:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20181012105329.40678d21@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/iqkQZOJoNghT1_bRlwNcXF."; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iqkQZOJoNghT1_bRlwNcXF.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/rxrpc/input.c

between commit:

  5271953cad31 ("rxrpc: Use the UDP encap_rcv hook")

from the net tree and commit:

  d2944b1c66a5 ("rxrpc: Use rxrpc_free_skb() rather than rxrpc_lose_skb()")

from the net-next tree.

I fixed it up (I used the net tree version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/iqkQZOJoNghT1_bRlwNcXF.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu/4nkACgkQAVBC80lX
0GxLKQf/SLpImoxPw+Hzjjcw8tD+Ha4tMMS01uXjx3p4G0NLyfKsRyVqj+ysO+nb
oHpf98JMC62dSsWtN1RuUnCtFEXTEBSa6x/dbh7s8hnRjA2+AtARxReXfeGVELrd
WhzZqUPN9R/Y7abQFDqfXffggtkcpn5RwiD+UnzBa9w8JKiIY8eAKZYx+7/YjBh9
oRr2wwHgC/rVyOc0AIqedW90IJJ/9N1X96/P7BicMY1m0/GZiKxgrzYcUgb8wP4s
8kMtmv2BJTengfOj5AubN5vac1i6xK8ydgnWHD3lC3IokWxxCan5mHP5KIQ/TSHl
52wy4oh0iwf1IvrIPJW37HbN4nYW7g==
=DA2r
-----END PGP SIGNATURE-----

--Sig_/iqkQZOJoNghT1_bRlwNcXF.--
