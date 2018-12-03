Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584B2C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2773220878
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2773220878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbeLCM0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 07:26:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:36856 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726223AbeLCM0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 07:26:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E28E5AFA8;
        Mon,  3 Dec 2018 12:25:57 +0000 (UTC)
Message-ID: <7a75afd030cbd17c986a3ad486aab35ad3418b28.camel@suse.de>
Subject: Re: [PATCH] firmware: arm_sdei: fix wrong of_node_put() in init
 function
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     James Morse <james.morse@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 03 Dec 2018 13:25:55 +0100
In-Reply-To: <08d6b9e6-7aa0-9342-193b-1ce6e0417f77@arm.com>
References: <20181126121536.28739-1-nsaenzjulienne@suse.de>
         <08d6b9e6-7aa0-9342-193b-1ce6e0417f77@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-t7AYbqLg9t8BDYsYLWC5"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-t7AYbqLg9t8BDYsYLWC5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi James, thanks for the review!=20

On Fri, 2018-11-30 at 18:31 +0000, James Morse wrote:
> Hi Nicolas,
>=20
> On 26/11/2018 12:15, Nicolas Saenz Julienne wrote:
> > After finding a "firmware" dt node arm_sdei tries to match it's
> > compatible string with it. To do so it's calling
> > of_find_matching_node()
> > which already takes care of decreasing the refcount on the
> > "firmware"
> > node. We are then incorrectly decreasing the refcount on that node
> > again.
> >=20
> > This patch removes the unwarranted call to of_node_put().
> >=20
> > Fixes: ad6eb31ef903 ("firmware: arm_sdei: Add driver for Software
> > Delegated Exceptions")
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>=20
> Thanks!, I agree this is unwarranted.
> Is there a tool that picks these up? I remember sparse giving me a
> headache, but
> I don't remember this one... I probably cargo-culted it from
> somewhere else.

We stumbled upon this one on a test system. TBH I don't really know
much about these tools so I can't tell. That said, I sent 4 more fixes
on this bug (one more in drivers/firmware) so there definitively was
some cargo-culting happening.

Regards,
Nicolas

>=20
> Acked-by: James Morse <james.morse@arm.com>
>=20
>=20
> Thanks,
>=20
> James
>=20
>=20
> > ---
> >  drivers/firmware/arm_sdei.c | 1 -
> >  1 file changed, 1 deletion(-)
> >=20
> > diff --git a/drivers/firmware/arm_sdei.c
> > b/drivers/firmware/arm_sdei.c
> > index 1ea71640fdc2..dffb47c6b480 100644
> > --- a/drivers/firmware/arm_sdei.c
> > +++ b/drivers/firmware/arm_sdei.c
> > @@ -1017,7 +1017,6 @@ static bool __init sdei_present_dt(void)
> >  		return false;
> > =20
> >  	np =3D of_find_matching_node(fw_np, sdei_of_match);
> > -	of_node_put(fw_np);
> >  	if (!np)
> >  		return false;
> > =20
> >=20


--=-t7AYbqLg9t8BDYsYLWC5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlwFINMACgkQlfZmHno8
x/4MIwgAtHytTe+96hhXYF8/nhxaRJfvz0lYGsmJmhQbfPjpwkDntyvwImjoAvFr
VqJe0LVkzJ9UgcmJfv5dKnhGkMO5Mb2pG1j8HAnOIwDu1l8JFiJdAOpxIIJoPBvJ
0wtuGeAqq01Qu0jAqTCqNjPwUe++Mm+Hq8c/R0IHAKe8LVxNj5nCxp31lutZE1hY
YiqopW+uLORHTBIVVm+K8rg3wYnFf8z5DfmKx/ddwF+exEENo9vt+JxQvTL6/Duk
VdH+5JkPTS6oTMOKpcJIYc7MUnUrF09O6YzUv3RddsKpjtrJo0qXWBllzs+CAvAX
Q4IrhMVAb178QBxt83+YJjE1xhAapQ==
=L/YC
-----END PGP SIGNATURE-----

--=-t7AYbqLg9t8BDYsYLWC5--

