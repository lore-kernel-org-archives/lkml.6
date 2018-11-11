Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716D5C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 02:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C95F20989
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 02:47:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C95F20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbeKKMeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 07:34:06 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48728 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbeKKMeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 07:34:06 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id B3B0326406F
Received: by earth.universe (Postfix, from userid 1000)
        id 027EF3C08D6; Sun, 11 Nov 2018 03:46:48 +0100 (CET)
Date:   Sun, 11 Nov 2018 03:46:48 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, letux-kernel@openphoenux.org
Subject: Re: [PATCH RFC] bluetooth: add uart h4 devices via serdev/devicetree
Message-ID: <20181111024648.7rt7rlhaqihtqecv@earth.universe>
References: <20181110232034.17277-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k52q5scznxewnt47"
Content-Disposition: inline
In-Reply-To: <20181110232034.17277-1-andreas@kemnade.info>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k52q5scznxewnt47
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Nov 11, 2018 at 12:20:34AM +0100, Andreas Kemnade wrote:
> This is a first try to be able to use h4 devices specified in
> the devicetree, so you do not need to call hciattach and
> it can be automatically probed.
>=20
> Of course, proper devicetree bindings documentation is
> missing. And also you would extend that by regulator/
> enable gpio settings.
>=20
> But before proceeding further it should be checked if the
> general way of doing things is right.
>=20
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---

Patch looks good to me, just one note

>  drivers/bluetooth/hci_h4.c | 78 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 78 insertions(+)
>=20

[...]

> +	return hci_uart_register_device(hu, &h4p);
> +}
> +
> +static void hci_h4_remove(struct serdev_device *serdev)
> +{
> +	struct h4_device *h4dev =3D serdev_device_get_drvdata(serdev);
> +
> +	hci_uart_unregister_device(&h4dev->hu);
> +}

I suggest to add a patch introducing

devm_hci_uart_register_device()

All existing users of hci_uart_register_device() could use it
(your driver, hci_bcm, hci_h5, hci_ll, hci_nokia and hci_qca)
and all drivers but hci_qca can drop their remove function.

-- Sebastian

--k52q5scznxewnt47
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlvnmBUACgkQ2O7X88g7
+pqzMQ//VqC1GTpZhAWWF3ZfWkVRrzBBUvcFGws0Mjlvc56FUJVD//VCGWmBm9Q4
H4jgogFIpjAtdxOQj3TnjqMcGO4XaWkj2hV+3X/NxkgBdAZYOR6Pz4nkcZQRL01R
l1CR4gCF7K9zGd+yj2XTOM4Rs8HmUvkU37rlaALe7J4tzd2fPf6wafztAKSDTOmL
1vw8c9/hT2jeadfrlK8QED0a2C+d3PE0fcWrpY0SU+lBI2CgT/fb7cEHk1xpJ9BC
ALIYxXKWOLoBPe67FrNvghoQre4SPu4BUfoQJZJ4uC9st8B16RgaomoBk1Y2rUHr
iTxxyBoFyX0lTB5lMTKPscHTNsawpAq1wf9ENkEjNztLn2d8hk4N68H5SGfTXpH6
rgw2081hRP/dUe3oADItWIRJ6jFRSUuorE/KeLpZHPN+arJwFGK292hkCvPbQzn2
ncTpxSfdSQDlHc5lhPH2v7ylhmrRhnkwmAdyRuwkIEYkKLyxwDH++GlkGxLKyVc7
aOqQ8VVKDlos1u+vbXWew8OaMWfKS5PCLbAdTuSb8ntHSdouIacbv+ZeSarxgTl/
HV0mLjr1haU8JPRJE7KNetQyANoR2mUEB4cw7pxwjaTA45Uf14wuhNYN81I/R7VF
NZ29WLtHf8BHf7h/MgU6xF1/mv9jJD8rTojrlXzy4extkVmuvQ4=
=WtdZ
-----END PGP SIGNATURE-----

--k52q5scznxewnt47--
