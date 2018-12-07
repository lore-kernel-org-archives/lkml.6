Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87B5C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 04:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817EB20700
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 04:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="q13MfoBZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 817EB20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbeLGErM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 23:47:12 -0500
Received: from ozlabs.org ([203.11.71.1]:43185 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbeLGErL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 23:47:11 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43B0Lh3YbMz9s3l;
        Fri,  7 Dec 2018 15:47:08 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544158029;
        bh=184WSYfWDxBFnLqXFJg7jMRhOTHZBqebrt56sKS4OYM=;
        h=Date:From:To:Cc:Subject:From;
        b=q13MfoBZW5i9UyHIN7+JeUw+lgmAw9ah0dJSbJ1bxWHDXI26WWOMKgtoLG47m5K6l
         kJyPDlW2idP4qTL44v5JSdf84JWElds4Fed5kzhKAwOMPlgo14wzev//t4Yzph7HeU
         akeKZY9+AZP976HEqkmG4idYt/jIVajwUHvu2kSBpZJkwD9NaS/xKYpVcJQqUYheA5
         F2z/dWP8ZQE3nd/P8AW5da0RLPXgK1u/a4Ol0KTuNHJGLE8Q+aSvSVIn91AV70Pmfx
         UzMbqcARyh6o4aLxYlPKfyIA/5sBlUf/RB3SV4tyeKjxoEhJQOZ0sJTHKwbgZjZ7zB
         1Ar5ARUweGQGg==
Date:   Fri, 7 Dec 2018 15:47:07 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Subject: linux-next: manual merge of the rcu tree with the net-next tree
Message-ID: <20181207154707.35322397@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/wPoC9+VwNm323wDY0paqyPS"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wPoC9+VwNm323wDY0paqyPS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rcu tree got conflicts in:

  net/bridge/br_mdb.c
  net/bridge/br_multicast.c

between commits:

  19e3a9c90c53 ("net: bridge: convert multicast to generic rhashtable")
  4329596cb10d ("net: bridge: multicast: use non-bh rcu flavor")

from the net-next tree and commit:

  1a56f7d53b5c ("net/bridge: Replace call_rcu_bh() and rcu_barrier_bh()")

from the rcu tree.

I fixed it up (I used the versions form net-next) and can carry the fix
as necessary. This is now fixed as far as linux-next is concerned, but
any non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/wPoC9+VwNm323wDY0paqyPS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwJ+0sACgkQAVBC80lX
0GwmZwf+Pwk/3IDVvgxuOUSXhAb61M+sIxwVknZ3PcrMzTNayld50mAO/OyzBUjA
oyop6qziWVU0TT4qH1eaogkxLIQtA2k+GGBnQr6sAu2dfPjZmuRtsdECdwx39LrD
LRWlAELLO7woL6JbTAq7gUZhZYHsg2KU7ke13YTuuC397PVxdFLIyZr1gs5GJzUc
YeTye7XYdHqRJXe1Hva7rfufJHtvtZdcsYM7T9YhWiJ749R+IN5IRPX9ZBFGtIJe
iVcuURcIgyrnq0PHODYZdgZ48YoIqcX/zB+2zoQlRu/V5dtee+ncYc9oNKsKWH7Q
AosvURxe0zpC8VCRaO6h1GLFnhGD0Q==
=PcQx
-----END PGP SIGNATURE-----

--Sig_/wPoC9+VwNm323wDY0paqyPS--
