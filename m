Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E36C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33D120879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E33D120879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbeLEVtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 16:49:24 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51466 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbeLEVtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 16:49:24 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 46D5326C263
Received: by earth.universe (Postfix, from userid 1000)
        id F230A3C08D6; Wed,  5 Dec 2018 22:49:20 +0100 (CET)
Date:   Wed, 5 Dec 2018 22:49:20 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Rob Herring <robh@kernel.org>
Cc:     tiny.windzz@gmail.com,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] power/reset: axxia: Convert to using %pOFn instead of
 device_node.name
Message-ID: <20181205214920.cudnhomld6ejzsx6@earth.universe>
References: <20181124143138.28999-1-tiny.windzz@gmail.com>
 <CAL_JsqJ8XkowAJQjZoiuucAWqZuJh1ep2jCFor6NCq4pL3m-Cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e6xi732btapmst62"
Content-Disposition: inline
In-Reply-To: <CAL_JsqJ8XkowAJQjZoiuucAWqZuJh1ep2jCFor6NCq4pL3m-Cg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e6xi732btapmst62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 27, 2018 at 10:51:09AM -0600, Rob Herring wrote:
> On Sat, Nov 24, 2018 at 8:31 AM Yangtao Li <tiny.windzz@gmail.com> wrote:
> >
> > In preparation to remove the node name pointer from struct device_node,
> > convert printf users to use the %pOFn format specifier.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/power/reset/axxia-reset.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Thanks, but I already sent out the same patch and have queued it since
> no one picked it up.

Yeah, I did not find enough time to review patches in the last few
weeks. OTOH I don't see a previous patch with axxia in the Subject
in my mailbox anyways. FWIW I will skip this one.

-- Sebastian

>=20
> Rob
> >
> > diff --git a/drivers/power/reset/axxia-reset.c b/drivers/power/reset/ax=
xia-reset.c
> > index 4e4cd1c8fe50..b16013265142 100644
> > --- a/drivers/power/reset/axxia-reset.c
> > +++ b/drivers/power/reset/axxia-reset.c
> > @@ -65,7 +65,7 @@ static int axxia_reset_probe(struct platform_device *=
pdev)
> >
> >         syscon =3D syscon_regmap_lookup_by_phandle(dev->of_node, "sysco=
n");
> >         if (IS_ERR(syscon)) {
> > -               pr_err("%s: syscon lookup failed\n", dev->of_node->name=
);
> > +               pr_err("%pOFn: syscon lookup failed\n", dev->of_node);
> >                 return PTR_ERR(syscon);
> >         }
> >
> > --
> > 2.17.0
> >

--e6xi732btapmst62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwIR+AACgkQ2O7X88g7
+ppofA/9G+OsVfrqJYe0I+HptisNYd6w3O4J53mTyTFqneE51pXObCHfUNikbRdl
jCn1ByD+amv4GtmSyUCgDdpU588SkuK9eMDVrcZmMJ3WvtraaZFlsAU6hfFQy7OD
QHrH8PSJNoi2a8pL31MV5ZbIsbtzgg136HyNLJiHX/24v0RTZigc/95Da8o8OWZV
FyqnZrDiyqojBmPOlG0/1NlwHyb5ilNZkNQR7xzP2rmIQAXiBI8km4N7gqL0vjSz
U96JtN+Rlhci0V37Fm7ouOLrSN3OPxEkOn2hLOdbLfxnOyClFULnEtLTxQgWcrTP
e7lj4L1cvOtFnuZtdvvol/Cz+qXDePXIdaV0Qzj+P0JPShhiVsoLDJoBz+be8q0p
vMuiNxcvOMLvkv6ufJr2VYloYfinPJ9v46N4Od0HSxT/T/MMc/VzJoiIUmKXN5/M
AreKP/XuInNQ9e8wJJVfhg8K2MD8sGmGZ4z6rkstJ6jqli2bPYnI2XhDfVVG1iJo
CeWgJxSxnpe4Ot2mUA+zVjol3BXSNHW21gQc4tlqMaC/L9M0vADilNHEaUY3ZF2t
Dk59gGiKg6V9iEcc3papIF0lRoFCy3bonpoEX+WUu/dkCa/JuwRRGSEIq6UBf9yV
SY9dykIbiNRWxRm6ClXPMnSs3+/Om6bRicaVEUlG8k62bM7V2GU=
=A2K/
-----END PGP SIGNATURE-----

--e6xi732btapmst62--
