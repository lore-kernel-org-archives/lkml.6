Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937241AbeBUNwa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 08:52:30 -0500
Received: from mout.gmx.net ([212.227.17.22]:49263 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933394AbeBUNw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 08:52:27 -0500
Date: Wed, 21 Feb 2018 14:51:19 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: christophe leroy <christophe.leroy@c-s.fr>
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org,
        Joel Stanley <joel@jms.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/6] powerpc/mm/32: Use pfn_valid to check if pointer is
 in RAM
Message-ID: <20180221135119.d3qgvdck5yruomi7@latitude>
References: <20180220161424.5421-1-j.neuschaefer@gmx.net>
 <20180220161424.5421-2-j.neuschaefer@gmx.net>
 <0d14cb2c-dd00-d258-cb15-302b2a9d684f@c-s.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jgd5mu54dmgravdc"
Content-Disposition: inline
In-Reply-To: <0d14cb2c-dd00-d258-cb15-302b2a9d684f@c-s.fr>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K0:aGGx3HXz8pic4j5Gky7WY4nzPyKMN1qjh+8Mmgb+rEu4a6fl9eI
 fS0UpJ0kY07Q8qCpR2VsD8E8rvQUUo3BJIz1JWu5POIsISVYliQ24jSNhaVMoEcnRyKNn43
 TyeIy+cqTH1Fm5MJOZ9wcSDNx2DFpRA1GZ3gRgZ3YVZZUJBjv4qclqp0NjmWzvdoPaXmuYf
 +SdlLETsUKuxZdnxgoALQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LetMlMBMcxM=:r7rpxHrBK0dX0dhZSgm8kD
 S/yPC4A2cAN4S/PYNsPiig3FHXlBUr9EkttxLbYpEKkWpBhyA+o2oztOad+v4OgLzmwCf4lhY
 PcheYp68HxoxtiQ/yo29XdLbvrR6NnCXYW/0XKP+9anHGL8IzhI+vCIN3ENkDLYxmU3k9hkEV
 qOlPSKFWt+9Ek4ykcgPAsDWmfVRJvMrhVekXr5IkJM3KX8ZC6XrffbOd5RAxVZh2EIMxJ4p70
 TW3W8ZUpvkg7nTspmn3kslzM7oV5GTqQlMtNctEhIXy+DmRi+tAJoS2FBvigsvCR5L+1WOxRn
 wGSNqV7MbMfY5fJ3I5zdBNKUh+SGSCV3EeD2qtThinzo0GY6Eholdq0votPVyKAPpZRnMdXdf
 HOsAs5pembjql3f/DZQsj2BC6TfW+Gy8yGweXZ3I8LNYKkIR8mv+fMYlN7eZ4CXMPiFPJ/3Zx
 ih7mcjWZjZnD7wO9LJ6SaRAuDth/HpS3hUh4izt7zrDxfgdS2syZNYz7EzsHFx1wsZgMLvnmj
 QFBB6hCB0pDgGmORTYCDJaEE0Bo+FtV2vkP4tUPZYTM1PeHZQDdmxlGLikbbsihrGnFD2rqZp
 TNc8oZjn2386b9uvY0RGqr/RmGlAph4wFgXc7GFYIS0Xd1L7v+GqVnXDGHjth35k8b/v25Gen
 0FvITucKpN5kuEj5+SSyRs2aUJ4TBempF4dxATO51V2xD3NDcdI8j+C4F8VTNeBqjgn/WSBPk
 k9vPa4f+oE5ViL3jkk5M6UbiBc5FqNo/br58JseUGdu0TPTVEBlXoJj00HoKA/U7ncq+2diRH
 CtXY9dffuFLQhduN8e8zpEFWbr0LA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jgd5mu54dmgravdc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Christophe,

On Tue, Feb 20, 2018 at 06:45:09PM +0100, christophe leroy wrote:
[...]
> > -	if (slab_is_available() && (p < virt_to_phys(high_memory)) &&
> > +	if (slab_is_available() && pfn_valid(__phys_to_pfn(p)) &&
>=20
> I'm not sure this is equivalent:
>=20
> high_memory =3D (void *) __va(max_low_pfn * PAGE_SIZE);
> #define ARCH_PFN_OFFSET		((unsigned long)(MEMORY_START >> PAGE_SHIFT))
> #define pfn_valid(pfn)		((pfn) >=3D ARCH_PFN_OFFSET && (pfn) < max_mapnr)
> set_max_mapnr(max_pfn);
>=20
> So in the current implementation it checks against max_low_pfn while your
> patch checks against max_pfn
>=20
> 	max_low_pfn =3D max_pfn =3D memblock_end_of_DRAM() >> PAGE_SHIFT;
> #ifdef CONFIG_HIGHMEM
> 	max_low_pfn =3D lowmem_end_addr >> PAGE_SHIFT;
> #endif

Good point, I haven't considered CONFIG_HIGHMEM before.

As far as I understand it, in the non-CONFIG_HIGHMEM case:

  - max_low_pfn is set to the same value as max_pfn, so the ioremap
    check should detect the same PFNs as RAM.

and with CONFIG_HIGHMEM:

  - max_low_pfn is set to lowmem_end_addr >> PAGE_SHIFT
  - but max_pfn isn't

So, I think you're right.


While looking through arch/powerpc/mm, I noticed that there's a
page_is_ram function, which simply uses the memblocks directly, on
PPC32. It seems like a good candidate for the RAM check in
__ioremap_caller, except that there's this code, which apparently
trashes memblock 0 completely on non-CONFIG_NEED_MULTIPLE_NODES:

  https://elixir.bootlin.com/linux/v4.16-rc2/source/arch/powerpc/mm/mem.c#L=
223


Thanks,
Jonathan Neusch=C3=A4fer

--jgd5mu54dmgravdc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJajXlOAAoJEAgwRJqO81/bA04P/A5eYOetCVfwe5i8CzVCzswi
syAI04l5dw0ka8DJ6Vn3mGtDFbw+uDpOmZ4bwyebvvmr4nMnbJP6DLrYgOfs6Jz1
aczZBbk1Jf/bO28zSvfZtrq1cfw5YI1RF54d6mJsjzC+oDpdCvTAwB03Feq1MbAu
QYO6tilAaCnJyQ8vvxRL309oh1/jiYSfXga0pyH3KkjxWlPYAK7BrSW4IuWsp8Yw
7mDJFnWuhiVxRMBgnvlXt4ykz6GLACM/mKaT/mWGtsvh/mTt2r+jk07QnnqX+Tvb
V9iiXMof5TAM+nLlI8oLgxsXTFbu//QJMiNa6s6NWv6WMA3/Dq2HlWf8X4lj6TXx
dmNNrcGWkVdCGdZKliwS+jAU0kMZ3cz2VCcLQH+rWJgCutQpbpF1I+J9Lv3vg7cH
0lcRcsmfnBF5JGKScvjaHjCqH2M98JDSER5xU9B2ff9dZn5db6zeN/804OD7htX3
nS//MoDImnbeur7ryfthSLgrVv5te78mv1aA/PLclGnveo5C/lrxWU1DjmBEmxW/
h6o5JU6hV1To0teV47Cu9QLPPebpmM0iVR45TK4Y9u5DjdmvpYLYgnTsxtgXJGkW
LX5tE060VtbeKZIA0N2VxKpwp+t+osCRPch+bPLlVjlS6Bo/gTtAHO5w9ldqDqf/
UGnCm3zfS2X0jWMdxvRc
=afR/
-----END PGP SIGNATURE-----

--jgd5mu54dmgravdc--
