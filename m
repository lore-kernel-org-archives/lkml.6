Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833EDC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 01:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E5723C29
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 01:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="IUSbAynU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39E5723C29
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934273AbeFVBxy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 21:53:54 -0400
Received: from ozlabs.org ([203.11.71.1]:57629 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934184AbeFVBxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 21:53:53 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41BhSB6ymRz9s47;
        Fri, 22 Jun 2018 11:53:46 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529632431;
        bh=VXjnn4aE2MheCsJjswlX+wktKao43Kxi2S3kX+3m0fE=;
        h=Date:From:To:Cc:Subject:From;
        b=IUSbAynU4buAGTkNkMNTP+Qyxd2rDtkKwL5hxoDrJfM2WXzF0LRitHTs1a0CCbMLs
         C0y161Px1th9H/5PZtiCkYD2pujTAwo1jDsMk4FzbSc0/jn9b3+r4VjDlbmHJULQLB
         RF1dArxrM7gxUEGQlLzF3HMUJL6QcAkggCYzWGh9MerSfw+ajL11XXTpatur2Ep5dY
         C5FKXIDujz7e+Kfq7BOHjAt0CbYvwnU8v7cQ6N962zesWJpNWYesc0mO8tctiG6Lo8
         Xi9I+iDwzXciqfTaqH8GFAaftCEJdBPMS0yiHrGNusrYi4ZPo9/rJEJ4hD7lEGq4nu
         V8p/3r4D+QblQ==
Date:   Fri, 22 Jun 2018 11:53:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: linux-next: manual merge of the tip tree with the vfs tree
Message-ID: <20180622115346.1e9cc433@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/PtLXaja3U9+9ULz58XqSlfI"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PtLXaja3U9+9ULz58XqSlfI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  arch/x86/kernel/cpu/intel_rdt_rdtgroup.c

between commit:

  58e4e43911f8 ("kernfs, sysfs, cgroup, intel_rdt: Support fs_context")

from the vfs tree and commit:

  a3dbd01e6c9d ("x86/intel_rdt: Create character device exposing pseudo-loc=
ked region")

from the tip tree.

I fixed it up (I think - see below) and can carry the fix as necessary.
This is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 38a54f56ff40,7b4a09d81a30..000000000000
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@@ -1270,9 -1861,16 +1842,15 @@@ static int rdt_get_tree(struct fs_conte
  		rdtgroup_default.mon.mon_data_kn =3D kn_mondata;
  	}
 =20
+ 	ret =3D rdt_pseudo_lock_init();
+ 	if (ret) {
+ 		dentry =3D ERR_PTR(ret);
+ 		goto out_mondata;
+ 	}
+=20
 -	dentry =3D kernfs_mount(fs_type, flags, rdt_root,
 -			      RDTGROUP_SUPER_MAGIC, NULL);
 -	if (IS_ERR(dentry))
 +	ret =3D kernfs_get_tree(fc);
 +	if (ret < 0)
- 		goto out_mondata;
+ 		goto out_psl;
 =20
  	if (rdt_alloc_capable)
  		static_branch_enable_cpuslocked(&rdt_alloc_enable_key);

--Sig_/PtLXaja3U9+9ULz58XqSlfI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlssVqoACgkQAVBC80lX
0Gxz9wf9HJ/dniTuD4KSfg5FhxNVN8J2WYddbbX0+HVTdf+qqBJb2DEJnywtETaN
2TlMKIhYfwa1rM4s9BJh+vgpGLv2HQQPMKIkvCJfRgV7u2RyagvC/gzf7fLcfwyU
Mz9hz+mZS3BmEgIi5htcDb30q0OWeIKxuxf0q6Z+QY3y0N9IS2FYRQZP1/DBDnLw
k2BDueq/gNKMh8sbBGRnjG697+EOcPwS4KfDbHxvBNbySvTkxNRWe+4GbTZA4DAd
MinhfKmG5r/NDqdHq1+AyMm1EPK364ekuoW9NgzUFVgpb5du0WueS9h0hsGLVBgJ
XB35mIaocLdgiYENlxcbLaMoeYJaAQ==
=pBJf
-----END PGP SIGNATURE-----

--Sig_/PtLXaja3U9+9ULz58XqSlfI--
