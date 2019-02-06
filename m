Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D22C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76AC20B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtsLkPIV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbfBFMfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:35:12 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40669 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbfBFMfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 07:35:12 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so7352880wrt.7;
        Wed, 06 Feb 2019 04:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u/w88v2oNTEtkiGb6hmwwDAENWupOfL46k/j3KkF2zs=;
        b=NtsLkPIVTMWMcSlmXArKQoC8ET29KLydXdmkWtL33y/jjV8WI1LHJcYoAZoXQHM6jk
         AqGFy6aOfyeG+Zmk4hMcedzvBc1uvXXVQd/Pk7Uo984f+vskYiLkkaBvsj+4Xhe6adSH
         rJqH67WPanU3da+A1bSxY92SXw/u4za+XGhTypgzaMyaK9r6CXNsiVc9ON1YeN3C1gan
         10IVdjBAL0MFlBE4QHsxZN6mRszjDjgEw7rj2oc7Rf0XGX/hCzIe6xBNouC1QsqASbEF
         rif8y8/FihEJavOmMnsKPefvoAuLItbpEqlPxBACdWByc4g6ZfCe3QHx3sZfGn6/8NEH
         eu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u/w88v2oNTEtkiGb6hmwwDAENWupOfL46k/j3KkF2zs=;
        b=A2JBo8rM/B00cXM0OwxnZ10hFYOL+yGXBD+YIHd9/JBQsbxLwK923YOfsg0C8j1ILp
         wLFTALKWgYy4KjABASCGco568Iz5Yj2G4DXxKp/YBDVfhL/q7pX6h8SHPtTTZeJXr0tD
         bbtL5RgIYiz+qm/WwXO9c73byXBCcqmiW7aK8RdIpHMITbHmYVN7ADf6EEd9EFse6D9f
         aVm6YULwyuiuMbmR1C5d52GupmERa/+DMk3gHfikm5k/v6X16ObSfSE6LWumI5XhrJqb
         JlVLIyG/YmZWRCc+wt+5+Ra41IhCWzQ+uoMeAJq4KeOg3su9Ps2zjq+OulXt+h8HLpzb
         gqrw==
X-Gm-Message-State: AHQUAubCfCY9KlqAfxpDwtRo+yd7klr4yclkgxf63hj73Nj1WMqAN7mc
        Ve5fo36ZtvVLgEteYSEGNjs=
X-Google-Smtp-Source: AHgI3IYbWzArCUWWrWrOBMKo912orJ+9Z7Hcc9JbIltcIh/D+VPE5E5AhOSmpGFZ4bq4WbCm8NlKxg==
X-Received: by 2002:a5d:45d0:: with SMTP id b16mr7475467wrs.86.1549456509922;
        Wed, 06 Feb 2019 04:35:09 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id k26sm9708028wmi.28.2019.02.06.04.35.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 04:35:09 -0800 (PST)
Date:   Wed, 6 Feb 2019 13:35:08 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Joe Perches <joe@perches.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Paul Zimmerman <pauldzim@gmail.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] r8169: Avoid pointer aliasing
Message-ID: <20190206123508.GE21676@ulmo>
References: <20190206123018.24802-1-thierry.reding@gmail.com>
 <20190206123018.24802-2-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="brEuL7wsLY8+TuWz"
Content-Disposition: inline
In-Reply-To: <20190206123018.24802-2-thierry.reding@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--brEuL7wsLY8+TuWz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2019 at 01:30:18PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> Read MAC address 32-bit at a time and manually extract the individual
> bytes. This avoids pointer aliasing and gives the compiler a better
> chance of optimizing the operation.
>=20
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Applies to net-next.
>=20
> I tested this on a Jetson TX2 with an add-in Realtek ethernet card that
> has a properly programmed OTP to verify that I got the endianess right.
> Seems like everything works and the device behaves the same with or
> without this patch.
>=20
> Changes in v3:
> - align MAC address to u16 for is_valid_ether_addr()
>=20
>  drivers/net/ethernet/realtek/r8169.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)

I also forgot Andrew's Reviewed-by here, but technically the patch has
changed, so I'll leave it up to him to confirm he's still okay with this
version.

Thierry

--brEuL7wsLY8+TuWz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxa1HwACgkQ3SOs138+
s6G0Ng/+KtaNxWSu5GQf9ZYxU5ysPjgJlfYmXnvC0/nnvAxE8d5uG30zW7Fe28Je
d47PbW9KvZDRBqodg6aZf8mM/hR9PwSUc4aI1sE+eZYhILLylNzNvv/0wz1+3/Wg
YvEHjetJG7AtwnAvR6RpxKpkOPEvifCIHfEf8esKRW60/IZxFjzD0mD3xWg7fJYy
1xFjy/PtdEftolX0fuyM0NM4/aL86o9YNmHxNe9ft3JzEVptQNplUPIK7eU2DCZy
pHaw3Zmiz3Mksy39EY6SOGog5uVVddKHDeXqI5NHW0psOAwu9oaKsa/viU6dtX3r
6sq0chifopb4zupjjihcV3MTfXpW0qjP4uUcXSLxu86MwF5wgp/9+AbdfCiX8EpK
aG2gXBrLRus/kz0Z/X8bsb/Z9XjtdaIPleANoVJbBAX6itfhljflXgdz5VRanyyp
KNmYt2qqe6Fly5az/bSb62Boclbz7r8remrUnnJZ/zbpl3lx5li/LqFutB/Ho2zr
MVHGKJWJqvv3wyD3WryU2DdNfBQ1o/vbWfFNHZHh/BIgPcXK8j058xAdDzyu3gzQ
C49Vaq18XZd4G76a0HN/g42jhzYLtqQk5BsRXfccOztXJOhRYAL99xM/d/SNiCuj
4Ev92sPjzE8c8F/qp6BxlsomG06TcTZk+b5Vz4jzDhuzDdjPgL4=
=nCxF
-----END PGP SIGNATURE-----

--brEuL7wsLY8+TuWz--
