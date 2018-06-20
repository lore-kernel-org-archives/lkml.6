Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A886BC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5B820846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B5B820846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owl.eu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932435AbeFTNis (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:38:48 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:59797 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753202AbeFTNir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:38:47 -0400
X-Originating-IP: 208.88.110.46
Received: from localhost (mtl.savoirfairelinux.net [208.88.110.46])
        (Authenticated sender: hle@owl.eu.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 13ACD40020;
        Wed, 20 Jun 2018 13:38:42 +0000 (UTC)
Date:   Wed, 20 Jun 2018 09:38:41 -0400
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Marcus Wolf <linux@wolf-entwicklungen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: pi433: fix race condition in pi433_open
Message-ID: <20180620133841.GB17525@hle-laptop.local>
References: <20180620023326.GA30440@hle-laptop.local>
 <20180620083439.6ouovmhsc235aprw@mwanda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <20180620083439.6ouovmhsc235aprw@mwanda>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 20, 2018 at 11:34:39AM +0300, Dan Carpenter wrote:
> On Tue, Jun 19, 2018 at 10:33:26PM -0400, Hugo Lefeuvre wrote:
> > @@ -1178,6 +1152,11 @@ static int pi433_probe(struct spi_device *spi)
> >  	device->tx_active =3D false;
> >  	device->interrupt_rx_allowed =3D false;
> > =20
> > +	/* init rx buffer */
> > +	device->rx_buffer =3D kmalloc(MAX_MSG_SIZE, GFP_KERNEL);
> > +	if (!device->rx_buffer)
> > +		return -ENOMEM;
>=20
> We need to free device.

Fixed in v3. Thanks !

regards,
 Hugo

--=20
             Hugo Lefeuvre (hle)    |    www.owl.eu.com
4096/ 9C4F C8BF A4B0 8FC5 48EB 56B8 1962 765B B9A8 BACA

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEE5LpPtQuYJzvmooL3LVy48vb3khkFAlsqWNIACgkQLVy48vb3
khlKggf/fce3HJfIuJDLnq/PxVVkn91Bcx8YDR8vrI+ZZDt7Annl49mnzis03pqO
tfq1Y3anBpnOCcFJ8gsGUwvc/bBn/pEqoSjnV9s6JrFRConxCTVByYzR1Rz/Mi7I
PSS5u5HJqlwc36aBMENgcC9bGtZYinSejLlBTR8f5QCTIDIhTG44a/8IOqOJUkdp
tky91MVh9+a/6mxsBWe2k0WfOwTfik2pj/x2TATZ5MhYYi87/J2qz8SiljvdXFUZ
yKMD1tEJNaHY9SN83u7+XvhKMbF6gMpXvPinpit5Ehn6qs1M2Kv/Y9uTIexkbrut
/GxYkKUvjOUWEVHxvNEVOin8i448/g==
=WncX
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
