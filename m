Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938652AbeBUQxI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 11:53:08 -0500
Received: from mout.gmx.net ([212.227.15.18]:39759 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753335AbeBUQxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 11:53:05 -0500
Date: Wed, 21 Feb 2018 17:52:57 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linuxppc-dev@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/6] DISCONTIGMEM support for PPC32
Message-ID: <20180221165257.kyf35ifr4ndblowt@latitude>
References: <20180220161424.5421-1-j.neuschaefer@gmx.net>
 <193a407d-e6b8-9e29-af47-3d401b6414a0@c-s.fr>
 <20180221144240.pfu2run3pixt3pzo@latitude>
 <a36983ec-5e97-e968-8143-1b2615ea55f8@c-s.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="okldkbspm4p3rco7"
Content-Disposition: inline
In-Reply-To: <a36983ec-5e97-e968-8143-1b2615ea55f8@c-s.fr>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K0:L5s+hE7BXZSnCQLcZcqi+krLeV8eGSk0ymaY8R6jzYjV8zwCT9K
 YkIOdzY/ypHP15kyFGBtCNMN4XjCaFdMEXTi5Fn7XF3eQ49YopBTzIbStw7PAGWnsdfxg1L
 3e3tAI3JNQ8Tbdd9wXYhiCJar+2YFjRqW9tTsUbuRT8+BH0lIusvfYxBJK0Jr66m4RNEhDw
 /XjvfEoAsOB3Jo5J+j4Cg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Jg05V2yn7CQ=:XAA8qfnXXqBtHvo/0zmx5l
 +m215d8qn/W7RhZ27E6LpoFgpy4MgGXOmR3pbvEMFdbzFUkOVPbBSwqBIHhaIqlW1dHFj2lTb
 4PRuDz9rEC8IDakYnJ88VnUF7LsestMJnSlWM8DOrWCq0sNUU1Hmh7Nh9xpd/ickFLG1f1Zo1
 0GFTqVqy3fiszlgCHLL0efd0HxLNql1VcMzulJbxamjTZyMNETQxq1nIyZnFlC+u71ey7P8BW
 fGZwa7CO64ewVrBYKUdcR/B2/m4WuGVvxRtz+IIk1Q382DDxGeMSceK7iV4wM1KcuD3Ra/BY6
 Ur9GCiBaB1TWJcxWIXrwb4iRZ1AdNWHUSnPeY45JFS6gNjBPND4hkT7LTqhUOBq3k41wGJzob
 CefyVp8ISLfDFsfkRJGiddXBRs5UtkWE7CLLvZwud63MU+hEibFsmpWYokU/RHCuKCNIBhoBc
 2TLlcLSek+gKKYIo1cV3+rKjcg3eoOHssg5UIoZ6OJFl9MO70fBDj8dL1aH42M9jhDPmdsO6i
 YTgnVTrgWF54jsLaWrwojpG8Eltu6REUK/4IO/rBWNYKh37k4Fl4NyhGowk2Wz3mislHl60U0
 /Sus7681ixXkqIZRdsrPFjhtIeD56eQfQIh2vA8cz975rqop7EI6bsQFU6zzIYGmqrtSAKV8X
 QVKkeA7bq+7mXVC1p9+ada68NgVFdukdaeH50C9XbVYEVzlrRDaNl6FMkh7828kHYonc3ljHI
 thBHsObm0muHkvudVCKw+eFPuy5aRQTJChJMyPXO5++zfk7mz/rQS8IJYUx5RNrYvXSpDGQcL
 VTnRuS+oOZ54UTSuKU58Xn0S84SGQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--okldkbspm4p3rco7
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

I'll give it a try.


Thanks,
Jonathan Neusch=C3=A4fer

--okldkbspm4p3rco7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJajaPhAAoJEAgwRJqO81/b+aAP/A8ieDpgUlAvsfT1R0W2JTwZ
fWSbAAewS0RNzEyDXJMKuhPHPIFsed0oBGKLd2MelE0DPqIqAab+nC8gtXjFWcWT
ze47sr01w+ePMhnX3UtVT71WFXMYlYder8iaj3CTBtNFSAZlt7hgouHFRDuqXos9
IogPzpgqsHml/4rOP0Qr/i9EKmCeXOKW4jRI3xTxTOUlaJaxbWUky+7CofvxRXpc
quq3ljk6SlBXeiZuskiN9u3g7h1uBfRXsl50QH/XrRaMZB5xVyzUSbT5hSHdmI1b
F/XS54jsZVFN0PcUOTg8E5XuLYA9/fZPxk/9+XwrI854VU5Br9qFmCW4grwsMIVE
efJEft6/2LRlZsLh2M/iJKNJ7isFKbzwI96x5SqT0lpY2QdrXYrlTWlWQY9UpMIY
urWQxOPogQ1LCqgKyi7aTBcWJh5VQ/imU4a91SancINfUMu0fpGkdquhCFLoLpTK
ZvkzsRJdLoy/urFxXFoWOsIeiz0MoHPW7dCfU9qZx/7jj3DQojqBxtltmrVXZdEc
bgOTMGGiYe2E6cbA6pXgVCNpbL0VqEzlc8Wkb3AQQCQbvZf+A5y1bLp7boHRD91z
zsmDfdCDxkbXqNhSKaBSwlO9zQIElbPauoidd2zDu3WBPH0CLPMr7P1o63By7HKA
6t8sFNQ2NavTaYaFH6Ij
=H5py
-----END PGP SIGNATURE-----

--okldkbspm4p3rco7--
