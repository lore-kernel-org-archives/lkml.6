Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671E5C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C5A20879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C5A20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbeLEWia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:38:30 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51680 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbeLEWi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 17:38:29 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 51D11267733
Received: by earth.universe (Postfix, from userid 1000)
        id AC0163C08D6; Wed,  5 Dec 2018 23:38:25 +0100 (CET)
Date:   Wed, 5 Dec 2018 23:38:25 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Claudiu.Beznea@microchip.com
Cc:     Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] power: reset: at91-poweroff: check shdwc data
 structure at the beginning of probe
Message-ID: <20181205223825.vkye6tgvan2laxlu@earth.universe>
References: <1541416443-4321-1-git-send-email-claudiu.beznea@microchip.com>
 <1541416443-4321-4-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="molrisa3iqg5uhvw"
Content-Disposition: inline
In-Reply-To: <1541416443-4321-4-git-send-email-claudiu.beznea@microchip.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--molrisa3iqg5uhvw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 05, 2018 at 11:14:28AM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> Check at91_shdwc before continuing with probe since we want only one inst=
ance of
> this driver. Inspired from commit 9f1e44774be5 ("power: reset: at91-power=
off:
> do not procede if at91_shdwc is allocated").
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

This depends on patch 2, so I skipped this one.

-- Sebastian

>  drivers/power/reset/at91-poweroff.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at=
91-poweroff.c
> index 48661e04a3de..e75d8f0f0526 100644
> --- a/drivers/power/reset/at91-poweroff.c
> +++ b/drivers/power/reset/at91-poweroff.c
> @@ -160,6 +160,9 @@ static int __init at91_poweroff_probe(struct platform=
_device *pdev)
>  	u32 ddr_type;
>  	int ret;
> =20
> +	if (at91_shdwc)
> +		return -EBUSY;
> +
>  	at91_shdwc =3D devm_kzalloc(&pdev->dev, sizeof(*at91_shdwc), GFP_KERNEL=
);
>  	if (!at91_shdwc)
>  		return -ENOMEM;
> --=20
> 2.7.4
>=20

--molrisa3iqg5uhvw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwIU2EACgkQ2O7X88g7
+prIDA//U8cbco0f57BpAw5fvYKg3OUiZ+k8pD1BhqrSsM/VfXF9PZm4uDQAP0EU
jcNmwCYrjV8jX0a9RA/ub29pj4Bl53608IN1cb9h4mnDuuyjVoX/T92gI6gbk+MT
dQow9HmkDB4ICCwefrthCd7IIwSXDlxf/COyMj8wZoSIih1/BtKnzjvnnw7ahPQX
btK/HrbGU/RLe1QgXq7X0VTnr6PPFB8XVbkoHr94yVO2jwKclbkB69wUK7NkHq5S
ahU/X3NPaFAEgH8xfZyw+jFMdxK8HVux5RsKOidIPJab9PE3sFb2VCgwIpMkNHQz
fIJiG9rL0JxUXKEa9mNl9pnGKG3LO0FmqGZqX9tuqs8EfvqmL9sI2B0+TKkqj41S
lm7N7O8gO4yRBCR8NmVDrCL+ZOxwqchKN0C4+RMBtiOxumtIyfX82h6RGI3vZW2n
n7QpoRPYeIlFByTd6yYGZPnsvDxs5thwpG0Wn4VmKlbGYO1ZzQjjK9aFuPSmRuGk
IqIsFH6TszJfQ00quVcxMBwrq9GxmJCXzwGeCLWq5ZRUm7iKLgf5R3664tdgLlnh
OddntHIGRcWF1q+/p2gAu1TSlB2vJZldgX/kHvHN8ARA3+i6ZMYeKYcobGOJP4yS
P0UR7v2GYyPT40XVNmpdycCrHxUsClOt862xMxbVBiBoTI7Babc=
=chEH
-----END PGP SIGNATURE-----

--molrisa3iqg5uhvw--
