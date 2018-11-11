Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AB7C0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B1520871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:20:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B1520871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbeKLFKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:10:11 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49040 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbeKLFKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:10:10 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvHr-0007PR-96; Sun, 11 Nov 2018 19:20:47 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvHr-00066I-2d; Sun, 11 Nov 2018 19:20:47 +0000
Message-ID: <dc0f4758889a7b6bddbab2443712159f7027b42f.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16 000/410] 3.16.57-rc1 review
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org
Date:   Sun, 11 Nov 2018 19:20:37 +0000
In-Reply-To: <20181111174853.l2ixlz7rmh7lsfye@decadent.org.uk>
References: <lsq.1528380320.647747352@decadent.org.uk>
         <20180608141426.GA5242@roeck-us.net>
         <945ce3bb1ecd9c70249e79d2cb5572f9475c9786.camel@decadent.org.uk>
         <bf66aa7e856d4c2c83dc78dca95eee76437a1513.camel@decadent.org.uk>
         <20181111162343.GA15513@roeck-us.net>
         <20181111174853.l2ixlz7rmh7lsfye@decadent.org.uk>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-9NHy//zQIlsgoFgf+qoV"
User-Agent: Evolution 3.30.1-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9NHy//zQIlsgoFgf+qoV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2018-11-11 at 17:48 +0000, Ben Hutchings wrote:
> On Sun, Nov 11, 2018 at 08:23:43AM -0800, Guenter Roeck wrote:
[...]
> > I re-enabled it, but now it fails. Let me know if you want to try to fi=
x
> > it. Probably something with out-of-tree build - I didn't try to find
> > the reason.
>=20
> Thanks.  I can reproduce the failure when building in Debian unstable,
> and am working through fixing the problems.

I fixed most of them.  Two of the problems still (potentially) exist in
mainline so I'll send patches for those and wait for those to come back
to stable.

In the mean time, please can you build perf with WERROR=3D0?

Ben.

--=20
Ben Hutchings
Reality is just a crutch for people who can't handle science fiction.



--=-9NHy//zQIlsgoFgf+qoV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlvogQUACgkQ57/I7JWG
EQnkKBAAtBIat3ToN9jRjqXZUoqLtekSp4OYoCbuJHrMwZls2NCwJGFWUBY5XPmm
a2xghQmQ9dQVPctwkpWaMnuuE42E1EEVq5cJdX//ufXvIlko0SH1Bzfg/GrXzpi2
NhFH//wt4zXHOjYWH4VDRiLjHXXmgi7bEVxd2lAogkXnCL/DiWet4yJmYTa/U5BD
nrt7ouaaOJKsDqkeaf8NVNMioDjjYZwmm3fD5daLbs55LBY3kgRIpi3gkc2bf/I9
HmbkDBFnf/dGTvGgh4URrSTSHG7UZdum+RVjoq+imN1WojgtZ0BKUWVyBiTzBBec
/Rx5fBczqgY+NZiOvbAwn4x5dDQuVUty5tGG6KbRFW8MTydTqAGMwNu4E9FWOUrn
8MRG2Izs7MAp4qQjSIwJIRObPu7Ul8+XBSyp/tSUiGWGMRkSYm7ePWAFnyYV0OaX
uj/Qidth9kO7QANtAkHBvKOOJ0ufhw14STWiXACZRiWSVuLaCvC0tNHm38kvErSi
FWM7JNXpW7nLrixRwNy7QPtpn7DkKrRM/NSw4f301g1eh1/hdmB4YlyRJOysvi+p
V9HGAXQMm/4G5vGQBXGe1AUb2Yy69vtW298qjBJ8Pst0CtWqbgtUPiJw4t4OANhR
XUrQpFj6Jqygl/bPEWQ4YHm4AHQw7Rv280h1EP1PmPc5sJpmY+s=
=ifnl
-----END PGP SIGNATURE-----

--=-9NHy//zQIlsgoFgf+qoV--
