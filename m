Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FA7C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 03:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12BC20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 03:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="f+vmQsGG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A12BC20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754303AbeFTDbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 23:31:10 -0400
Received: from ozlabs.org ([203.11.71.1]:35497 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753906AbeFTDbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 23:31:08 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 419VjR0HcMz9s4v;
        Wed, 20 Jun 2018 13:31:06 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529465467;
        bh=fkNOO49MQAVBYp0GabtUDP7xh2DtQX+sblfCmIGGLvk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f+vmQsGG05oVnIU2XOhELIXdpFIkxXm8L/bi3MgY4Lw+Irf2cxJNMI93WmrZh+HmF
         7N7JP0NKmfr83nJG/ApQV+NI1EXlEz17nL1JmdmNR1Jq9tUIytLfaCwoLGg7PxuZaJ
         mj2qm0MUILQptL1RaiskmCO32iQS5aoUxysBub/UO6V1cSszGK8vZ1KG3CWKpkHKkN
         haVLTiruP+H21g2AG0oCLfc5U04JOVd84T/670sv9Nm7zg3B510fpvggbcQHwx4hIa
         AaQqZDFEu3tyyStwxS9jgsqzJZPAvQjIBNM1vDTkszBVrwnuSLxVrUS7o1H7GY2akg
         +R7xZAEJSqg9g==
Date:   Wed, 20 Jun 2018 13:31:06 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: linux-next: manual merge of the userns tree with the vfs tree
Message-ID: <20180620133106.7d71897a@canb.auug.org.au>
In-Reply-To: <20180620114441.285f5dfa@canb.auug.org.au>
References: <20180620114441.285f5dfa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/f=cgb/d5A/o9FV+=IlwwX6d"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/f=cgb/d5A/o9FV+=IlwwX6d
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 20 Jun 2018 11:44:41 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the userns tree got a conflict in:
>=20
>   fs/proc/internal.h
>=20
> between commit:
>=20
>   0223e0999be2 ("procfs: Move proc_fill_super() to fs/proc/root.c")
>=20
> from the vfs tree and commit:
>=20
>   04035aa33a12 ("proc: Don't change mount options on remount failure.")
>=20
> from the userns tree.
>=20
> diff --cc fs/proc/internal.h
> index ea8c5468eafc,69fa8d953cde..000000000000
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@@ -270,10 -252,16 +270,15 @@@ static inline void proc_tty_init(void)=20
>   /*
>    * root.c
>    */
> + struct proc_mount_options {
> + 	kgid_t pid_gid;
> + 	int hide_pid;
> + };
> +=20
>   extern struct proc_dir_entry proc_root;
>  -extern int proc_parse_options(char *options, struct proc_mount_options =
*opts);
>  =20
>   extern void proc_self_init(void);
>  -extern int proc_remount(struct super_block *, int *, char *);
>  +extern int proc_reconfigure(struct super_block *, struct fs_context *);
>  =20
>   /*
>    * task_[no]mmu.c

The struct proc_mount_options was removed by my later merge resolution.

--=20
Cheers,
Stephen Rothwell

--Sig_/f=cgb/d5A/o9FV+=IlwwX6d
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlspynoACgkQAVBC80lX
0GwkRQf/cIck6KaSZ5ZDw/E5HhZgFpsk00RhAgPtM2cs19faMnp6P3LUNI0ynVGm
sfZUnRWL3D5iyDJab7DCCqSbHod4cnkmi9VTHEHyEANX9ayfedsYICG+BSgm8nTW
lX79gNDxTr79gacwnaJ2H/BcnUztIUemBAaeZy0XDPvPS75Q1HGaLWIkozJqErIR
fONXwHAKxGzpeUSQJyXe3wFk1gupfoFLwWE49+RVs2ntfscjmMqAZ6zy3HXyApKH
oiL+PUNbcuc6A07QxWr9u0tdR87945QPae4Y3lAeL1oOqBF6v4IOtxDLx3Oxre29
kybGDAvErjL2f3uIspxlUgb71mgoow==
=KVfB
-----END PGP SIGNATURE-----

--Sig_/f=cgb/d5A/o9FV+=IlwwX6d--
