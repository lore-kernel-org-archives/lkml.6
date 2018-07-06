Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB63C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 756C32075B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 756C32075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933920AbeGFRE7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:04:59 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49828 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932746AbeGFRE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:04:56 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 056D127A9CE
Date:   Fri, 6 Jul 2018 19:04:52 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     Mike Looijmans <mike.looijmans@topic.nl>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org,
        Julia Lawall <julia.lawall@lip6.fr>, sil2review@lists.osadl.org
Subject: Re: [PATCH] power: supply: ltc2941-battery-gauge: Release
 device_node in ltc294x_i2c_probe()
Message-ID: <20180706170452.xw3w56dgtj4j4tru@earth.universe>
References: <1524954955-22107-1-git-send-email-khoroshilov@ispras.ru>
 <20180501123908.z3kuokp2b6umnnda@earth.universe>
 <8fef316f-85d0-0bd4-4bbe-2d8330dfe2ec@ispras.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sgp437usmp7xmvlg"
Content-Disposition: inline
In-Reply-To: <8fef316f-85d0-0bd4-4bbe-2d8330dfe2ec@ispras.ru>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sgp437usmp7xmvlg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 08, 2018 at 10:16:31PM +0300, Alexey Khoroshilov wrote:
> On 01.05.2018 15:39, Sebastian Reichel wrote:
> > On Sun, Apr 29, 2018 at 01:35:55AM +0300, Alexey Khoroshilov wrote:
> >> There is of_node_get(client->dev.of_node) in ltc294x_i2c_probe(),
> >> but these is no of_node_put() somethere in the driver.
> >>
> >> The patch adds one on error and normal paths.
> >>
> >> Found by Linux Driver Verification project (linuxtesting.org).
> >>
> >> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> >=20
> > That is ugly. Let's replace of_property_read_u32(np, ...) with
> > device_property_read_u32(dev, ...) and get rid of np instead.
>=20
> Ok, I will prepare v2.
>=20
> What is the right way to replace
> info->supply_desc.name =3D np->name;
> ?
>=20
> If lifetime of 'client->dev.of_node' =3D 'np' cannot be less than lifetime
> of 'client->dev', should we use just
> info->supply_desc.name =3D client->dev.of_node->name;
> ?

It looks like I never responsed to this, sorry for the delay.
Your suggestion looks fine.

-- Sebastian

--sgp437usmp7xmvlg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAls/oTQACgkQ2O7X88g7
+pq9xw//V+h6sEIzoTlgvBqXNPwpDULp4u31CGbC5taCrRW3sSAUxrSf2Bwixr1i
9yhwEelcRrQkkZO3Z4gp8B3z2tEVVw8H6x8DmbI6k4ZGeZgBKiH6w92+PDsGoo3E
NlcTRN/MjX3Z6zkilIpOV9k+EMDDZdFHT4tS6PHxVh8KFFZ85qLBkpkoXi7rjEKf
xPJTd6yKdXGy4OkMtDFRONvqJHOA55+aMxzzLC5DBdEg1c2Vwpaa9K+cV4UZBRjb
3mrCJsdgmP+uzbbSrWRdq1aU1Lfb6gNiXJna1RIVeJG4MwQyw7jLLBU0mNzg6lMx
gKBk8ohWH+7AJnF3SoKJOIZJEeuZbo90Lx0IyHTsneh4F8oXYrkKXxj6ffwFm+BO
weMeCbYvQKBtoMzhJkm76VSvP40pdihCbcpqYoFJYlbXDAjMJ4pndrxod7wfpuwT
rYorDKS9OzWXvKjxrpFmczU9hyLW4oFr1xk4oPhhNFezGkpbWcmhqsXc4roaiAYe
MfBhqCjm0FrulJEtwHaaLVz0O41AFQjdHwezmfwubI576PIRArQ43UCjgl79dlE6
yAAg5I+U9Cug5c/yDTbwQ9a7dpty7KxEmTaMbV7+gstccofDTTKvtrOK41GquhbL
394dzVfTYjbe4zh03uVA8xkREjX2RVoOTDTRmOVJxxAnIlJF2rc=
=pGHf
-----END PGP SIGNATURE-----

--sgp437usmp7xmvlg--
