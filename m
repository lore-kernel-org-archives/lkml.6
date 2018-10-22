Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAA3C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED1F20658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0eGIR70"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED1F20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbeJVQTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 12:19:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55194 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbeJVQTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 12:19:21 -0400
Received: by mail-wm1-f67.google.com with SMTP id r63-v6so9215166wma.4;
        Mon, 22 Oct 2018 01:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O4KEfZG94xkHASrVjNwhCM2PiP9ABAoB7A67gTy5l8U=;
        b=O0eGIR70Y8cpD9TqEK0fLj17EJzYEBg+XGli944TdVmyvuQlkK4Ak0oCmFX6nBMatN
         f7tJtcdYD5Mj5JNh+jM6kyAXKss76ldBax05TTYYGFd9UnS/PCyKkVEGt06hgQf7oTNt
         DnfDIUN32UAWQdFInzBJ1y8xrR/8n4QzTRmYA1LYLgCZsd+zvd6xECEynSW4E6kbunsH
         Wc4sOKAAqzq9uKphFXPZhSUiMQYl6aX29GpRxoYwYc8zDgslc8sR8LvE3Zmt2opWj5Au
         vxrV4x66EYmwI45whxhKIiTFRzcu9u/KTji2MLqW+fK8CZhg0vaXzeKWTZLtdYz0g5Sh
         pVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O4KEfZG94xkHASrVjNwhCM2PiP9ABAoB7A67gTy5l8U=;
        b=NfTWUBGm/L5VFJw6QT+YKWUi7Eqo8306ej16OY0iBgG/2UHEzYaQTxJfb5+QcmQqiy
         TRq8Oj5sp/o7VWVVOVVIcDSRVcLNQyunV79tqnrS+zY7EGIbAoM7TMSSB4x1/BT6HtCH
         bJU9F1UNqcE3OmGevYMT0kK7iKXSsvMHpoQHM09YLnU30DwfmZb9hSE3GQz2Vt4x+a6R
         lx3yGgq+cXnJmbLWDk61FfZlu7pcYQrSDIPG9y7OeJYX2tXnAf0AvZLTsqCHiDcrAoVt
         kvIiaTqR7kxA48stLFCG6Jnol7onuvzeAIp2AHtgIdkloKiL0nMNE2Gon5yIqZCWm5ZD
         q8bA==
X-Gm-Message-State: ABuFfoglZ+5rxACYigVk++wV9LZVNOKAtXXfd9t2MIp3XhE1s6jFwMAJ
        lKBoPaCYLB+tTD1sh2oI8og=
X-Google-Smtp-Source: AJdET5et+BeTmPAl7qB8kyag0Vu0KlLqtpPyZ9EP3d9LjKyegVciFalZBEMw58wnrXjTXv9dXiqLmw==
X-Received: by 2002:a1c:4054:: with SMTP id n81-v6mr14920861wma.82.1540195312567;
        Mon, 22 Oct 2018 01:01:52 -0700 (PDT)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id q17-v6sm20856520wrw.19.2018.10.22.01.01.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 01:01:51 -0700 (PDT)
Date:   Mon, 22 Oct 2018 10:01:50 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 5/6] gpio: gpio-tegra: simplify getting .driver_data
Message-ID: <20181022080150.GA3620@ulmo>
References: <20181021200002.1472-1-wsa+renesas@sang-engineering.com>
 <20181021200002.1472-6-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <20181021200002.1472-6-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 21, 2018 at 10:00:00PM +0200, Wolfram Sang wrote:
> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>=20
> Build tested only. buildbot is happy.
>=20
>  drivers/gpio/gpio-tegra.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvNg+sACgkQ3SOs138+
s6HO3hAAp2ajg6Q+V/KuVKnYNlR0s50A+tJvu3lYFZrpDkkYBquJ9XI+35g1THdS
fBG1mwfVp5JpJ2FRLNuFpHo0gR8b+D2ef05a+2Ywni2vbLguAqvIw92b3Nlo1bCA
E4rJJBLsKZPt2FH0RLxkrQOzIiJ7YRxLaOVyiAy36eCQBAPGnHrrrXY0WZGbsDyv
5uN7/Q8Mt1h4SB85QVdou0DHydrfI+9HGqymrDeiX5XWZg7Hj8L2nXOBrqVgxFyI
TQoIxr98RkfN6Y+x+Vi3N890vaATHzf2egHkC1+LQqOKyWvrcodRbkOISTP7YX+f
0FeUhvcMjKuEw1gDxLVoHrnPHcun71J5r0Ycw0RywjYqLGEq2ODaJV+jhLlMTQ4S
YBCNBdEP7sJJJtpT5Ntw+3adsmEboVqqAXw2Zng9N9gi8Gdrf5Vmd0t3lttt/OMR
vqvjE6fzjOTcjW/hDX0UMTWc5OyFc59NVGbLZZ6n2uQVYuXhAeWLoGualjjhKqew
toa8Ipd6rQ+ur6JLinSWVJKn3q+lhcF5W3CBfnnn0obS8+f9gec7IqBWl+bh8zqw
Vd+reN252gjEhxXMasadvO5NMXP5sHa/djdGBRz4cszr2vaDVb8F/nUED8j3G9zf
+FtjMjSygcd/qvHupBBJoN8lWXEblvjLuRy/kph1EUARIO60SpA=
=kBfA
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
