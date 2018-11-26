Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE32C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 04:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF7A20855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 04:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="VX9Py2N4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF7A20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbeKZPc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 10:32:26 -0500
Received: from ozlabs.org ([203.11.71.1]:54779 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbeKZPc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 10:32:26 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 433Dht0Pdnz9s3C;
        Mon, 26 Nov 2018 15:39:26 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543207170;
        bh=TGwz4jyk9wheW3vbXF1li0Al3+LVO7MG++/twsmL16w=;
        h=Date:From:To:Cc:Subject:From;
        b=VX9Py2N4wI5IOgpnxj0hhoCCPcqn2XcdB0fgBlAm4Jb97gpXToL5k00We0T0SBBcv
         ZCATYJCmrKOdDGRDrX+B+5XPrMMVSzMaR1BdarNrocAiC+M1jgCHVeC1fLnYkYha7g
         n92mCqD95V96H7aUTQaQQj4w7x/iKbWMq3VM61ZQ02IzK7Ys+ebE5H+kw0C08KktC1
         KkcO84OtLzO3fCWjbARaKt3MDZShHg7ows7Hd8Fvr34ljA7tdubtvqHZQgg9hjMUBn
         HX5Q9Vck1ZOfLaDHi3TvdYxDuOBpr9Z3xhVwftiR8ETrWZeJVJN/1wAqCIosTQ+O1r
         3tEuVCoVCkv2Q==
Date:   Mon, 26 Nov 2018 15:39:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Babu Moger <Babu.Moger@amd.com>, Borislav Petkov <bp@suse.de>
Subject: linux-next: manual merge of the tip tree with the vfs tree
Message-ID: <20181126153925.3ab6b337@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3BX=4/RIDil5BdQBMqHiwwS"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3BX=4/RIDil5BdQBMqHiwwS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  arch/x86/kernel/cpu/resctrl/rdtgroup.c

between commit:

  16ec1a5d58ea ("kernfs, sysfs, cgroup, intel_rdt: Support fs_context")
(where the file is arch/x86/kernel/cpu/intel_rdt_rdtgroup.c)

from the vfs tree and commit:

  580ebb66cbb3 ("x86/resctrl: Add vendor check for the MBA software control=
ler")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 37c0ccb50823,61b102dd51a5..000000000000
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@@ -2032,88 -2065,8 +2032,91 @@@ out
  	rdt_last_cmd_clear();
  	mutex_unlock(&rdtgroup_mutex);
  	cpus_read_unlock();
 +	return ret;
 +}
 +
 +enum rdt_param {
 +	Opt_cdp,
 +	Opt_cdpl2,
 +	Opt_mba_mpbs,
 +	nr__rdt_params
 +};
 =20
 -	return dentry;
 +static const struct fs_parameter_spec rdt_param_specs[nr__rdt_params] =3D=
 {
 +	[Opt_cdp]	=3D { fs_param_is_flag },
 +	[Opt_cdpl2]	=3D { fs_param_is_flag },
 +	[Opt_mba_mpbs]	=3D { fs_param_is_flag },
 +};
 +
 +static const char *const rdt_param_keys[nr__rdt_params] =3D {
 +	[Opt_cdp]	=3D "cdp",
 +	[Opt_cdpl2]	=3D "cdpl2",
 +	[Opt_mba_mpbs]	=3D "mba_mbps",
 +};
 +
 +static const struct fs_parameter_description rdt_fs_parameters =3D {
 +	.name		=3D "rdt",
 +	.nr_params	=3D nr__rdt_params,
 +	.keys		=3D rdt_param_keys,
 +	.specs		=3D rdt_param_specs,
 +	.no_source	=3D true,
 +};
 +
 +static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *pa=
ram)
 +{
 +	struct rdt_fs_context *ctx =3D rdt_fc2context(fc);
 +	struct fs_parse_result result;
 +	int opt;
 +
 +	opt =3D fs_parse(fc, &rdt_fs_parameters, param, &result);
 +	if (opt < 0)
 +		return opt;
 +
 +	switch (opt) {
 +	case Opt_cdp:
 +		ctx->enable_cdpl3 =3D true;
 +		return 0;
 +	case Opt_cdpl2:
 +		ctx->enable_cdpl2 =3D true;
 +		return 0;
 +	case Opt_mba_mpbs:
- 		ctx->enable_mba_mbps =3D true;
- 		return 0;
++		if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL) {
++			ctx->enable_mba_mbps =3D true;
++			return 0;
++		}
++		break;
 +	}
 +
 +	return -EINVAL;
 +}
 +
 +static void rdt_fs_context_free(struct fs_context *fc)
 +{
 +	struct rdt_fs_context *ctx =3D rdt_fc2context(fc);
 +
 +	kernfs_free_fs_context(fc);
 +	kfree(ctx);
 +}
 +
 +static const struct fs_context_operations rdt_fs_context_ops =3D {
 +	.free		=3D rdt_fs_context_free,
 +	.parse_param	=3D rdt_parse_param,
 +	.get_tree	=3D rdt_get_tree,
 +};
 +
 +static int rdt_init_fs_context(struct fs_context *fc, struct dentry *refe=
rence)
 +{
 +	struct rdt_fs_context *ctx;
 +
 +	ctx =3D kzalloc(sizeof(struct rdt_fs_context), GFP_KERNEL);
 +	if (!ctx)
 +		return -ENOMEM;
 +
 +	ctx->kfc.root =3D rdt_root;
 +	ctx->kfc.magic =3D RDTGROUP_SUPER_MAGIC;
 +	fc->fs_private =3D &ctx->kfc;
 +	fc->ops =3D &rdt_fs_context_ops;
 +	return 0;
  }
 =20
  static int reset_all_ctrls(struct rdt_resource *r)

--Sig_/3BX=4/RIDil5BdQBMqHiwwS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlv7eP0ACgkQAVBC80lX
0GwLnAf+NcpW5uzfZwQwU+wzNDzQ7xS2g83eds5fNEXheWwkX2dYegLPDLOpS5V2
pk6GZ9UvAzlVfl5LG3UNHpI2A33wSyYL1Fg3JBGgQ0FE6/coAACoGtpvd2Lm7qLy
8zEYVN3YKTOXO9erKgwm//fLhExMIsHgjD5rKs1Bsh1VqW2/plzc3mL/AfRjMzSf
a9qvTv1vSUmgMHu7jxaWC8ZnpUb4sqztb7S22/LKUIF++4NZTBV1DSVCNaaQEFj2
/I/QhOXfG95C8BFUA6qXwagcv74DZ1LUlqYQw7MRX0xKlQhxW3DTAMU/W9ZglAIM
t6PSFi8oht0/d4tvahbsjIKpkBj0yg==
=dyMm
-----END PGP SIGNATURE-----

--Sig_/3BX=4/RIDil5BdQBMqHiwwS--
