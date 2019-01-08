Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A891C43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBCE0205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732564AbfAHThr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:37:47 -0500
Received: from sauhun.de ([88.99.104.3]:44108 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731786AbfAHThp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:37:45 -0500
Received: from localhost (p54B337DA.dip0.t-ipconnect.de [84.179.55.218])
        by pokefinder.org (Postfix) with ESMTPSA id 4626C3E48B8;
        Tue,  8 Jan 2019 20:37:43 +0100 (CET)
Date:   Tue, 8 Jan 2019 20:37:39 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Yi Zeng <yizeng@asrmicro.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: dev: prevent adapter retries and timeout being set
 as minus value
Message-ID: <20190108193739.owmxiosvgtl3nufk@ninjato>
References: <1546864661-19407-1-git-send-email-yizeng@asrmicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="q27njlkdxmceqiql"
Content-Disposition: inline
In-Reply-To: <1546864661-19407-1-git-send-email-yizeng@asrmicro.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q27njlkdxmceqiql
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 07, 2019 at 08:37:41PM +0800, Yi Zeng wrote:
> If set adapter->retries to minus value from user space via ioctl,
> will make __i2c_transfer and __i2c_smbus_xfer jump the calling to
> adapter->algo->master_xfer and adapter->algo->smbus_xfer that
> registered by the underlying bus drivers, and return value 0 to
> all the callers. The bus driver will never be accessed anymore by
> all users, besides, the users may still get successful return value
> without any error or information log print out.
>=20
> If set adapter->timeout to minus value from user space via ioctl,
> will make the retrying loop in __i2c_transfer and __i2c_smbus_xfer
> always break after the the first try, due to the time_after always
> returns true.
>=20
> Signed-off-by: Yi Zeng <yizeng@asrmicro.com>

Please run checkpatch.pl on your patch. It found two issues:

ERROR: code indent should use tabs where possible
#34: FILE: drivers/i2c/i2c-dev.c:480:
+                        return -EINVAL;$

WARNING: please, no spaces at the start of a line
#34: FILE: drivers/i2c/i2c-dev.c:480:
+                        return -EINVAL;$


--q27njlkdxmceqiql
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlw0+/8ACgkQFA3kzBSg
KbYSshAAnzZE+HczY3uslaNw5nyyKYc2JLsI7ZTagqp+o9IlSBoR4uafDBPuK76A
8MotMFyvQo/C3D5wu4WL6GWqj28mk7rUDm5x++Xk2uNDqiiBj7huAIO/bYs24ny8
QJhyNrzUIZvVBkYyurRbnxV0NlaStkmGKu7DRFvfBmaRWQPSXl3V9DpHnNwRggq6
GEYMFfIoCxjYW3L2qB3RPk/LleUdX1DYz3xTtFc38hjbqrUdz+9OMhHK68SQgF2o
rUbRkqQtkGHJTE/1F3C7h/L2q43Xdk4X7gmzN4xbf7jlI/lq6/5Cwr6x1l9AnvjE
wojV4C5TVucFJPpmLTP4OjwVd0VQiZVshnkBzl71KlZImphP/74nMtBwUtb+mDPi
3+VBcDNcce6X1eBvyZ1+SKZgQ/3fMsmujy6TsRMfNwBYeO+w+0Ni6CQiS4CwqlaC
r7YQjKYr7ObRhOoqjrB4ehmHXci33H27FrJ2/OE0F47xy/KpgkzLnAZE3lE2rahL
nLUhgGE1OH8cxENq8tKRLzAv9h7w5yQmFI0EAJFdjpt5xmXeN/nZP5BUKWT+D2Bh
LgbNAfo5ni/y8wlG2N5oWS8iXKjWpuG8gXSMO7/2zLAgfrbS8tzyxEnZ/gasnZOG
LBXjjStQIkjPQHafPl0vtZSVOTmu7vjlWE+v11bw0RTTxN0TaNc=
=vTwj
-----END PGP SIGNATURE-----

--q27njlkdxmceqiql--
