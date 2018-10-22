Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD63ECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F6D2083C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9G4reM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F6D2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbeJVSKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:10:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33310 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728363AbeJVSKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:10:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id u1-v6so8407876wrn.0;
        Mon, 22 Oct 2018 02:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ki2MYSVCuAfkbalSqWiJdcG/jwISPWEKY7R1P8Wmo80=;
        b=C9G4reM+0JQ9imE/lVP0MIuIalfVgF73Kfdr3b/Z71AyanJDyBwXnHYjJ/gv/VWx+a
         UEivIwU03suGJEaB+ZoPXpRwdm922aTgUXAHVGk8FPcnb6Ypkt7iWNDediCT/IRmDHXe
         fIIBsMryo3PJ5/2PsKprEafx0AgyAyLRV7OkOyiVl0M/xJ9r0cs3h8kwnj5SBwBfpQwV
         SOnCyCz1yqjTqFe1qTGX54lRx/a26t9VWmKJMpMU5hL3lvjTlBAPgvVl+s0VqK3cJC0Q
         lM825z33gHdebx5m8K9JtgF/DxD8RB6MfOg+BTb4KDLeTCTuQh1ekRH92+GB4HEbPveX
         ezng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ki2MYSVCuAfkbalSqWiJdcG/jwISPWEKY7R1P8Wmo80=;
        b=FjIZWaGgcP+66IGvYRgOEGvGvSnL+RY88fLHjdIvpjmxycXu7rkTnejgXaw5PwfyQr
         CvUfVMxCsq09BK+JziEhuBmElhYvZRl9iq04QiJoVbVy4ae39cFFTYDtN/9yvLAy9TWQ
         gzbCi1Qmufm/ihuiR/McXiJSPYb2CD33/1h2GQt8k/Agx0malpj9H+CcMFmHNKf/sEGd
         2nc6kmU6D6qhOxVM+e6wTlxMEMW8JcyzjuzOOFrp6un4nba3oXOzBMcEBCeIYCSxczf4
         7rFawq4wXHXMq+t8bzK/SBzB75uNGnAyv5ct5P19qCho6tkGOOLmEN4IxsZsb4rDIyCM
         mdfA==
X-Gm-Message-State: ABuFfog1Ezvet4HoTxCHzL/uT8z0t1BGMI+EsxENN5u1HhgKlpiDZZxL
        gmLeipqaMHJ4QThjXYqExjg=
X-Google-Smtp-Source: ACcGV61OAozih6CJAQapNVuV2RXwvYZ7+o6E4Gyp8N+BtLNtsreflnKT8nQEHemrzKH3bWp3y41axw==
X-Received: by 2002:adf:9e8f:: with SMTP id a15-v6mr42823272wrf.70.1540201979403;
        Mon, 22 Oct 2018 02:52:59 -0700 (PDT)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id t194-v6sm13356379wmd.48.2018.10.22.02.52.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 02:52:58 -0700 (PDT)
Date:   Mon, 22 Oct 2018 11:52:57 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] mfd: tps6586x: Handle interrupts on suspend
Message-ID: <20181022095257.GD4014@ulmo>
References: <1539955373-13735-1-git-send-email-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zbGR4y+acU1DwHSi"
Content-Disposition: inline
In-Reply-To: <1539955373-13735-1-git-send-email-jonathanh@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zbGR4y+acU1DwHSi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 19, 2018 at 02:22:53PM +0100, Jon Hunter wrote:
> From: Jonathan Hunter <jonathanh@nvidia.com>
>=20
> The tps6586x driver creates an irqchip that is used by its various child
> devices for managing interrupts. The tps6586x-rtc device is one of its
> children that uses the tps6586x irqchip. When using the tps6586x-rtc as
> a wake-up device from suspend, the following is seen:
>=20
>  PM: Syncing filesystems ... done.
>  Freezing user space processes ... (elapsed 0.001 seconds) done.
>  OOM killer disabled.
>  Freezing remaining freezable tasks ... (elapsed 0.000 seconds) done.
>  Disabling non-boot CPUs ...
>  Entering suspend state LP1
>  Enabling non-boot CPUs ...
>  CPU1 is up
>  tps6586x 3-0034: failed to read interrupt status
>  tps6586x 3-0034: failed to read interrupt status
>=20
> The reason why the tps6586x interrupt status cannot be read is because
> the tps6586x interrupt is not masked during suspend and when the
> tps6586x-rtc interrupt occurs, to wake-up the device, the interrupt is
> seen before the i2c controller has been resumed in order to read the
> tps6586x interrupt status.
>=20
> The tps6586x-rtc driver sets it's interrupt as a wake-up source during
> suspend, which gets propagated to the parent tps6586x interrupt.
> However, the tps6586x-rtc driver cannot disable it's interrupt during
> suspend otherwise we would never be woken up and so the tps6586x must
> disable it's interrupt instead.
>=20
> Prevent the tps6586x interrupt handler from executing on exiting suspend
> before the i2c controller has been resumed by disabling the tps6586x
> interrupt on entering suspend and re-enabling it on resuming from
> suspend.
>=20
> Cc: stable@vger.kernel.org
>=20
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/mfd/tps6586x.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

So does this mean that the SPI interrupt for the PMIC can still be a
wakeup source even if it is masked? This is slightly odd because now
you're saying that this does work while it doesn't work for the RTC
interrupt. So is this an implementation quirk of the LIC/GIC on Tegra
which doesn't extend to the TPS6586x? Or am I missing something?

Thierry

--zbGR4y+acU1DwHSi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvNnfkACgkQ3SOs138+
s6GlnA/+KbEp9RE2FAGyFfLfuTungMyuI62z7iZMDzNFgcKg9lCZKMjyKFpRVnP+
aavNDm4ZX/3qxqN/aqmbNjTy+PrZZv1+YXuIUHDJLJhVHtRdct/VjFBKH85z6F23
4bryvN4Z5NGJ63xkDu1IBxuJ6VGlMxo4wkK2SBhiA+FlVranLI5L2ujSYgo3NSPv
5gzpYzyppQxGosf+n/0tCc4wa8yDovaBailBU7gZLC84xwQVXaMf6eFhAey4LsbX
Hg2FK3Z3aV9bJpruRS9LsXayt/Ko0DxrP815+wXbtoAND6257Yx1ONPBMhX50cWT
dxL9u8WxzVgRt3qQ9ApX51qEIneA+TCYOIVBXnQVkR1M9Gg1u6/kekAalcxoLER9
lERbo1Snwrs+H24AWsM6xAnv8e01HYuWMODx8mWCl9ePf/Vy+xqrFcOsySfI/mny
x1rDpioj2+Kgj9kP8monFBlhm2NmaQJuyV9qy2lrzC9Ltt0+dLKK4W/Tr/J9tvTy
C1fj6eJrd3dGCwbrzIBNlAkf6niD6zUhm97eYfM87tlDN5VFcAg3k17sUxCuAFXF
H1ppMHoba/CJMDNXsrsXSM6SXjPuAQGJI3214Al6rqbIsGhzOJMDA7dw+x9Ho1px
MDgQx0Zoxl8KoNc/rZuQ0Uhldrk2IUcC2Y/2eKMxRRLjXQVf3P8=
=tOjs
-----END PGP SIGNATURE-----

--zbGR4y+acU1DwHSi--
