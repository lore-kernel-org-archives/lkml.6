Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92315C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD3F20883
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWs48b/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD3F20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933451AbeGIRCm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 13:02:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37168 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933315AbeGIRCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 13:02:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id q10-v6so11741178wrd.4;
        Mon, 09 Jul 2018 10:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hgpx2OIo/fH7/PxyRgwvn5AG+JxlK4GjLsMLtLuc25Y=;
        b=QWs48b/CbdqKM0hPx1dBcWUSuDBp/KKwktQaQO7cjpQEj0TjMlegHH8VbBlgbaN9r/
         iVZIzAZlRAL8uq7iWtnmvJUrAWFuUr/zsV+xYhqtw3uSios6q6zs89JLbxH8Jyndhepi
         1X0MY4qWbDWdNgkM+JGQjXuGpQ+LeI2lwPs65dpeCGNH00xah4G3WMbiVv8tMjpfjqjx
         6iKdaSIo7IZxHbHF93wT+gtdqnXkVY7DFo2UP2IDbSMqu6fTic/Mz3RJ1yRo/E2y6ym5
         oUsdedzpIDAqyqud7wz/c4VNQvbCZwNEkCm+MSAlIAwjSaXUXgccStzJ3jz6NYLcVxqx
         n5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hgpx2OIo/fH7/PxyRgwvn5AG+JxlK4GjLsMLtLuc25Y=;
        b=AQdilC1GuA1a9rpkChJy/p29Z3RsoalR51oKxTrRt3ZClnDPXcx1nUDPGOmkgSs0wX
         TK8ey+CxEqRN9jNkRQ6VvI0Y1OLNDzO2YixOw3l67NFicIPRZvUWCKdkzblwIaG9FFuv
         kyreWu0kDUbpxHhKYNh1tdo+ljLxh1Qe57EgGleD2ilsAz5cS89bsMQBmXXCdQNmFfnf
         SCIsCyWMTC6t1XwgFBnG0BU3lA41zwtgaRK57H6KutjcXvfRrO6DQKhlrXs9PKgXvp8U
         Se+11hCla/CA40nvbfZ4w19RIbwjWHM/7JxPhS5OO05m5CgBqk1g/7gO2H9XaJbQ60JN
         0l3w==
X-Gm-Message-State: AOUpUlHFCiexvEnIeJOvNY+8sbsfhU5g3SDUwcvb4IS+cnvIljvDUY8x
        bas7dCrFxg3X0zZ3P+IKhjC4Rg==
X-Google-Smtp-Source: AAOMgpdTNWOQeeSmx+VGDWUeV7Fw5FzuQxLFLxejf5bPtcglhgZvbhzBtvneSU0Dz/yLS8GCRrPy7A==
X-Received: by 2002:adf:acf6:: with SMTP id o109-v6mr2129518wrc.34.1531155759489;
        Mon, 09 Jul 2018 10:02:39 -0700 (PDT)
Received: from localhost (pD9E51B8F.dip0.t-ipconnect.de. [217.229.27.143])
        by smtp.gmail.com with ESMTPSA id 24-v6sm38802651wrz.94.2018.07.09.10.02.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 10:02:38 -0700 (PDT)
Date:   Mon, 9 Jul 2018 19:02:37 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 6/8] pwm: cros-ec: Switch to SPDX identifier.
Message-ID: <20180709170237.GE26651@ulmo>
References: <20180605175429.9072-1-enric.balletbo@collabora.com>
 <20180605175429.9072-7-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="47eKBCiAZYFK5l32"
Content-Disposition: inline
In-Reply-To: <20180605175429.9072-7-enric.balletbo@collabora.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--47eKBCiAZYFK5l32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 05, 2018 at 07:54:27PM +0200, Enric Balletbo i Serra wrote:
> Adopt the SPDX license identifier headers to ease license compliance
> management.
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>=20
> Changes in v2: None
>=20
>  drivers/pwm/pwm-cros-ec.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)

Applied, thanks.

Thierry

--47eKBCiAZYFK5l32
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltDlS0ACgkQ3SOs138+
s6E3ww//RSQdA4BEAn2Tz6L7FOULNUMCJN/itBVul55azU7X8RWi8Lf+3ED6/uFq
napmFqadsFc7gaWtlb/Po5raIOkP6oFzIb6PIT77tdGSBgNSV5vTdTa7pnZO3Lwt
fqbXS98nesKnLIMWPVOqVD0A5jxdAfhod20o9e4LUOqI/eM5o7WzktoJqaOU3q4R
K7ec7S/jkvmHfoKHSVW13TJ7TETdNv2iUCxrRhtbMQLVvkxpQ/OU6CU0H/TC0CRj
n5EiwxsyH9uKbbahC59JhaXBU/Hw3J08quyq8OlKNgBKcjbuqE/y75Y1tZeFEVhO
9XuqtZwh4DqDsftcqCHYtpFk9heaNs1p9SQCRANK8M02dE2qXjbC12dJ8jtlt+7v
ntvJmi7Fxx98ZdVVvXU3xAyHPYqVx/CvwuMk2K3hsJobanI+PYWrZthvaJSQZg1+
HUJzbvq3kQ/uIHTcduB43kJOH+7gy0QEU/Tbg4XqvlDSqF1p8KnHV6RvJgQoG1LG
m8nt58iVKzhuS+j92WO6fvj9t1V88hTgoXlWKimgAQf8H4h0I51FTAewFcFSrJPc
k91fbvUkrXK3wkqPOFl/jh/jIHWP8KweCpv78dGScC34MKhAzfXaFgWmSq6fS2HU
xD1T7yzpDCUHz22BLBgm9sVoiqRA557LiqZyZY5ySJ48BU5DaeE=
=kgR/
-----END PGP SIGNATURE-----

--47eKBCiAZYFK5l32--
