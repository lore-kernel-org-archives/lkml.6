Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0089AC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86202081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZStDF5Ib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86202081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbeLKKFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:05:55 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38621 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbeLKKFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:05:54 -0500
Received: by mail-ed1-f66.google.com with SMTP id h50so12018142ede.5;
        Tue, 11 Dec 2018 02:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JhVzsSVTu5/1KUGpEPQdBbgEcXVIhDUjHvu9SEMn77c=;
        b=ZStDF5IbrSXTiKnvC/gCzwThTDxP+1rDl1LafpVD4vYinS8N8QPf7V7o/AjzB+nCk6
         xhu31RY87ywjBROzqt2K1PYvsQLGiIIehqtZ+eGvOvzbP/TUTdTG2hJORednkEXHtz92
         bP/d3ZXWpNso/9/BxHqZB2N25WDP4NpmnzLxlo3NH5aSv00vJEq2q0q0h3PM0vM6zPWI
         xwhToeR0hVOBhl1SYWtPCHM4kcHfYEnqrlvuQvUjnEXG7m2+vGmot+PU2RoO7YT9ZZF7
         6SwhmuRLVsSOjMgyIKjnD7dHeqD8SK5VZjXv/xwNnNouvfQKF1wBU97Yrk8xiRxfsfhG
         ZyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JhVzsSVTu5/1KUGpEPQdBbgEcXVIhDUjHvu9SEMn77c=;
        b=aW4c02FGkHekvK9cC9avt8nbtPz0l3U+5nxvrzO8X5KYU4isqmyT+OWpD1RUdJCFN/
         L5PSfGWpjJH1dIW//RidVf8O0cXMiBvgTXBJ0chTbgI0HX4qjxex1FoKeq7TC8qdQx2j
         5FFtaPcrhgAGQwYqVMsq335AMzqL9BVX1GcUqzZEsob9jNQ65i0vhR7p+wJZyGFHIvdE
         I+Dns72QU80VhNq2Sv83MfzQdmZ0D5bCxADrwXq5VIezFdiYD0USuotBGAskSbA9AaRZ
         s5ffDCQNjDr8u1d90REufLpumTvoLJH6xpbXuqwasyhCIvDvIj16WsgCHIdW7P76Y9tH
         PGuw==
X-Gm-Message-State: AA+aEWY/+Rz4EyVyFAVHPgiHx/JlEhDXD4G1kMClOixgHw9ba1ws/Xeh
        rKcD74NiEe3SQOsR+GBgWGU=
X-Google-Smtp-Source: AFSGD/UrU59mZ+AB8vW2kGD8PNyuP2hxTMUm/wz/8hLglX058cs0HwP0nM8E+1Y9Xk07683OFKwjPA==
X-Received: by 2002:a17:906:55d2:: with SMTP id z18-v6mr1606668ejp.163.1544522752693;
        Tue, 11 Dec 2018 02:05:52 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id by5-v6sm2163120ejb.7.2018.12.11.02.05.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 02:05:51 -0800 (PST)
Date:   Tue, 11 Dec 2018 11:05:50 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     arm@kernel.org, Jonathan Hunter <jonathanh@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] ARM: tegra: avoid section mismatch warning
Message-ID: <20181211100550.GD14426@ulmo>
References: <20181210215856.2238253-1-arnd@arndb.de>
 <20181210215856.2238253-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8w3uRX/HFJGApMzv"
Content-Disposition: inline
In-Reply-To: <20181210215856.2238253-2-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8w3uRX/HFJGApMzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2018 at 10:58:37PM +0100, Arnd Bergmann wrote:
> WARNING: vmlinux.o(.text+0x39ecc): Section mismatch in reference from the=
 function tegra114_gic_cpu_pm_registration() to the (unknown reference) .in=
it.rodata:(unknown)
> The function tegra114_gic_cpu_pm_registration() references
> the (unknown reference) __initconst (unknown).
> This is often because tegra114_gic_cpu_pm_registration lacks a __initconst
> annotation or the annotation of (unknown) is wrong.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-tegra/irq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I'm not seeing these. Do I need to enable any special options to trigger
these? Or are these just so new that I haven't run into them yet?

In either case, I see that this is called by tegra_init_irq() and that
does have an __init annotation, so this looks good to me:

Acked-by: Thierry Reding <treding@nvidia.com>

--8w3uRX/HFJGApMzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwPi/4ACgkQ3SOs138+
s6FLVQ/+NM4HKqTPuyuEUc0S1R5ieZZ6+FH1S1uUzhJVbjr3yp6GsVL8fkXR6dMv
4A0o92B1GuH8D/JKFi+Wy5U1JIRBokNkg+o2B358cTOHUUhKc4OQ2Q7/3gyNXJX6
0xCI6IBrG7nrsYrgGYuyl4/h0kuyffG2Ot0bxIBxkrfx/YHebKRUKebL6ociI7Q6
ZPYYhmbs7GM1XENuOSRhLvyfADDDHeYmevM3oOPaBHcaYZ5AxrkUlcQ4mhAdL7yh
k+TxI575WuGxSzs4lgRCA9qAjsKjR+BoLeaYA9b1PEW9PNxgoLq6w1EdK+p62ay+
EncuT4kzZmsa5BlY9ADbEIDel6t7PKF+dFljssnmutrB7V1WVav2mjXvbeBIRcl5
t0y7OJtG2+BMCMANxDvIvNZ2mNwI0awHGIzf9j9Dk8M6WsdLXB1og/i9VOFjL6fW
mRoJQRCw15a6xdxwAlOVBN81/+aocrNmF2c1u5kDcSgsjQqhMbGFR2Kq6ZBDQVeF
604EDZyQ/KX7+cn3RnojlCzTPo/ahhrb5kGO0ypJPEXoV8MuuUSXULAFblHmHF5S
Klrv3iPlnxB1xfZ1UubentR8gqZZeArXPJAdYPLZ2V4VA9U/2k6xAM6Mob+Y+dbK
1S7UktZGm9/20Yfq14rZ+DpNoPpjmg/Q/Kkd1VFCrKp5lMospsw=
=QpbD
-----END PGP SIGNATURE-----

--8w3uRX/HFJGApMzv--
