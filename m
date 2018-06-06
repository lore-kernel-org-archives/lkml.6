Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HS1Lhsfc"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 486A360555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752202AbeFFEti (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 00:49:38 -0400
Received: from ozlabs.org ([203.11.71.1]:40679 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751035AbeFFEtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 00:49:36 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 6 Jun 2018 14:49:33 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: linux-next: build failure after merge of the net-next tree
Message-ID: <20180606144933.3bd24898@canb.auug.org.au>
In-Reply-To: <20180601085243.3p33sctlpckcq7vl@ast-mbp>
References: <20180529132548.7f71c2ff@canb.auug.org.au>
        <20180531073855.29c23fce@canb.auug.org.au>
        <20180601135943.66b90890@canb.auug.org.au>
        <20180601085243.3p33sctlpckcq7vl@ast-mbp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Xp/s/SOLnB+wy8aGROVoOJx"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Xp/s/SOLnB+wy8aGROVoOJx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 1 Jun 2018 04:52:45 -0400 Alexei Starovoitov <alexei.starovoitov@gm=
ail.com> wrote:
>
> On Fri, Jun 01, 2018 at 01:59:43PM +1000, Stephen Rothwell wrote:
> >=20
> > On Thu, 31 May 2018 07:38:55 +1000 Stephen Rothwell <sfr@canb.auug.org.=
au> wrote: =20
> > >
> > > On Tue, 29 May 2018 13:25:48 +1000 Stephen Rothwell <sfr@canb.auug.or=
g.au> wrote: =20
> > > >
> > > > After merging the net-next tree, today's linux-next build (x86_64
> > > > allmodconfig) failed like this:
> > > >=20
> > > > x86_64-linux-ld: unknown architecture of input file `net/bpfilter/b=
pfilter_umh.o' is incompatible with i386:x86-64 output
> > > >=20
> > > > Caused by commit
> > > >=20
> > > >   d2ba09c17a06 ("net: add skeleton of bpfilter kernel module")
> > > >=20
> > > > In my builds, the host is PowerPC 64 LE ...
> > > >=20
> > > > I have reverted that commit along with
> > > >=20
> > > >   61a552eb487f ("bpfilter: fix build dependency")
> > > >   13405468f49d ("bpfilter: don't pass O_CREAT when opening console =
for debug")
> > > >=20
> > > > for today.   =20
> > >=20
> > > I am still getting this failure (well, at least yesterday I did). =20
> >=20
> > Still happened today.  My guess is that bpfilter_umh needs to be built
> > with the kernel compiler (not the host compiler - since ir is meant to
> > run on the some machine as the kernel, right?) but will require the
> > kernel architecture libc etc
>=20
> Sorry for delay. networking folks are traveling to netconf.
> The issue is being discussed here:
> https://patchwork.ozlabs.org/patch/921597/
>=20
> Currently we're thinking how to add a check that hostcc's arch
> is equal to cross-cc target arch and ideally equal to arch
> of the host where it will be run.

Looks like this is fixed in today's tree by not building bpfilter when
CC cannot link against user libraries.  Unfortunately this means that
it will never be built by my infrastructure (since all my compilers are
minimal cross compilers) :-(

I may look into getting a different set of compilers (or doing my
PowerPC builds natively).
--=20
Cheers,
Stephen Rothwell

--Sig_/Xp/s/SOLnB+wy8aGROVoOJx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsXZ90ACgkQAVBC80lX
0GzbyQf/cqSW3QooI/gU4ti+VW4czkVJf5hEWKdUNbq8Th6hB4eo8Fd7naxdUrTA
OqefRojgT41//qmQbBJsCKjBe/B/kBJvjo3DVLIwdTHefWC3KOMpRE8b9fZppkcE
eJmHu9sXxDHis5Fbh57KimCDCR39bNtemgNGzik/iFo18p2FuQPRgTZ6K0DNmYaz
nHWAvyLVbB0F4IaeGoXYke1RVG00VvW77KNaTGkw3/8QpqPLlDIa2c3SJ5YnmO/d
OnQFUT+6ScledQVPntrFH/Nwj3RzIFKfioZPe26jybcGLEkrgfS69BCg/yo6c1JH
h7Y9DE+XHEs5GVTjd4efzOc/4gSSsQ==
=yT4H
-----END PGP SIGNATURE-----

--Sig_/Xp/s/SOLnB+wy8aGROVoOJx--
