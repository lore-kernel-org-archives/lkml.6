Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B910FC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 554EE21570
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eh0HK+6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 554EE21570
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbeHRSm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 14:42:29 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35938 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbeHRSm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 14:42:29 -0400
Received: by mail-lf1-f68.google.com with SMTP id b22-v6so7936045lfa.3;
        Sat, 18 Aug 2018 08:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FNm5JaRbW09kMnlz3KmhPbIPW5l7/aR9EfFsy8DYNH8=;
        b=Eh0HK+6BP4GgRS3He/DUYWi27J1VsRcz/X5aQHS0O1QGAnNQM2pqK6GSAixTQVRRrr
         p9+HHHTeToNJKNCv5mGN3M+y88McgGMstqDGN7piYcsLBSnw/vnUsCZwIhJN1yiYhC1B
         S0bab/SvAAZ593c4iDfK9IHLxR+X1tduCeAWiQ4/Qcg7SfdstDG2cXemr9oknjZHocZF
         OQr/Bi3/0t6/YqtL040sH7YigedremM6OkApgpPW7XpP/sdMMvxbDxV3K7h1Z/oaQ9Y/
         j1gfQOT7Pzk9NHLWQrs3RYFbPx0nz3keyRvCeg3pH7bYQD5zL1VFIxzUuM1KDBboRmgx
         1T8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FNm5JaRbW09kMnlz3KmhPbIPW5l7/aR9EfFsy8DYNH8=;
        b=Q2z59/wAlIn/RruqduK3Md80PTXL0ploaivf3FQK3nuEU5tzY9b+GdgCZ4gm/VZWpO
         XMnBIoOlEH2hQNnKGq4EdzpEqCOKBfbgDce+fV3M+tsBesOtRLUUxIZfxuiPET+DSoc5
         h2WlpMyecyQDEHmrqai9Xw56EE0+fhxUSwXtmvEElfMcJmCnwTZRForFhJgNvu9MKr6I
         Prq9xNwI7e2RMcqOrxc1954vGElAfQqTaiRvjAX0kGSSu4kDbVfch20lOcfX415qwQId
         g4ttjlBf7kcJMGcPPoDOYq07WNVewW1DprLa88c5afeE4MFTi5XlUiD9RbR0HwCHK9Kz
         pR2A==
X-Gm-Message-State: AOUpUlGdvVQGkbKv+rS3vdeRuIAunSaBuQa3zNBK1c23llbwpR/IUfQQ
        757QR99YkKUwKOpnEIgRHpU=
X-Google-Smtp-Source: AA+uWPyZa2WfXD6lBlQrS98faVZWsLqtLX9ixv/GLhq1GDR2v/7pUZUr/QvoiIuyLdX+aEQM2EvEKw==
X-Received: by 2002:a19:f50d:: with SMTP id j13-v6mr920016lfb.127.1534606461565;
        Sat, 18 Aug 2018 08:34:21 -0700 (PDT)
Received: from gmail.com (c-2ec26f18-74736162.cust.telenor.se. [46.194.111.24])
        by smtp.gmail.com with ESMTPSA id d10-v6sm875970lfk.63.2018.08.18.08.34.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Aug 2018 08:34:20 -0700 (PDT)
Date:   Sat, 18 Aug 2018 17:34:40 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: cros_ec_accel_legacy: Mark expected switch
 fall-throughs
Message-ID: <20180818153416.GA3543@gmail.com>
References: <20180815163852.GA4910@embeddedor.com>
 <20180815172700.GA29039@gmail.com>
 <64cccc17-ebfe-205a-6b2c-2a72aae765b0@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
Content-Disposition: inline
In-Reply-To: <64cccc17-ebfe-205a-6b2c-2a72aae765b0@embeddedor.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Gutavo,

Sorry for the delay.

On Wed, Aug 15, 2018 at 12:50:10PM -0500, Gustavo A. R. Silva wrote:
> Hi Marcus,
>=20
> On 8/15/18 12:27 PM, Marcus Folkesson wrote:
> > Hi,
> >=20
> > On Wed, Aug 15, 2018 at 11:38:52AM -0500, Gustavo A. R. Silva wrote:
> >> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> >> where we are expecting to fall through.
> >>
> >> Addresses-Coverity-ID: 1462408 ("Missing break in switch")
> >> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> >> ---
> >>  drivers/iio/accel/cros_ec_accel_legacy.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/ac=
cel/cros_ec_accel_legacy.c
> >> index 063e89e..d609654 100644
> >> --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> >> +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> >> @@ -385,8 +385,10 @@ static int cros_ec_accel_legacy_probe(struct plat=
form_device *pdev)
> >>  		switch (i) {
> >>  		case X:
> >>  			ec_accel_channels[X].scan_index =3D Y;
> >> +			/* fall through */
> >>  		case Y:
> >>  			ec_accel_channels[Y].scan_index =3D X;
> >> +			/* fall through */
> >>  		case Z:
> >>  			ec_accel_channels[Z].scan_index =3D Z;
> >>  		}
> >=20
> > Hum, I'm not sure we are supposed to fall through here, even if it does
> > not hurt to do so.
>=20
> Yeah. You're right. It doesn't hurt but is actually redundant. I think
> the original intention was to break instead of falling through.
>=20
> > I even think we can remove the switch and put that outside the for-loop,
> > e.g:
> >=20
> > 	ec_accel_channels[X].scan_index =3D Y;
> > 	ec_accel_channels[Y].scan_index =3D X;
> > 	ec_accel_channels[Z].scan_index =3D Z;
> >=20
> > 	for (i =3D X ; i < MAX_AXIS; i++) {
> > 		if (state->sensor_num =3D=3D MOTIONSENSE_LOC_LID && i !=3D Y)
> > 			state->sign[i] =3D -1;
> > 		else
> > 			state->sign[i] =3D 1;
> > 	}
> >=20
>=20
> I like this, but the code clearly depends on MAX_AXIS. So, if MAX_AXIS
> will be always 3, then the change you suggest is just fine. Otherwise,
> it seems that adding a break to each case is the right way to go.
>=20
> What do you think?

Well, I guess it is a matter of taste after all.
I don't think the number of axis will change, but just put the break in
place is good enough.

Anyway, If we choose to not use the switch, I think we should remove the
for-loop as well, eg:

	ec_accel_channels[X].scan_index =3D Y;
	ec_accel_channels[Y].scan_index =3D X;
	ec_accel_channels[Z].scan_index =3D Z;

	if (state->sensor_num =3D=3D MOTIONSENSE_LOC_LID) {
		state->sign[X] =3D -1;
		state->sign[Y] =3D 1;
		state->sign[Z] =3D -1;
	} else {
		state->sign[X] =3D 1;
		state->sign[Y] =3D 1;
		state->sign[Z] =3D 1;
	}

But someone else may like to give their point of view on this change.

>=20
> Thanks for the feedback.
> --
> Gustavo

Best regards
Marcus Folkesson

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlt4PIwACgkQiIBOb1ld
UjLo7w//dweWmx/iH5AtCG4H8NpYy69PjgwBEayWNZtvQRLNq/vh4vUOWerkE+fQ
VprzIrn7rDki3ggrm1Sl7sO4pd0YCsxDw+ug+WjvgnYlc2sYqUw9yCnoirvDy2UR
7FTs5eAlt3zDwUGugwr6Xfb6utGlDu+pQ9gltaArc3hpk0xvSTiJiOhd+Se6NmWf
6171D+13WcWXO2i4FWK8N5B33TP/j4NDlnCvdzZ/Mp5sUW7RXq1zTx6CyxbETQKA
s2a4zgfv7V1C53Emxk0T7X/T9fNpniQDpNCoYjtTaeJuGmozt3M8gUh1k09IUYCr
yIrCB4y6ORipJV8NRjR4hMW2COxVOifvAUmsaFdV4Uyw2vnh9qgBtqMJLWyLEb2e
z3yQX5wMLIxB+lBnY+dczvSvn7ciUMrvPrIydhkPjWPkSP2FwdRMeGvWXjdkV7qX
/Qr51++Ux4+NINEOQbvVawsolpVyMbH5h7SQQ50MR+nsY9rV7D6V/IU70oM3j11K
98zgz2EzCgWKh5orBvbo5TtKmJhe+g28sca3W8Jeqv25dJ7etIuiutUvkhzz1OvT
ul8C4c2vi4HNGFba3YemenDaiZovMp/2LXNEspN4YFBIwaDd28N8ofhJKCzL6Vxl
VTEt5EUnYxRHoXB3wuiCCOfSBIecQKOK/2V0t73tLnHdV5ujVsg=
=XOY9
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--
