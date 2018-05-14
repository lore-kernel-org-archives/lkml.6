Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752138AbeENV5b (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 17:57:31 -0400
Received: from ozlabs.org ([203.11.71.1]:49701 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752390AbeENV51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 17:57:27 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 15 May 2018 07:57:23 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jakub Kicinski <jakub.kicinski@netronome.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the bpf-next tree with the bpf tree
Message-ID: <20180515075723.658e19fd@canb.auug.org.au>
In-Reply-To: <20180514134140.0c468174@cakuba>
References: <20180514115700.0faadd6f@canb.auug.org.au>
        <20180514134140.0c468174@cakuba>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Pr=9fcFrD43j/RAAXwnkS8h"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Pr=9fcFrD43j/RAAXwnkS8h
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Mon, 14 May 2018 13:41:40 -0700 Jakub Kicinski <jakub.kicinski@netronome=
.com> wrote:
>
> On Mon, 14 May 2018 11:57:00 +1000, Stephen Rothwell wrote:
> > diff --cc tools/lib/bpf/libbpf.c
> > index 8da4eeb101a6,df54c4c9e48a..000000000000
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@@ -2163,9 -2193,12 +2193,12 @@@ int bpf_prog_load_xattr(const struct =
bp
> >  =20
> >   	if (!attr)
> >   		return -EINVAL;
> > + 	if (!attr->file)
> > + 		return -EINVAL;
> >  =20
> > - 	obj =3D bpf_object__open(attr->file);
> > + 	obj =3D __bpf_object__open(attr->file, NULL, 0,
> > + 				 bpf_prog_type__needs_kver(attr->prog_type));
> >  -	if (IS_ERR(obj))
> >  +	if (IS_ERR_OR_NULL(obj))
> >   		return -ENOENT; =20
>=20
> This is okay, thanks.  The OR_NULL is unnecessary just using the
> bpf-next code is a better merge IMO.

Thanks, I have updated my merge resolution from today.

--=20
Cheers,
Stephen Rothwell

--Sig_/Pr=9fcFrD43j/RAAXwnkS8h
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr6BkMACgkQAVBC80lX
0GzYCggApJbT2qM26AAH+0X4WpBUcKTUrVY9PGu8tuVJABfTNrxHe66WGhYJYYU6
QZmZBD+Q8OpGWqssPMk/LphbOKtiNi7cZh5gUiOtVwcV84z6Oh0Cj5KqW0OROmtQ
QCsZjTThKsDgL0R0DHou1TeOOTK1OgMQThfE4nnNRKDy8eX9T8r0eTssZPegQv2I
Al+3pnphZota2eV19oKhxYTqyx7TbGbPZqUxYcMlRKR1v1bquNhTzHBmPUoekztj
MwvxQJiniaVU2CDVu//wR3yfp2OSW45l+e3YC/1TorwjETRj2AgximwJbtkFjdo9
0wKvT14XD3Olmd+tL9MpFOLxgBgP5Q==
=XrJg
-----END PGP SIGNATURE-----

--Sig_/Pr=9fcFrD43j/RAAXwnkS8h--
