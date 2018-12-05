Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4EBC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D912205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D912205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbeLER2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:28:46 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50444 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbeLER2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:28:45 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 084D427E6A9
Received: by earth.universe (Postfix, from userid 1000)
        id 16ECF3C08D6; Wed,  5 Dec 2018 18:28:41 +0100 (CET)
Date:   Wed, 5 Dec 2018 18:28:41 +0100
From:   Sebastian Reichel <sre@collabora.com>
To:     Colin King <colin.king@canonical.com>
Cc:     linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: cpcap-battery: make array
 cpcap_battery_irqs static, shrinks object size
Message-ID: <20181205172841.2ivcisxk2h7kul7e@earth.universe>
References: <20181129230342.4300-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="phpln7qmp3skcy3j"
Content-Disposition: inline
In-Reply-To: <20181129230342.4300-1-colin.king@canonical.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--phpln7qmp3skcy3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 29, 2018 at 11:03:42PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Don't populate the array cpcap_battery_irqs  on the stack but instead
> make it static. Makes the object code smaller by 99 bytes:
>=20
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   13673	   2448	      0	  16121	   3ef9	cpcap-battery.o
>=20
> After:
>    text	   data	    bss	    dec	    hex	filename
>   13510	   2512	      0	  16022	   3e96	cpcap-battery.o
>=20
> (gcc version 8.2.0 x86_64)
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/cpcap-battery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/=
cpcap-battery.c
> index 98ba07869c3b..204e22e3e9b4 100644
> --- a/drivers/power/supply/cpcap-battery.c
> +++ b/drivers/power/supply/cpcap-battery.c
> @@ -620,7 +620,7 @@ static int cpcap_battery_init_irq(struct platform_dev=
ice *pdev,
>  static int cpcap_battery_init_interrupts(struct platform_device *pdev,
>  					 struct cpcap_battery_ddata *ddata)
>  {
> -	const char * const cpcap_battery_irqs[] =3D {
> +	static const char * const cpcap_battery_irqs[] =3D {
>  		"eol", "lowbph", "lowbpl",
>  		"chrgcurr1", "battdetb"
>  	};
> --=20
> 2.19.1
>=20

--phpln7qmp3skcy3j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwICsUACgkQ2O7X88g7
+ppspQ//W2sTS7H/gv4ulEdipPoxlBt+xPHgvJ61Z4jRsVB1pm36U/sIJ8wSDBjN
uWMjHTB8cjB39Saa9aDkX1nBWSVX3Gjrw6dh9LlfAa03PCWTOr1kNgSo8jRluVsQ
JFKsRjQrCdtN0Gzked4dQOa0oqHfRksV2VspaeQQfYa6gQ2ONLJOTNNY3NL/0LSK
IgqWah5fc0MUZGjvfto+PWmSXQfKN5gHHSugHuu1Xq1eGNwG1RMMb4AWnbFyH+K7
v9eGQATiav8be0RJ9k1WG5EUZ9zmkSqjl17KxEFUJl/tETSkCWSQsaLFyKoV/r9F
JCWsQT9go+D4ftiRqys+Vk0j7BNRF+o8cwY8Io6XmSlSC6JgkDc/53bS9OPsMRiR
BhjJJJP6sezgumKo1D7hwPrrrCoOENvGXBoeh2S1C7c2ZBRURN/nOF4j3m2ceDAz
5B6gdtmW7S2v6oxNwUuo1IzaH31T4nUKJGolzkhQA8PLmD/6X5gwiDP0xUxQJVtn
WFmyEky2e4yu74fKzvQbkeCrzXXyedNkGHAIqrsRQNyihPXmnPj0/KpwglJujJCC
F5UUvB4EoMaUZYROwBgBo8lnsRhcG002z0uWHwqlbAV8yfSJ1EjcgfSQHM6+4U0C
l0ES2zLgQUMvYnAIGxB9HVUzcIUgczyd3nk8YarRAe2+ffwdYiY=
=JDfb
-----END PGP SIGNATURE-----

--phpln7qmp3skcy3j--
