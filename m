Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABA5C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 00:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD14208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 00:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QTTwpFSg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FD14208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbeJPIEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 04:04:52 -0400
Received: from ozlabs.org ([203.11.71.1]:46285 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbeJPIEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 04:04:52 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42YwqD5VjKz9s8F;
        Tue, 16 Oct 2018 11:17:12 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539649032;
        bh=oFKsLW5BNsPup1g1EwOThfA1LOvt3a3NeWjSa/1NZ38=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QTTwpFSguKSux2vlF8XgiqXfZfovIrmtWXdsDYLoMXTs40qweyoFw91Q39EfYuAs6
         zyzqGePUkUQqbHs6ggEOItUabzIc1hIOk47gVkk/7c6Pw8y/L3Iy2mdCvBvxlfWUhY
         6GQ4HYjiRxditMnWVWxL+wInePEkDRNzNoO780tcABohJyrKIFRKHKg9vJ2SLwj6Lp
         LrzjHWHhVkCdUM7pmJWlWiInKNkZnH2F2CBXjTWx9GM04GuzsVmK3NAArbzlMPKiK8
         lxLkhNzx7w9T2geSjGe8Ru+C0idUUuPE0F6+eE+Fhz8S0jQYkNk3Y4yMaHPp7GxRC0
         f6SE8qpDp4SJA==
Date:   Tue, 16 Oct 2018 11:17:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Daniel Rosenberg <drosen@google.com>
Subject: Re: linux-next: build failure after merge of the vfs tree
Message-ID: <20181016111712.33f9dc2e@canb.auug.org.au>
In-Reply-To: <20181003103222.6e1655cd@canb.auug.org.au>
References: <20181003103222.6e1655cd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/TEftn5M8Uq_Tz9EbmG0X=IY"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TEftn5M8Uq_Tz9EbmG0X=IY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 3 Oct 2018 10:32:22 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> After merging the vfs tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
>=20
> /home/sfr/next/next/fs/f2fs/super.c: In function 'f2fs_remount':
> /home/sfr/next/next/fs/f2fs/super.c:1589:16: error: 'MS_RDONLY' undeclare=
d (first use in this function); did you mean 'IS_RDONLY'?
>   if ((*flags & MS_RDONLY) && test_opt(sbi, DISABLE_CHECKPOINT)) {
>                 ^~~~~~~~~
>                 IS_RDONLY
>=20
> Caused by commit
>=20
>   dcf8001d292b ("vfs: Suppress MS_* flag defs within the kernel unless ex=
plicitly enabled")
>=20
> interacting with commit
>=20
>   f80f781514ef ("f2fs: checkpoint disabling")
>=20
> from the f2fs tree.
>=20
> I have added the following merge fix patch for today.  If it is correct,
> I assume that it could be applied to f2fs tree as the the other uses of
> MS_RDONLY have already been changed to SB_RDONLY.  (There is another
> use of MS_READONLY in this function that is already cleaned up in the
> vfs tree commit.)

Can this be applied to the f2fs tree?

> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Wed, 3 Oct 2018 10:27:04 +1000
> Subject: [PATCH] f2fs: update for MS_* flags mostly going away
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  fs/f2fs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 6ed77589ff2b..b612a9e4a35e 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1586,7 +1586,7 @@ static int f2fs_remount(struct super_block *sb, int=
 *flags,
>  		goto restore_opts;
>  	}
> =20
> -	if ((*flags & MS_RDONLY) && test_opt(sbi, DISABLE_CHECKPOINT)) {
> +	if ((*flags & SB_RDONLY) && test_opt(sbi, DISABLE_CHECKPOINT)) {
>  		err =3D -EINVAL;
>  		f2fs_msg(sbi->sb, KERN_WARNING,
>  			"disabling checkpoint not compatible with read-only");
> --=20
> 2.18.0

--=20
Cheers,
Stephen Rothwell

--Sig_/TEftn5M8Uq_Tz9EbmG0X=IY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvFLggACgkQAVBC80lX
0Gxr+Af6Am+7E3UDorrVdHgRGn5Mcozhp9qQyCdFhV419sCG6JEQ+DvsX87CdmAq
ZDr1MDKgt+Lt5jRafZgd1FDesgnGIH9mTB6d8cpl1snjjBMpX4D2lcvNN9/04nHQ
EtZhsU7+XrA3hlR/DqnQmeIhyWSQNitbftDZFTJTrw5YsXXZ7rwjX3eGbyXQxzs/
LblvZNuOjod2UDSXsojup5k+9Ur+nXPVmudEf5U0VDsJDklb/43kD8A+3VaR3oGi
H7bOCul3xDAR8mKYZYRmKP+Iu+cMyMmcKp88H4iexZSjWyd451tX5724y3RTIMwB
+3koLMQpRUKnavchWDwpCr0JL+gCig==
=yFj7
-----END PGP SIGNATURE-----

--Sig_/TEftn5M8Uq_Tz9EbmG0X=IY--
