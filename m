Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE49C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA852089B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T78TEXkM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDA852089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933485AbeGIP2F (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:28:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43870 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933045AbeGIP2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:28:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id b15-v6so11442125wrv.10;
        Mon, 09 Jul 2018 08:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BtuTjFx73TTivc4iT2UGIFySofZL9+K4+WlU+nUYBgI=;
        b=T78TEXkMX9T0PzXbX3q98Qt5yj2ywb63xSxFVBpb5VE1kTyDqjOM9QHE5/DkccoVny
         gfeb4zT0muwfR0Za46buF8O1TFWi7zWy1nHBRK6839Z0VqSA2VKzmcMtLXZ8rK4RC47w
         VpE4KlmXkW9qEo3tIVhLxliPa/mApL0ofF0/zSoVxLURWOMwfv5VWGfcup2QLxspBTDn
         wiZVLUdRQ7BevynvVggN1jZs1ykYEHSSxFiSR1UHp8fygwZG73a6k9Nah7fizggFj9jO
         /z9GuFmVlodrSbXY98kj+nHxHvMXJkzmrw3S3HvRJzP2Izr5e2rAx1vn8oCrr00kRuzY
         NkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BtuTjFx73TTivc4iT2UGIFySofZL9+K4+WlU+nUYBgI=;
        b=f2oorl8a89sIqLYoNXhICgGtqrI+J7wxkW7PAl4BWsfmp1C0FV+mhSk6jQkVMJ7+L0
         PVQE3tzAK21iA59qq3bZgY4ieYDoQYC27sWw3aPGdZ+1Cy1OvD2cg5zNKBvu0DNsREf+
         DkOSDWA1lF0tpsh48wwrHiZKOB7Nun3Kc3+V7TRp2ShKzY3VoPucV9wzTBOC1EfpbTol
         Mv97EBP31W2Zsom6r2D80El6C4f7BWBHOV/YVTwz7AJLgfVTBSmdx5R72ElZFVCCEr5+
         zoqYhi+tFrXxTRuVKUb3/u+HZERn2DEKzRqN5ub3KHmRB0iTZaVqMrd/aW+sEEgI+djq
         oFnw==
X-Gm-Message-State: APt69E1dRS7tdi7nTEA9PX7qyNxB++QC2RIdPUbUw8lKTiRPUtY9QH1K
        MLUnnN+Jowntsq2D+dWasQY=
X-Google-Smtp-Source: AAOMgpeHQinVGfM+3fi/DSzsu/tlyRThFOH7o1pz/33ZkCt6izOlhQwC60C5qlxbkihX/twTDGrbZA==
X-Received: by 2002:adf:e841:: with SMTP id d1-v6mr14914159wrn.269.1531150080798;
        Mon, 09 Jul 2018 08:28:00 -0700 (PDT)
Received: from localhost (pD9E51B8F.dip0.t-ipconnect.de. [217.229.27.143])
        by smtp.gmail.com with ESMTPSA id o4-v6sm18953776wmo.20.2018.07.09.08.27.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 08:27:59 -0700 (PDT)
Date:   Mon, 9 Jul 2018 17:27:58 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Agner <stefan@agner.ch>, Lucas Stach <dev@lynxeye.de>
Subject: Re: [PATCH v7 1/4] ARM: dts: tegra: Remove usage of deprecated
 skeleton.dtsi
Message-ID: <20180709152758.GD18353@ulmo>
References: <1527144833-24285-1-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bjuZg6miEcdLYP6q"
Content-Disposition: inline
In-Reply-To: <1527144833-24285-1-git-send-email-krzk@kernel.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bjuZg6miEcdLYP6q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 24, 2018 at 08:53:50AM +0200, Krzysztof Kozlowski wrote:
> Remove the usage of skeleton.dtsi because it was deprecated since commit
> 9c0da3cc61f1 ("ARM: dts: explicitly mark skeleton.dtsi as deprecated").
> It also allows later to fix DTC warnings for missing unit name in
> /memory nodes.
>=20
> The /chosen and /aliases nodes are added only when dependent DTSes do
> not define them.  Compiled DTB is the same as before this commit.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Stefan Agner <stefan@agner.ch>
>=20
> ---
>=20
> Changes since v6:
> 1. Add Stefan's reviewed-by tag.
>=20
> Changes since v5:
> 1. New patch, split with skeleton.dtsi removal (suggested by Stefan).
> ---
>  arch/arm/boot/dts/tegra114.dtsi       |  8 ++++++--
>  arch/arm/boot/dts/tegra124.dtsi       |  6 ++++--
>  arch/arm/boot/dts/tegra20.dtsi        | 11 +++++++++--
>  arch/arm/boot/dts/tegra30-apalis.dtsi |  4 ++++
>  arch/arm/boot/dts/tegra30.dtsi        | 11 +++++++++--
>  5 files changed, 32 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114=
=2Edtsi
> index 0e4a13295d8a..27ef515e5640 100644
> --- a/arch/arm/boot/dts/tegra114.dtsi
> +++ b/arch/arm/boot/dts/tegra114.dtsi
> @@ -5,11 +5,15 @@
>  #include <dt-bindings/pinctrl/pinctrl-tegra.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> =20
> -#include "skeleton.dtsi"
> -
>  / {
>  	compatible =3D "nvidia,tegra114";
>  	interrupt-parent =3D <&lic>;
> +	#address-cells =3D <1>;
> +	#size-cells =3D <1>;
> +
> +	memory {
> +		device_type =3D "memory";
> +	};
> =20
>  	host1x@50000000 {
>  		compatible =3D "nvidia,tegra114-host1x", "simple-bus";
> diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124=
=2Edtsi
> index 174092bfac90..951feea784af 100644
> --- a/arch/arm/boot/dts/tegra124.dtsi
> +++ b/arch/arm/boot/dts/tegra124.dtsi
> @@ -7,14 +7,16 @@
>  #include <dt-bindings/reset/tegra124-car.h>
>  #include <dt-bindings/thermal/tegra124-soctherm.h>
> =20
> -#include "skeleton.dtsi"
> -
>  / {
>  	compatible =3D "nvidia,tegra124";
>  	interrupt-parent =3D <&lic>;
>  	#address-cells =3D <2>;
>  	#size-cells =3D <2>;
> =20
> +	memory {
> +		device_type =3D "memory";
> +	};
> +
>  	pcie@1003000 {
>  		compatible =3D "nvidia,tegra124-pcie";
>  		device_type =3D "pci";
> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.d=
tsi
> index 0a7136462a1a..88dd1afb5877 100644
> --- a/arch/arm/boot/dts/tegra20.dtsi
> +++ b/arch/arm/boot/dts/tegra20.dtsi
> @@ -4,11 +4,18 @@
>  #include <dt-bindings/pinctrl/pinctrl-tegra.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> =20
> -#include "skeleton.dtsi"
> -
>  / {
>  	compatible =3D "nvidia,tegra20";
>  	interrupt-parent =3D <&lic>;
> +	#address-cells =3D <1>;
> +	#size-cells =3D <1>;
> +
> +	chosen { };
> +	aliases { };
> +
> +	memory {
> +		device_type =3D "memory";
> +	};
> =20
>  	iram@40000000 {
>  		compatible =3D "mmio-sram";

Any idea why Tegra20 here and Tegra30 below get empty chosen and aliases
nodes while Tegra114 and Tegra124 don't?

Thierry

> diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/te=
gra30-apalis.dtsi
> index d1d21ec2a844..6f29cbad6e8a 100644
> --- a/arch/arm/boot/dts/tegra30-apalis.dtsi
> +++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
> @@ -10,6 +10,10 @@
>  	model =3D "Toradex Apalis T30";
>  	compatible =3D "toradex,apalis_t30", "nvidia,tegra30";
> =20
> +	memory {
> +		reg =3D <0 0>;
> +	};
> +
>  	pcie@3000 {
>  		avdd-pexa-supply =3D <&vdd2_reg>;
>  		vdd-pexa-supply =3D <&vdd2_reg>;
> diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.d=
tsi
> index a110cf84d85f..19237c08c166 100644
> --- a/arch/arm/boot/dts/tegra30.dtsi
> +++ b/arch/arm/boot/dts/tegra30.dtsi
> @@ -5,11 +5,18 @@
>  #include <dt-bindings/pinctrl/pinctrl-tegra.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> =20
> -#include "skeleton.dtsi"
> -
>  / {
>  	compatible =3D "nvidia,tegra30";
>  	interrupt-parent =3D <&lic>;
> +	#address-cells =3D <1>;
> +	#size-cells =3D <1>;
> +
> +	chosen { };
> +	aliases { };
> +
> +	memory {
> +		device_type =3D "memory";
> +	};
> =20
>  	pcie@3000 {
>  		compatible =3D "nvidia,tegra30-pcie";
> --=20
> 2.7.4
>=20

--bjuZg6miEcdLYP6q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltDfvwACgkQ3SOs138+
s6EA8A/9HoX9mAttPZpyA2xDqoRKQ0NsaVz+MV9Pv1tXqekZZDES/59JUNLUK6Ul
jTtKzSo1tksaiZC+kfqfn1QXV4EqpG9IhFgRMNc1SXuBbP7G3PmO7Ji1l99e+Noj
plV7aBTujj7kqRIal3KsifvgKn+CyJ+8LS7bCw89NWXTMTlpwzjYgwT7CBNpczNl
1eDnlstYIQn5AuAXI795MIHUNlPPxeupaX+WJS4CFXx8Mo7WwcYZWC2Dr8JiZbYt
BWHkOmgNpfZAc1AXimBm8hWHFb9f4yS15We7BXAxjDsN00eXRKWd38+Z9vz/YfIH
69petUoITag+JQNVm03YN2jR33x4RExkZ6rignHlpJT0Vs0seBv7alaeyV7EJpQQ
5OCzT/HnQs5wSZjWxE2D5udcaoaOwBCk3BNIvb8gnCr/UTTOkTqK2U2+jzsAT1Wl
YLrC0ue+xH7Do/ICIYjVQAAEpWo5EzHpReeEkai4PA6v9dF9gTuOKLqZlo0mlCpv
tG9I1SS5O5Ts9II5fpvKUBg3m+1RJYxV8IXC97BSJZRQTJkSRsFhkLSeZzdPbWMH
ZrsW/42CcEtwU8utzkYvZaK+/+FSSu6W5C2M/XySZ4JmA4f1aD8rxq6LvSI79YMK
j3bRMILPvTdSCzCxtCyhZlftN/GxqLP7Bfg6MdeLjUE78qLlmDI=
=aG6/
-----END PGP SIGNATURE-----

--bjuZg6miEcdLYP6q--
