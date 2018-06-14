Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D3BD3C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 01:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81359208CC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 01:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81359208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owl.eu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935949AbeFNBKn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 21:10:43 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:40579 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935513AbeFNBKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 21:10:42 -0400
X-Originating-IP: 70.80.172.8
Received: from localhost (modemcable008.172-80-70.mc.videotron.ca [70.80.172.8])
        (Authenticated sender: hle@owl.eu.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 1D0D51BF206;
        Thu, 14 Jun 2018 01:10:47 +0000 (UTC)
Date:   Wed, 13 Jun 2018 21:10:37 -0400
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marcus Wolf <linux@wolf-entwicklungen.de>,
        linux-kernel@vger.kernel.org, kernelnewbies@kernelnewbies.org
Subject: Re: [PATCH v2] staging: pi433: fix race condition in pi433_ioctl
Message-ID: <20180614011037.GA21075@hle-laptop.local>
References: <20180613014741.GC2265@hle-laptop.local>
 <20180613091649.r3bck3wjma6tmjet@mwanda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <20180613091649.r3bck3wjma6tmjet@mwanda>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dan,

> There is no need for this comment, since it's obvious.  Also if you use
> simpler names then the copy fits on one line:
>=20
> 		if (copy_from_user(&tx_cfg, argp, sizeof(tx_cfg)) {
>=20
>=20
> > +		mutex_lock(&device->tx_fifo_lock);
> > +		if (copy_from_user(&tx_cfg_buffer, argp,
> > +				   sizeof(struct pi433_tx_cfg))) {
>=20
> Sorry for the duplicate review, but it got sent to both my inboxes... :P

Thanks for your review ! Patch updated.

Please tell me if you don't to be CC-ed anymore. :)

regards,
 Hugo

--=20
             Hugo Lefeuvre (hle)    |    www.owl.eu.com
4096/ 9C4F C8BF A4B0 8FC5 48EB 56B8 1962 765B B9A8 BACA

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEE5LpPtQuYJzvmooL3LVy48vb3khkFAlshwIIACgkQLVy48vb3
khmLBAf9FO3lTSjPwyO1Uy1ACTowKWK67DW6xhm+UVRe2mDRTG83CsW0WfF72bzH
G+FpIbglu8qanddDQepLuVEi6NCJlm4uqArhcq4EeMb2Ju+aqmsiODrlYNZkWlfi
BzD2Jv1csWl0tnoo0jFnUVoInR6rfRlfn7FqVxCXXf63z8pN+ueqoQXAJAIyFoWE
JFl0O82MiEUwsuRFwc81Tx/ijuvJSFgjUCOcn9+PodojlVJYqtV7fU7gRCFnMeb3
GYFB7MeDMDodjYM4oEQ1BOXDxm3CeSXGCkV4oDgxn9xEBZlX4QvHzEjUhixOaEvf
NvtUwwzx+2+NllE1yLJrgF8b3Ky0rQ==
=WUYq
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
