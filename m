Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CF5C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B16821D6A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Za0R1adg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B16821D6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbeHIOjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:39:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43916 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730301AbeHIOjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:39:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id b15-v6so4937730wrv.10;
        Thu, 09 Aug 2018 05:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NddY8Heov1KYXozmGf1XBJ5CeoxLoEcdUZ4pHWfzu3Q=;
        b=Za0R1adgf/Pqeb5bVgpEbDJMS1m4VCq1il6l0XwlK5CmD8CaTpr8b0Cz+XcPEEMAny
         8odztmr2pFMyH/Kq3bjgZto7hyVUfP/I1Bg8sj0zYkKNzkKfQQ+x6xznApOyZrDIjVmp
         vbsQUUq/lFWpgQRdwWHIZVVoTD9pgU9yfu7+8yyMy7e0R3BdoRraoWQlb/6am1W0UJvl
         xK31jtl1v27INS32R+iDpFaEX5xS/PQqxpoKfsQCCpt8nLx9EiPfaxqJqaXqIPFdHL0g
         k5JN3IxgMTjYBzsek4VOixbGiPWB3jvdvfgBWvK9q6C69YWSozo+7d6U6YgarxbXy2Ab
         XOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NddY8Heov1KYXozmGf1XBJ5CeoxLoEcdUZ4pHWfzu3Q=;
        b=HR1/VGiJIm7W9f7IM0YfaFvX075Jp2ODpKcj7UQ9SK0VRjcBrlIaXUm/gOS18753qV
         gM3kAvSqnLtEv/Igg2XdEn67FWsg/3yt3KtK4gdR4FXSN/Ttz5Mh2qNqYIpdZB/ZarUg
         4LyQmJLeJBbffXjK30Gn+lgv0Q0iw7S2tco7jy5mUB2+yHS1AfMtnljoAxgEsPgQIOPB
         I1RXzEK3i4Bn+qrWgcWi094kpBS5inofzvZNd3u7IBpfVqYMjliuN9Fz3Z1qZIEunohF
         Zm+dpYzb73y74VDlZXhhSoQuhLRU1O3j3njSf8Eptcxy17zHk/AHBQFyTQ8PAEE1a5FI
         r+GA==
X-Gm-Message-State: AOUpUlEx4dpisxr9Ty0RP7Fb0K37ZldQRYnGOPjC1URwoh0iopEmENjj
        vV7vxIYd6Uy0+We6VZiSCok=
X-Google-Smtp-Source: AA+uWPxSPTG+AOIglX+6MEV5XowfNyEoPH+z3vYTsL8EYLL6DEMAq7lAru0tt9XObD5+ssdKepm+aA==
X-Received: by 2002:adf:eac8:: with SMTP id o8-v6mr1215954wrn.150.1533816902486;
        Thu, 09 Aug 2018 05:15:02 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id t6-v6sm11032927wmf.8.2018.08.09.05.15.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 05:15:01 -0700 (PDT)
Date:   Thu, 9 Aug 2018 14:15:00 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Aapo Vienamo <avienamo@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH 02/40] dt-bindings: mmc: tegra: Add pad voltage control
 properties
Message-ID: <20180809121500.GP21639@ulmo>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
 <1533141150-10511-3-git-send-email-avienamo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1LW0Rr0Uq98qh6Rv"
Content-Disposition: inline
In-Reply-To: <1533141150-10511-3-git-send-email-avienamo@nvidia.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1LW0Rr0Uq98qh6Rv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2018 at 07:31:52PM +0300, Aapo Vienamo wrote:
> Document the pinctrl bindings used by the SDHCI driver to reconfigure
> pad voltages on controllers supporting multiple voltage levels.
>=20
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/mmc/nvidia,tegra20-sdhci.txt          | 22 ++++++++++++++++=
++++++
>  1 file changed, 22 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.t=
xt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> index 9bce578..90c214d 100644
> --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> @@ -38,3 +38,25 @@ sdhci@c8000200 {
>  	power-gpios =3D <&gpio 155 0>; /* gpio PT3 */
>  	bus-width =3D <8>;
>  };
> +
> +Optional properties for Tegra210 and Tegra186:
> +- pinctrl-names, pinctrl-0, pinctrl-1 : Specify pad voltage
> +  configurations. Valid pinctrl-names are "sdmmc-3v3" and "sdmmc-1v8"
> +  for controllers supporting multiple voltage levels. The order of names
> +  should correspond to the pin configuration states in pinctrl-0 and
> +  pinctrl-1.

Do we also want "sdmmc-off" to allow SDMMC pads to be powered down when
the slot or card is not used?

Thierry

> +
> +Example:
> +sdhci@700b0000 {
> +	compatible =3D "nvidia,tegra210-sdhci", "nvidia,tegra124-sdhci";
> +	reg =3D <0x0 0x700b0000 0x0 0x200>;
> +	interrupts =3D <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> +	clocks =3D <&tegra_car TEGRA210_CLK_SDMMC1>;
> +	clock-names =3D "sdhci";
> +	resets =3D <&tegra_car 14>;
> +	reset-names =3D "sdhci";
> +	pinctrl-names =3D "sdmmc-3v3", "sdmmc-1v8";
> +	pinctrl-0 =3D <&sdmmc1_3v3>;
> +	pinctrl-1 =3D <&sdmmc1_1v8>;
> +	status =3D "disabled";
> +};
> --=20
> 2.7.4
>=20

--1LW0Rr0Uq98qh6Rv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsMEQACgkQ3SOs138+
s6EKVQ/9Hkhh22E0hhTKV3WiJWymoURwVYwRFr/2l3Hk/IqQYO+48fPgKaQ2yxyx
W7CSmOP0uYd0kxaiFjQtnFDRwmT/nn+SGiYk6Vf+HEbGn4GeReVXRxSiiFvySNVU
bF/9z1aMBaAeAnXrvp9pvMZsEy0fA3+qZGZUAvYEZjrcbWp1Ew0JHbLc8x2QlNVr
l4/vm/OBsoliidFGCB/hyFoLTwb2+wUSUuUfLCkNADYJ12y78+njPgB0pJDBoG0p
pQHb9csVIaeSdfHv4SxIBS2jS2VsLraWQ56gMILsst74RNz/6rXu36VPK3MuXvrD
73RsBjb8E28TJS1WPKubtuRmSXWUzMCaYsY73K70dk1APhkz9gYWhdgtXeTLhxAZ
k4sPQFJw5U1Vx3xhy4tKKrr6tnXV+8GTl3ufO5IabPTms+/GVfad06v5Ot/WX6fh
gOe4ic/rWqxjHt30Qr9aq8NLjyXEWxZ64GJwf30UcpFDLq4jcANt/dnMdmrnZwlX
+fgDLcizuUDxToWN3cwLxlS0GekZARu0Qkfaq5z80xgmTrTi5DuYskeHBNhfGN8c
hLpfE0yxD9jrLJCqA8LDYTAZmFbBhoCEVTJ4BwEpBvBdyzGLstj/+wLcUTnKBGoq
zK9gpP+oMV3toAQvguswH71LlYBfYcfHVfgT+Qb3Xc3v9uhnxLo=
=LFLg
-----END PGP SIGNATURE-----

--1LW0Rr0Uq98qh6Rv--
