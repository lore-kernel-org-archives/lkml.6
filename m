Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898CAC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526C72147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKR7KF7x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731097AbfA1RbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:31:15 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54980 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729610AbfA1P6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:58:16 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so14550254wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 07:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nk2L2kY3ijKVwPEwYYt3wvEHHf0F0QhwE9k8NOFbOgo=;
        b=WKR7KF7x9ykDgaywv73OwXmeSFjkYna/pFuhOfHBqgtx1ntTjevO1wcVQarTP4fWPP
         34LeWKXsoTGUbscAF9mqX07ntx/SqCH3dvj4xBWYFKaYmQ8+7DskxFwP6psSQIB4g9DI
         6q6xak+M/r9atWAUxaTxppjYOlxaOvBcvLjmWGx+37alF14H1CMu8K5W3QqhobqtBrwQ
         cauNnjZZJ+4UxgoAhobrEoGxwT/97xFv7Kr1BwaAiGBSlDg5MCfjjsksbzV5vSa/7LF1
         dWUiBQWgvunLB3Qq1fbRs3rAWS9THtKiv52Hd5LPtk5ZgrxlD5C1BbJz/BNbHMn3hhLX
         40DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nk2L2kY3ijKVwPEwYYt3wvEHHf0F0QhwE9k8NOFbOgo=;
        b=QDNdnL208J/4bCHIYGV23LV3u2S4Y5/+h5OialI4QYZqY22/9utS0e5lCcvGt4rpOF
         2da6KaBZY0pWzZSTxFxNEAZjhm2ulGVXk6EeGbXO3fX2tUL4Fb4hFa3XhcQYevquu6a6
         o7yM0mh3ikC1SIXC67GteEK6RYsIue+n9g0tpSIn2aH7egBC1DKiemLrhl6J5u28m7RT
         WZVConl151nP+aZl9HnHD0RcKMQFmNf+lsXIf6yKD5OC8IRLUE+j4IQ+AFCGfWrazomt
         qzeQXswLUKeKQHkWCUPnHHjpDdJLT/+LnSXTRx7d6LMW9NAyOsagzzykx6pDoMGU+svp
         XKTg==
X-Gm-Message-State: AJcUukfemhh4rJ3Ls20SkkEeaml75xW50IZ7SXVpPnf05VLhaTYKwwue
        nO3+yb5nRdijxRq/nry6njI=
X-Google-Smtp-Source: ALg8bN566yMJ+TRH++AzTav7ZS/5GaI8qhn4cl8i+Kx/gymY/llsKof9aoQm3iKgAXdnnEwuk8xWOQ==
X-Received: by 2002:a1c:2088:: with SMTP id g130mr17294000wmg.122.1548691093694;
        Mon, 28 Jan 2019 07:58:13 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id k128sm104120665wmd.37.2019.01.28.07.58.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 07:58:12 -0800 (PST)
Date:   Mon, 28 Jan 2019 16:58:11 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v9 1/2] dt-bindings: panel: Add Sitronix ST7701 panel
 documentation
Message-ID: <20190128155811.GA26200@ulmo>
References: <20190124215131.17452-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <20190124215131.17452-1-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 25, 2019 at 03:21:30AM +0530, Jagan Teki wrote:
> Techstar TS8550B MIPI DSI panel is 480x854, 2-lane MIPI DSI LCD panel
> with inbuilt ST7701 chip.
>=20
> The default regulator names in ST7701 chip is renamed in Techstar TS8550B
> so, add specific binding names for them.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes for v8, v9:
> - none
> Changes for v7:
> - collect Rob Ack
> Changes for v6:
> - none
>=20
>  .../display/panel/sitronix,st7701.txt         | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/sitro=
nix,st7701.txt

Both patches applied to drm-misc-next, thanks.

Thierry

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxPJpAACgkQ3SOs138+
s6HDvQ/9FKy5cvkCq/2EJEd6MfVEfVFFr6VqlFf6FylZy8JJyIwza6THxdI9Ugu3
NUJyGyWh0GuCHLgLB71t1mm9Vp8zLJF3gRmuznRqyxycEnevOhUSUmLpW1GcV+Tx
/dSRO+OpUns+2QOCYCjIm2Wcf+pgWW/DweftcNaeGJHZi+1JkOTi3InXEzyWJMAh
xUFfFpmdATstThotRY/mJyy4MK3h+ymOL6HH2GfaQDfFfu+1Idrhfbc4X1uGyzPP
lo8XrUeCrNcxr3hvlXA/BIKXKY2Plbbiq9YURdNbbtw8i/fOn7TiUMmD5kOinMnk
lXHex0zOEHZLBR3R9DVQwmGEkp+Wp1lyBAYiYeckwnv+fCMIRpUzBKEnAQGpZf/H
xrL2tisSiQshTOvvKS5Fy0m63ovYsC7Pt8Eh4sYpmL32/zoRPA0he1XR8RkDVdAB
eSECeQAREYPxwvizA/NCzbV8miJzpuDZ02Lf/yDbE3iHU5rfu6U7R9z6Qt2wPmrt
0FzHof7IOqSmAtRSwbjP0UhsDUAjup4pZ6nGNJbScSTKvCQ3Q28NpSnaKdSF5Uzw
IWXvb2e+5xMV0yX75OekYGJI9v/tvR8vdcT4l/rHzsVcHs1MMHkBUNe3nPfWQZ2I
kJMqM+4vuNispQjoMvELpiefABMSZp2l6JNwVD3anDZUpTHTLMY=
=HAHP
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
