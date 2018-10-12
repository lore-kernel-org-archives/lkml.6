Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40285C28CF8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 00:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71D720835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 00:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RKrHH+ez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71D720835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeJLHki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 03:40:38 -0400
Received: from ozlabs.org ([203.11.71.1]:42941 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbeJLHkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 03:40:37 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42WSsr4H5Yz9s8J;
        Fri, 12 Oct 2018 11:10:56 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539303056;
        bh=as0NkWqkxarQOnYPcezCc662rFfIc9f0SYF8/PAk4S0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RKrHH+ezx+AUz5UcLvEp1omIaerOUMdzs2ea8bVVbWKA23Ygg2NIPQBfixjfaafC6
         4exiF3dG/sjqeCuz8Gn6+ds3bqt22S1lu1/n/ys9Hz60sUMc4hsJQASkA2u722+Lpp
         H73qfXL4KvJ2HU1y/hyjv9QoPXFhgpXwXSLmeve2W3RD+mNCbaFCAOrgLNBQeSI+jf
         iUMdl23/ROdWlRFmrNYKHpjMwUv6znO7PMh0udO8OHTYo/MIaxzfQO0NpDgqFl4SGo
         xxTcmC44KDYPy/XHsLyBK45FXu5sWSIpMWXz6hItSHys8j55zXu0Hdi+hdtB9RHya3
         kETYaIt1MFBFw==
Date:   Fri, 12 Oct 2018 11:10:55 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20181012111055.31eaf9f3@canb.auug.org.au>
In-Reply-To: <20181012105329.40678d21@canb.auug.org.au>
References: <20181012105329.40678d21@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/rz2Y5V4nJVSwrBhq8yt2=5f"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rz2Y5V4nJVSwrBhq8yt2=5f
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 12 Oct 2018 10:53:29 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the net-next tree got a conflict in:
>=20
>   net/rxrpc/input.c
>=20
> between commit:
>=20
>   5271953cad31 ("rxrpc: Use the UDP encap_rcv hook")
>=20
> from the net tree and commit:
>=20
>   d2944b1c66a5 ("rxrpc: Use rxrpc_free_skb() rather than rxrpc_lose_skb()=
")
>=20
> from the net-next tree.
>=20
> I fixed it up (I used the net tree version) and can carry the fix as

Just to be clear, I did not use the whole file from the net tree, just
the net tree version of the conflicting hunks.  There are other non
conflicting changes on both sides.

--=20
Cheers,
Stephen Rothwell

--Sig_/rz2Y5V4nJVSwrBhq8yt2=5f
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu/5o8ACgkQAVBC80lX
0GwRmQf+JCNu33Ov5fRwh0OUyduXN4JjiHqv7lG5yWtbjcGo9J+l7eFCiOyMTSyf
lbiXPAZY3jBELlZoWT8N7bfTN0JSYykNK0Gy+Z/9i0ya0h/PHLYyttEahSoCDGFf
BHFe+Y6P9JmGhr0vqmY9N1JB5ys1qOwmbygYbrfDrytkDnwng+nlI7R+U0Qe/lK7
nRoWp6TVKPw2si2q4BS3yNbBdyuxrAB4h1a/BiDsXH77Irej+xhN+CNSX5IEOjqN
tu1UOrZYjaK2lHjdMBrlG5+vN59TJC0XUbn92QkDf3VUKUd9jnQITaDtYyJLKFqk
+nSXXAgjE+PlNkyOHqXIQwfe9aF0Zw==
=Ddtc
-----END PGP SIGNATURE-----

--Sig_/rz2Y5V4nJVSwrBhq8yt2=5f--
