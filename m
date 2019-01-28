Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33709C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA732184D
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nigk6Sqs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388383AbfA1QSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:18:16 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:50565 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388351AbfA1QSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:18:11 -0500
Received: by mail-wm1-f42.google.com with SMTP id n190so14651250wmd.0;
        Mon, 28 Jan 2019 08:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ufeu8Lz+oaM8z+oyMCQG6BYxf2o0e3Wj1J9aKIiazgg=;
        b=nigk6SqsOR2Et16NRaPVAy4CATGAT1i5UvrYEsRDd0tT7uqbIxD9m/QkZaSWPntiGx
         lxXP9JS2niFAhv86xUxT9i5lP7VZx9p0pqFbczcpeNpko+qZJ/8joykP6kuhdHqKCNa8
         mxDs3WkILFFr2T+LkSvL/GFHAZuqqM7eqVgpPwtJ1orkeywWkO/y87fQ3jpWJx2+Riht
         s4lKAvIP89XBwBvYieA4WqWHj/uM1cBBwM3rSFjbjDe4M0o2LpDOSWP86UQ9lvJ1TGFs
         s9rxwAYmg7+jStCbzprK+skJpYtqTn6YmonfmgMTfLJi8o9Rhnl/fbi7Ash/BMea6A9S
         H0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ufeu8Lz+oaM8z+oyMCQG6BYxf2o0e3Wj1J9aKIiazgg=;
        b=d06oX6SgBk4YgNdM0u3TsSM4NREbeXN0bzY3hUlZmT+XZCDLPgN0Ab55iRHa81GRNG
         Is86OFBcTjr52pjPzQHwBJy4YJfvAlRfYjicjziEMwcn04Zqs8WXffJTtHbxoCfDCuuO
         rEJR+zXyAIghZCOahLfV7h30ewvQKhcUghWEDgDy7Mtw7x5AG6XYdB3l/Id1zvDpJaQz
         xuG6gKwSSNiq4LPHedqvl+JA1fTcSmLybp6HFtI4upEOePsrpO0uy3Gnj30qGvUWv8FD
         m/gDZN2bM68ujczmpRUZknj0dIZqEjNjL7RmpPe2sIkrbaXUWEua5+I76ksMcXlGPXA6
         Yn0w==
X-Gm-Message-State: AJcUukexQycD8hH5Xj62V+RLJxuSFrMZJaYxmB9QKSZCokHa8/dZRh5J
        KUt+St72u2+bB9uV0QFrOgQ=
X-Google-Smtp-Source: ALg8bN4cP3PCY9aMz9TpNOUgwQkMdbpe9WzpKc2Q3lmMyNffi5HX3gnSdt9D8hJ5wLT5BZ9Fd3XB4A==
X-Received: by 2002:a1c:a00f:: with SMTP id j15mr16989022wme.84.1548692288622;
        Mon, 28 Jan 2019 08:18:08 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id d2sm93643621wrs.97.2019.01.28.08.18.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 08:18:07 -0800 (PST)
Date:   Mon, 28 Jan 2019 17:18:07 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Eugen.Hristev@microchip.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Nicolas.Ferre@microchip.com,
        Cristian.Birsan@microchip.com
Subject: Re: [PATCH v2 3/3] drm/panel: simple: add support for PDA
 91-00156-A0 panel
Message-ID: <20190128161807.GI26200@ulmo>
References: <1547458584-29548-1-git-send-email-eugen.hristev@microchip.com>
 <1547458584-29548-4-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PMULwz+zIGJzpDN9"
Content-Disposition: inline
In-Reply-To: <1547458584-29548-4-git-send-email-eugen.hristev@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PMULwz+zIGJzpDN9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 14, 2019 at 09:43:31AM +0000, Eugen.Hristev@microchip.com wrote:
> From: Eugen Hristev <eugen.hristev@microchip.com>
>=20
> PDA 91-00156-A0 5.0 is a 5.0" WVGA TFT LCD panel.
> This panel with backlight is found in PDA 5" LCD screen (TM5000 series or
> AC320005-5).
>=20
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)

Applied to drm-misc-next, thanks.

Thierry

--PMULwz+zIGJzpDN9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxPKz4ACgkQ3SOs138+
s6GQ7A/6A40zNnOUXXz3Y+lz+5v+ncu7xHRZ6n0q11nJJ83TduEbkoCTQgLkqKy7
makLAI2kCDJsHqW+fdxxLNPEBV2njIPhSPzwLBEdbom+bGGICO2+3aGCuXQLe7wB
mNeTziTe529E7CCdC0SatoNzkRY1mph5jzX6mzvgLdIJ8NBrSOBJAriMc8LCi2ih
re6hNFdF/OpVxwn8t3mwGJL4Tl6PKUf/NGkEujoxzokEAv9+5J3Jv0nYkctDVFLj
KpkT8cAHaa2l4h+CMakmbk9kQmfr6138SSZcrH+KY2u9GihXQB1cntXnzTks/GAZ
1yGcHPqGhlG7fn94Lbyw03AvrFPkKYi9fUQdit9X6AIHg3OUZ9atgMt85ekr7Jzm
ZM9ohgrgAUGZ1FaGoOPAXLFE/EKFvQg6CZ3ji9eXaLceFHiisZzFu0JzfZL0YrQg
+TmoUNF8Y7cXbKfBMXTo0vt9aJaeo4HIkDl1+uUvjYZo+a+4cHEOQkzS45k3hXnX
Pif7g3C7fpWwF6avcPMHhZ9E8RXcaNYeisY4QiaWkNoidcZshTs1FOqVpeWm9owI
p42ah6cQLYtMj9xsKH61a4kWi9djQ0JzicWZUWfL366thRKXv4KYQ8wYKqsYCsV+
fxFtKD4ZHngM9siOCbWeG/wVatEx42nxF9Sl+zwf5DPtWVdX0ag=
=e/Qf
-----END PGP SIGNATURE-----

--PMULwz+zIGJzpDN9--
