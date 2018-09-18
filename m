Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB036ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B46F21508
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="M6TJFgen"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B46F21508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbeISDNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 23:13:15 -0400
Received: from ozlabs.org ([203.11.71.1]:40587 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727811AbeISDNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 23:13:15 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42FGZm4Jn1z9sCQ;
        Wed, 19 Sep 2018 07:38:39 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1537306721;
        bh=0wGgRPDmmnnXQGElkea7sbv4iQpnt9J5GOYF5e9SzIQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M6TJFgen5KUr8qjxnUlO+vafCEoNOCeVfb9EpI6DEOeO8AnSkjdQmJTrpVS4ksdmg
         hSawa7ZcelSwOh7mSdJYobHGukSyJlAl8R1zbfuy6qlRbrR2Vs82DUU6UpwYLPfjps
         jAAJTCRVrk3NOwmf9ze/0zmK1Qm3U7pDcJMVh9gFXFx7CrSygHaCLnSiUlwr4iuq37
         BVfIAjjvHbLr75XbVoTiMuNIweCRR4SVGHcEGIH4hkCg2Vi8bIgIWpwYkroAInTJCr
         ketMGmPv2zquZWmC3CjdUMViAQDfGqH+TkuE/XI/GPdvC4nSmwspYOgacJv+m5b3Yu
         0U4G99EPWsKpg==
Date:   Wed, 19 Sep 2018 07:38:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: linux-next: build failure after merge of the vfs tree
Message-ID: <20180919073826.02370812@canb.auug.org.au>
In-Reply-To: <20180910133525.28c5dd20@canb.auug.org.au>
References: <20180910133525.28c5dd20@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/N2dAEWL+q=FnKfk_MZKhVWN"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/N2dAEWL+q=FnKfk_MZKhVWN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David, Al,

On Mon, 10 Sep 2018 13:35:25 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the vfs tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
>=20
> samples/vfs/test-fsinfo.c: In function 'fsinfo':
> samples/vfs/test-fsinfo.c:37:17: error: '__NR_fsinfo' undeclared (first u=
se in this function); did you mean 'fsinfo'?
>   return syscall(__NR_fsinfo, dfd, filename, params, buffer, buf_size);
>                  ^~~~~~~~~~~
>                  fsinfo
> samples/vfs/test-fsinfo.c:37:17: note: each undeclared identifier is repo=
rted only once for each function it appears in
> samples/vfs/test-fsinfo.c: In function 'dump_attr_LIMITS':
> samples/vfs/test-fsinfo.c:180:30: warning: format '%llx' expects argument=
 of type 'long long unsigned int', but argument 2 has type '__u64' {aka 'lo=
ng unsigned int'} [-Wformat=3D]
>   printf("\tmax file size: %llx\n", f->max_file_size);
>                            ~~~^     ~~~~~~~~~~~~~~~~
>                            %lx
> samples/vfs/test-fsinfo.c:181:32: warning: format '%llx' expects argument=
 of type 'long long unsigned int', but argument 2 has type '__u64' {aka 'lo=
ng unsigned int'} [-Wformat=3D]
>   printf("\tmax ids      : u=3D%llx g=3D%llx p=3D%llx\n",
>                              ~~~^
>                              %lx
>          f->max_uid, f->max_gid, f->max_projid);
>          ~~~~~~~~~~
> samples/vfs/test-fsinfo.c:181:39: warning: format '%llx' expects argument=
 of type 'long long unsigned int', but argument 3 has type '__u64' {aka 'lo=
ng unsigned int'} [-Wformat=3D]
>   printf("\tmax ids      : u=3D%llx g=3D%llx p=3D%llx\n",
>                                     ~~~^
>                                     %lx
>          f->max_uid, f->max_gid, f->max_projid);
>                      ~~~~~~~~~~
> samples/vfs/test-fsinfo.c:181:46: warning: format '%llx' expects argument=
 of type 'long long unsigned int', but argument 4 has type '__u64' {aka 'lo=
ng unsigned int'} [-Wformat=3D]
>   printf("\tmax ids      : u=3D%llx g=3D%llx p=3D%llx\n",
>                                            ~~~^
>                                            %lx
>          f->max_uid, f->max_gid, f->max_projid);
>                                  ~~~~~~~~~~~~~
> samples/vfs/test-fsinfo.c: In function 'dump_attr_SUPPORTS':
> samples/vfs/test-fsinfo.c:197:24: warning: format '%llx' expects argument=
 of type 'long long unsigned int', but argument 2 has type '__u64' {aka 'lo=
ng unsigned int'} [-Wformat=3D]
>   printf("\tstx_attr=3D%llx\n", f->stx_attributes);
>                      ~~~^     ~~~~~~~~~~~~~~~~~
>                      %lx
> samples/vfs/test-fsmount.c: In function 'fsopen':
> samples/vfs/test-fsmount.c:63:17: error: '__NR_fsopen' undeclared (first =
use in this function); did you mean 'fsopen'?
>   return syscall(__NR_fsopen, fs_name, flags);
>                  ^~~~~~~~~~~
>                  fsopen
> samples/vfs/test-fsmount.c:63:17: note: each undeclared identifier is rep=
orted only once for each function it appears in
> samples/vfs/test-fsmount.c: In function 'fsmount':
> samples/vfs/test-fsmount.c:68:17: error: '__NR_fsmount' undeclared (first=
 use in this function); did you mean 'fsmount'?
>   return syscall(__NR_fsmount, fsfd, flags, ms_flags);
>                  ^~~~~~~~~~~~
>                  fsmount
> samples/vfs/test-fsmount.c: In function 'fsconfig':
> samples/vfs/test-fsmount.c:74:17: error: '__NR_fsconfig' undeclared (firs=
t use in this function); did you mean 'fsconfig'?
>   return syscall(__NR_fsconfig, fsfd, cmd, key, val, aux);
>                  ^~~~~~~~~~~~~
>                  fsconfig
> samples/vfs/test-fsmount.c: In function 'move_mount':
> samples/vfs/test-fsmount.c:81:17: error: '__NR_move_mount' undeclared (fi=
rst use in this function); did you mean 'move_mount'?
>   return syscall(__NR_move_mount,
>                  ^~~~~~~~~~~~~~~
>                  move_mount
> samples/vfs/test-fs-query.c: In function 'fsopen':
> samples/vfs/test-fs-query.c:32:17: error: '__NR_fsopen' undeclared (first=
 use in this function); did you mean 'fsopen'?
>   return syscall(__NR_fsopen, fs_name, flags);
>                  ^~~~~~~~~~~
>                  fsopen
> samples/vfs/test-fs-query.c:32:17: note: each undeclared identifier is re=
ported only once for each function it appears in
> samples/vfs/test-fs-query.c: In function 'fsinfo':
> samples/vfs/test-fs-query.c:38:17: error: '__NR_fsinfo' undeclared (first=
 use in this function); did you mean 'fsinfo'?
>   return syscall(__NR_fsinfo, dfd, filename, params, buffer, buf_size);
>                  ^~~~~~~~~~~
>                  fsinfo
> samples/vfs/test-statx.c: In function 'dump_statx':
> samples/vfs/test-statx.c:160:29: warning: format '%llx' expects argument =
of type 'long long unsigned int', but argument 2 has type '__u64' {aka 'lon=
g unsigned int'} [-Wformat=3D]
>    printf("Attributes: %016llx (", stx->stx_attributes);
>                        ~~~~~~^     ~~~~~~~~~~~~~~~~~~~
>                        %016lx
>=20
> Caused by commits
>=20
>   2615362dc9ce ("vfs: Add a sample program for the new mount API")
>   e9078278ec11 ("vfs: syscall: Add fsinfo() to query filesystem informati=
on")
>=20
> The directory name has changed, but the errors persist!
>=20
> I have applied this patch for today:
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 10 Sep 2018 13:19:20 +1000
> Subject: [PATCH] disable building the VFS sample programs
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  samples/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/samples/Kconfig b/samples/Kconfig
> index 0431af2589ac..c8823d9d97db 100644
> --- a/samples/Kconfig
> +++ b/samples/Kconfig
> @@ -148,6 +148,7 @@ config SAMPLE_VFIO_MDEV_MBOCHS
> =20
>  config SAMPLE_VFS
>  	bool "Build example programs that use new VFS system calls"
> +	depends on BROKEN
>  	help
>  	  Build example userspace programs that use new VFS system calls such
>  	  as mount API and statx()

Can we have a permanent solution to this, please ... I am still
applying the above patch.

--=20
Cheers,
Stephen Rothwell

--Sig_/N2dAEWL+q=FnKfk_MZKhVWN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluhcFIACgkQAVBC80lX
0GxRCAf/aueiwnWn3/QrPw/G59/wUecwFdvTEiB8QEQpqt5jZyWCtC4GkV8teyzJ
CkL7EAc0k6JhqZaw5b1SeVCvXnqn64WC6sC8ptRoLFO4Cm7/Q6xHiVMVsvoISJsO
ooqnuU/hXxsluZZMTj3nudUjzJoKMYdNUJ2qKUtMOwrTCUs10SkI6bZYJPc+oYn1
NJFLP+2TyTZUa3F8Sj9HOKsQRBj20oONVItiqTiSb13co1oXfQw6YNEiqJ3xwElw
OMe0AbeIDiw545eQFMDTiqQE8v1tsuOknhTQ1hUq+BiJvyhgyDVm9Ds5CsSoTqQD
t4+dffB+XUUVRKH6wMU6zr/FU1N0oA==
=kXV8
-----END PGP SIGNATURE-----

--Sig_/N2dAEWL+q=FnKfk_MZKhVWN--
