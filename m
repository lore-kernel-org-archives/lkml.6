Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F40DC2BC61
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 22:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FBED2082D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 22:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FBED2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeJ2HRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 03:17:24 -0400
Received: from sauhun.de ([88.99.104.3]:58178 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbeJ2HRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 03:17:24 -0400
Received: from localhost (unknown [87.113.172.131])
        by pokefinder.org (Postfix) with ESMTPSA id A470A4A1CA7;
        Sun, 28 Oct 2018 23:31:22 +0100 (CET)
Date:   Sun, 28 Oct 2018 22:31:17 +0000
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 2/2] i2c: Clear client->irq in i2c_device_remove
Message-ID: <20181028223116.GJ1882@kunai>
References: <20181019085958.32694-1-ckeepax@opensource.cirrus.com>
 <20181019085958.32694-2-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nywXBoy70X0GaB8B"
Content-Disposition: inline
In-Reply-To: <20181019085958.32694-2-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nywXBoy70X0GaB8B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 19, 2018 at 09:59:58AM +0100, Charles Keepax wrote:
> The IRQ will be mapped in i2c_device_probe only if client->irq is zero and
> i2c_device_remove does not clear this. When rebinding an I2C device,
> whos IRQ provider has also been rebound this means that an IRQ mapping
> will never be created, causing the I2C device to fail to acquire its
> IRQ. Fix this issue by clearing client->irq in i2c_device_remove,
> forcing i2c_device_probe to lookup the mapping again.
>=20
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Adding Benjamin here again. Also, should there be a Fixes: tag?

> ---
>  drivers/i2c/i2c-core-base.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 656f0a6fe3adf..28460f6a60cc1 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -430,6 +430,8 @@ static int i2c_device_remove(struct device *dev)
>  	dev_pm_clear_wake_irq(&client->dev);
>  	device_init_wakeup(&client->dev, false);
> =20
> +	client->irq =3D 0;
> +
>  	return status;
>  }
> =20
> --=20
> 2.11.0
>=20

--nywXBoy70X0GaB8B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvWOLQACgkQFA3kzBSg
KbarpxAAgDPF5ZTzxqcRaHNqgT7B1zs+FSEUT4PilL5Z821riy7NoaVCu9ZPK9h7
Mm3rpjhyK9+lwoeoJYmmxB1zZtO8cARubMM7qqdUg8FtYs9PVw2lcRs3Iuk2V4M2
oSJg3ND6NZsF0odk+PhhUhw6rGNDfq4Pk1w3aCr/HHtw9uoh/Rr2IMUavxYvyxbL
hosvpNS1sCcSQK+oNCvWnzVQN+ThBtJ2wvYsBHh9BO+dgIEseASb5JYZgqvfqHGM
wTriA3wB0LVbKbTfP8TN5aJRL0UW6oSYiRR7nx7Yy57Wk4hPWQw2SP/iQ22HWPgF
elHvHL+TG7VJ1n5MjoF15y+8HRaJE30r77IlirU4cw7Kig1/YZAVSGSP55le37qn
PfvFRFSTt51FnQd41XOMQlhI2K/FkbY492oQFeRGl68yQWQmiKllMtAnQi+F/qvI
mXeLW0cGF8uY2PqS6tGupMh+hTxM3EuNO/B1TKcBi0e1WV4QsgmtOzh9Ot/hZgZ/
NqOeRfZXsSIpcMnVXZ3x5tGZ1MPdlSWjxZ7Pa7n0xX9oW0mixPiE9G2uR5tdPSGn
z7QPdlzr0qYSn/l9BkmpGpQVEnal+GXV+sCamSannlW2RGDN3dLiegphHCQpQ8au
xuZm7aYWmlPCBcJMKY0AP4K/lmoP+LiP8p23L2ghF8ZDYmy2a7U=
=o0VB
-----END PGP SIGNATURE-----

--nywXBoy70X0GaB8B--
