Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52554C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64892154B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFoSaT9J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E64892154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbeHTMrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 08:47:39 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34944 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbeHTMrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 08:47:39 -0400
Received: by mail-wm0-f68.google.com with SMTP id o18-v6so13226599wmc.0;
        Mon, 20 Aug 2018 02:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rnuB8rtF/kaZa0/OSMS/WHdyS45hq3o4yPDRq3T4G2s=;
        b=iFoSaT9JW9R3kZWzz+qD6tL5rYzJikp3QCrQQsJkwCWfhapndWYJHiVEKFsZ62ss0N
         FGDG+pAr4ErgUHcSLsB30XA+9zwWHREGNNJ+gj1FuL8o6Y0olps9lgM/ag00q05OqXqB
         KocjNNc8JWJYrMCZDqpPIGCTRj9YQSTC0BfGy9oJ8/GqdUsmP5sPAx74A6Z91C86fQzI
         Ut6n/6E1QxXMshe+V9cHoZbYsr9JVir7A11XcUNKAK7Ee5IlQDMcKmyXFM5ZOWdyXeA5
         Ld56bbPijSlH6gzpLTQBhOBxOTF9p1vvtD9AgBPClFzz+cI05B9Ogwzh5XATrOjxSyj/
         Idsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rnuB8rtF/kaZa0/OSMS/WHdyS45hq3o4yPDRq3T4G2s=;
        b=dMTLfoXNBuJBhk/LcQ5hP8f5eN5h3K71+IKbWFYyVv/U5pOtdhPf4JHPqOuDWWyczY
         R2zt8iJBCvj4eMmPOsgxDqgraymZwxlM+kw9ASPu0OFBnOsqyBGxTCf2NXOA5DOvvaU6
         AfNejlNq41TjY14cjDIq10Y+z7NQhSmAi12t3l/GNwb0vw3Ra6NkHhPNrSHVlgbfd7AO
         CFjyeLULKX+ptrpmKeYbfdYGSuP1ItjjbGy8fZjhFCVlld59BRrlowpGtBEkanwqDcca
         1WUTbQZA57mJhEWtP5bFZ6huA6iwH/IB0K2r8ipN+JdY4AGXbTXhcD25yDeQTBcNh2rF
         3/2A==
X-Gm-Message-State: AOUpUlFOBbQdl09FrOIgUU858OrWLCX8W1cW8//xJBGZYtoRUaakhQzh
        lc34vJ/Cz9Zvig28gfBvW8s=
X-Google-Smtp-Source: AA+uWPyoCM3JPa7zEBnKurV9+ffW0H2kVku9DxhFd3LAGy/h8PUKMCJW5AuVSN9PMgPnB5E+chXvPQ==
X-Received: by 2002:a1c:ea9b:: with SMTP id g27-v6mr23748896wmi.152.1534757564450;
        Mon, 20 Aug 2018 02:32:44 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id i205-v6sm11997737wmf.30.2018.08.20.02.32.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 02:32:43 -0700 (PDT)
Date:   Mon, 20 Aug 2018 11:32:42 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>, linux-pwm@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: meson: fix mux clock names
Message-ID: <20180820093242.GC8242@ulmo>
References: <20180801105720.23999-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Content-Disposition: inline
In-Reply-To: <20180801105720.23999-1-jbrunet@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2018 at 12:57:20PM +0200, Jerome Brunet wrote:
> Current clock name looks like this:
> /soc/bus@ffd00000/pwm@1b000#mux0
>=20
> This is bad because CCF uses the clock to create a directory in clk debug=
fs.
> With such name, the directory creation (silently) fails and the debugfs
> entry end up being created at the debugfs root.
>=20
> With this change, the clock name will now be:
> ffd1b000.pwm#mux0
>=20
> This matches the clock naming scheme used in the ethernet and mmc driver.
> It also fixes the problem with debugfs.
>=20
> Fixes: 36af66a79056 ("pwm: Convert to using %pOF instead of full_name")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/pwm/pwm-meson.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.

Thierry

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlt6iroACgkQ3SOs138+
s6Ek3w/8CJ+FuFrZL+LE/RFDTuEtukAo1boyyc1MykHQ8cHPRBBsiHXFhyKLVUsr
hz31W9xtX98G71ROnzpDbBFyS5j/SPnZLaIGFwbwEqAzIsKDS8MhkYH2wjEH0gVC
V9jNXqWYYiGItsGyfXkvPiSULD1OHKD6hpYDC4kQhe+WvFmCk9R/135X0myETf9S
sEa17iLJ6HAh0AvCV930agM2wZ5tEi1TRL/sfca0XS06Vx5qXtdy9dtaFlrKU6jW
w3cvHTf0bxCY7ShmNrzvE5esok2VV2wir5fwj6hIDUIK9crCvQ6QcOiMP2ZZHlrQ
kZgeC3T6O2hXkGWv/q4yjS6mj5It8zNcwAsX5EUoFept+6SCFZLU+1Z7ZqHrlP33
gknC6AHcutrK5r2Z7Q5p9eUkdRStlexpXok5LtrHoKjnPpuoIUuaIahFXZpidQ9d
lhfNTinvaq1Eu/oPcO4/JWI8GixACkLNgH7urUfvgV3YfQj4q4wQ3nTfHOOM7PnA
dJKk9GqsUf1f+oTgms+iBCnxGJ+AzhIeyr3wy2FiLljwicApwILe2xAXl1HqwT9R
YfTOn7ufs3EE3q1U6TaO/0H7QDVnHva6P5CjX2O3Gs8K1vz8QnXCA8vJUH0JB2WB
+p0trXuYlb1mkyKQb3MbB0vXuc1aRb7qsZ+qBQJq79Nx6Ia2CpU=
=LNSJ
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--
