Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B39C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 05:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5A3214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 05:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mpmWmHFD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E5A3214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730969AbeKNPfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 10:35:32 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45119 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbeKNPfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 10:35:32 -0500
Received: by mail-pf1-f193.google.com with SMTP id g62so4041497pfd.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 21:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9SVFOpPc6UA0HjNl/0hXbDtMt12UuTP3YIsZER8SNko=;
        b=mpmWmHFD6wOxlDS0fdQe4GJr6mLdQBoGslQxthgNGMalsMk2/87dXaYsF5uAQ60Cyw
         oOkyP+qwnxTq8zJDnUyZWWBCz+kY8rdUCEg4HmwS+8g6Ns9J3qUTDVRpWNN+Pz1bWO0N
         xl/3DA2/R5DcuxKvnVOsN6TChuMRTSzSnawqrt477Djy+senbzmU391UyHgbBzxlPpTn
         TL5RUhZ7s7XfcJ6EGgr/c0l0H6Tf0EMhq095JG7drE1zgU0reI9iK+kfKo6LCifv6liy
         B+ZcNFL9Fl3eVq3QGbqDo5CgujJVZu6WSgNj4bUraScMneNiMXBf+GxhQwfUyPDno/GQ
         YS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9SVFOpPc6UA0HjNl/0hXbDtMt12UuTP3YIsZER8SNko=;
        b=mEc+rQfBbFpzNlPZYh+tbCF3XadPfzKack1REw/Fw10e2r4HXa69AG2Aa7OY4kkhOM
         jhpvDpYatr/LY8S3PbIDzkAG3UKN4loR60bos8jWeqhDlWH9gpFFtLRbhgSGWcJnxx6r
         1oDd14yfc9WafFE7uK8WwET+FHrMd0mAuqrXbYRC5CSCNjqUZrbkMB8xKKuh3LzcyYNZ
         59XwNirUgPiotXgY8X42wQ7Oe+VbzQtBrhYJdJRyP6eLoS/tTdd4+AQLpwx0efrPAin4
         92c3Adc3KeaXdeumI8FcGK1OvSTsmonoCFxLmhrYkQ1RgXGCcjgmXXpAfsmGnqLgg4Hr
         FKrw==
X-Gm-Message-State: AGRZ1gLGDNCAEuSHmNefDsnUQev5bsFfOWOGjf1eTRFDa3E83fs9dR12
        UlKYCb//CM79/gxDxP7ZtUOIOg==
X-Google-Smtp-Source: AJdET5fT2vLRkAqCVdsGnazTEq9XhRoWlKAsRONk6YhAxFfRymphmK2ByheoK9U/wVs5ZihcgxX0wQ==
X-Received: by 2002:a63:1d10:: with SMTP id d16-v6mr481597pgd.228.1542173630269;
        Tue, 13 Nov 2018 21:33:50 -0800 (PST)
Received: from google.com ([2620:15c:202:1:c562:226a:6d78:2ae4])
        by smtp.gmail.com with ESMTPSA id m12-v6sm27014623pff.173.2018.11.13.21.33.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 21:33:49 -0800 (PST)
Date:   Tue, 13 Nov 2018 21:33:47 -0800
From:   Benson Leung <bleung@google.com>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>,
        Shawn Nematbakhsh <shawnn@chromium.org>,
        Alexandru Stan <amstan@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        RaviChandra Sadineni <ravisadineni@chromium.org>
Subject: Re: [PATCH v2 1/2] platform/chrome: straighten out
 cros_ec_get_{next,host}_event() error codes
Message-ID: <20181114053347.GA145716@google.com>
References: <20181108024939.174321-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <20181108024939.174321-1-briannorris@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Brian,

On Wed, Nov 07, 2018 at 06:49:38PM -0800, Brian Norris wrote:
> cros_ec_get_next_event() is documented to return 0 for success and
> negative for errors. It currently returns negative for some errors, and
> non-negative (number of bytes received) for success (including some "no
> data available" responses as zero). This mostly works out OK, because the
> callers were more or less ignoring the documentation, and only treating
> positive values as success (and indepdently checking the modification of
> 'wakeup').
>=20
> Let's button this up by avoiding pretending to handle event/wakeup
> distinctions when no event info was retrieved (i.e., returned 0 bytes).
> And fix the documentation of cros_ec_get_host_event() and
> cros_ec_get_next_event() to accurately describe their behavior.
>=20
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Applied.

Thanks,
Benson

> ---
> v1 -> v2:
>  * don't make as many changes to the API -- just fix the documentation
>    and a few corner cases instead
> ---
>  drivers/platform/chrome/cros_ec_proto.c | 4 ++--
>  include/linux/mfd/cros_ec.h             | 6 ++++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/c=
hrome/cros_ec_proto.c
> index b6fd4838f60f..fff67b389c87 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -580,7 +580,7 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_=
dev, bool *wake_event)
> =20
>  	if (!ec_dev->mkbp_event_supported) {
>  		ret =3D get_keyboard_state_event(ec_dev);
> -		if (ret < 0)
> +		if (ret <=3D 0)
>  			return ret;
> =20
>  		if (wake_event)
> @@ -590,7 +590,7 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_=
dev, bool *wake_event)
>  	}
> =20
>  	ret =3D get_next_event(ec_dev);
> -	if (ret < 0)
> +	if (ret <=3D 0)
>  		return ret;
> =20
>  	if (wake_event) {
> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> index e44e3ec8a9c7..de8b588c8776 100644
> --- a/include/linux/mfd/cros_ec.h
> +++ b/include/linux/mfd/cros_ec.h
> @@ -317,7 +317,9 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev);
>   * @wake_event: Pointer to a bool set to true upon return if the event m=
ight be
>   *              treated as a wake event. Ignored if null.
>   *
> - * Return: 0 on success or negative error code.
> + * Return: negative error code on errors; 0 for no data; or else number =
of
> + * bytes received (i.e., an event was retrieved successfully). Event typ=
es are
> + * written out to @ec_dev->event_data.event_type on success.
>   */
>  int cros_ec_get_next_event(struct cros_ec_device *ec_dev, bool *wake_eve=
nt);
> =20
> @@ -329,7 +331,7 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_=
dev, bool *wake_event);
>   * events raised and call the functions in the ec notifier. This function
>   * is a helper to know which events are raised.
>   *
> - * Return: 0 on success or negative error code.
> + * Return: 0 on error or non-zero bitmask of one or more EC_HOST_EVENT_*.
>   */
>  u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev);
> =20
> --=20
> 2.19.1.930.g4563a0d9d0-goog
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlvrs7oACgkQHwn1ewov
5lgTUg/+JrUouL1LPHbtliz9Ue5I3glYAa3Lg2gs2AjkZ+JA2fDAiWqNmuHrcoFp
CPiiEJgIP3ckvRjIjZh46Vyreyxx+vWiJo74qyoJyPwwUGiGRO7hdKspOc0vAqiw
kmcb7FqAVqLhdNJAr1KQ/0+ZATQavQ6gPCITA9LbL1J7gadqxc2AXsKeftg5cjA2
w9e9kZU+mozxsdA0DezC86609aDpGEkSFgsviP9gWwvC+7o8w7/WTaoPq4kiueh9
8Ggb1pVeQWqIIX2tBngyDqiYzqH4cdNmNWiYh31ODt7kQDzOoV5kjfaowN2hkO5F
kc+AtdPa/kQAUT2e8r4up1XN2sQ+i5L4suyyzXUFzkc379smUfJKFz8K597DfHYH
Zqvt0fm1cXpdacwxp1ZyKwrwpI/Ipj1p21mat4G72tqZTEy58uqSXJS4hzla2LxX
ZItFDCjqnWFVC766jxnVmYpdNsRTiSvZm6jYHT3Dy1L5IX0rnpjd7jUK5kD+KuZy
D8TBn9Z2lYAnoHX73N0Nhq2T7HDDvBifa+ovwW5WCA1iw15nYXXXd9XRCzZrV6hN
2/FMj8aFQSoeam8/r9RCncFL1UsdQyHd70hGVlbsOC3dMmQwEemcWxDyIwJlggiR
azGXdZhYf+di5DvGVDXycUcE/fikcfMuQOxFf3HXgHDRdD9Crqc=
=7gTH
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
