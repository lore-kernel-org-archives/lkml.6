Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B375C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A4D20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ldox5XVn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A4D20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbeLLKGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:06:00 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43664 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeLLKF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:05:59 -0500
Received: by mail-ed1-f67.google.com with SMTP id f9so15032772eds.10;
        Wed, 12 Dec 2018 02:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0QXqToRHDI6/IV/zawFzzKWnsR/rxTCak08k0YSBLlg=;
        b=Ldox5XVndYd40Pu4jUTIbSsC+5g2jI9yap1rp2/AVh1R8sKiJ9vTYu4enaNhLJicCN
         aHu5iHj07etrqJW99Gd3d/fLeVHxVQ4rDOD3Qp0wct2JDELFcOaGnjMLTYhIE3YZGSYY
         vRwqBdI6ITM87OskZFCHLRqsQSReh3iJK9fabNT85vSV9PH1RmaGoJQCW/riw5zVt+tV
         w89qNMQX1irEDF2Y0j5zzGKrVR/+gnaNXTqCYkPQNiYvgHvc7rZHJCCvK4u+/j6xVuKe
         0lHbAakx4sbiS1ntEEb5xsgbJyS7z7SRC/TPJm4A6VLefM6MZqXHYC5/sHdRfBkYy8HI
         Xa6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0QXqToRHDI6/IV/zawFzzKWnsR/rxTCak08k0YSBLlg=;
        b=N6o+jJFYFOf0P81r6xUYNtw4j6vi93bWumeKbkldYP7D3nSvciBcCEwi1gF3UTWpZb
         b106d/fgoBd1osGVSx8TmeER4slUILpHDD7HeFKS5FUL+JnFtJ6x+bOvBQ+7dpfR+5dQ
         cjiBr9XkfkVYeFzMpP/BqpHtPkhYHG0LSMVzhHD79uoJwjP0klcZHNyrECewzSGvubYS
         UkQJPcSJzRAkuwABXBnvOhWyivUz8FpnKLL7Da0iaPdP9pazpt+7JVT105RT9sabJodx
         M02hfqOIsCyj3WnozBCvqU6JYvIp1fk4bzF+tFHOXPOjhgZGcYYD+I3+ksA4wHvhjKfo
         +tEQ==
X-Gm-Message-State: AA+aEWZB9HgACv15pTg12XiMEGHY6MkdtSvbrXTQzwND4fV1RjZAGolA
        SuwiZK/47yDaF8UWcHLe9qvRFlV7
X-Google-Smtp-Source: AFSGD/VvO707YTcB0E/vN2gGHU5riEY99qA9UGeFxp+DFTyXkGiqDyI0QmThOjBcP8GtyyTazAqJ4g==
X-Received: by 2002:a17:906:6011:: with SMTP id o17-v6mr4676009ejj.237.1544609157786;
        Wed, 12 Dec 2018 02:05:57 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id i24sm4660967edq.0.2018.12.12.02.05.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 02:05:57 -0800 (PST)
Date:   Wed, 12 Dec 2018 11:05:56 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 12/21] memory: tegra: Use relaxed versions of
 readl/writel
Message-ID: <20181212100556.GI15092@ulmo>
References: <20181209202950.31486-1-digetx@gmail.com>
 <20181209202950.31486-13-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IR1Y5IvQhrKgS4e6"
Content-Disposition: inline
In-Reply-To: <20181209202950.31486-13-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IR1Y5IvQhrKgS4e6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 09, 2018 at 11:29:41PM +0300, Dmitry Osipenko wrote:
> There is no need for inserting of memory barriers to access registers of
> Memory Controller. Hence use the relaxed versions of the accessors.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/mc.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--IR1Y5IvQhrKgS4e6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwQ3YQACgkQ3SOs138+
s6GGGhAAnVGGzhNNAjxLTjYdbjVxTO+bXB0nc146fW2vgphsGF+pQq6buITkXJk2
bz1X74SxdrH2OS2WUS6kyh4wyAQWbWF3krxeOYHt4s4ylOPUk7QgYXmgUgTqCE/M
Mnabz6tXbv4O9Rdqtkt9QbEkiohqxsSZCy55QFaPxSqkytHjDinhyFuKa4pmRUIn
RkjOm2KaSyEIHQAyy3uZQSY1iFfsPx1OA29UVoa+xPtnSgBd/saYDWz+XkTgKgNx
YLiPW36Dzf9HBMYN5XqDunXz4Kv3hgIxU1rbDppouVRrJrwYzIc/NWU6jHN7xsFZ
BrRTj2fOCwCf+P/z5vkNRjK35FvYzK6PcEJ073ZS3IzvNsF923C4HUzNSRf2jVEA
GhZKhnYN/bePEphSTBW0JF58N375gffXoMhSzdskZhBzVHtcr1vYB0akf58o7Hs+
B2j+e/9o68dLhmuIReRlWEdf2LZXZA3rbFs/GFlUCOo7/hCngewR3OqZxdyVp4Up
FVAHlNWKBO6O1orV1hfn0MwKhEiiE7149GjPqe+nMIrNDnyBB5/sTHrW2UveKdAC
QUxACgCtD3fpEe5GrQzyw2cHiqf3OOx3faICD9cbHzU94bsGbuVqcayd9lK3UH31
GzNcx4DNHFy2iuQLK+ppsPTZOlbzYxxf9RKfq6UZEy4oOBPls/s=
=1jiE
-----END PGP SIGNATURE-----

--IR1Y5IvQhrKgS4e6--
