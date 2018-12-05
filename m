Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710A8C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B45220879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B45220879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbeLEWk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:40:57 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51692 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeLEWk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 17:40:56 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 7BE59267733
Received: by earth.universe (Postfix, from userid 1000)
        id 395113C08D6; Wed,  5 Dec 2018 23:40:52 +0100 (CET)
Date:   Wed, 5 Dec 2018 23:40:52 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Claudiu.Beznea@microchip.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] power: reset: at91-poweroff: move shdwc related data
 to one structure
Message-ID: <20181205224052.34o3cmh3y3htchcj@earth.universe>
References: <1541416443-4321-1-git-send-email-claudiu.beznea@microchip.com>
 <1541416443-4321-3-git-send-email-claudiu.beznea@microchip.com>
 <20181106210933.GU24212@piout.net>
 <6719a808-e704-3c63-f592-3b90d44ccbfe@microchip.com>
 <20181107172340.GF21694@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7jup4dhfa2jvl5qs"
Content-Disposition: inline
In-Reply-To: <20181107172340.GF21694@piout.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7jup4dhfa2jvl5qs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 07, 2018 at 06:23:40PM +0100, Alexandre Belloni wrote:
> On 07/11/2018 14:54:17+0000, Claudiu.Beznea@microchip.com wrote:
> > Hi Alexandre,
> >=20
> > On 06.11.2018 23:09, Alexandre Belloni wrote:
> > > Hi Claudiu,
> > >=20
> > > On 05/11/2018 11:14:26+0000, Claudiu.Beznea@microchip.com wrote:
> > >>  static int __init at91_poweroff_probe(struct platform_device *pdev)
> > >> @@ -154,16 +160,22 @@ static int __init at91_poweroff_probe(struct p=
latform_device *pdev)
> > >>  	u32 ddr_type;
> > >>  	int ret;
> > >> =20
> > >> +	at91_shdwc =3D devm_kzalloc(&pdev->dev, sizeof(*at91_shdwc), GFP_K=
ERNEL);
> > >> +	if (!at91_shdwc)
> > >> +		return -ENOMEM;
> > >> +
> > >=20
> > > Is there any real benefit that will offset the time lost for that
> > > allocation at boot time?
> >=20
> > No, I haven't run benchmarks on this. I only wanted to have them groupe=
d in
> > one structure. Please let me know if you have some tests in mind.
> >=20
>=20
> Well, it is probably not much but small things adds up. Having it as a
> global structure is probably good enough.

I suppose I will get a new patch with this change?

-- Sebastian

>=20
> > >=20
> > > I understand you are then testing at91_shdwc to know whether the driv=
er
> > > already probed once. But, the driver will never probe twice as there =
is
> > > only one shutdown controller on the SoC and anyway, If it was to probe
> > > twice, it will still work as expected.
> >=20
> > I had in mind the scenario where the driver would be compiled as module=
=2E I
> > know insmod already does this checking. I'm ok to remove this checking.=
 I
> > will do it in next version. With this I will also remove devm_kzalloc()=
 of
> > at91_shdwc.
> >=20
>=20
> Thanks,
>=20
> --=20
> Alexandre Belloni, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

--7jup4dhfa2jvl5qs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwIU/QACgkQ2O7X88g7
+prpcBAApVtD/m59e95DIdgGh2IqxIfqkmorBI4Yy/SQD7QokwmVns/8AUPhwxDO
SdulNqMPGCkm7QvUODDMJ91VSUwv6nnBY7ABu0R6eBi188c0V1g0qukrX4j0fbQh
7q+HxhcmWJddtkSE3QSYzsVb9+hrtwaYy47zehqzDNiloxJj0P6iFQbZmXJwIr2/
rVRLnMk99Aj+fUGcpu1Far2ojzftVFvsUGm80kYS8iMi6kS3zhxzXweo9QZr0wNb
O9trFVRGI7Y/jxdQGNevc8zJGMmfLXRpN7JZ4Mwyidckc2OWwMNXe+3TBmOZy/Wi
Fckz5OKKymitxe3d41XLwnsxNglAmDwz7HLTLdpszabYH89FnkgXFvh5csHZq9E4
NMapiMD8uhZevVF2b5Gkk0PQGnijV+OZNsM0AzyJIWj41rq2+OfJgaJ3vMNDeMGn
mbzUYjCxw0FfKlwvigTRYq/4c/NdS5vdmfnNsyshg70/ctCcXyHBPPR6GAWTX4tG
XEdIoGfexgIFT8lvspSEucRtsS2e25bvBCDB8gvstvXBllrt8FJqhZ78dnxFzr1Z
Bn+KlwCoatA7Y4w7A0zPrHIY93m9zyuBXhkAsSkKmXh0YN4nPtGyAmRcT78f985s
2TiN3zGNwG6o5g0dHF8k6NlzhoNnI6mvgZYMlNwCtUUTBt0SC0c=
=YuLw
-----END PGP SIGNATURE-----

--7jup4dhfa2jvl5qs--
