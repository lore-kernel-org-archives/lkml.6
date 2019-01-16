Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B249C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDCC220578
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVu/CGD9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403902AbfAPMcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 07:32:21 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55947 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732893AbfAPMcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 07:32:20 -0500
Received: by mail-wm1-f67.google.com with SMTP id y139so1764847wmc.5;
        Wed, 16 Jan 2019 04:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=phQIeCgUHi7zMXRFqO2t93/1fJdgOeJ+b+jyCo5TPfM=;
        b=kVu/CGD9XoBVp7xhK3yp4Z7dleZHxn8W56y7tlxSKJRuByCy9mKRdE+bAVivRkpau5
         Sr3aHFDkBDGeHQzMoZNuLa3TuESEnf32yWzc0Pv13CfyB12OBO443yUz+oRTL4drJDSi
         wxfuLOhVSYuDGge1lenH1kcya3R52HDmHv2TZrB8VrM8j77rmV0dgaZxTcA0U705jOnQ
         zG32Ql71a25t6rQ6iV+h9mUH1fcuSRcS7L78SrKqYXFVhL6Qe4g/qPpJWTXO6JyXhUAg
         w+Wg9VAsppEdQiBLjfxBxvCQxCgz5UmxxurbZM+cGwLT1hzBU5tY43p0SCioUqY7Vvep
         K//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=phQIeCgUHi7zMXRFqO2t93/1fJdgOeJ+b+jyCo5TPfM=;
        b=Eo872Ge5MbiDre4iQlf3hcWZ2OyAzPa00KBIORSYSbWQcg2jBMA9bcUsPl7ela0YHo
         GAbOczvYOM9XPm7Xn0osYhBaESb0m2eVr6puGqeSLiQFeVhnt0HzrykUPFGT6wQNCM3Z
         hJwIxxIsC1MOclL29+3SUSPCBvpIvfF8rco7LN2Ghtp83DF9aXjQr9Ihd11yE7j/cwkl
         ReMPkTD9DqLkZTUatbpdinxaAHfq2oz+MqvAk2j1AaE1+YkK7p1Fxc+67x/6JQOzW6H9
         dsz/OAzgsZnCJN0ntSsQZE8LpmPXWLIs+4fdVe6vVx9x1f/tBmOyYnLtmFhFtSHjLBd2
         jbug==
X-Gm-Message-State: AJcUukcJkvJy1xxO7WL04OGvPuIzE7e/4U0pGjvVwT7bLLtlFlDwiQ2m
        s3oT1q7bbuTP/BMD2lY1HYo=
X-Google-Smtp-Source: ALg8bN7ovEGrwBvGEQ8+NsfDdkOWp6Heok+crT5/6zwCHyVYfF185cigxAOGcMBWopE5uA0wHPhJ5A==
X-Received: by 2002:a1c:4c0c:: with SMTP id z12mr6979206wmf.17.1547641938529;
        Wed, 16 Jan 2019 04:32:18 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id w18sm67403447wru.54.2019.01.16.04.32.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 04:32:17 -0800 (PST)
Date:   Wed, 16 Jan 2019 13:32:16 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>
Subject: Re: [PATCH 1/3] mmc: sdhci: use WP GPIO in sdhci_check_ro()
Message-ID: <20190116123216.GC30993@ulmo>
References: <20190115162837.5399-1-thomas.petazzoni@bootlin.com>
 <20190115162837.5399-2-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
Content-Disposition: inline
In-Reply-To: <20190115162837.5399-2-thomas.petazzoni@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 15, 2019 at 05:28:35PM +0100, Thomas Petazzoni wrote:
> Even though SDHCI controllers may have a dedicated WP pin that can be
> queried using the SDHCI_PRESENT_STATE register, some platforms may
> chose to use a separate regular GPIO to route the WP signal. Such a
> GPIO is typically represented using the wp-gpios property in the
> Device Tree.
>=20
> Unfortunately, the current sdhci_check_ro() function does not make use
> of such GPIO when available: it either uses a host controller specific
> ->get_ro() operation, or uses the SDHCI_PRESENT_STATE. Several host
> controller specific ->get_ro() functions are implemented just to use
> check a WP GPIO state.

"use check" was probably meant to be just "check"?

>=20
> Instead of pushing this to more controller-specific implementations,
> let's handle this in the core SDHCI code, just like it is already done
> for the CD GPIO in sdhci_get_cd().
>=20
> The below patch simply changes sdhci_check_ro() to use the value of
> the WP GPIO if available. We need to adjust the prototype of the
> function to use a mmc_host* as argument instead of sdhci_host*, since
> the mmc_can_gpio_ro() and mmc_gpio_get_ro() helpers take a mmc_host*.
>=20
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> ---
>  drivers/mmc/host/sdhci.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Other than the typo in the commit message, this looks fine:

Reviewed-by: Thierry Reding <treding@nvidia.com>

--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlw/JFAACgkQ3SOs138+
s6GeDhAAwsNmmLpq9tvuMI4JohtkuLt6RUH4Gr+hsYPGSzqqZrIa0GtmelLT6Orf
omnjgIpNq+dGJIXlH+LmHjGmDdQiMs3Q/TeORrMjXvHryoWGbXFRqNgoCanM+UvT
TbcDMMGvjkLNTJ4ra0gwJzSB4us+atleiCYn00ed+oz9Hzz3QZ5ncOK6E+JULwKn
shVzMM2O84za0wt3hTG7vKpA18VJg5zVaJGVsPPNvUOHYtoCDFD0JN/Uf13yU7rA
jVv+an0THTk0Lz82mBMLl4jZaRV2npKwvznzgnae85iflV61RFnkvQ13uXuEg1C5
LmNSBSO3YE7kxmfaRaUgQ1G8wB42/nHNxizE8+09ET9bRjUGsy5cybC/05WihEgo
UPZtqr66dN899Zp1NaBugD1M0NKPj9ZbQIsZ6yjRICPxIAE/2cYIM4Kq8JrpYC0s
JqC5t0KjRCM7W4IY7ImG8rgT26VwSoXNm2xaan7T7D/t2divLQsNBXK+QiZRPooA
ggFnnJTz4Sm5h8GD79RWGfnh1jJ+oXIyhOOTWXlVHNhXFiOoKf8fymUPv2mU5cym
w2M1ZraTqC6Rn3EG0FzIJq2jXmgiEsZod8B7jVJyTFJEJCbkTIRQfy93Hw/KNu6k
XCfm3V4pXTxWAViZ5/3pmaVKsDduXLRzCKofuKXA9CS0QhYMYZw=
=i3+o
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--
