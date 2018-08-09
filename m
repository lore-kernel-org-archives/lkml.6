Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4BCC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E55521D6A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAHNiB+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E55521D6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731097AbeHIOic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:38:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33277 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730928AbeHIOic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:38:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id g6-v6so4976130wrp.0;
        Thu, 09 Aug 2018 05:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aHPeKTpJ8sUw5eh278M89YR1p9oOqDkpboZtrpX6UuQ=;
        b=MAHNiB+shFmOHTIs1TEr2iE8Jl6TgTSvPOwsZ7bZisGq8lidg0F6Cu8p4TwaRxLFHP
         wYB6q6T3drLrF+uZY1Krm+/zvDtWTIAQrKZjmTpsF5BqfQw9OzYc1wCxT0fuB9Nf5p09
         mKp941dt6M2G038WQl7Rifd6eJQaeYvT8Sz2UVe3sZ3V6Snha3gXOjU/6Rv5Sll8EQrv
         wfmGk+8icdF1XFmxIu11nXzegIlCfStazgEDC50rjv2a9pUhYEyVstjvm2bYJRYQQ1uQ
         LbC+uLuoTsMs33SZAHcvVfzJBy4jZ9lGBumA6C4MAa9QjD/4WW21CENho5Vo3P9EGP/P
         1V1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aHPeKTpJ8sUw5eh278M89YR1p9oOqDkpboZtrpX6UuQ=;
        b=baj6zo1aDr6pqHC7+WysM17GP/xPqfV3qnruV2Xv3ObpaT/O5K3ppzNPnOz+sPYT8x
         bGz3YjHoAs9wS4tbEr6sLQmutHiNnELRH7CRZT19eM0gf1XlB3aKKhZ7phSVAAjWhieu
         yTvs34tjAyWNKH9pTC/tICY3aeZiid+HoZb4LDOGBa7u+l9MbPDdNPXvwlZuOWdozRtr
         lflgU0mKq0zLIvxoht3F6UZDN/MGoy77oj7jmDmht1ScmxTc9Rl5IkRvFmpGKTK7gAwI
         7iFINrWb9KIPyrgwoG0tGNGWFwTIohXfva1Pi5Y6o5B1ofIxRR/PoR+xJvdz+8YHzZQi
         vkfw==
X-Gm-Message-State: AOUpUlFYivF/6bKFQmuzKSZZr5jPw0IieRckPykbRIQOa0vSSa/jaUYG
        k6qU18wDw/M4XX/f20HPkRo=
X-Google-Smtp-Source: AA+uWPzH5SBdg/YsQ/OVk193eGme6CddrpGGpENkQAhcJidifAlnk/amWXOoXni51Qe7DhXPqT2M1Q==
X-Received: by 2002:adf:db41:: with SMTP id f1-v6mr1415620wrj.212.1533816832798;
        Thu, 09 Aug 2018 05:13:52 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id p14-v6sm10968799wru.0.2018.08.09.05.13.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 05:13:51 -0700 (PDT)
Date:   Thu, 9 Aug 2018 14:13:50 +0200
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
Subject: Re: [PATCH 01/40] dt-bindings: Add Tegra PMC pad configuration
 bindings
Message-ID: <20180809121350.GO21639@ulmo>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
 <1533141150-10511-2-git-send-email-avienamo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2/+Vq7w28QOSGzSM"
Content-Disposition: inline
In-Reply-To: <1533141150-10511-2-git-send-email-avienamo@nvidia.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2/+Vq7w28QOSGzSM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2018 at 07:31:51PM +0300, Aapo Vienamo wrote:
> Document the PMC pinctrl bindings for pad power state and signaling
> voltage configuration. Both nvidia,tegra186-pmc.txt and
> nvidia,tegra20-pmc.txt are modified as they both cover SoC generations
> for which these bindings apply.
>=20
> Add a header defining Tegra PMC pad voltage configurations.
>=20
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/arm/tegra/nvidia,tegra186-pmc.txt     |  92 +++++++++++++++=
+++
>  .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 103 +++++++++++++++=
++++++
>  include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h |  18 ++++
>  3 files changed, 213 insertions(+)
>  create mode 100644 include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h
>=20
> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-=
pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.t=
xt
> index 5a3bf7c..d7fed4d 100644
> --- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
> @@ -34,3 +34,95 @@ Board DTS:
>  	pmc@c360000 {
>  		nvidia,invert-interrupt;
>  	};
> +
> +=3D=3D Pad Control =3D=3D
> +
> +On Tegra SoCs a pad is a set of pins which are configured as a group.
> +The pin grouping is a fixed attribute of the hardware. The PMC can be
> +used to set pad power state and signaling voltage. A pad can be either
> +in active or power down mode. The support for power state and signaling
> +voltage configuration varies depending on the pad in question. 3.3 V and
> +1.8 V signaling voltages are supported on pins where software
> +controllable signaling voltage switching is available.
> +
> +Pad configurations are described is with pin configuration nodes which

The "is" in the middle there seems to be left-over from a previous
formulation of the sentence.

> +are placed under the pmc node and they are referred to by the pinctrl
> +client properties. For more information see
> +Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt.
> +
> +Following pads are present on Tegra186:

"The following pads..."

> +csia		csib		dsi		mipi-bias
> +pex-clk-bias	pex-clk3	pex-clk2	pex-clk1
> +usb0		usb1		usb2		usb-bias
> +uart		audio		hsic		dbg
> +hdmi-dp0	hdmi-dp1	pex-cntrl	sdmmc2-hv
> +sdmmc4		cam		dsib		dsic
> +dsid		csic		csid		csie
> +dsif		spi		ufs		dmic-hv
> +edp		sdmmc1-hv	sdmmc3-hv	conn
> +audio-hv	ao-hv
> +
> +Required pin configuration properties:
> +  - pins: Must contain name of the pad(s) to be configured.

"the name". Also, I'm assuming that this can take a list of names, so
perhaps this should read:

	- pins: A list of strings, each of which contains the name of a pad
	    to be configured.

> +
> +Optional pin configuration properties:
> +  - low-power-enable: Configure the pad into power down mode
> +  - low-power-disable: Configure the pad into active mode

Do we need both of these? low-power could be a boolean property to mean
that the pad(s) should be configured in power down mode. If absent it
would mean that the pad(s) should be configured in normal mode. The only
reason why I can think of them to have to be separate is if we want to
define a configuration where the power mode is not touched. But is that
really something we need or want?

> +  - power-source: Must contain either TEGRA_IO_PAD_VOLTAGE_1V8 or
> +    TEGRA_IO_PAD_VOLTAGE_3V3 to select between signaling voltages.
> +    The values are defined in
> +    include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h.

Why is this called "power-source"? This defines the signaling voltage of
the pad, so why not something like "power-level", or "voltage", or
"output-voltage"?

Or is this because it is a mux that will internally select either a
1.8 V or a 3.3 V source? In which case I guess this is okay. Perhaps
give some explanation of the mechanics of the underlying hardware to
make this more obvious.

> +
> +Note: The power state can be configured on all of the above pads except
> +      for ao-hv. Following pads have software configurable signaling
> +      voltages: sdmmc2-hv, dmic-hv, sdmmc1-hv, sdmmc3-hv, audio-hv,
> +      ao-hv.
> +
> +Pad configuration state example:
> +	pmc: pmc@7000e400 {
> +		compatible =3D "nvidia,tegra186-pmc";
> +		reg =3D <0 0x0c360000 0 0x10000>,
> +		      <0 0x0c370000 0 0x10000>,
> +		      <0 0x0c380000 0 0x10000>,
> +		      <0 0x0c390000 0 0x10000>;
> +		reg-names =3D "pmc", "wake", "aotag", "scratch";
> +
> +		...
> +
> +		sdmmc1_3v3: sdmmc1-3v3 {
> +			pins =3D "sdmmc1-hv";
> +			power-source =3D <TEGRA_IO_PAD_VOLTAGE_3V3>;
> +		};
> +
> +		sdmmc1_1v8: sdmmc1-1v8 {
> +			pins =3D "sdmmc1-hv";
> +			power-source =3D <TEGRA_IO_PAD_VOLTAGE_1V8>;
> +		};

Wouldn't these be implicitly low-power-disable? What if these are off by
default? Selecting these states would change the power source but keep
them in power down, no? Don't we want something like the below instead?

		sdmmc1_3v3: sdmmc1-3v3 {
			pins =3D "sdmmc1-hv";
			power-source =3D <TEGRA_IO_PAD_VOLTAGE_3V3>;
			/* low-power-disable implied here */
		};

		sdmmc1_1v8: sdmmc1-1v8 {
			pins =3D "sdmmc1-hv";
			power-source =3D <TEGRA_IO_PAD_VOLTAGE_1V8>;
			/* low-power-disable implied here */
		};

		sdmmc1_off: sdmmc1-off {
			pins =3D "sdmmc1-hv";
			low-power;
		};

That would allow the SDHCI driver to select between the two signaling
modes and a separate state for powering down the pad.

> +
> +		hdmi_off: hdmi-off {
> +			pins =3D "hdmi";
> +			low-power-enable;
> +		}
> +
> +		hdmi_on: hdmi-on {
> +			pins =3D "hdmi";
> +			low-power-disable;
> +		}

These would similarily become:

		hdmi_off: hdmi-off {
			pins =3D "hdmi";
			low-power;
		};

		hdmi_on: hdmi-on {
			pins =3D "hdmi";
		};

> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-p=
mc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> index a74b37b..5363b90 100644
> --- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> @@ -195,3 +195,106 @@ Example:
>  		power-domains =3D <&pd_audio>;
>  		...
>  	};
> +
> +=3D=3D Pad Control =3D=3D
> +
> +On Tegra SoCs a pad is a set of pins which are configured as a group.
> +The pin grouping is a fixed attribute of the hardware. The PMC can be
> +used to set pad power state and signaling voltage. A pad can be either
> +in active or power down mode. The support for power state and signaling
> +voltage configuration varies depending on the pad in question. 3.3 V and
> +1.8 V signaling voltages are supported on pins where software
> +controllable signaling voltage switching is available.
> +
> +The pad configuration state nodes are placed under the pmc node and they
> +are referred to by the pinctrl client properties. For more information
> +see Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt.
> +The pad name should be used as the value of the pins property in pin
> +configuration nodes.
> +
> +Following pads are present on Tegra124 and Tegra132:
> +audio		bb		cam		comp
> +csia		csb		cse		dsi
> +dsib		dsic		dsid		hdmi
> +hsic		hv		lvds		mipi-bias
> +nand		pex-bias	pex-clk1	pex-clk2
> +pex-cntrl	sdmmc1		sdmmc3		sdmmc4
> +sys_ddc		uart		usb0		usb1
> +usb2		usb_bias
> +
> +Following pads are present on Tegra210:
> +audio		audio-hv	cam		csia
> +csib		csic		csid		csie
> +csif		dbg		debug-nonao	dmic
> +dp		dsi		dsib		dsic
> +dsid		emmc		emmc2		gpio
> +hdmi		hsic		lvds		mipi-bias
> +pex-bias	pex-clk1	pex-clk2	pex-cntrl
> +sdmmc1		sdmmc3		spi		spi-hv
> +uart		usb0		usb1		usb2
> +usb3		usb-bias

What about chips prior to Tegra124?

Thierry

--2/+Vq7w28QOSGzSM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsL/wACgkQ3SOs138+
s6FEgQ/+MtQ0fxIXDUNK2HsXkdHw2vRGHMBEuqJFZyTbAYLOhT4Oi0u91UIHkba5
m6yztZJQPLCtc3OU5HuXDqtCNYRD+HUoKpRgDqmjVlY0oKgzlnzVFmfmAwOAfH30
ktGPJC6o7aUB+5D2ed/uk4zLAywBvPFgP8KmcfYzRR1cRLG+mpzPbkcDKOd+XYX+
3nvG36eiEhfuNRE9PkpmiGHoXq8ktnZOikMFv0f1308uXJ4ynXrRck4EhTTX2gRd
KE3Z54UeV1o49ao41VSumr1Bu0gc53fpKl3nRgp/KoxO6c5wH90HCGebvXboNnf+
z6GYQxsZi7LfxMrgMUQ6mwDC81YY5Wb+zgb/yLy5pZy577FLe6F1sz2yZ5LMzcCT
wavSxlUGqi3TWDTFEQaaC7jdHBhc3YcHoNxue6Rto+15HZE3U6IXoHVmJVTjK6Oq
XnmKCVstIZvjt36Bbi8j4gTZm5o7Nbu3zXyuqQ4QN9gIiKCKOJefyxBhkmf2oPRQ
wA6RZS/x7zvvH62d67EsryLnHMS/DRYDJbUAVr4XCTIezK1obQ67yYlcnUj9zu3A
NZ7jPWaE5m22YXeWlfi3CGGbWXo1h5M8ME2WyEBNtZ0QR1xHmdpiAmnZ84HAe5NM
VXjgZBBmSbYYUfe3uDfsa7Mn++V2X0yZjJZKrQwSeP+6zWRYfks=
=OVwz
-----END PGP SIGNATURE-----

--2/+Vq7w28QOSGzSM--
