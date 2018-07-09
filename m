Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA89C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC91120878
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eejc3f8z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC91120878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933489AbeGIQyL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:54:11 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39940 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932755AbeGIQyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:54:09 -0400
Received: by mail-wm0-f65.google.com with SMTP id z13-v6so21481468wma.5;
        Mon, 09 Jul 2018 09:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2nmDBdHaoiJlRKX2dCr2qJINz5OQ51O1RXcSljt2hHk=;
        b=eejc3f8z+Lb4f8PSso2jJVVesF5ePgZseTmXUiOfhi5Acx4sPOJhhl67PRxtb8ehfx
         a7v7VDPHtbgxs9qYOpEIOpx05rFOgSkWhUEmbuAiohkkFAGEZIsQRNnIe9rI9yCg5aNz
         XDHxLGXdIQfqvb6NA2A25EraDo+sZ6KpWh3JPLmYFozDSjHrZCZbRuaJcKSQJrOn6bCi
         J7HGyQr0mVet65i0nnBH37YGh+PqsMagkLOdtofChdmqpIbWdcmmg3TLg+23XqqeKhHJ
         KGDldrHqMtMBiWWeDxDgeA1ZVkH56vs/BA4Orv32Y8efm1VLOnjsYUQed+oG4URHweXY
         En/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2nmDBdHaoiJlRKX2dCr2qJINz5OQ51O1RXcSljt2hHk=;
        b=a8hRBsgDPEEuV97CVaRW+sLNTaHYbldaVvZLByLUA2/VuUOrDTOIUiRsPOW2w3hpge
         TEUEcKpBNPs8g7RS2ehBAod7uWx82f0NhYrNpoTW3cury87IMt3MyEPBFmqVcqLbHEmI
         fEumpk7Z5+NqoLS4+mD7klVFVx+vHpSeQ+GDZchwMI8/c7FzmRoqnpjYxwlDF+W+PMBx
         q3OXar+Ts1qQFbJtSbLoz2Ha/qA5qU1eSx9PM8wPscN4A3syXOajPfJZc06P05UKTH7F
         nDLjSxg2yEL68mRi4rd6iobNqXrbKioPtImOWmsfTieHc3JvT1eZtl5YOyMdGWjNJZ14
         TX7g==
X-Gm-Message-State: APt69E0vn01ka9/DD28AryvJFjj2zKTg91i+T6s47zSpqL2BMOV4T6am
        1/WFnV3krTAa2zmtXu0YtBI=
X-Google-Smtp-Source: AAOMgpdNC4wDzbx0VxFsY8oaaehPghdOorDW6GKu18pEmzEFSxnuGu5VuUHEydN1mGsuL1AnAeO8EQ==
X-Received: by 2002:a1c:9754:: with SMTP id z81-v6mr13494122wmd.35.1531155247701;
        Mon, 09 Jul 2018 09:54:07 -0700 (PDT)
Received: from localhost (pD9E51B8F.dip0.t-ipconnect.de. [217.229.27.143])
        by smtp.gmail.com with ESMTPSA id c3-v6sm12095090wmb.40.2018.07.09.09.54.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 09:54:06 -0700 (PDT)
Date:   Mon, 9 Jul 2018 18:54:05 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Agner <stefan@agner.ch>, Lucas Stach <dev@lynxeye.de>
Subject: Re: [PATCH v8 1/4] ARM: dts: tegra: Remove usage of deprecated
 skeleton.dtsi
Message-ID: <20180709165405.GA26651@ulmo>
References: <20180709160519.23497-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <20180709160519.23497-1-krzk@kernel.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 09, 2018 at 06:05:16PM +0200, Krzysztof Kozlowski wrote:
> Remove the usage of skeleton.dtsi because it was deprecated since commit
> 9c0da3cc61f1 ("ARM: dts: explicitly mark skeleton.dtsi as deprecated").
> It also allows later to fix DTC warnings for missing unit name in
> /memory nodes.
>=20
> Compiled DTBs are the same as before this commit.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Stefan Agner <stefan@agner.ch>
>=20
> ---
>=20
> Changes since v7:
> 1. Remove adding of chosen and aliases (suggested by Thierry).
>=20
> Changes since v6:
> 1. Add Stefan's reviewed-by tag.
>=20
> Changes since v5:
> 1. New patch, split with skeleton.dtsi removal (suggested by
> Stefan).
> ---
>  arch/arm/boot/dts/tegra114.dtsi       | 8 ++++++--
>  arch/arm/boot/dts/tegra124.dtsi       | 6 ++++--
>  arch/arm/boot/dts/tegra20.dtsi        | 8 ++++++--
>  arch/arm/boot/dts/tegra30-apalis.dtsi | 4 ++++
>  arch/arm/boot/dts/tegra30.dtsi        | 8 ++++++--
>  5 files changed, 26 insertions(+), 8 deletions(-)

Series applied to for-4.19/arm/dt, thanks.

Thierry

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltDkysACgkQ3SOs138+
s6HqOA//QmEj+qn0rD3Jw+uLZyLCsVsTFSI9mMUK5jBELy9LS1YNgKskKlYVavtD
8XDhU46rWmGlsE7WcJVKbdTlvYHNGvsvtczZ0D8vdSOhmjgyP9nOr4uI8+sCCyXD
xa4H2sHqn66AJQHNOCcqRiuXL2Bee6V4Qd84J0xnyabeF/cXqUDkBzkU9bryzFNk
SVGhjJaUAaBvk/fazY5ZwkJX3iSyhqXaeMw9deIpMDfV+zdOiC4nBHygQJkwXw6G
ziw2N67k07s6VI/9FX6i78GGX1dfA7iayVcTyv5AFPs5pzkttkndVciIU98Dy2cF
PZu6uC52V7DeAReFCCmJOVjKiqptaSqrSOfcwBHRif7y2Rr4sZJ7g1pY0uvR4WLy
iEleSu38QI2nZu0lUVTDeElki/3fhm6/9/I/DyGaz4am8eMhWIENodSsxbqYL8FE
ZaSxHwjTkNY7LMimEWqN1E0cmRnpOj6tthdEiPLu1uvv3yKfs+BESJ8nF1pJ7zme
o01oYlOe8OSSDkFMzAUFauN9L15pL5xOY9p2M8Qly8pUgdl79SuKDL2LnQ9gEgv7
X9sa5a4WvVfQS1Aet0lmdSaOw2TORVVVmYD9/xAQrnaBHPPK1LdPJjAgmOaoMPxh
EhryoTz7OCY/v2bJF8qicVjoREgNBE6GzVUDYaIQ0B/c3RmdRTA=
=3PJ3
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
