Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751810AbeAaWmm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 17:42:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:58834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751433AbeAaWml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 17:42:41 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D7B2175D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Wed, 31 Jan 2018 22:42:36 +0000
From: James Hogan <jhogan@kernel.org>
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: ralf@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: fix typo BIG_ENDIAN to CPU_BIG_ENDIAN
Message-ID: <20180131224235.GC7637@saruman>
References: <20180117185638.22426-1-clabbe.montjoie@gmail.com>
 <20180117195527.GZ27409@jhogan-linux.mipstec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
Content-Disposition: inline
In-Reply-To: <20180117195527.GZ27409@jhogan-linux.mipstec.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2018 at 07:55:27PM +0000, James Hogan wrote:
> On Wed, Jan 17, 2018 at 07:56:38PM +0100, Corentin Labbe wrote:
> > MIPS_GENERIC select some options with condition on BIG_ENDIAN which do
> > not exists.
> > Replace BIG_ENDIAN by CPU_BIG_ENDIAN which is the correct kconfig name.
> > Note that BMIP_GENERIC do the same which confirm that this patch is
> > needed.
> >=20
> > Fixes: eed0eabd12ef0 ("MIPS: generic: Introduce generic DT-based board =
support")
> > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
>=20
> Good spot:
> Reviewed-by: James Hogan <jhogan@kernel.org>
>=20
> Probably worthy of a backport too:
> Cc: <stable@vger.kernel.org> # 4.9+

For the record, this needs the patch "usb: Move USB_UHCI_BIG_ENDIAN_*
out of USB_SUPPORT" [1] to avoid Kconfig warnings.

Thanks
James

[1] https://patchwork.linux-mips.org/patch/18559/

>=20
> Cheers
> James
>=20
> > ---
> >  arch/mips/Kconfig | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > index 13c6e5cb6055..504e78ff0b00 100644
> > --- a/arch/mips/Kconfig
> > +++ b/arch/mips/Kconfig
> > @@ -119,12 +119,12 @@ config MIPS_GENERIC
> >  	select SYS_SUPPORTS_MULTITHREADING
> >  	select SYS_SUPPORTS_RELOCATABLE
> >  	select SYS_SUPPORTS_SMARTMIPS
> > -	select USB_EHCI_BIG_ENDIAN_DESC if BIG_ENDIAN
> > -	select USB_EHCI_BIG_ENDIAN_MMIO if BIG_ENDIAN
> > -	select USB_OHCI_BIG_ENDIAN_DESC if BIG_ENDIAN
> > -	select USB_OHCI_BIG_ENDIAN_MMIO if BIG_ENDIAN
> > -	select USB_UHCI_BIG_ENDIAN_DESC if BIG_ENDIAN
> > -	select USB_UHCI_BIG_ENDIAN_MMIO if BIG_ENDIAN
> > +	select USB_EHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
> > +	select USB_EHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
> > +	select USB_OHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
> > +	select USB_OHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
> > +	select USB_UHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
> > +	select USB_UHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
> >  	select USE_OF
> >  	help
> >  	  Select this to build a kernel which aims to support multiple boards,
> > --=20
> > 2.13.6
> >=20
> >=20



--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpyRlsACgkQbAtpk944
dnraCA/8DOrWc3EfUIBPYFry8laKCaTyddG8F1HTNqOYFZ4MrKNnks53vYJ298Dn
i0wHzMXXDU+wuuVDou9hKLG5rmhvRIHHAPCzQBVqSJ/HJb0WdMJDfM6NZhN5dhod
XIlxnjS5nbhzJ9vcHV00n6l1nCKxN0nTp8hIYP45AZ2fZsQqlhsT0JvZIqrT3iaG
PrvLlvKub/OrJBnHqFl1cGczwkAoBigPRYo0Ix8K2qrnX3EL3KlYXahHQsK/hXn6
NBOR1k4arjcts8/tisK+r8OASieDVo8vooVT5xGuDEQSEDwE8ZNhxX1PjY1T9YM6
v/5DK5GP60au3QyKoi5u0qQKJDkqqaWslm7uprSg9F/VB+rl+KesVqmmdGv5g1kJ
DdQ/WuA8rsX/rQqv5E1+3yTGHcx/oTx/igvcMZZ/DU9gG2/NLYWV6xr0U5xhtfRS
NSGXVKn/Hzsx+casN4mMiqTtEwbJDUnalxK9RuJ0GAgr9yUmFWT1GukW//TL98e3
ZJuBrXfdWERw3uox26Nnu93+5Tk1Sevl8eRjxKhcuqTSufS506NWedlaOy+1WQ3T
1woNlmfM4FWkXqDLGfL3886Y7Oq231i01Oht7UTf6z/cXHYWsxemmHxq45VbwqkO
QN293l0n6x8vLVQL/nH+NMsO5mR70k3f66WjIi8znhwEq8o8m0s=
=1d66
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--
