Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A994CC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 15:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A06C208CA
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 15:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSoZRO1i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A06C208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932720AbeGHPJT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 11:09:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46863 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932091AbeGHPJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 11:09:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id s11-v6so8408466wra.13;
        Sun, 08 Jul 2018 08:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+2+bod118ttdd1rSjSKdZOkQgp9I6uE/Fued1aXTmUw=;
        b=gSoZRO1iGGRNfFKwjOVnITzdkNFhJ8g7ADQtc4GBU/WPXMX2h53R4QqYrSNzq2PKUy
         vl6vqqVB3MJGpb1wuoYN2Xq3GanEfE40UVwon9iWw4RfXc8T9ReVb/WJjB9llypMSz+w
         jp1cYiMYAGxyxkNSVxlVhXMEio6yYFhUUhrxwJluOm1osQj+KhDwcS0e/r1dayQSeIWL
         WU8tjJ7rLFVJJluVRTuy/c/S6q8rz4AL91ElPXiUkWFYW0A5tzAEHnICtW4muKw7I9rh
         d7ZvlODcJAFF9ZgG3QQYaPqkSXkxzN17DXC5NwWm/WO7HTrUhNQDHYt8S/6e5+NxHC8y
         riug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+2+bod118ttdd1rSjSKdZOkQgp9I6uE/Fued1aXTmUw=;
        b=dTH7hhKPc/r5k7Y67G0oBDg1iw/tdqp6GNN/m5qAQ1Kb0RHviPMmFN0+mf3QTgjmQF
         LGP+/GBoR37LpokgoLY3vq7i1LqqaPO43j56fqSxH9fkdVM/N/uyLITcrAViTdOefVMu
         Z3walAAwp/8dELQKmx05kD6Wp1sjwiqUjqk5qQbZdxA+gZR4VCmxfGdt55129avs+8nN
         iiWunYoth7h73qvNzuU/A4Oi648kFzjFi9EW5QWL4spN4vsGFvPu4VQJdcwlx3vurBQ0
         9YpIT9Jj4SVK8SDiFZqU0+1ecckJjAZl0EtkxHRZgOY5iwCoIoiP+74GOH3zWIsjO2Zn
         rpEg==
X-Gm-Message-State: APt69E0JPwdg4rHaaKHyQkW6FMFjLCU31Bf456YxCOH6lon9TtQF5EXV
        g9sdwj6U4/5C/7cIWFn9a98=
X-Google-Smtp-Source: AAOMgpdpy1Yw0/BxzYwqTx8Acbgfxn50iAomlKslPwKJS2WctbHPkIHHNcvctngv1f44HPcaXZSTqQ==
X-Received: by 2002:adf:a6e2:: with SMTP id t89-v6mr13390980wrc.231.1531062556124;
        Sun, 08 Jul 2018 08:09:16 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id l10-v6sm14112881wrv.23.2018.07.08.08.09.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Jul 2018 08:09:15 -0700 (PDT)
Date:   Sun, 8 Jul 2018 17:09:14 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Damien =?utf-8?B?VGjDqWJhdWx0?= <damien@dtbo.net>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dell-laptop: Fix backlight detection
Message-ID: <20180708150914.x4tpxbe5yq54hw6a@pali>
References: <20180708170220.35f40818@anakin>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wtqqc3twmzzketk2"
Content-Disposition: inline
In-Reply-To: <20180708170220.35f40818@anakin>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wtqqc3twmzzketk2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sunday 08 July 2018 17:02:20 Damien Th=C3=A9bault wrote:
> Fix return code check for "max brightness" ACPI call.
>=20
> The dell laptop ACPI video brightness control is not present on dell
> laptops anymore, but was present in older kernel versions.
>=20
> The code that checks the return value is incorrect since the SMM
> refactoring.
>=20
> The old code was:
>   if (buffer->output[0] =3D=3D 0)
>=20
> Which was changed to:
>   ret =3D dell_send_request(...)
>   if (ret)
>=20
> However, dell_send_request() will return 0 if buffer->output[0] =3D=3D 0,
> so we must change the check to:
>   if (ret =3D=3D 0)

You are right, dell_send_request() return non-zero value on error.

> This issue was found on a Dell M4800 laptop, and the fix tested on it
> as well.
>=20
> Fixes: 549b4930f057 ("dell-smbios: Introduce dispatcher for SMM calls")
> Signed-off-by: Damien Th=C3=A9bault <damien@dtbo.net>
> Tested-by: Damien Th=C3=A9bault <damien@dtbo.net>
> ---
>  drivers/platform/x86/dell-laptop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/dell-laptop.c
> b/drivers/platform/x86/dell-laptop.c index f1fa8612db40..06978c14c83b
> 100644 --- a/drivers/platform/x86/dell-laptop.c
> +++ b/drivers/platform/x86/dell-laptop.c
> @@ -2185,7 +2185,7 @@ static int __init dell_init(void)
>  		dell_fill_request(&buffer, token->location, 0, 0, 0);
>  		ret =3D dell_send_request(&buffer,
>  					CLASS_TOKEN_READ,
> SELECT_TOKEN_AC);
> -		if (ret)
> +		if (ret =3D=3D 0)
>  			max_intensity =3D buffer.output[3];
>  	}
> =20

Reviewed-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--wtqqc3twmzzketk2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCW0IpGAAKCRCL8Mk9A+RD
UktQAJ9ndsT1KIfEeZAahpigvrPbDJH+sACfYRCDasXR+UBhF7ARasxGpznSWXU=
=rZw7
-----END PGP SIGNATURE-----

--wtqqc3twmzzketk2--
