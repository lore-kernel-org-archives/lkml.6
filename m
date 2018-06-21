Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC27C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B54C20837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="fWi53AUE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B54C20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933199AbeFUL1c (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 07:27:32 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38797 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932936AbeFUL12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 07:27:28 -0400
Received: by mail-wr0-f193.google.com with SMTP id e18-v6so2801260wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 04:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=Xbhc+o+AUbjHIHdto1ruPPomu0E0MkrWwVJulK75BsI=;
        b=fWi53AUEAhpoi1IVRDSk9wDQZhLY5j5FbKeSNaBlNHCu6QpkjY0xvNxL6/Uvb1xAFP
         W3GFOqb7uqAeUkMXgCpnbJ+QjtYxYkUKRityvQC0mQbt1hZz9NpNWEEMgTHnPacKzU2Y
         +KcnsEiCl7Wa8v79f/tOz06yKtWoroHmAG3q7DnT3m47qwYRMn6/OSTBMo7TwdkpH00g
         dVfVz4DmIX0y74S7WWLLKcod1YIFDh4/4nxMZYh8Jdz6sDW8zL7pKUwozlf45rvG8iGy
         JzkWwWWHhmrto0uD8WPeztoWaPD0F6K7YPJN3L/4wee9igtuh5ZKkH9RT1in7HHSBUxd
         ig6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to;
        bh=Xbhc+o+AUbjHIHdto1ruPPomu0E0MkrWwVJulK75BsI=;
        b=ZDwZqb6gsG1Zz1L/iKl1gOLTH83Ko2iFaKRetcoC/aAn6UZMQDEo/57Ol31uxh9OqV
         ks/v5OEV5eDE5/mmxkIDYSHolQzH0jU8pAGIkR4b0vxo+vK8NEvQFVce7rgyh281IX5i
         ZBNy2CWAZM9670Ihhiqqw3QKtf7VtWOIO8Sf5beXzPfUqgMu7YLh2bygPaS+dueRSI90
         P8E9/ahM6QjEotpB/BitQBL3aXsAaDat3iWLfCikqXAa3071LT0A+CyhtvWr4p1M5piA
         6hVHqwYc1m+gez35wJFWowxoPnX9xoKiRMPrQVY79bZTM+6zi4UwJdCgrIaaDdb0wJK0
         qPFA==
X-Gm-Message-State: APt69E3saF9Yn/xU5QFmcT52xeSxdhHS49ABS5pbwFRt4sXoXqgFMJbI
        M6BFv96T842Yqo6mmxBGkCgBh79H
X-Google-Smtp-Source: AAOMgpc7h6M43dsQJcCsmoexrhsEc3UtRLuPNWgpMongdnn22HVC9Sj2tx7m3MARSbEZh8SPrBtcUg==
X-Received: by 2002:adf:8e50:: with SMTP id n74-v6mr972547wrb.100.1529580446406;
        Thu, 21 Jun 2018 04:27:26 -0700 (PDT)
Received: from [74.125.71.108] ([149.199.62.254])
        by smtp.gmail.com with ESMTPSA id a5-v6sm3678070wro.12.2018.06.21.04.27.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 04:27:24 -0700 (PDT)
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH 1/2] microblaze: remove unecessary of_platform_bus_probe
 call
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <20180619213620.14146-1-robh@kernel.org>
From:   Michal Simek <monstr@monstr.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=monstr@monstr.eu; prefer-encrypt=mutual; keydata=
 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
 RmzhqoTJlA==
Message-ID: <79e40491-6f64-d69e-9f6e-d51b3510243b@monstr.eu>
Date:   Thu, 21 Jun 2018 13:27:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619213620.14146-1-robh@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="snYpS2BphDcbml0xLcyIXS2IYZF3YF2Ew"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--snYpS2BphDcbml0xLcyIXS2IYZF3YF2Ew
Content-Type: multipart/mixed; boundary="GMOHKbGyPP7quG4YHM7O7r3JVzsHljcbf";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org
Message-ID: <79e40491-6f64-d69e-9f6e-d51b3510243b@monstr.eu>
Subject: Re: [PATCH 1/2] microblaze: remove unecessary of_platform_bus_probe
 call
References: <20180619213620.14146-1-robh@kernel.org>
In-Reply-To: <20180619213620.14146-1-robh@kernel.org>

--GMOHKbGyPP7quG4YHM7O7r3JVzsHljcbf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 19.6.2018 23:36, Rob Herring wrote:
> The call to of_platform_bus_probe has no effect because the DT core
> already probes default buses like "simple-bus" before this call.
> Michal Simek said 'xlnx,compound' hasn't been used in a long time, so
> that match entry isn't needed.
>=20
> Cc: Michal Simek <monstr@monstr.eu>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/microblaze/kernel/platform.c | 7 -------
>  1 file changed, 7 deletions(-)
>=20
> diff --git a/arch/microblaze/kernel/platform.c b/arch/microblaze/kernel=
/platform.c
> index 2540d60610d9..b9a414552d9b 100644
> --- a/arch/microblaze/kernel/platform.c
> +++ b/arch/microblaze/kernel/platform.c
> @@ -14,15 +14,8 @@
>  #include <linux/of_platform.h>
>  #include <asm/setup.h>
> =20
> -static struct of_device_id xilinx_of_bus_ids[] __initdata =3D {
> -	{ .compatible =3D "simple-bus", },
> -	{ .compatible =3D "xlnx,compound", },
> -	{}
> -};
> -
>  static int __init microblaze_device_probe(void)
>  {
> -	of_platform_bus_probe(NULL, xilinx_of_bus_ids, NULL);
>  	of_platform_reset_gpio_probe();
>  	return 0;
>  }
>=20

Applied.

Thanks,
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--GMOHKbGyPP7quG4YHM7O7r3JVzsHljcbf--

--snYpS2BphDcbml0xLcyIXS2IYZF3YF2Ew
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlsri5cACgkQykllyylKDCFx9QCfWdeOFI60JYjhUwuHI9OdHfFZ
ZRAAoJK9O2o09Ry2E6Vf99U40TlGuDFO
=P/5e
-----END PGP SIGNATURE-----

--snYpS2BphDcbml0xLcyIXS2IYZF3YF2Ew--
