Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751368AbeBUXcH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 18:32:07 -0500
Received: from mout.gmx.net ([212.227.15.19]:40919 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751345AbeBUXcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 18:32:05 -0500
Date: Thu, 22 Feb 2018 00:31:58 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linuxppc-dev@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/6] DISCONTIGMEM support for PPC32
Message-ID: <20180221233158.4rnxsyxffhevtj44@latitude>
References: <20180220161424.5421-1-j.neuschaefer@gmx.net>
 <193a407d-e6b8-9e29-af47-3d401b6414a0@c-s.fr>
 <20180221144240.pfu2run3pixt3pzo@latitude>
 <a36983ec-5e97-e968-8143-1b2615ea55f8@c-s.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3wousgr6cvagsioq"
Content-Disposition: inline
In-Reply-To: <a36983ec-5e97-e968-8143-1b2615ea55f8@c-s.fr>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K0:LBuGx1155MwBthgXVjoNNhtbY5zQxqZwTuo+D0dDGZHjovUVpOb
 KRfKXivFbgL1WP3iq13fOAOZkGbob6Q1+yoVbkyPlWFi03FiCCufwqF/6IYWv8ML17t6yFE
 GCd3FnZjr7N1/TSI6aqcaVDh1DcpjpZfeyInAzst2L3N6eT67rTnSgnXIHaZPL+0AvmbHjV
 jS4FPIW0Z8Aqh80Vpxpcw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FVY98I8ueZk=:GVrDnzns3ooNyPoHKcsa0D
 MRx+qawLnzi8sCK0j0A6vRDMo0qu5C50JO7ZdFNA6kNms0h0pCUE0TxqjZRw2FDKS8++iU9w3
 pFsgOgx5+0sYb1SyeyEjFCtts9z/+SmDSdap+QHv1SxlGNiHIXJtmoDCFT5NtsRSIQAy2Z1JM
 w6ZGjtCcODfXjE2v8w+8J8RtIZ2o1+iW2slzIdMWmKmo9cMZgI1HnPu2ZRgnS83G6Xh7UOpQW
 gv0aXjTH8BQxY/b5gJS1Q2bEUZe3nSeuq2N1LtzLPrWFI2xdp8F0ZpG3Bo7xl5iiiN9uc0wNI
 qm6Je0yFPParxSPxtkx0ZGMAsNMZCzT/dhC7AiS9khhALSw1SNdh8sJSJbKv3Fa6t7UJC2AGj
 4YW+w7YIQe8o5FKGMEgcMBywNpcGJoBas+ZW+Mi1sCQ4mT5wKskhvP4esUNuGhw2Lik4WX/fl
 jE2swGttC+uqiGXhRFzS7DT/h8x6a8w2jZEDoXvL9S8T3PkeQ9Rc9M6NE2HbsgFexkvfDh6bq
 eTp7HhUYQtZtgDQSzS9B2D/fVe/CzI42xVIIUy8gAK/Gjh6Z0i13uHFTB0HHCNK99pfXoFINj
 gs82v5WOA27xinVm1A3OnM9iybAOyPtEbAgPK/r1lmt7EWrFn3fm5YlK8AfB+08Szyr4XvRPW
 Y/9Xok8cAmSNS3DiU9Es82Rcw0dq3qxurjX9enyPFnYIhsq8oondEKGfykZTvHKpPBuLjS3UW
 suwbQohbZ5CcSLMZN3TVl2EDJQvzqI66TUZgO8kOge2gxsiAhV2C9xhzK1PfEQlL5Tk8bopz8
 bxM9z4bo1k+GBFdA/P56BaVffc3zA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3wousgr6cvagsioq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2018 at 04:02:25PM +0100, Christophe LEROY wrote:
[...]
> > > My question might me stupid, as I don't know PCC64 in deep, but when =
looking
> > > at page_is_ram() in arch/powerpc/mm/mem.c, I have the feeling the PPC=
64
> > > implements ram by blocks. Isn't it what you are trying to achieve ? W=
ouldn't
> > > it be feasible to map to what's done in PPC64 for PPC32 ?
> >=20
> > Using page_is_ram in __ioremap_caller and the same memblock-based
> > approach that's used on PPC64 on PPC32 *should* work, but I think due to
> > the following line in initmem_init, it won't:
> >=20
> > 	memblock_set_node(0, (phys_addr_t)ULLONG_MAX, &memblock.memory, 0);
>=20
> Can't we just fix that ?

Turns out I was completely wrong about this. memblock_set_node as called
above only assigns all memory to node 0 and merges *adjacent* memblocks.
It doesn't merge the memblocks on the Wii, which are far apart.

So now I actually have a working patchset (coming soon), that's a good
deal shorter than this patchset, and hopefully won't break
CONFIG_HIGHMEM in the same way.

Thanks for your input! :)


Jonathan Neusch=C3=A4fer

--3wousgr6cvagsioq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJajgFjAAoJEAgwRJqO81/bDAUP+gPIvPGu0J/u2uqZfNr27T+4
sh45TNrfe52W5evpflDWMx4ZUq2v6Y/sug9fvebmiLJ5t3oMPzTWxNxIxB8q4Fn3
qI5QIyZGpsr+8z5TH2Ww4givs3W5c24Ze4ysbsqefJJZMJzkMM+Ao3cGcWD686/C
rTn6K27WxO80xhTlf/5jtdjf2vBQd0aUSN0BgtlsJElYuXXUN7qlsF4apLTcHsVi
itdOxGqajwn+vBlcp8e7i86DnOaWOX2u09TDGgUHL10hnLTzToWZjeI8UUBtdiOY
9WVT+69J1FnyLPjHnBl+ry3Z3BBJWIWYWKMtUdUSLT90V3VPWfFUnCobX1E+TQ+C
QmP6romqvvxBsJLQQ1MPxCRDOxFmMfNulWQNYwIM+6T4HBBMHQ5mi/7QYRBOxVef
NI/cuiXExZ6dE2gx48XfFDbferQ3ah9IUSeu3JUIkZ5457KPQVfc0a/t/AJcEmn4
WfWY+CPHs0RoD73KgqskxC/NR3BDHCPGPfMwMlkBuPjhREgLmYHwmCpDjgUXST+2
gagoCx4q0CYYC7VPgq/UDJBnaOyiK/znpr6EyJ0HBBeUd2HR/uVKeGD5GAiSV7hu
9BlVNc6XMUUp/q3H6TcJqI2UUt8LMvBhwQ1p9B7xCtJRxgiys3eCSrtIsgJA0d5w
+c2s4pf5ExFkCl1Mp04x
=GpyF
-----END PGP SIGNATURE-----

--3wousgr6cvagsioq--
