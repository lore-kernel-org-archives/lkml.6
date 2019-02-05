Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51045C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB482080F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbfBEMJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 07:09:14 -0500
Received: from sauhun.de ([88.99.104.3]:56746 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728782AbfBEMJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 07:09:11 -0500
Received: from localhost (unknown [46.183.103.8])
        by pokefinder.org (Postfix) with ESMTPSA id BB9252C0509;
        Tue,  5 Feb 2019 13:09:08 +0100 (CET)
Date:   Tue, 5 Feb 2019 13:09:06 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2] i2c: bcm2835: Clear current buffer pointers and
 counts after a transfer
Message-ID: <20190205120905.GB1045@kunai>
References: <20181227154225.5492-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Content-Disposition: inline
In-Reply-To: <20181227154225.5492-1-paul.kocialkowski@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 27, 2018 at 04:42:25PM +0100, Paul Kocialkowski wrote:
> The driver's interrupt handler checks whether a message is currently
> being handled with the curr_msg pointer. When it is NULL, the interrupt
> is considered to be unexpected. Similarly, the i2c_start_transfer
> routine checks for the remaining number of messages to handle in
> num_msgs.
>=20
> However, these values are never cleared and always keep the message and
> number relevant to the latest transfer (which might be done already and
> the underlying message memory might have been freed).
>=20
> When an unexpected interrupt hits with the DONE bit set, the isr will
> then try to access the flags field of the curr_msg structure, leading
> to a fatal page fault.
>=20
> The msg_buf and msg_buf_remaining fields are also never cleared at the
> end of the transfer, which can lead to similar pitfalls.
>=20
> Fix these issues by introducing a cleanup function and always calling
> it after a transfer is finished.
>=20
> Fixes: e2474541032d ("i2c: bcm2835: Fix hang for writing messages larger =
than 16 bytes")
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Stefan, Florian, any comment about this patch?


--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxZfOEACgkQFA3kzBSg
KbYpQw/+I5EVIhwbmysIh+L9Au4/Gm2PS/klKGFRPiiV5gJZWeYg6Pnb7exKsPet
Jht6B6C5nDf2c8UcGc4Sj3vdJMeu3hln3j8Xv/mQQo5bUYU2VYsf5+wTwrh8NFbH
CUBP32dXvZMyDl5wI4dDXwyiOOtJYwMr76SXaeQuxsNZITBPMqI8sl3TYbCeaT2x
/UoYyCD4GTBed3lRUknOqmtr07bbnsohBS3IFVKZMCiSSCoTAHNe9q3XptYVEdlp
0KyaaKrlEa4XvrZmolJMlgcHMoQMSptmARj6ZTl664WmwD90TrjsHoyPKAtFPn/B
bP+XzwsAJqhasN/CrUrebDxd1vzMSGtj0kShlQABvZRXN7DK4vdmLfKrOYcCZ5ra
bWigpqGuGOnyQOJCWfPh4o0EpHQt8Fqu06cKZLQDIGz7x7n7rqp5PRFJzxhGK3Go
gY7ESo/VZ0rXGawuYFWVpGw3r/TAWNNIR39v1vmN7+lr7mfnKjvnZnwOS7+HwcBN
CehQ9lS/pM2jvZZfs8mWbWx3wnmZ1tfWooacHBi9FRksTylHLoiOaPONfUXB4l5z
exhP7ryt4iN/HS/wAVUYcTVzpIlDsDyf0kwsfXwRg+rj9ykl6DKC72nnK1bg/lEh
HPuolBp1p71U5oY3AgfDSwtuEL1CR6IU/+vI6fnWTgRMJqbyxNY=
=fC0y
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
