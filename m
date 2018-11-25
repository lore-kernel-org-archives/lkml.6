Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977C5C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 09:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68BB120855
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 09:38:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68BB120855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeKYU3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 15:29:08 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58695 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbeKYU3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 15:29:08 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 00F818092E; Sun, 25 Nov 2018 10:38:22 +0100 (CET)
Date:   Sun, 25 Nov 2018 10:38:25 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Ayman Bagabas <ayman.bagabas@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 1/3] x86: add support for Huawei WMI hotkeys.
Message-ID: <20181125093825.GA24150@amd>
References: <20181031191938.7513-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <20181031191938.7513-1-ayman.bagabas@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-10-31 15:19:36, Ayman Bagabas wrote:
> This driver adds support for missing hotkeys on some Huawei laptops.
> Currently, only Huawei Matebook X Pro is supported. The driver
> recognizes the following keys: brightness keys, micmute, wlan, and
> Huawei special key. The brightness keys are ignored since they work out
> of the box.
>=20
> Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
> ---
>  drivers/platform/x86/Kconfig      |  13 ++
>  drivers/platform/x86/Makefile     |   1 +
>  drivers/platform/x86/huawei_wmi.c | 225 ++++++++++++++++++++++++++++++
>  3 files changed, 239 insertions(+)
>  create mode 100644 drivers/platform/x86/huawei_wmi.c
>=20
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 0c1aa6c314f5..c6813981e45c 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1229,6 +1229,19 @@ config I2C_MULTI_INSTANTIATE
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called i2c-multi-instantiate.
> =20
> +config HUAWEI_LAPTOP
> +	tristate "Huawei WMI hotkeys driver"
> +	depends on ACPI
> +	depends on ACPI_WMI
> +	depends on INPUT
> +	select INPUT_SPARSEKMAP
> +	help
> +	  This driver provides support for Huawei WMI hotkeys.
> +	  It enables the missing keys and adds support to micmute
> +	  led found on these laptops.q
> +	  Supported devices are:
> +	  - Matebook X Pro

Extra q. Plus we normally say module name in Kconfig help text. See
above.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlv6bZAACgkQMOfwapXb+vLFMwCfWoagSZsq60Ju+s6g8MEyIOSp
RXQAnj8oyLlHKRXoXhfJe3NM5nW/zBw7
=hpUx
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
