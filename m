Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A85C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 01:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9BFF2171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 01:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lyj0Kbwu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbfABBcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 20:32:33 -0500
Received: from ozlabs.org ([203.11.71.1]:49689 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727722AbfABBcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 20:32:33 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43Ttp64yPWz9s4s;
        Wed,  2 Jan 2019 12:32:30 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1546392750;
        bh=sSpolR+oWvT9liyhQcoaLchG6DPxnvZhRMUpdNNjtl8=;
        h=Date:From:To:Cc:Subject:From;
        b=lyj0Kbwue84OHOf+z1c6Ks13f/YStVS1mFQNITl4V/Y2JpN85Kn1vKnevjpCi/m3J
         8f7A0rd8ykuie9Wwi5Mgtn72S7i2Iua4SR+FWAbCLsBERnisv0/mF4M2pNjQyEVxJ0
         gc/8POx5sZpPQOoHBQEeoL9gW4fbwuCufSrj/AF+drcH3YOs9cG+1mI6oXxiBD1Sbi
         GY8SmhM9cUuzBlhG8qruBkm5HFyiiMlI4DX6+oVhN/j5Gw7XrxMAILg/frt3UAh1YB
         YVYLqiypqxfzqct0/PA0uJR0AczVLJx5vPa4LpKG0iAtHc1Iq6a0Yydt/KGV0BfkNa
         S9tmkt9dWY1gw==
Date:   Wed, 2 Jan 2019 12:32:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>, Tejun Heo <tj@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: linux-next: manual merge of the vfs tree with Linus' tree
Message-ID: <20190102123228.67892bdb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zedF5+EIlAP=nTj/6pwVMue"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zedF5+EIlAP=nTj/6pwVMue
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs tree got a conflict in:

  kernel/cgroup/cgroup-v1.c

between commit:

  3fc9c12d27b4 ("cgroup: Add named hierarchy disabling to cgroup_no_v1 boot=
 param")

from Linus' tree and commit:

  b3678086951a ("kernfs, sysfs, cgroup, intel_rdt: Support fs_context")

from the vfs tree.

Its a pity that the former commit did not appear until after the merge
window opened.  :-(

I fixed it up (I think - see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc kernel/cgroup/cgroup-v1.c
index 583b969b0c0e,4b189e821cad..000000000000
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@@ -1003,17 -968,91 +971,94 @@@ int cgroup1_parse_param(struct fs_conte
  				continue;
 =20
  			/* Mutually exclusive option 'all' + subsystem name */
- 			if (all_ss)
- 				return -EINVAL;
- 			opts->subsys_mask |=3D (1 << i);
- 			one_ss =3D true;
+ 			if (ctx->all_ss)
+ 				return cg_invalf(fc, "cgroup1: subsys name conflicts with all");
+ 			ctx->subsys_mask |=3D (1 << i);
+ 			ctx->one_ss =3D true;
+ 			return 0;
+ 		}
 =20
- 			break;
+ 		return cg_invalf(fc, "cgroup1: Unknown subsys name '%s'", param->key);
+ 	}
+ 	if (opt < 0)
+ 		return opt;
+=20
+ 	switch (opt) {
+ 	case Opt_none:
+ 		/* Explicitly have no subsystems */
+ 		ctx->none =3D true;
+ 		return 0;
+ 	case Opt_all:
+ 		/* Mutually exclusive option 'all' + subsystem name */
+ 		if (ctx->one_ss)
+ 			return cg_invalf(fc, "cgroup1: all conflicts with subsys name");
+ 		ctx->all_ss =3D true;
+ 		return 0;
+ 	case Opt_noprefix:
+ 		ctx->flags |=3D CGRP_ROOT_NOPREFIX;
+ 		return 0;
+ 	case Opt_clone_children:
+ 		ctx->cpuset_clone_children =3D true;
+ 		return 0;
+ 	case Opt_cpuset_v2_mode:
+ 		ctx->flags |=3D CGRP_ROOT_CPUSET_V2_MODE;
+ 		return 0;
+ 	case Opt_xattr:
+ 		ctx->flags |=3D CGRP_ROOT_XATTR;
+ 		return 0;
+ 	case Opt_release_agent:
+ 		/* Specifying two release agents is forbidden */
+ 		if (ctx->release_agent)
+ 			return cg_invalf(fc, "cgroup1: release_agent respecified");
+ 		ctx->release_agent =3D param->string;
+ 		param->string =3D NULL;
+ 		if (!ctx->release_agent)
+ 			return -ENOMEM;
+ 		return 0;
+=20
+ 	case Opt_name:
++		/* blocked by boot param? */
++		if (cgroup_no_v1_named)
++			return cg_invalf(fc, "cgroup1: Blocked by boot paramter");
+ 		/* Can't specify an empty name */
+ 		if (!param->size)
+ 			return cg_invalf(fc, "cgroup1: Empty name");
+ 		if (param->size > MAX_CGROUP_ROOT_NAMELEN - 1)
+ 			return cg_invalf(fc, "cgroup1: Name too long");
+ 		/* Must match [\w.-]+ */
+ 		for (i =3D 0; i < param->size; i++) {
+ 			char c =3D param->string[i];
+ 			if (isalnum(c))
+ 				continue;
+ 			if ((c =3D=3D '.') || (c =3D=3D '-') || (c =3D=3D '_'))
+ 				continue;
+ 			return cg_invalf(fc, "cgroup1: Invalid name");
  		}
- 		if (i =3D=3D CGROUP_SUBSYS_COUNT)
- 			return -ENOENT;
+ 		/* Specifying two names is forbidden */
+ 		if (ctx->name)
+ 			return cg_invalf(fc, "cgroup1: name respecified");
+ 		ctx->name =3D param->string;
+ 		param->string =3D NULL;
+ 		return 0;
  	}
 =20
+ 	return 0;
+ }
+=20
+ /*
+  * Validate the options that have been parsed.
+  */
+ static int cgroup1_validate(struct fs_context *fc)
+ {
+ 	struct cgroup_fs_context *ctx =3D cgroup_fc2context(fc);
+ 	struct cgroup_subsys *ss;
+ 	u16 mask =3D U16_MAX;
+ 	int i;
+=20
+ #ifdef CONFIG_CPUSETS
+ 	mask =3D ~((u16)1 << cpuset_cgrp_id);
+ #endif
+=20
  	/*
  	 * If the 'all' option was specified select all the subsystems,
  	 * otherwise if 'none', 'name=3D' and a subsystem name options were

--Sig_/zedF5+EIlAP=nTj/6pwVMue
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwsFK0ACgkQAVBC80lX
0GwL1gf/YL0Zs2VpoNeGXBa0AZRHyBhFgryB8xqqAJxONLiSBL6wkuLRwMYrWv/5
SITPBcMrhDwqOXynao3yPet/PQBKE5axMksQhpt0V+3qRvp5s2mfZ6+e+6ktX2gC
pCcCjtMlnLaYQ2Oj5ycWnRX5IcYDid38pLtL47kvQ9aMSYObuGR3VLBbHQsecqmM
/buHqnemsztayerpoUztLRfNH64/6bAYchb9TYwJd8//fmVNzCas7fgqPVvfuM92
tVQgGjje5xbRHqMReqQt7ZG8Lh+g+FsH9vDUHoSVQ6/JynkJC83eroq1KTF1eevd
AGNSWadWjCMUvW/9yhISA3y72PlsFw==
=QdGV
-----END PGP SIGNATURE-----

--Sig_/zedF5+EIlAP=nTj/6pwVMue--
