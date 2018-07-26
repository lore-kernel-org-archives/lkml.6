Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292EFC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3BDB20882
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="UosbZSuO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3BDB20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbeGZCdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 22:33:39 -0400
Received: from ozlabs.org ([203.11.71.1]:41653 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728411AbeGZCdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 22:33:39 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41bZ4h6vMXz9s0R;
        Thu, 26 Jul 2018 11:19:16 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532567957;
        bh=5HMG5738ZeX7NGsQqoLEV+FoUWOfqwPLTEvQ+sXLPw8=;
        h=Date:From:To:Cc:Subject:From;
        b=UosbZSuOe26XvKFQL6huhZc7YlMkKCve83zmaez3KMB3CK6Du3fujguDaarTsrn81
         YMmSfpPMtMMrN1ONC+QuI7XdR0yDL0pT6GwnK7kkMVm/S/RRRm6T9EBR9sULvOG3UB
         aP1cNGFz4qg3f6LrVIpK/jP2Y4dSGctrRSH4S6g9XH0fE+NU4ZlO0XCkbumae3JsUo
         JNmhnNtHpKigQdxpI7fcXh+hoNWzXbI7KDQARWNTccBjGKd80wCyuYnjnnaFutYJum
         sAbZCnKZ/FTGcBEyNUyGaETOoOyblKwgsfBnnPCPMDoFUhCB0n6LwaOSflTxtGkHfn
         WlfabaLdtg5yg==
Date:   Thu, 26 Jul 2018 11:19:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Okash Khawaja <osk@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
Subject: linux-next: manual merge of the net-next tree with the bpf tree
Message-ID: <20180726111916.47a47dbf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/KrEKTqefwe2s5mJCS828dQR"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KrEKTqefwe2s5mJCS828dQR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got conflicts in:

  tools/lib/bpf/btf.c
  tools/lib/bpf/btf.h

between commits:

  5b891af7fca1 ("bpf: Replace [u]int32_t and [u]int64_t in libbpf")
  38d5d3b3d5db ("bpf: Introduce BPF_ANNOTATE_KV_PAIR")

from the bpf tree and commit:

  92b57121ca79 ("bpf: btf: export btf types and name by offset from lib")

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

diff --cc tools/lib/bpf/btf.c
index 2d270c560df3,03161be094b4..000000000000
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@@ -269,9 -259,29 +266,29 @@@ __s64 btf__resolve_size(const struct bt
  	return nelems * size;
  }
 =20
+ int btf__resolve_type(const struct btf *btf, __u32 type_id)
+ {
+ 	const struct btf_type *t;
+ 	int depth =3D 0;
+=20
+ 	t =3D btf__type_by_id(btf, type_id);
+ 	while (depth < MAX_RESOLVE_DEPTH &&
+ 	       !btf_type_is_void_or_null(t) &&
+ 	       IS_MODIFIER(BTF_INFO_KIND(t->info))) {
+ 		type_id =3D t->type;
+ 		t =3D btf__type_by_id(btf, type_id);
+ 		depth++;
+ 	}
+=20
+ 	if (depth =3D=3D MAX_RESOLVE_DEPTH || btf_type_is_void_or_null(t))
+ 		return -EINVAL;
+=20
+ 	return type_id;
+ }
+=20
 -int32_t btf__find_by_name(const struct btf *btf, const char *type_name)
 +__s32 btf__find_by_name(const struct btf *btf, const char *type_name)
  {
 -	uint32_t i;
 +	__u32 i;
 =20
  	if (!strcmp(type_name, "void"))
  		return 0;
@@@ -368,3 -379,20 +385,11 @@@ int btf__fd(const struct btf *btf
  {
  	return btf->fd;
  }
+=20
+ const char *btf__name_by_offset(const struct btf *btf, __u32 offset)
+ {
+ 	if (offset < btf->hdr->str_len)
+ 		return &btf->strings[offset];
+ 	else
+ 		return NULL;
+ }
 -
 -const struct btf_type *btf__type_by_id(const struct btf *btf,
 -				       __u32 type_id)
 -{
 -	if (type_id > btf->nr_types)
 -		return NULL;
 -
 -	return btf->types[type_id];
 -}
diff --cc tools/lib/bpf/btf.h
index e2a09a155f84,24f361d99a5e..000000000000
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@@ -15,10 -14,12 +15,12 @@@ typedef int (*btf_print_fn_t)(const cha
  	__attribute__((format(printf, 1, 2)));
 =20
  void btf__free(struct btf *btf);
 -struct btf *btf__new(uint8_t *data, uint32_t size, btf_print_fn_t err_log=
);
 -int32_t btf__find_by_name(const struct btf *btf, const char *type_name);
 -int64_t btf__resolve_size(const struct btf *btf, uint32_t type_id);
 +struct btf *btf__new(__u8 *data, __u32 size, btf_print_fn_t err_log);
 +__s32 btf__find_by_name(const struct btf *btf, const char *type_name);
- const struct btf_type *btf__type_by_id(const struct btf *btf, __u32 id);
 +__s64 btf__resolve_size(const struct btf *btf, __u32 type_id);
+ int btf__resolve_type(const struct btf *btf, __u32 type_id);
  int btf__fd(const struct btf *btf);
+ const char *btf__name_by_offset(const struct btf *btf, __u32 offset);
+ const struct btf_type *btf__type_by_id(const struct btf *btf, __u32 type_=
id);
 =20
  #endif

--Sig_/KrEKTqefwe2s5mJCS828dQR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltZIZQACgkQAVBC80lX
0Gx0agf/UmZXN8ro9LhVhmTDM8faWIx69l5Rhgsf2z2vELLgPnouZKt48qRhi8DY
PW4iu2lj02sTqS36hVAdvUrBi8o93viDenHpWTIQZmhRpf3LOhOpG2iVn2+dAjT3
/dnbXL8wv2bbUBlAmTgMvhzVRDus3pGiHBC1DmAhYJZEsxds52GvjTKBmz7OaogE
nLj1BUGEfkVzVs1TzCX4luhDQ7BU/61KbPktTVAMMfWXsIBjMcuNIzZM7cO4tDvc
CPOGyOzHLwtnZAxGUIdWmqkZF+YAnhUdySZcy50mvkk9cK36Cb8/mxBvjr7LvSYB
6NfUKtDTloFK+0CTumLxb5BZWC6N2w==
=yCKs
-----END PGP SIGNATURE-----

--Sig_/KrEKTqefwe2s5mJCS828dQR--
