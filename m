Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807CDC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52BC1218DA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="psY1cC0u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732252AbfAaLXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 06:23:48 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33107 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbfAaLXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 06:23:48 -0500
Received: by mail-wr1-f65.google.com with SMTP id p7so2895468wru.0;
        Thu, 31 Jan 2019 03:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QAzHz2lgPibHLBj7Nb6iWwJlAWoldG8Zl0ALZrbS5sI=;
        b=psY1cC0ukcvlFMT0p9LcU46M89jbCTFGiPsWlSEKvTenG0FdBIf0K9vTcbC02cSIFL
         BwIiB7f+WJZe8v00uGTVPzCqz4688i6/Xl2yq4t1nG9rn3MC1+0odf1vaF1zpaKXtlim
         Oe7QZnLnq7cjYhYTOFrRyrQNgfwMh+DoizGiItrW2Qqwt+rd70uB4DcNXuoTRvZi5tE2
         SAQfhr2kkIaYLhmLWiYB/CGk++pIXAnqMIZMeUoEQqM6YBBAU8gtGl1AI7VEDp6pJSXB
         H2GmgUDh1xsdmJI2TSVuUOjgibcRJaD0QMJPdx0RKcF6coWOeBrGPhBK6ShbYvX1a6fe
         gdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QAzHz2lgPibHLBj7Nb6iWwJlAWoldG8Zl0ALZrbS5sI=;
        b=unzq4MJioYY2JGh2PAKYR0E2dlSimz5WD9Pze9Gcmcz7Vz6muYdnFuUSIvJDCkgc6R
         fS2X5tte5DmZOtmOMAxDBl8TZ1mAObJ4LrJWp5SzDBasWD/xBHMfTHrHPONAyEG0A4v7
         Bk8Kas6vjAfOwS1F3bIsL8R0ShzX+2aRth7okYBHckJZKo/m1eNobJAD2cTp7s3A/WVE
         qB5vAecGnBCOpDlhqGR/NXrgMVgo9H6Bgc4culHYaWISPJz+KxoP/MNmAoAZFOd5Pw1w
         wGA8+ZIu6r7XV49A4J0BTqlqZK4GADrt+O6jikPUBodYwDG5zZIhBexCuwN2Fd3rQFcA
         3CdQ==
X-Gm-Message-State: AHQUAubyobsuepogPVe7y3vEuUppoNqbHalDRMQFpEk/O7BLa07suo4O
        r+rCJnG+hlo2FCR8JDMONSk=
X-Google-Smtp-Source: AHgI3IbNnTGvLdOr4Pp0o+JLRXs+An9jsP+/K3kuAFKn1cgkCBTqb0cSiyAIFPJJl+COeX8EIXakog==
X-Received: by 2002:adf:be0f:: with SMTP id n15mr21503051wrh.267.1548933826303;
        Thu, 31 Jan 2019 03:23:46 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id 199sm5111604wmh.21.2019.01.31.03.23.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 03:23:45 -0800 (PST)
Date:   Thu, 31 Jan 2019 12:23:44 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joseph Lo <josephl@nvidia.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 2/7] clocksource: tegra: add Tegra210 timer support
Message-ID: <20190131112344.GB23438@ulmo>
References: <20190131092410.28222-1-josephl@nvidia.com>
 <20190131092410.28222-3-josephl@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline
In-Reply-To: <20190131092410.28222-3-josephl@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 31, 2019 at 05:24:05PM +0800, Joseph Lo wrote:
> Add support for the Tegra210 timer that runs at oscillator clock
> (TMR10-TMR13). We need these timers to work as clock event device and to
> replace the ARMv8 architected timer due to it can't survive across the
> power cycle of the CPU core or CPUPORESET signal. So it can't be a wake-up
> source when CPU suspends in power down state.
>=20
> Also convert the original driver to use timer-of API.
>=20
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
> v4:
>  * merge timer-tegra210.c in previous version into timer-tegra20.c
> v3:
>  * use timer-of API
> v2:
>  * add error clean-up code
> ---
>  drivers/clocksource/Kconfig         |   2 +-
>  drivers/clocksource/timer-tegra20.c | 369 ++++++++++++++++++++--------
>  include/linux/cpuhotplug.h          |   1 +
>  3 files changed, 272 insertions(+), 100 deletions(-)

Looks good to me:

Acked-by: Thierry Reding <treding@nvidia.com>

Thierry

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxS2r4ACgkQ3SOs138+
s6E4kw/+KIr1/qDOYKPC0vig58FLCc8MiVQkfgBHJc6+1ItsalgY5BQsUbedis6k
hHROsupsiqkLH4u7KWL/kxeJeG/bxkyqjSw3QKE7ql+UOa/h0HVTaKBqtRFAoq3b
Dvrve2WDgczk1+4XXaqbwh3s6pprOsH+T85vUDR2OT7yVeiWuXyvIS/mwoxFpOLN
w8kGBcW6Lo0QDMND50ZJ2gJJyk3CHQhqeUVqQMtVGG/+qG+dbKvwiR9BLA3gekqG
KUoTSJnpmc02jYxIct8WHBBD6SckJtcBvLi5bBG5Zg/16SLOFxSLVVWPKEXaMnzP
/Bd6GYCbVu/8CVFH8lLU377YK4Ca14MWS2lXhCgWGenvXPa+DEP5Pq5Hedxauanl
HQ6Gzc6QHtNQeaLrHasJ8QLDYyUhw2sL2Vwjs+Xn4gWcsy1/T7i+l08bmjEXWLvU
cvQwO9KP3vg0BWXqB63JhvZZTkfKsPWgdQppon9GMxKwQEmI4smM8d3PGLoY9xl5
i+GBTffLp45DXlDyXTi2AE+9OMxCh6NGqnUVgysOEi6OLHz+VmsG0IE+yNHRuII3
BzLnzE2R0eeptzEBy7qaQo6v1CmOhb6Vk3Cez7TUzBVen9hmnazkSfx3t1+1Li2f
oggvSwpAqz6rlGNd6byY5MuLpQXB97R3WjGbzjZSxOnPNDs/y+I=
=JPuk
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
