Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754226AbeEWIO4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 04:14:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:56912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754082AbeEWIOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 04:14:52 -0400
Date: Wed, 23 May 2018 09:14:48 +0100
From: James Hogan <jhogan@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] MIPS: PCI: Use dev_printk() when possible
Message-ID: <20180523081447.GA15645@jamesdev>
References: <152699466671.162686.1029992586935534102.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152699470263.162686.16975145205315900817.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <152699470263.162686.16975145205315900817.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 22, 2018 at 08:11:42AM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>=20
> Use the pci_info() and pci_err() wrappers for dev_printk() when possible.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/mips/pci/pci-legacy.c |    7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/mips/pci/pci-legacy.c b/arch/mips/pci/pci-legacy.c
> index 0c65c38e05d6..73643e80f02d 100644
> --- a/arch/mips/pci/pci-legacy.c
> +++ b/arch/mips/pci/pci-legacy.c
> @@ -263,9 +263,7 @@ static int pcibios_enable_resources(struct pci_dev *d=
ev, int mask)
>  				(!(r->flags & IORESOURCE_ROM_ENABLE)))
>  			continue;
>  		if (!r->start && r->end) {
> -			printk(KERN_ERR "PCI: Device %s not available "
> -			       "because of resource collisions\n",
> -			       pci_name(dev));
> +			pci_err(dev, "can't enable device: resource collisions\n");

The pedantic side of me wants to point out that you could wrap that line
after the comma to keep it within 80 columns.

Either way though:
Acked-by: James Hogan <jhogan@kernel.org>

Cheers
James

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWwUi9QAKCRA1zuSGKxAj
8l/hAP9wRhKTLcj7bgyBloqtW+lACwcm1L6ZG8rvMTYeyETdsQD/Ub0CM0qhhbwf
dcBrWIGOv/N8paHxgYfocG/YUmMdTgE=
=PUQd
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
