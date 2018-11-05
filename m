Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A187FC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED8220862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ED8220862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388246AbeKFHsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:48:37 -0500
Received: from mx1.mailbox.org ([80.241.60.212]:41600 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387983AbeKFHsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 02:48:37 -0500
Received: from smtp1.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 911844B507;
        Mon,  5 Nov 2018 23:26:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id VkyUcoOJScGn; Mon,  5 Nov 2018 23:26:39 +0100 (CET)
Subject: Re: [PATCH AUTOSEL 4.19 28/57] watchdog: lantiq: update register
 names to better match spec
To:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
References: <20181104135144.88324-1-sashal@kernel.org>
 <20181104135144.88324-28-sashal@kernel.org>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <680f90dd-0dc2-5b6c-46e8-8e079864a852@hauke-m.de>
Date:   Mon, 5 Nov 2018 23:26:38 +0100
MIME-Version: 1.0
In-Reply-To: <20181104135144.88324-28-sashal@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4rY1EjgR5KvYE9aQONltd3Ozxnnz7DQrG"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4rY1EjgR5KvYE9aQONltd3Ozxnnz7DQrG
Content-Type: multipart/mixed; boundary="aMaSDI3JcbEDcJxlCeCpWakMfM7BOR1FU";
 protected-headers="v1"
From: Hauke Mehrtens <hauke@hauke-m.de>
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
 Wim Van Sebroeck <wim@linux-watchdog.org>
Message-ID: <680f90dd-0dc2-5b6c-46e8-8e079864a852@hauke-m.de>
Subject: Re: [PATCH AUTOSEL 4.19 28/57] watchdog: lantiq: update register
 names to better match spec
References: <20181104135144.88324-1-sashal@kernel.org>
 <20181104135144.88324-28-sashal@kernel.org>
In-Reply-To: <20181104135144.88324-28-sashal@kernel.org>

--aMaSDI3JcbEDcJxlCeCpWakMfM7BOR1FU
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/04/2018 02:51 PM, Sasha Levin wrote:
> From: Hauke Mehrtens <hauke@hauke-m.de>
>=20
> [ Upstream commit 1f59f8aff98f200af7a6882184add7b85f5da741 ]
>=20
> Some of the names of the bits were confusing to me.
> Now the bits share the same prefix as the register they are set on.
>=20
> The LTQ_WDT_CR_PWL register (bits 26:25) is the pre warning limit and i=
t
> does not turn anything on. It has 4 possible divers 1/2, 1/4, 1/8 and
> 1/16, this drivers only uses 1/16.
> The LTQ_WDT_CR_CLKDIV register bits(25:24) is only configuring a clock
> divers and do not turn any thing on too, all possible values are valid
> dividers.
> Using the LTQ_WDT_SR prefix is also wrong these bits are used in the
> LTQ_WDT_CR registers, SR is the status register which is read only.
>=20
> This uses GENMASK where it is a mask and it uses shifts when a value is=

> written to some bits.
>=20
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/watchdog/lantiq_wdt.c | 36 ++++++++++++++++++-----------------=

>  1 file changed, 19 insertions(+), 17 deletions(-)

This does not really fix a bug, I think it is not worth it to backport th=
is.

Hauke


--aMaSDI3JcbEDcJxlCeCpWakMfM7BOR1FU--

--4rY1EjgR5KvYE9aQONltd3Ozxnnz7DQrG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAlvgw54ACgkQ8bdnhZyy
68cszQf+MFgT2yNZFr1uNX8OEWeR5NAlCEcYEH3LldrkS5TqU7dDl7VEmpKXAyaa
e2got9jRsjcV2TRmT3XS1Hwc+03sPF4hLJAfd6t4hNzP59+kFGyFVjee0Az+QB4b
4bL8j1uKNqQnGV8fs1KaPxgrbhXxoFSAmqy/3hdr230UbDoluvtn2+SkqeQ7WmHi
7rjL9pNJUoBxRwJCjo2a0YtJZhmN0wwQImI1fLEe+jAW9C6C+y4badGPhVHPTGGz
Nl48oQIr4gV9qMvDnyft5XpNvFAEVsXqv6HGQIuNzV3n3W3IpvhpGwlMmcPFgyhy
tqVky7c6qWeHt8jSecRSFe35lUPk3A==
=El+y
-----END PGP SIGNATURE-----

--4rY1EjgR5KvYE9aQONltd3Ozxnnz7DQrG--
