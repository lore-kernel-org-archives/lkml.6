Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E569EC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9995D2083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WgwUo3Sd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9995D2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755883AbeFSGgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 02:36:37 -0400
Received: from ozlabs.org ([203.11.71.1]:47647 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750736AbeFSGgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 02:36:35 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 418yss2rNPz9s1R;
        Tue, 19 Jun 2018 16:36:33 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529390193;
        bh=UFb05F0vMAh9S4LDF8KXiIuar7iKlishUhBYJTxy5Js=;
        h=Date:From:To:Cc:Subject:From;
        b=WgwUo3SdEQ9Tlp4OBH7gnJdHtC3NpDETzAKbh0RqJXOPQbmOnKywa0ahqbJOweWvj
         CHw59Ag0z1r/4QxZr6DRgEoP156m+miJmjD1Uqg48tk4Ir5zn1SsyXAKDfaR879aHp
         VZkhgxevseiBJG3XOwpU85P9YmpPy6vrzqBkiQZSNENWOuNf3gYcQTmqHc9nstKymt
         RP34G1cy4W3cVhvJN/91mdUKQYeeiPcRUPBgRBwmn44fPayQkWDTPDlwnkV/qyEVpD
         tn02xp27FK8trsHDfSNYQtMMgM7ZCTUgeruTssxCXkQ18VZT8YSqwwZIJagTOn9QRZ
         9MyrevYqmZBbQ==
Date:   Tue, 19 Jun 2018 16:36:32 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Roman Gushchin <guro@fb.com>
Subject: linux-next: manual merge of the akpm-current tree with the vfs tree
Message-ID: <20180619163632.42ac1ae5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/K=qe0EjkZgqvclx5/Tu7eMK"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/K=qe0EjkZgqvclx5/Tu7eMK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  kernel/cgroup/cgroup.c

between commit:

  58e4e43911f8 ("kernfs, sysfs, cgroup, intel_rdt: Support fs_context")

from the vfs tree and commit:

  dbe8cec5a8a3 ("mm, oom: add cgroup v2 mount option for cgroup-aware OOM k=
iller")

from the akpm-current tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc kernel/cgroup/cgroup.c
index 33a11d941d11,de25822590d0..000000000000
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@@ -1734,23 -1734,28 +1734,30 @@@ int cgroup_show_path(struct seq_file *s
  	return len;
  }
 =20
 -static int parse_cgroup_root_flags(char *data, unsigned int *root_flags)
 +static int cgroup2_parse_option(struct fs_context *fc, char *token)
  {
 -	char *token;
 +	struct cgroup_fs_context *ctx =3D cgroup_fc2context(fc);
 =20
 -	*root_flags =3D 0;
 -
 -	if (!data)
 +	if (!strcmp(token, "nsdelegate")) {
 +		ctx->flags |=3D CGRP_ROOT_NS_DELEGATE;
 +		return 0;
 +	}
++	if (!strcmp(token, "groupoom")) {
++		ctx->flags |=3D CGRP_GROUP_OOM;
+ 		return 0;
++	}
 =20
 -	while ((token =3D strsep(&data, ",")) !=3D NULL) {
 -		if (!strcmp(token, "nsdelegate")) {
 -			*root_flags |=3D CGRP_ROOT_NS_DELEGATE;
 -			continue;
 -		} else if (!strcmp(token, "groupoom")) {
 -			*root_flags |=3D CGRP_GROUP_OOM;
 -			continue;
 -		}
 +	return -EINVAL;
 +}
 =20
 -		pr_err("cgroup2: unknown option \"%s\"\n", token);
 -		return -EINVAL;
 +static int cgroup_show_options(struct seq_file *seq, struct kernfs_root *=
kf_root)
 +{
- 	if (current->nsproxy->cgroup_ns =3D=3D &init_cgroup_ns &&
- 	    cgrp_dfl_root.flags & CGRP_ROOT_NS_DELEGATE)
- 		seq_puts(seq, ",nsdelegate");
++	if (current->nsproxy->cgroup_ns =3D=3D &init_cgroup_ns) {
++		if (cgrp_dfl_root.flags & CGRP_ROOT_NS_DELEGATE)
++			seq_puts(seq, ",nsdelegate");
++		if (cgrp_dfl_root.flags & CGRP_GROUP_OOM)
++			seq_puts(seq, ",groupoom");
+ 	}
 -
  	return 0;
  }
 =20

--Sig_/K=qe0EjkZgqvclx5/Tu7eMK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsopHAACgkQAVBC80lX
0GxoxQf8CGNCAoRCwOUnaH803iUFa0VRIzffQeqLCBplgkoGAKlGy9qxt6uZkcUK
fRac+A0if+dxpLoFvQMYpcXZAjXhvrIqhGXPiT7yesig+iKJBrgcbcwaLD+kw2kC
Iil6p7NqrUJWVLDBqH/476Jk+kmAQVtu2mjYUQuejIzTS35lOdrxb9tx6sb5HRgZ
mY071Vd+XpKgOyGdjNCXiJky/THTgeUfAPWXIaQqwupjjCEX81U6Hcnttbo5Ls5O
INUrItJ5DS2MrSDAYeotZ+q23v2fE+sa6LSKqBglWmpCaUq11zZNOsN7d2amOtEp
XrpdLgWvMDsjdGsCri3XitYi+2ERXQ==
=XHK3
-----END PGP SIGNATURE-----

--Sig_/K=qe0EjkZgqvclx5/Tu7eMK--
