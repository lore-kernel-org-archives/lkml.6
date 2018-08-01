Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4537C43142
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 01:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5380820894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 01:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lZA3diMx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5380820894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732962AbeHADSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 23:18:16 -0400
Received: from ozlabs.org ([203.11.71.1]:48027 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732855AbeHADSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 23:18:15 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41gG8F319Gz9s0R;
        Wed,  1 Aug 2018 11:35:09 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533087309;
        bh=STnLippQ4FM+5xbFYhdBKi2vNAfwjIgv7R7wC3st4Fw=;
        h=Date:From:To:Cc:Subject:From;
        b=lZA3diMxOlBiHlyQSFAWLcINW/SuhSCd79qVNrHxaVgULIhrPRE3jkDYN463RWEpI
         1oap2kGGjIYM8beCu3B3K0al3KA+kHA31beq3wMz1rmr5ThW41wEODpH6FV2kUxcEu
         ypigcHCJ82YTdy3S2O7riVU5j1BSCyXTRwyxKYUQlJo4GFpBX6/hhGCo7xE1mtOhtL
         7Ghaby1Z7awX913/A4Txg0jOc3oJwONfGdFuUQ3xkCWKXIQANzWqcHTtq96L04v9SP
         ir9a3Lv2cW/GcA/nAEVtp+aR/fMQXEtc5jCSf407OGFSVfqCrZbcJnirEVyr4u0Ehq
         +tCks4dHsAmfg==
Date:   Wed, 1 Aug 2018 11:35:08 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>, Okash Khawaja <osk@fb.com>
Subject: linux-next: manual merge of the net-next tree with the bpf tree
Message-ID: <20180801113508.54323706@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/6_.gedhC4A+UgcVCzLtjUyh"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6_.gedhC4A+UgcVCzLtjUyh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  tools/bpf/bpftool/map.c

between commit:

  573b3aa69406 ("tools/bpftool: fix a percpu_array map dump problem")

from the bpf tree and commit:

  2d3feca8c44f ("bpf: btf: print map dump and lookup with btf info")

from the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc tools/bpf/bpftool/map.c
index f74a8bcbda87,9c8191845585..000000000000
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@@ -34,9 -34,7 +34,8 @@@
  #include <assert.h>
  #include <errno.h>
  #include <fcntl.h>
 +#include <linux/kernel.h>
+ #include <linux/err.h>
  #include <stdbool.h>
  #include <stdio.h>
  #include <stdlib.h>
@@@ -162,11 -262,20 +264,21 @@@ static void print_entry_json(struct bpf
  		print_hex_data_json(key, info->key_size);
  		jsonw_name(json_wtr, "value");
  		print_hex_data_json(value, info->value_size);
+ 		if (btf) {
+ 			struct btf_dumper d =3D {
+ 				.btf =3D btf,
+ 				.jw =3D json_wtr,
+ 				.is_plain_text =3D false,
+ 			};
+=20
+ 			jsonw_name(json_wtr, "formatted");
+ 			do_dump_btf(&d, info, key, value);
+ 		}
  	} else {
 -		unsigned int i, n;
 +		unsigned int i, n, step;
 =20
  		n =3D get_possible_cpus();
 +		step =3D round_up(info->value_size, 8);
 =20
  		jsonw_name(json_wtr, "key");
  		print_hex_data_json(key, info->key_size);

--Sig_/6_.gedhC4A+UgcVCzLtjUyh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlthDkwACgkQAVBC80lX
0Gznegf/QzA4G36j7kLiJwsq0+f+eYGEMMl/tf4RTiHRPSbWZPvpyDMPXrF+oFDM
Jx9smZVtD96s9MJUgt8lW4Et9HS9rOeVGSzUHUfdnvnR2pQ+YkcOjHOFV43++LtA
Tm6GfV3n9U0/nZ41CY4Sz/SBsAA+DkygTDv4dDw8ZHlyO3CAbocgT8hwvEfTR0+v
3zRAwwrlgnWxlAtZ4si90Ot6e6IcKizcfM2mCRsOI4nJMkkjSeDjAE9HEBAPtniw
ekfdwK45J1PxIWq6TTDzvk8GJ+AnsFXZPIWG+5Lx5SCcrTiR2obU62j8G/p+fJn3
xd+g+0NkA11+5AVKenpeNc1H4FKBKA==
=Ex7n
-----END PGP SIGNATURE-----

--Sig_/6_.gedhC4A+UgcVCzLtjUyh--
