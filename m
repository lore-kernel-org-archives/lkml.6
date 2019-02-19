Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5866BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C1792147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JI5JUQ/r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbfBSRHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:07:09 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43141 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbfBSRHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 12:07:09 -0500
Received: by mail-wr1-f67.google.com with SMTP id d17so8392782wre.10;
        Tue, 19 Feb 2019 09:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wzlV2QAH9pT27eShx13Lf8lV4OInzAHffmyQAEg/bgQ=;
        b=JI5JUQ/rTPO+aiw9yQa+wa+nhO38+2rs+GL0H0CyzBJbq1uqVSEZet5JyIuhlxmM7e
         XZfLPsL3DBxd51SIqWOhzQ+IiaRxq5pVHIbMuvcLlNxPzHuUoGNVrOszbm3Qwd/2FspF
         4H7cSbNMgARbBcDpChPGnAXVrwBzzH7jnwX9inW/ko185h2812sjKmcbyoRJzafD4r5l
         rU0aRcOQMHd8owJU1TCDYZDL9t/ftBlIt2OZaghTBoDDiwViuXWKM1ZeRwwUEVdDW/NM
         heR9uBR8D4hMKThhOD8bZepc6pNZyLRJwLreBtWv1sxLsd0cekFgHevw+gYUVuYwkpwo
         8fVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wzlV2QAH9pT27eShx13Lf8lV4OInzAHffmyQAEg/bgQ=;
        b=tAvO36WJwTL6+abmuTIk/BnXL6T61afoGJDvQmI4mbi7vAsiGK8ev0CuqtoJ//wjiu
         KJ0niEIcInNVglyr5ho4ZnIA5UQftGoccx47SVddn2geBqV0m/h1D/k2gxF50p9hLLQW
         lJ7SF+1WTErqD+vcmG2toOU/O0LmQdLzGwD5W8If9TmF7bxLTFjTWWGdZkNR+BSQX8V2
         x7SonGrzK5v5S23+Mg8HMQsf6r8oSNiB1wO99UOzWB7SbOVMX5vlOYr3uYXlxVneUBhx
         ZIvOqA9NPrxWmZ8Qn/kDlLmNQhnmkFcH59+XSaojtSnKaRVSbuwOPFmUQQySrLi+ZOzr
         UJjg==
X-Gm-Message-State: AHQUAuaQ4fDS8BgCaB7rOGhfawb+4Xlmi/PANCVZEcKn672+K3dEks/i
        T6EF3I/apZA7NwSxJZty6kI=
X-Google-Smtp-Source: AHgI3IZ2GuQHI3OL90XRqlYxb6iuDpFEg41svd/juNGIosjTdsD6Ir/KJYxPUzj6i8JGdTratM+jVw==
X-Received: by 2002:a5d:6a88:: with SMTP id s8mr19209213wru.303.1550596026054;
        Tue, 19 Feb 2019 09:07:06 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id m15sm12848915wrx.30.2019.02.19.09.07.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 09:07:05 -0800 (PST)
Date:   Tue, 19 Feb 2019 18:07:04 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lukas Wunner <lukas@wunner.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] driver core: Fix PM-runtime for links added during
 consumer probe
Message-ID: <20190219170704.GB14351@ulmo>
References: <2442421.P6CTj2BjBs@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Content-Disposition: inline
In-Reply-To: <2442421.P6CTj2BjBs@aspire.rjw.lan>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2019 at 05:53:26PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> Commit 4c06c4e6cf63 ("driver core: Fix possible supplier PM-usage
> counter imbalance") introduced a regression that causes suppliers
> to be suspended prematurely for device links added during consumer
> driver probe if the initial PM-runtime status of the consumer is
> "suspended" and the consumer is resumed after adding the link and
> before pm_runtime_put_suppliers() is called.  In that case,
> pm_runtime_put_suppliers() will drop the rpm_active refcount for
> the link by one and (since rpm_active is equal to two after the
> preceding consumer resume) the supplier's PM-runtime usage counter
> will be decremented, which may cause the supplier to suspend even
> though the consumer's PM-runtime status is "active".
>=20
> For this reason, partially revert commit 4c06c4e6cf63 as the problem
> it tried to fix needs to be addressed somewhat differently, and
> change pm_runtime_get_suppliers() and pm_runtime_put_suppliers() so
> that the latter only drops rpm_active references acquired by the
> former.  [This requires adding a new field to struct device_link,
> but I coulnd't find a cleaner way to address the issue that would
> work in all cases.]
>=20
> This causes pm_runtime_put_suppliers() to effectively ignore device
> links added during consumer probe, so device_link_add() doesn't need
> to worry about ensuring that suppliers will remain active after
> pm_runtime_put_suppliers() for links created with DL_FLAG_RPM_ACTIVE
> set and it only needs to bump up rpm_active by one for those links,
> so pm_runtime_active_link() is not necessary any more.
>=20
> Fixes: 4c06c4e6cf63 ("driver core: Fix possible supplier PM-usage counter=
 imbalance")
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>=20
> Changes from the RFC version:
>  - T-by and R-by tags from Jon and Ulf.
>  - More details in the changelog.
>=20
> ---
>  drivers/base/core.c          |    4 ++--
>  drivers/base/power/runtime.c |   29 ++++++-----------------------
>  include/linux/device.h       |    1 +
>  include/linux/pm_runtime.h   |    4 ----
>  4 files changed, 9 insertions(+), 29 deletions(-)

I'm sure Jon and Ulf have done much more extensive testing, but I've had
this applied for most of today and haven't run into any issues, so:

Tested-by: Thierry Reding <treding@nvidia.com>

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxsN7gACgkQ3SOs138+
s6Fm+xAAnvoSqdn6wZcWkWeG6qooOo7YeCJH5FRW4fU6hIXoj6So8VgX9Miqnn+j
bDvvgviE6euyVqHSA2gokG35z0JQE8ZrIBcVwx2nZ7Qk8tGpYncvDtnnXCarnY6p
z4tfFrLK15/c84R1tc/ighFWS+9HAdZ33Lp673bhKCioGS52oUKoHKPIfoSYzIhL
oHcby4bCaWz91vwHVWfIF8vsBzvVPfs784D5Pc/nObvfOpa61ec1QkZvt+sdsC6L
edN63P4bYUzFhASWyrsOSPDomahh535L1cnXnNObcZTIIeOigiI6/gMDAhQkHK6E
QV6KtIPvj/uooTj9WHT5RqGHhQb+6fcyOzVwsJMJLpAdqErOzBTVlw1j1IuvGu2q
uOu1n+pz0c3h2y0B1bRc+CWjEMvRoHYz+eIcfE6GNk9oA1oE2rmiO4K/OeNicbew
hVrAuwBj02PgFmvEyfk9te08jhWwPEdApQB6A1bOazF+HHp/sHF/18F/1zochBcO
2hiyTs8br4Sriv2f+AnYncGTEGGgTtcDI5006mut0QlKTkTJT03PNEpP4I8aKtic
rrAfRIQbDA2BN6qcaBbjvAtgPZ6kVCRMcGBfp/yGg1fFh+6zbrROChQsiXrbbnDO
PLgh+vZMsUpj2QjwLbWCfl9+5ye6vIMX+FeFXSDIkjzWZetK2dY=
=hcNP
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--
