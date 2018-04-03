Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751403AbeDCC1Z (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 22:27:25 -0400
Received: from ozlabs.org ([103.22.144.67]:46687 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750798AbeDCC1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 22:27:24 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 3 Apr 2018 12:26:29 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mateusz Guzik <mguzik@redhat.com>
Subject: Re: linux-next: build failure after merge of the vfs tree
Message-ID: <20180403122629.688f2cab@canb.auug.org.au>
In-Reply-To: <20180319170627.04eae43b@canb.auug.org.au>
References: <20180319170627.04eae43b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/2j93cYseQ+/pdycqKHdsIJE"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2j93cYseQ+/pdycqKHdsIJE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Al,

On Mon, 19 Mar 2018 17:06:27 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the vfs tree, today's linux-next build (x86_64 allnoconfig)
> failed like this:
>=20
> fs/super.c: In function 'do_thaw_all_callback':
> fs/super.c:942:3: error: implicit declaration of function 'emergency_thaw=
_bdev'; did you mean 'emergency_remount'? [-Werror=3Dimplicit-function-decl=
aration]
>    emergency_thaw_bdev(sb);
>    ^~~~~~~~~~~~~~~~~~~
>    emergency_remount
>=20
> Caused by commit
>=20
>   92afc556e622 ("buffer.c: call thaw_super during emergency thaw")
>=20
> I have reverted that commit for today.

I am still doing that revert ...

--=20
Cheers,
Stephen Rothwell

--Sig_/2j93cYseQ+/pdycqKHdsIJE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrC5lUACgkQAVBC80lX
0Gyx6Af/f2yVMI3cSY69kghx2iiBw7se/h0Vmw5k75gTvzLylWeztVTQnibtVs2F
B43Nx7hKLGKbIhinCVsoOWCGVyUfyWqZ3QqNoGUHAW78meLoXOm4894juuoGLlPg
JWEITdEDA3NKRw9+F5mN+RLc0RTl060phD0j3hTdzREN9aonmQOrKjMhw6MLYech
nQgXro7dIUghLhWe5yrNZcxA0PGpU+olCRliiYcZPbOCWxk3CNFlfdq/eg0nNErp
bvSaZLojapNXNLVoVR6GtQhloEOw2lkGFb89OAt7tywp15sqx0j93s1EpyLtBJ9G
bcgFjEbDiXbAiEZ48PoncIiNOzeK8w==
=ZKV7
-----END PGP SIGNATURE-----

--Sig_/2j93cYseQ+/pdycqKHdsIJE--
