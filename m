Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AA9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E7D2075B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="UowJ0QHn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E7D2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390604AbeKVKNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 05:13:00 -0500
Received: from ozlabs.org ([203.11.71.1]:54473 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387897AbeKVKM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 05:12:59 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 430f933hgcz9s1x;
        Thu, 22 Nov 2018 10:36:23 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1542843384;
        bh=5aPsJOg4kc4mpkHHUvuassOUT30bqZKJ+d8WsbBiPQo=;
        h=Date:From:To:Cc:Subject:From;
        b=UowJ0QHnZ23UuwnFP/dFWTHTZjVyMgGfriqOgzh8Cqv/iBzoNlQpkLZ/lLqcFKLfV
         RSwUk0guHRq6IQNkgU0uTdQwcwTG3CD4DBdpzNsKwEnMmQpmwkD+vh2LPunoaZeCq0
         tyW7xPRxf5H4kXL2gugwJ2XfLGxc0QyNyTs9Fng1KmhqCdcnkLiKY6UpoZ54HyTjZd
         NjG10E53w7D+AGOUUE2VQnFdmrIZO80XWcm2Lchl8f9+WQh6DTGfeDi94aAYnzIFcY
         kOFoNPTY/Wk3PvJ/c8FlBCqtXaIn9JO5vgRhYlC/UVZoiW90RB2538Gb5G7lxiEZ3t
         X4AVfcb9WdXDw==
Date:   Thu, 22 Nov 2018 10:36:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Nikita V. Shirokov" <tehnerd@tehnerd.com>
Subject: linux-next: manual merge of the bpf-next tree with the net-next
 tree
Message-ID: <20181122103621.548afe8b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/e8HMKaQm.7cH_t+OJtiBLs_"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/e8HMKaQm.7cH_t+OJtiBLs_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  tools/testing/selftests/bpf/Makefile

between commit:

  bd8e1afe6436 ("selftests: add dummy xdp test helper")

from the net-next tree and commit:

  b1957c92eba5 ("bpf: adding tests for map_in_map helpber in libbpf")

from the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc tools/testing/selftests/bpf/Makefile
index 4a54236475ae,43157bd89165..000000000000
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@@ -38,7 -39,7 +39,7 @@@ TEST_GEN_FILES =3D test_pkt_access.o test
  	get_cgroup_id_kern.o socket_cookie_prog.o test_select_reuseport_kern.o \
  	test_skb_cgroup_id_kern.o bpf_flow.o netcnt_prog.o \
  	test_sk_lookup_kern.o test_xdp_vlan.o test_queue_map.o test_stack_map.o \
- 	xdp_dummy.o
 -	test_map_in_map.o
++	xdp_dummy.o test_map_in_map.o
 =20
  # Order correspond to 'make run_tests' order
  TEST_PROGS :=3D test_kmod.sh \

--Sig_/e8HMKaQm.7cH_t+OJtiBLs_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlv16/UACgkQAVBC80lX
0Gxa4gf+PIzgBvnF/4pwqCduKBz1GItnzqRVlfZ1JyY7Pw3WrsswhbXRBZwoxdFs
USHhhVx6tbyqGn/OeJ66B+xxuya+43gT4mlmvy/q/jykMvtP/TgWZim+w0av/PCq
dRGtptLYQRqoV92TXHfo0dkT1pwrVmo2vNYDh9m060i+lmoJu6ZrgeUpfNsbyP2V
r2sM9q3JuzSrR3433YyCgD6yDwTqhDIOBzb7V4HJMJuhn7QkWgFIMVFkGJQkSl1k
lNmB3g8WgqkEWgj2ZvvJSbgjq6a1fwNDDIQOCtZiAELVH5Ar7LjoOxk3sa/f4OSk
+RnooyQ4Me3GIuBQ3HtFrQ6JGv0qSw==
=3Xy3
-----END PGP SIGNATURE-----

--Sig_/e8HMKaQm.7cH_t+OJtiBLs_--
