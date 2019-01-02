Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A4CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 01:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC440208E3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 01:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rOKuriyF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbfABB40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 20:56:26 -0500
Received: from ozlabs.org ([203.11.71.1]:48031 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728094AbfABB40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 20:56:26 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43TvKb4vDQz9s4s;
        Wed,  2 Jan 2019 12:56:19 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1546394182;
        bh=3HglAxicMKB1x3BmLygz2Y+G8/xJL+dWQZ0YmRROdSI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rOKuriyFWUtz/2jgVv6XdZgsRNomiJcFnZBt76NwId0jtzQeUReOdpCFtkDVu8K0D
         HlemOwnAPTCQtmhSIIliuz0Lrh/9oJWkpIX8Xllvnrjp/juUzxVmdN1CJn/1q4q6gD
         DKMgiulTO4m/RdPX0dz05wkq8hdq8mKV7Q/WCRhF7gOVilnbAjDfYCkN8m1QKYiRm6
         91n9Fep9YKQeqsmGw3SPm0voHQcakfr+Le+JKEOFi81Wgd5L9cvnpX83Qc8ZG4E6ry
         7SayBftWdkb1Lq7JPUzcQcH6qNc4xDe9OFEl+Fei+pTBrTw5eQOsNSo3sMuTkauf4u
         EVDDr3WEm96Lg==
Date:   Wed, 2 Jan 2019 12:56:19 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Babu Moger <Babu.Moger@amd.com>, Borislav Petkov <bp@suse.de>
Subject: Re: linux-next: manual merge of the tip tree with the vfs tree
Message-ID: <20190102125619.32ee905d@canb.auug.org.au>
In-Reply-To: <20181126153925.3ab6b337@canb.auug.org.au>
References: <20181126153925.3ab6b337@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/IOa/WoZ2FKvyn2CGnIFnTQ1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IOa/WoZ2FKvyn2CGnIFnTQ1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 26 Nov 2018 15:39:25 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the tip tree got a conflict in:
>=20
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c
>=20
> between commit:
>=20
>   16ec1a5d58ea ("kernfs, sysfs, cgroup, intel_rdt: Support fs_context")
> (where the file is arch/x86/kernel/cpu/intel_rdt_rdtgroup.c)
>=20
> from the vfs tree and commit:
>=20
>   580ebb66cbb3 ("x86/resctrl: Add vendor check for the MBA software contr=
oller")
>=20
> from the tip tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 37c0ccb50823,61b102dd51a5..000000000000
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@@ -2032,88 -2065,8 +2032,91 @@@ out
>   	rdt_last_cmd_clear();
>   	mutex_unlock(&rdtgroup_mutex);
>   	cpus_read_unlock();
>  +	return ret;
>  +}
>  +
>  +enum rdt_param {
>  +	Opt_cdp,
>  +	Opt_cdpl2,
>  +	Opt_mba_mpbs,
>  +	nr__rdt_params
>  +};
>  =20
>  -	return dentry;
>  +static const struct fs_parameter_spec rdt_param_specs[nr__rdt_params] =
=3D {
>  +	[Opt_cdp]	=3D { fs_param_is_flag },
>  +	[Opt_cdpl2]	=3D { fs_param_is_flag },
>  +	[Opt_mba_mpbs]	=3D { fs_param_is_flag },
>  +};
>  +
>  +static const char *const rdt_param_keys[nr__rdt_params] =3D {
>  +	[Opt_cdp]	=3D "cdp",
>  +	[Opt_cdpl2]	=3D "cdpl2",
>  +	[Opt_mba_mpbs]	=3D "mba_mbps",
>  +};
>  +
>  +static const struct fs_parameter_description rdt_fs_parameters =3D {
>  +	.name		=3D "rdt",
>  +	.nr_params	=3D nr__rdt_params,
>  +	.keys		=3D rdt_param_keys,
>  +	.specs		=3D rdt_param_specs,
>  +	.no_source	=3D true,
>  +};
>  +
>  +static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *=
param)
>  +{
>  +	struct rdt_fs_context *ctx =3D rdt_fc2context(fc);
>  +	struct fs_parse_result result;
>  +	int opt;
>  +
>  +	opt =3D fs_parse(fc, &rdt_fs_parameters, param, &result);
>  +	if (opt < 0)
>  +		return opt;
>  +
>  +	switch (opt) {
>  +	case Opt_cdp:
>  +		ctx->enable_cdpl3 =3D true;
>  +		return 0;
>  +	case Opt_cdpl2:
>  +		ctx->enable_cdpl2 =3D true;
>  +		return 0;
>  +	case Opt_mba_mpbs:
> - 		ctx->enable_mba_mbps =3D true;
> - 		return 0;
> ++		if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL) {
> ++			ctx->enable_mba_mbps =3D true;
> ++			return 0;
> ++		}
> ++		break;
>  +	}
>  +
>  +	return -EINVAL;
>  +}
>  +
>  +static void rdt_fs_context_free(struct fs_context *fc)
>  +{
>  +	struct rdt_fs_context *ctx =3D rdt_fc2context(fc);
>  +
>  +	kernfs_free_fs_context(fc);
>  +	kfree(ctx);
>  +}
>  +
>  +static const struct fs_context_operations rdt_fs_context_ops =3D {
>  +	.free		=3D rdt_fs_context_free,
>  +	.parse_param	=3D rdt_parse_param,
>  +	.get_tree	=3D rdt_get_tree,
>  +};
>  +
>  +static int rdt_init_fs_context(struct fs_context *fc, struct dentry *re=
ference)
>  +{
>  +	struct rdt_fs_context *ctx;
>  +
>  +	ctx =3D kzalloc(sizeof(struct rdt_fs_context), GFP_KERNEL);
>  +	if (!ctx)
>  +		return -ENOMEM;
>  +
>  +	ctx->kfc.root =3D rdt_root;
>  +	ctx->kfc.magic =3D RDTGROUP_SUPER_MAGIC;
>  +	fc->fs_private =3D &ctx->kfc;
>  +	fc->ops =3D &rdt_fs_context_ops;
>  +	return 0;
>   }
>  =20
>   static int reset_all_ctrls(struct rdt_resource *r)

This is now a conflict between Linus' tree and the vfs tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/IOa/WoZ2FKvyn2CGnIFnTQ1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwsGkMACgkQAVBC80lX
0GzovAf+OEju+9rxphuvCQZVgGIZJmRnq+w2GQxPttBlvk/iqMo/j9RKn1npVxEe
X4F0nNSxPtxbJ/N6QMF7Wco5aMHfXqKsFylBmrfkJS1N2XV+JwMVrBU/1ywQgk4+
c9CJYl0BEL+J1VvL7XWD7BKSN/x48n/ifyaRu8RDpP9tMi19tNbzQP4c1GlBXJvY
nNwb+Yzm3Z4xgW6lk8jaTMwZW38N8aQ0tLDGi6Txxkn3h8QLyoM06S4NQSasUNlp
5YqhMoepQbL4rwu5ahEyGStRK59bhDESBZllkEynSZDNoHCtNMenacyz2rzTHTZF
bMeBRNU719jJNs98KHozKcq36VNZ6A==
=2GVt
-----END PGP SIGNATURE-----

--Sig_/IOa/WoZ2FKvyn2CGnIFnTQ1--
