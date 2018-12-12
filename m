Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3928DC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3252084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCsi2uyU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF3252084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbeLLLFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:05:31 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40525 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbeLLLFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 06:05:30 -0500
Received: by mail-ed1-f68.google.com with SMTP id d3so15181326edx.7;
        Wed, 12 Dec 2018 03:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kNiHA8Ef19pQBfWBuK9N+L5BPL1BPaw1UAVVAUCw+K8=;
        b=VCsi2uyUIxCi7JNeBPUkILpoRRy2nK+rdLR3XpAAxsg5T7iskmnzWMS17FwHClXLWL
         aoVA/IpCFL/HSyag0RBAR1iABvNBBDLL/x/fSpjZeYp40yjrshNx5yfujDAIxwI+2+ON
         GoosmkFUbIZ3Q1RqK1G7glxMiP5+EehyCo1ObyHO2LdYJ5JSenQIpSEQrYKWcfNxpCRK
         uBWcPSuLRXB31w3erJBSKnP7IugW+EAIT9wA7DFjHaRehQKsHAXcKaPc+5HLB0j5xA8D
         ou6U6KDsOrNpcsVBwtw1anPdhJDhSKH4cR3LCmLJ56XauqNku5HuzwdYra2lLWFcxyDh
         o/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kNiHA8Ef19pQBfWBuK9N+L5BPL1BPaw1UAVVAUCw+K8=;
        b=a4ONKug7cR0No+yxmOz9E7RFppMJf/Wq5WP7fN6a+xQ2qFoJ5V75/SfICRGgk03yvt
         yvorGWvhxEwElUD1q72BuutfQn+NBY+T/7wiGd5aO6OOSXZoxPpGEOz/PxzPKifiscAY
         ahI6pVpRAQ+tumReH5aepWyKx8apgYjES44be45j9/3/eriZQPVzDj01XZScy4BR8FEp
         eQl9Rf6n6yoZbUhLimgzTuu6Voy5fQUkfG3QZzPa6wsXMSgNsv4hvvMK0WiWoGX1awrZ
         wq8MtbvmdjIfXRD6UfQOW4tBKDaR+AAovSuXCMwOI9A0Q/7lfgnUMzdA26bxkhsBcld4
         wH0g==
X-Gm-Message-State: AA+aEWYL8kX7XRwFa9dA/U88cnjdf/O2USjHRuU67YZcjtpMXXS934dD
        AlDwt47IjySj6iqYzcArx/nB6RyM
X-Google-Smtp-Source: AFSGD/VOy39AThA1Q8LrCiznjNo/P+C+i0zJ/3hey7sbvnzVBhBZ6pcIDIorXhtOq4Dvco6GaSSb3w==
X-Received: by 2002:a50:8163:: with SMTP id 90mr18526845edc.174.1544612728805;
        Wed, 12 Dec 2018 03:05:28 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id b9sm4578203ede.12.2018.12.12.03.05.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 03:05:27 -0800 (PST)
Date:   Wed, 12 Dec 2018 12:05:27 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pwm: kconfig: enable kona pwm to be built for cygnus
 arch
Message-ID: <20181212110527.GG17654@ulmo>
References: <20181123093559.10397-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UTZ8bGhNySVQ9LYl"
Content-Disposition: inline
In-Reply-To: <20181123093559.10397-1-peron.clem@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UTZ8bGhNySVQ9LYl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2018 at 10:35:59AM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> The Cygnus architecture use a Kona PWM. This is already present
> in the device tree but can't be built actually. Hence, allow the
> Kona PWM to be built for Cygnus arch.
>=20
> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/Kconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks. I did fixup the subject to be consistent with other
commit messages.

Thierry

--UTZ8bGhNySVQ9LYl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwQ63cACgkQ3SOs138+
s6Gaug//ULne9E+EP+aa0IM3LLUq/M0sF9a5Y8e3y2sRu6V0yPkt5JAqc1n4HiRV
H9ntOZiqxAT0bUuve1RHjtwQkwEsnuB1OdzacZitzTDixSVggQ5Y8pFP7Ct3EKfR
z1lMHrjcc+zY82Xlz84sTT4K/ApNKFZCtMSsPLaVq3PBi+uKX8i4YznKP1VkyCMY
FoiymU2BYrhIGiyrdCG/Yh3UlO685CFMP6ritmDmvPuVj4NBEIFD3Cay+MtLcaSo
mRZMyhgC0vyOUwHT6w8xeWJ3KfdlxIaJSzMTT6BlDMQQk9M8HllXmTIR4tSTp4Og
oq2NS7ph5+Jw6zig3TXXvif0uK3mYmu9jysBJsqufKZ1rFvtYBmVS6gE6ERYN589
TzkC98UH0O9ucp+8276/kj/GhqGx3l/HybR+GNw2hkOOwZhXZIP0fN+U8DUP/sl2
qhkAIZ6R2LRPXU6eBj6rJS6L74dYohdMLbD1smMP95MSxQInSCK9s2lyv+9GSoA2
kU6T0WDJhy7VU0s9km8Kgk4NgPs0sIuTucbDALwM2WDtXUUN6p3rui8mdIOx1vGq
mrZoJ40r82YvfeIMXZEI/C+Ro04V2C1yioHz+zFDicq1FJ8dEepDANHpMzcPRrRf
Mf2RGIS17mn5yxWEdwKm78IX3Oc1V8hPpVAPnelTJmhMSM1MqS0=
=QaWF
-----END PGP SIGNATURE-----

--UTZ8bGhNySVQ9LYl--
