Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDBAC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA732084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0rhKgBP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA732084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbeLLOGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 09:06:11 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56076 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbeLLOGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 09:06:11 -0500
Received: by mail-wm1-f65.google.com with SMTP id y139so5858582wmc.5;
        Wed, 12 Dec 2018 06:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/Ngl/3sNByFGecTFbcd0qMUD9GCJOsTEKEVK5WoQ7HA=;
        b=D0rhKgBPNm/tJ3WEMiXzUk7Q3RmRCgwPRrIbFyHPV6ii1/fvYVYcunxqw1vTAgJHGM
         ALAHoJ7LVubhXwWvYj5ZF8iqvjiFeDo+nvtf+YdzaJt9ACaiATjhG3+Vnbx2SUGqQ81I
         Njxl+lPxfJ3u0X2cF7QIuOsybUJ6OwGAuutmB550bAB2jdVyOskfwxgipMH/VUtGkvTS
         rjOEPqzpXQ/d5ErXAEIXqRv0X20XEJUM8l1UWQyse9vUQKPhbW2jBCak3I1Au7ODHWcZ
         hLhalUb7E70hRXUosPumWn5t0a9+hNBy0bAJiZnauolwMkKWozFo6uC8bmvlZ9okofaL
         B6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/Ngl/3sNByFGecTFbcd0qMUD9GCJOsTEKEVK5WoQ7HA=;
        b=WW3n6TvdV9D2ZGsW8d3zQ1FUJFmtBcikINZmSzdxRpGiNaqQEFmXi0LfuYriJzNaFY
         RjfJHwr6O/WcxSMaLwdA4UvYo88ZIZ+p1ociTqgSaMmRjb80BanOaC3G2flnYGnMgpae
         ZCwfsKseECYZMih2+xZuItBWG25NOtUF6LH7D8MuZkw556Cb8MkJ5aG6hBtWoO6LNdSh
         BSaynqAj5yZTvsOq8QFAP20MFDSTBGaAxFRfm9s5qs90uhBsQrld/OcyvYmmHGRUXD5A
         PgIO7A8lIp0VSHaZl3E7NRqP+xH0VTKWTxXZfZQypP8D0BgyyXDm+vsnvX7pskk6qsim
         WKdw==
X-Gm-Message-State: AA+aEWbUiC2indIp1TDZuioLTw8MvuuhNwyppBKTwLcprsgQLXVzs1MP
        0APaTQahEqlPB0oI33ldi0A=
X-Google-Smtp-Source: AFSGD/U2NpjmiH6orVmUEkGFDRN8BgNxpBJ3A9Ubtin1Ng5fKQZdEUgtIGMJn8Er/B+fP5+C4+z84A==
X-Received: by 2002:a1c:2314:: with SMTP id j20mr6407376wmj.142.1544623569312;
        Wed, 12 Dec 2018 06:06:09 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id a12sm16682229wro.18.2018.12.12.06.06.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 06:06:08 -0800 (PST)
Date:   Wed, 12 Dec 2018 15:06:07 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     mjg59@srcf.ucam.org, dvhart@infradead.org, andy@infradead.org,
        mario.limonciello@dell.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: dell-wmi: Ignore new keyboard backlight
 change event
Message-ID: <20181212140607.nrawhff2rgn5ykja@pali>
References: <20181212064125.25137-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ajpibhwdb3gdqfhi"
Content-Disposition: inline
In-Reply-To: <20181212064125.25137-1-kai.heng.feng@canonical.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ajpibhwdb3gdqfhi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday 12 December 2018 14:41:25 Kai-Heng Feng wrote:
> There's a new wmi event generated by dell-wmi when pressing keyboard
> backlight hotkey:
> [ 3285.474172] dell_wmi: Unknown key with type 0x0010 and code 0x003f pre=
ssed
>=20
> This event is for notification purpose, let's ignore it. The keyboard
> backlight hotkey uses another event so it still works without event
> 0x3f.
>=20
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/platform/x86/dell-wmi.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-=
wmi.c
> index 16c7f3d9a335..c3166ba73e9a 100644
> --- a/drivers/platform/x86/dell-wmi.c
> +++ b/drivers/platform/x86/dell-wmi.c
> @@ -267,6 +267,9 @@ static const struct key_entry dell_wmi_keymap_type_00=
10[] =3D {
>  	/* Fn-lock switched to multimedia keys */
>  	{ KE_IGNORE, 0x1, { KEY_RESERVED } },
> =20
> +	/* Keyboard backlight change notification */
> +	{ KE_IGNORE, 0x3f, { KEY_RESERVED } },
> +
>  	/* Mic mute */
>  	{ KE_KEY, 0x150, { KEY_MICMUTE } },
> =20

Looks good.

Reviewed-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--ajpibhwdb3gdqfhi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXBEVzQAKCRCL8Mk9A+RD
UrR8AJwKr+779pt0Pd3lwX78ReYcUFcVxwCfSvLj8abvqOYllNgNY+KgjdjPaS4=
=TZxd
-----END PGP SIGNATURE-----

--ajpibhwdb3gdqfhi--
