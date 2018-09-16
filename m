Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60254ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 20:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD0E208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 20:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD0E208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbeIQB0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 21:26:46 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47108 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728567AbeIQB0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 21:26:44 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 9FF5E27DB34
Received: by earth.universe (Postfix, from userid 1000)
        id 8DAF53C0C3D; Sun, 16 Sep 2018 11:34:18 +0200 (CEST)
Date:   Sun, 16 Sep 2018 11:34:18 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     David Lechner <david@lechnology.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power_supply: sysfs: ratelimit property read error
 message
Message-ID: <20180916093418.ysblsx6hm2xjndyr@earth.universe>
References: <20180913004830.1265-1-david@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t5twzgmypjd2fkjq"
Content-Disposition: inline
In-Reply-To: <20180913004830.1265-1-david@lechnology.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t5twzgmypjd2fkjq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 12, 2018 at 07:48:30PM -0500, David Lechner wrote:
> This adds ratelimiting to the message that is printed when reading a
> power supply property via sysfs returns an error. This will prevent
> userspace applications from unintentionally dDOSing the system by
> continuosuly reading a property that returns an error.
>=20
> Signed-off-by: David Lechner <david@lechnology.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/power_supply_sysfs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index 6170ed8b6854..dce24f596160 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -131,7 +131,8 @@ static ssize_t power_supply_show_property(struct devi=
ce *dev,
>  				dev_dbg(dev, "driver has no data for `%s' property\n",
>  					attr->attr.name);
>  			else if (ret !=3D -ENODEV && ret !=3D -EAGAIN)
> -				dev_err(dev, "driver failed to report `%s' property: %zd\n",
> +				dev_err_ratelimited(dev,
> +					"driver failed to report `%s' property: %zd\n",
>  					attr->attr.name, ret);
>  			return ret;
>  		}
> --=20
> 2.17.1
>=20

--t5twzgmypjd2fkjq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlueI5cACgkQ2O7X88g7
+ppTNA/8DGN3fiWvUrFzSicgIZG4E/fb1jo065u6FHSK5X1qDJxcXyrHAlN7prLr
hqVxJI3x6XhkLQAQrk48MnwtYXKQqZn6TIHAveFJ5evnmcnsD2j/HE5R5PNxTGUP
P9eKSlVfB07YW0LOJW2AYDVonVjG93ZGCLiAcZE92fa+YTs9pkHyCeqpHQSrPIdM
e7rbu94aSqUtCkrIWtTECyn5uV531O5KvRG3CpC/GGGB2Hi8QNTKFrU9J35V7TXT
qwbn4o3BA9JW2jxeQVKa1VmvS2sHMw2O8C2sTG0jCYaBcCRVUQGaX/t6wAlajorp
7jYUuf6nj+zepN02cmNpb2IBkM2NWpXDsihL3e/A8G/S/iUhp1BWkVyKVqO53cyU
aS7hk4r/j3SyFoK2jKo9fnoUV6zIljaCCvLhKG5aGM1GTZ9sJQS2GgQihs8bzdjE
uFQNXMUUKo+1hY4xgNB1nAEtn279JQWBB3ypdMh4fIOwyAH1ziO7BLMmcgkJu5lM
g2edFpeCgMvhE7H4jz16rV5KMK6bxyRhObcI0yZ9UpR2HPRjvmH7K+rK2Ad7hpDo
dtd62QBSSx8j9cra+DEeozycBK4M2fbJYVXVIXondHcqs8FYvOEhPXWO9AeRIErR
aFKjrOdVT+YXShaB/gFZOMk3re6QPuZV1Rmlie7NegtUSfUmmeE=
=bB9D
-----END PGP SIGNATURE-----

--t5twzgmypjd2fkjq--
