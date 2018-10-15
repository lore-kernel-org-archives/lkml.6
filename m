Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2FAC7112B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 09:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF2720652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 09:46:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF2720652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kleine-koenig.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeJORbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 13:31:03 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:47104 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeJORbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 13:31:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by antares.kleine-koenig.org (Postfix) with ESMTP id 43F0B415A2B;
        Mon, 15 Oct 2018 11:46:30 +0200 (CEST)
Received: from antares.kleine-koenig.org ([127.0.0.1])
        by localhost (antares.kleine-koenig.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id U3HiOS_v99-F; Mon, 15 Oct 2018 11:46:29 +0200 (CEST)
Received: from [IPv6:2a02:8071:b581:3afc:4db9:a56e:fff8:4352] (unknown [IPv6:2a02:8071:b581:3afc:4db9:a56e:fff8:4352])
        by antares.kleine-koenig.org (Postfix) with ESMTPSA;
        Mon, 15 Oct 2018 11:46:29 +0200 (CEST)
To:     Alessandro Rubini <rubini@gnudd.com>
Cc:     gregkh@linuxfoundation.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        Michal.Vokac@ysoft.com, akpm@linux-foundation.org,
        kernel@pengutronix.de
References: <20181014202807.16412-1-uwe@kleine-koenig.org>
 <20181015093708.GA22876@mail.gnudd.com>
From:   =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Openpgp: preference=signencrypt
Autocrypt: addr=uwe@kleine-koenig.org; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH RFC] err.h: document that PTR_ERR should only be used if
 IS_ERR returns true
Message-ID: <41de7e1a-1c93-a27d-b777-7e4db4e8d11b@kleine-koenig.org>
Date:   Mon, 15 Oct 2018 11:46:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181015093708.GA22876@mail.gnudd.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="XXc09EDCBptyBkgcwYxcgxKzEZJznvbWN"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XXc09EDCBptyBkgcwYxcgxKzEZJznvbWN
Content-Type: multipart/mixed; boundary="tt4oGjWbeueP4WnO6KR8mRSNA0nsIfBl9";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Alessandro Rubini <rubini@gnudd.com>
Cc: gregkh@linuxfoundation.org, corbet@lwn.net, linux-kernel@vger.kernel.org,
 thierry.reding@gmail.com, Michal.Vokac@ysoft.com, akpm@linux-foundation.org,
 kernel@pengutronix.de
Message-ID: <41de7e1a-1c93-a27d-b777-7e4db4e8d11b@kleine-koenig.org>
Subject: Re: [PATCH RFC] err.h: document that PTR_ERR should only be used if
 IS_ERR returns true
References: <20181014202807.16412-1-uwe@kleine-koenig.org>
 <20181015093708.GA22876@mail.gnudd.com>
In-Reply-To: <20181015093708.GA22876@mail.gnudd.com>

--tt4oGjWbeueP4WnO6KR8mRSNA0nsIfBl9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello,

On 10/15/2018 11:37 AM, Alessandro Rubini wrote:
>> during a review I claimed that PTR_ERR should only be used if IS_ERR w=
as
>> already checked. The rationale isn't obvious though and Thierry
>> suggested to keep the code as is and not introduce an IS_ERR check.
>=20
> The rationale is the same ch11 you linked to: "any other value
> is a valid pointer".  It isn't usefult to convert to long sth that
> your are not using as a long.  You should not pass it to strerror(-err)=

> for example.

ok, that's obvious that this should be forbidden.

> OTOH I admit you can compare any value with -EINVAL, after PTR_ERR.
> But in general you first detect the error condition and then split
> among error (or print a message according to the exact value.
>=20
>> maybe something like "On an Alpha it is important because
>> not doing it results in a bus error there."
>=20
> No, nothing that exotic.

OK, if there is nothing that exotic, the patch is probably of little use.=


> You said:
>=20
>> Thierry suggested to keep the code as is and not introduce an IS_ERR c=
heck.
>=20
> I wonder where. Sure no extra check in the header, that would be
> extra wasted time in every caller. If it's a specific caller place,
> it may make sense to avoid the check, I don't know the details.

http://patchwork.ozlabs.org/patch/981774/#2009383

The obvious alternatives would be:

	if (PTR_ERR_OR_ZERO(imx_chip->pwm_gpiod) =3D=3D -EPROBE_DEFER)

	if (imx_chip->pwm_gpiod =3D=3D ERR_PTR(-EPROBE_DEFER))

but if no kittens die anywhere it's probably of little value to argue her=
e.

> As for the specific patch you propose, I'm unsure it's useful.  Maybe
> we should remember that "this returns the equivalent of "-errno" if
> IS_ERR() is true", but I'm personally not much for overcommenting:
> It's a simple cast and there are a zillion users to see how exactly
> this works if anyone is uncertain.

ack.

Thanks for your input
Uwe


--tt4oGjWbeueP4WnO6KR8mRSNA0nsIfBl9--

--XXc09EDCBptyBkgcwYxcgxKzEZJznvbWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAlvEYfIACgkQwfwUeK3K
7AnqJgf9EUlWMSw913wu22MLdls7Oz0bHevthohbMcgtsY4s6XKvpApRXqqdFevy
U2NU/eNjN5bx54h0wc5+uBNgBNET9mjvLyLWPyvxd3ldCXE5mdmx0FYwyr78z0mI
aT8XXroT4PxRU+zeiAU3u2PF8Q6zJeDanRn63pUZ0a11XbZA3Y+ookGVvrbels43
hTOp9TtUVQT5QY8MEK9vrAIc2N5QClCWVVv8Zr+enM354+faifYtC/H/r3R9+ZTZ
6kXXt3oSClrSz85mAfFC474Qml21swMLOO6v/U+vO9GZmWSWuW+L2jQ3tzIWBh4C
Sr3n/aRDrUENGCwcTDzSaLaqNzIPjg==
=akc/
-----END PGP SIGNATURE-----

--XXc09EDCBptyBkgcwYxcgxKzEZJznvbWN--
