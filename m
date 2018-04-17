Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753097AbeDQMcB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 08:32:01 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:35877 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752359AbeDQMb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 08:31:59 -0400
Date: Tue, 17 Apr 2018 14:31:28 +0200
From: Alban <albeu@free.fr>
To: Rob Herring <robh@kernel.org>
Cc: Alban <albeu@free.fr>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v3 1/3] nvmem: Update the OF binding to use a subnode
 for the cells list
Message-ID: <20180417143128.69126385@avionic-0020>
In-Reply-To: <20180416210429.e3yo52f355qxnopb@rob-hp-laptop>
References: <1521933899-362-1-git-send-email-albeu@free.fr>
        <1521933899-362-2-git-send-email-albeu@free.fr>
        <20180416210429.e3yo52f355qxnopb@rob-hp-laptop>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/esdboVINWphvIninm4cYbzi"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/esdboVINWphvIninm4cYbzi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 16 Apr 2018 16:04:29 -0500
Rob Herring <robh@kernel.org> wrote:

> On Sun, Mar 25, 2018 at 12:24:57AM +0100, Alban Bedel wrote:
> > Having the cells as subnodes of the provider device without any
> > compatible property might clash with other bindings. To avoid this
> > problem update the binding to have all the cells in a 'nvmem-cells'
> > subnode with a 'nvmem-cells' compatible string. This new binding
> > guarantee that we can turn any kind of device in a nvmem provider.
> >=20
> > While discouraged for new uses the old scheme is still supported for
> > backward compatibility.
> >=20
> > Signed-off-by: Alban Bedel <albeu@free.fr>
> > ---
> >  Documentation/devicetree/bindings/nvmem/nvmem.txt | 55 +++++++++++++++=
+-------
> >  drivers/nvmem/core.c                              | 10 +++++
> >  2 files changed, 48 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.txt b/Docume=
ntation/devicetree/bindings/nvmem/nvmem.txt
> > index fd06c09..6b723e7 100644
> > --- a/Documentation/devicetree/bindings/nvmem/nvmem.txt
> > +++ b/Documentation/devicetree/bindings/nvmem/nvmem.txt
> > @@ -11,14 +11,29 @@ these data from, and where they are stored on the s=
torage device.
> >  This document is here to document this.
> > =20
> >  =3D Data providers =3D
> > -Contains bindings specific to provider drivers and data cells as child=
ren
> > -of this node.
> > +A data provider should have a subnode named 'nvmem-cells' that contains
> > +a subnodes for each data cells.
> > +
> > +For backward compatibility the nvmem data cells can be direct children
> > +of the data provider. This use is discouraged as it can conflict with
> > +other bindings. =20
>=20
> I don't think we need to go this far. Whether this is necessary depends=20
> on the provider.

It depend more on the drivers implementation. Sure as long as the
driver only support the nvmem API it doesn't matter, both binding are
fine. But if it ever need to support another API the bindings might
clash and the whole device binding will need to be updated. So all in
all I see very few value in still allowing the old binding for new
devices, or do you seen any problem with the new binding?

However if the consensus is to keep both styles I will rewrite this
paragraph as needed.

Alban

--Sig_/esdboVINWphvIninm4cYbzi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJa1ekhAAoJEHSUmkuduC28zUMP/R1CQa0hBlA+o8D8cTMQpkcN
xacENM3vNWs8WCGoiKWnbMtMFPNBTELSg201T+2iL4d/oCTZ29sOjoziTACQyqAJ
vTI5HqGVZtsUl/r3wzrWCudrGbT+ghon9rvJrkpPE3t+G6YoVrqfYvxYqwRjA2EP
sg825d9ZtAlijI0JtgYHPklGRej7AMMy8b6KbDXgnGTM+Xr4ETQ/VaefAOUszjL3
FeZjGL8Su3hZmEcOIMv50yVLrVZt05URnU8nX8FqkX5/i0Hzr50eS1bLjfSKu69m
pGZuLB9mQMDjEj13SY/fJS/tRe+6g8GLe2EPiWwcy6RN6I0vCquIIzzESJOkwUgo
+FeLp1bZA9UGg3PtFtuY1zvkHJIwafBE/4NwSd7d4nF0lHZsLzDgIhEOUNnwqKvc
vo9RB+MDskA2viYoLC+IUwgYdYpQHyfRn/AucccNvlfvV8u6uuFnfeXUrGU9bmIO
80uTEavVCjUVMwixZy4+jUXcgZVusg5S9sjiZQj81jBhtVulUint5/4caApKmQy+
//ujAMHVq5KxVQ639+exxkM1cqV8+NcsxY0HQHLmYmJwLNoXsLubwM6pYrMfhN0Y
Idg/c/NVt2/EvrNee0a3W88VpiExZTfzXCdDkUi1qgcPvmdOX/SB0QIFF4bEhV44
BsEGkmWGx1g7yTvlsU/x
=eR8l
-----END PGP SIGNATURE-----

--Sig_/esdboVINWphvIninm4cYbzi--
