Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBEFC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8056214DA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="CeM10h0S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8056214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbeLEWQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:16:25 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:52502 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbeLEWQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 17:16:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bsSaAMtwr+45q3a68kABZNi0Fa2kMSt3ZgqNY295MFM=; b=CeM10h0S8JU+V9fxWEXt+HCqX
        NaeCFo0CAThl8I8gakTuetDh/amkdrdRYwVngMvwwZJgcRrReBli5x6O9cAK4bewn1FNhQIRjYAqk
        3I8hbsNOoSSvgQ5sL18HspiEoRc9GQImNqv2TSgsDHWWU/rIUTrDmGf311QROiDsiUdVQ=;
Received: from p5dcc3ed6.dip0.t-ipconnect.de ([93.204.62.214] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gUfSu-00069j-Sq; Wed, 05 Dec 2018 23:16:20 +0100
Date:   Wed, 5 Dec 2018 23:15:30 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Johan Hovold <johan@kernel.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH 2/5] gnss: sirf: power on logic for devices without
 wakeup signal
Message-ID: <20181205231530.2fe6bc33@aktux>
In-Reply-To: <20181205150116.GF15689@localhost>
References: <20181118215801.12280-1-andreas@kemnade.info>
        <20181118215801.12280-3-andreas@kemnade.info>
        <20181205150116.GF15689@localhost>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/JRj.6il/9mwX=/cOns4r66X"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JRj.6il/9mwX=/cOns4r66X
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Dec 2018 16:01:16 +0100
Johan Hovold <johan@kernel.org> wrote:

> On Sun, Nov 18, 2018 at 10:57:58PM +0100, Andreas Kemnade wrote:
> > Some Wi2Wi devices do not have a wakeup output, so device state can
> > only be indirectly detected by looking whether there is communitcation
> > over the serial lines.
> > Additionally it checks for the initial state of the device during
> > probing to ensure it is off.
> > Timeout values need to be increased, because the reaction on serial line
> > is slower and are in line  with previous patches by
> > Neil Brown <neilb@suse.de> and  H. Nikolaus Schaller <hns@goldelico.com=
>.
> >=20
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >  drivers/gnss/sirf.c | 97 +++++++++++++++++++++++++++++++++++----------=
--------
> >  1 file changed, 65 insertions(+), 32 deletions(-)
> >=20
> > diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
> > index b5efbb062316..6a0e5c0a2d62 100644
> > --- a/drivers/gnss/sirf.c
> > +++ b/drivers/gnss/sirf.c
> > @@ -22,8 +22,8 @@
> > =20
> >  #define SIRF_BOOT_DELAY			500
> >  #define SIRF_ON_OFF_PULSE_TIME		100
> > -#define SIRF_ACTIVATE_TIMEOUT		200
> > -#define SIRF_HIBERNATE_TIMEOUT		200
> > +#define SIRF_ACTIVATE_TIMEOUT		1000
> > +#define SIRF_HIBERNATE_TIMEOUT		1000 =20
>=20
> We shouldn't increase the timeouts for the general case where we have
> wakeup connected.
>=20
Well, in most times they are not hit in the general case, only once
if the internal state is not in sync.
But I can add a second pair of defines with more refined defines.

> >  struct sirf_data {
> >  	struct gnss_device *gdev;
> > @@ -45,26 +45,14 @@ static int sirf_open(struct gnss_device *gdev)
> >  	int ret;
> > =20
> >  	data->opened =3D true;
> > -	ret =3D serdev_device_open(serdev);
> > -	if (ret)
> > -		return ret;
> > -
> > -	serdev_device_set_baudrate(serdev, data->speed);
> > -	serdev_device_set_flow_control(serdev, false); =20
>=20
> And also here, I think we shouldn't change the general case (wakeup
> connected) unnecessarily. Currently user space can request the receiver
> to remain powered, while not keeping the port open unnecessarily.
>=20
Yes, that usecase makes sense. There is even no need to keep that
device opened in the no-wakeup case. If I just open the serdev
during state change, code will probably be cleaner.

> > =20
> >  	ret =3D pm_runtime_get_sync(&serdev->dev);
> >  	if (ret < 0) {
> >  		dev_err(&gdev->dev, "failed to runtime resume: %d\n", ret);
> >  		pm_runtime_put_noidle(&serdev->dev);
> >  		data->opened =3D false;
> > -		goto err_close;
> >  	}
> > =20
> > -	return 0;
> > -
> > -err_close:
> > -	serdev_device_close(serdev);
> > -
> >  	return ret;
> >  }
> > =20
> > @@ -73,8 +61,6 @@ static void sirf_close(struct gnss_device *gdev)
> >  	struct sirf_data *data =3D gnss_get_drvdata(gdev);
> >  	struct serdev_device *serdev =3D data->serdev;
> > =20
> > -	serdev_device_close(serdev);
> > -
> >  	pm_runtime_put(&serdev->dev);
> >  	data->opened =3D false;
> >  }
> > @@ -109,6 +95,11 @@ static int sirf_receive_buf(struct serdev_device *s=
erdev,
> >  	struct sirf_data *data =3D serdev_device_get_drvdata(serdev);
> >  	struct gnss_device *gdev =3D data->gdev;
> > =20
> > +	if ((!data->wakeup) && (!data->active)) { =20
>=20
> You have superfluous parenthesis like the above throughout the series.
>=20
OK, will reduce them.

> > +		data->active =3D 1; =20
>=20
> active is bool, so use "true".
>=20
> > +		wake_up_interruptible(&data->power_wait);
> > +	}
> > +
> >  	/*
> >  	 * we might come here everytime when runtime is resumed
> >  	 * and data is received. Two cases are possible
> > @@ -149,6 +140,25 @@ static int sirf_wait_for_power_state(struct sirf_d=
ata *data, bool active,
> >  {
> >  	int ret;
> > =20
> > +	/* no wakeup pin, success condition is that
> > +	 * no byte comes in in the period
> > +	 */ =20
>=20
> Multiline comment style needs to be fixed throughout. Also use sentence
> case and periods where appropriate.
>
OK. maybe I did believe too much in checkpatch.pl. It likes this patch.
I thought it would moan about such basic things.

> > +	if ((!data->wakeup) && (!active) && (data->active)) {
> > +		/* some bytes might come, so sleep a bit first */
> > +		msleep(timeout); =20
>=20
> This changes the semantics of the functions and effectively doubles the
> requested timeout.
>
So maybe I should sort this block out into a properly-named function
with properly named constants?
The logic is to give the device some time first to calm down. And then
check for some time if it is really down.
=20
> > +		data->active =3D false;
> > +		ret =3D wait_event_interruptible_timeout(data->power_wait,
> > +			data->active =3D=3D true, msecs_to_jiffies(timeout));
> > +
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		/* we are still getting woken up -> timeout */
> > +		if (ret > 0)
> > +			return -ETIMEDOUT;
> > +		return 0;
> > +	}
> > +
> >  	ret =3D wait_event_interruptible_timeout(data->power_wait,
> >  			data->active =3D=3D active, msecs_to_jiffies(timeout));
> >  	if (ret < 0)
> > @@ -203,21 +213,48 @@ static int sirf_set_active(struct sirf_data *data=
, bool active)
> >  static int sirf_runtime_suspend(struct device *dev)
> >  {
> >  	struct sirf_data *data =3D dev_get_drvdata(dev);
> > +	int ret;
> > =20
> >  	if (!data->on_off)
> >  		return regulator_disable(data->vcc); =20
>=20
[..] minor  style issues ... will fix, still wondering
why checkpatch does not complain. Just saved the patch again  and
checked.
> > +
> > +	/* we should close it anyways, so the following receptions
> > +	 * will not run into the empty
> > +	 */ =20
>=20
> Not sure what you mean here, please rephrase.
>=20
If the serdev is closed, nothing will be sent to a probably
not-existing-anymore gnss device.
> > +	serdev_device_close(data->serdev);
> > +	return 0;
> >  }
> > =20

[...] more minor style issues
>=20
> > +	ret =3D sirf_set_active(data, true);
> > +
> > +	if (!ret)
> > +		return 0; =20
>=20
> Add an error label instead, and return 0 unconditionally in the success
> path.
>=20
Ok, makes sense.

> > =20
> > -	return sirf_set_active(data, true);
> > +	if (!data->on_off)
> > +		regulator_disable(data->vcc);
> > +err_close_serdev:
> > +	serdev_device_close(data->serdev);
> > +	return ret;
> >  }
> > =20
> >  static int __maybe_unused sirf_suspend(struct device *dev)
> > @@ -311,18 +348,6 @@ static int sirf_probe(struct serdev_device *serdev)
> >  	if (data->on_off) {
> >  		data->wakeup =3D devm_gpiod_get_optional(dev, "sirf,wakeup",
> >  				GPIOD_IN);
> > -		if (IS_ERR(data->wakeup))
> > -			goto err_put_device; =20
>=20
> You still want to check for errors here.
>=20
Yes, I should only ignore NULL here..

Regards,
Andreas

--Sig_/JRj.6il/9mwX=/cOns4r66X
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlwITgIACgkQfb1qx03i
kySJUQ/5AdVvvxGirQE7iWN0tVCXCeF/A/QR1mBOQwy9ilDcqZg5OFsDKTKMOIsC
54xSCJOBiUEcRIZPXTD/ugtfH7nDKysMrB6hdsXmOoZnpcxtQD1CZLoe/hROl1nd
A5R+KWzWdY+UG+MdPibkDfjodKLkPPSQu+oP1nWe9+Pi5zCuJa2ry6vAHO+kRaHx
UgNrDfLizPOM3ECmAshD41E/AECISuaVSldp6ABqlF8v4llPoCDrpI4e8z0U8guU
Y37YJ49B0NnfOXQZvLcHE2ItniJS8vrA4IVrZ0F2DhRyicuNqboV4sw416OCth9h
XyKVcU9LpmQ+E16bT7Sjby2BlKv64KR+r/OAuvHVlHL1E1Q7leWPwzMnkv3rADRb
TbLF9/cOelCcmQztlCX7bGIJAY72cc6yXOhWJ75qK1LPLxJoY7AL3Hibgx2czgPK
rvzKwAJKcJeaIwM3GDVeI9mtp5jqrXHg0jl6RvOlqRL99LknVoB58iRaP364LItd
UitseSNl50T1kKA3BM4Gf3MFnlsva0KIweLeX+r/vhbGHs/BKHt4GKPWbV+cMXic
YsoX3c34NqK7AJFJS4dPlF4+8nV43rOWssYcQTrg0+jWfll2cjaxVN0Lz++jJVbK
P3+FHWt+t5Lrs8T5vSaXI3lBhNkMsY4cy/ei5wmcaTW8RSGfnhQ=
=eumg
-----END PGP SIGNATURE-----

--Sig_/JRj.6il/9mwX=/cOns4r66X--
