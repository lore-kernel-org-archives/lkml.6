Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87968C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2381520882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="PrqoKDcZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2381520882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbeIMOjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 10:39:37 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38223 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbeIMOje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 10:39:34 -0400
Received: by mail-wm0-f67.google.com with SMTP id t25-v6so5380944wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 02:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=cgp/4PbF1jH0DppZpJV45b2IYRkgP087Q9bvbULOWOM=;
        b=PrqoKDcZSUQTJUxdmRvmm2OPYkwhNxz5iC/56BUgzT8FCSAPBwERSblDvkYMAN0ArB
         ihhS4+Mp0dLjWWAfiOMDSpbXFaFUqr0C+Z9mljkhlGhtduqTSZCXHu2vtoTcdBahsOa9
         RaTlJy17vy8OZ13uyrRpWj01+nOD0wS4Z/pSGuZWzdkdIOQPl3xxuDesMy3g9tCxyLGc
         rajc4jFXcwJEF27VnIrr6ctxeltC+lIUP3bR3KPXbt+xLbSLPF2BIjrU717jDm9lDJzZ
         qG9Ags4pjAACoDHvFBZxJ5/NndaIJCuW9utoD/3ToKXH1W7RKC9lMJkh7uVgRkKLHs5H
         tOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to;
        bh=cgp/4PbF1jH0DppZpJV45b2IYRkgP087Q9bvbULOWOM=;
        b=WvqofqprXhvw+jJkexC5nWqV5/MIaQ17l1nMhGvcWG6vRhG8piDtfA1mulTReXYHcC
         0AGXT7WHD1CRfL3/WQmrj/lTVnUxCZG8EE759U4i3FFfeGfe3ZL5/Twxtv7MieTYpx9C
         8KP/8b/Tbuvq5krZ0yqydCjfr9vFDGZE74XpjOZMeZdZZIQFrv34aEBsOWR0rf3mBEfr
         Y0xxYyCQdZT4z9f8RWMMGVVhGtJzJTCxmAyZO3wZ9Jhe+W2LfpHwNwESTtlv6i7VWyMF
         sPE2rQTbZQeDb2nAl5HBpUWdGKC/uMSBTIsYv3HSmkkZq1ooN/WNEOG6pacgN/oWMXij
         6d7A==
X-Gm-Message-State: APzg51DhRVb0T4/nWjdJQWQxtg9aI3G3Hti6CPIpxJ++UvszM0gyMbvk
        QHRbg0U/MePIY42Neq4A56UTpw==
X-Google-Smtp-Source: ANB0VdZ2Dn47FIC4Z2WfIW+iWePaBUMhrTw8yQtXPAyUD1yRRiO8BLkK0vnDCXyfO9AzoshUB4+eXA==
X-Received: by 2002:a1c:3a92:: with SMTP id h140-v6mr4865843wma.41.1536831054445;
        Thu, 13 Sep 2018 02:30:54 -0700 (PDT)
Received: from [173.194.76.109] ([149.199.62.254])
        by smtp.gmail.com with ESMTPSA id r6-v6sm3040312wrt.92.2018.09.13.02.30.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 02:30:53 -0700 (PDT)
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH 1/2] of: base: Introduce of_alias_check_id() to check
 alias IDs
To:     Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
References: <0ee4683a7d3927c2ef20b1e106720e6154811cd7.1535980468.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=monstr@monstr.eu; prefer-encrypt=mutual; keydata=
 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
 RmzhqoTJlA==
Message-ID: <f67030b9-0afa-15f1-6e9f-284b51724bff@monstr.eu>
Date:   Thu, 13 Sep 2018 11:30:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0ee4683a7d3927c2ef20b1e106720e6154811cd7.1535980468.git.michal.simek@xilinx.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="TT1AdXVD1OFBCCdRtQfJGpOSK7KsctXr7"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TT1AdXVD1OFBCCdRtQfJGpOSK7KsctXr7
Content-Type: multipart/mixed; boundary="q9kHpJ06SzFgzaYECd2uaXV2cQKth14PE";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>
Message-ID: <f67030b9-0afa-15f1-6e9f-284b51724bff@monstr.eu>
Subject: Re: [PATCH 1/2] of: base: Introduce of_alias_check_id() to check
 alias IDs
References: <0ee4683a7d3927c2ef20b1e106720e6154811cd7.1535980468.git.michal.simek@xilinx.com>
In-Reply-To: <0ee4683a7d3927c2ef20b1e106720e6154811cd7.1535980468.git.michal.simek@xilinx.com>

--q9kHpJ06SzFgzaYECd2uaXV2cQKth14PE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On 3.9.2018 15:14, Michal Simek wrote:
> The function travers the lookup table to check if the request alias
> id is compatible with the device driver match structure.
> This function will be used by serial drivers to check if requested alia=
s
> is allocated or free to use.
>=20
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>=20
> Based on discussion with Rob
> https://lkml.org/lkml/2018/4/27/397
> nbits is passed to the function not to limit only to 32/64bit fields.
>=20
> ---
>  drivers/of/base.c  | 48 ++++++++++++++++++++++++++++++++++++++++++++++=
++
>  include/linux/of.h |  3 +++
>  2 files changed, 51 insertions(+)
>=20
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 466e3c8582f0..236a85d69957 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -16,6 +16,7 @@
> =20
>  #define pr_fmt(fmt)	"OF: " fmt
> =20
> +#include <linux/bitmap.h>
>  #include <linux/console.h>
>  #include <linux/ctype.h>
>  #include <linux/cpu.h>
> @@ -1893,6 +1894,53 @@ int of_alias_get_id(struct device_node *np, cons=
t char *stem)
>  EXPORT_SYMBOL_GPL(of_alias_get_id);
> =20
>  /**
> + * of_alias_get_alias_list - Get alias list for the given device drive=
r
> + * @matches:	Array of OF device match structures to search in
> + * @stem:	Alias stem of the given device_node
> + * @bitmap:	Bitmap field pointer
> + * @nbits:	Maximum number of alias ID which can be recorded it bitmap
> + *
> + * The function travels the lookup table to record alias ids for the g=
iven
> + * device match structures and alias stem.
> + */
> +void of_alias_get_alias_list(const struct of_device_id *matches,
> +			     const char *stem, unsigned long *bitmap,
> +			     unsigned int nbits)
> +{
> +	struct alias_prop *app;
> +
> +	/* Zero bitmap field to make sure that all the time it is clean */
> +	bitmap_zero(bitmap, nbits);
> +
> +	mutex_lock(&of_mutex);
> +	pr_debug("%s: Looking for stem: %s\n", __func__, stem);
> +	list_for_each_entry(app, &aliases_lookup, link) {
> +		pr_debug("%s: stem: %s, id: %d\n",
> +			 __func__, app->stem, app->id);
> +
> +		if (strcmp(app->stem, stem) !=3D 0) {
> +			pr_debug("%s: stem comparison doesn't passed %s\n",
> +				 __func__, app->stem);
> +			continue;
> +		}
> +
> +		if (app->id >=3D nbits) {
> +			pr_debug("%s: ID %d greater then bitmap field %d\n",
> +				__func__, app->id, nbits);
> +			continue;
> +		}
> +
> +		if (of_match_node(matches, app->np)) {
> +			pr_debug("%s: Allocated ID %d\n", __func__, app->id);
> +			set_bit(app->id, bitmap);
> +		}
> +		/* Alias exist but it not compatible with matches */
> +	}
> +	mutex_unlock(&of_mutex);
> +}
> +EXPORT_SYMBOL_GPL(of_alias_get_alias_list);
> +
> +/**
>   * of_alias_get_highest_id - Get highest alias id for the given stem
>   * @stem:	Alias stem to be examined
>   *
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 4d25e4f952d9..e474710e3930 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -387,6 +387,9 @@ extern int of_phandle_iterator_args(struct of_phand=
le_iterator *it,
>  extern void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align));
>  extern int of_alias_get_id(struct device_node *np, const char *stem);
>  extern int of_alias_get_highest_id(const char *stem);
> +extern void of_alias_get_alias_list(const struct of_device_id *matches=
,
> +				    const char *stem, unsigned long *bitmap,
> +				    unsigned int nbits);
> =20
>  extern int of_machine_is_compatible(const char *compat);
> =20
>=20

Can you please take a look at this patch?

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs




--q9kHpJ06SzFgzaYECd2uaXV2cQKth14PE--

--TT1AdXVD1OFBCCdRtQfJGpOSK7KsctXr7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAluaLkgACgkQykllyylKDCHSqwCgkF/nachzgOYUWT3mGLLHxeX5
FpkAn0xmdsUDwNbQJXhohhWlFhpzu3v0
=z7p3
-----END PGP SIGNATURE-----

--TT1AdXVD1OFBCCdRtQfJGpOSK7KsctXr7--
