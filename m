Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7195C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8BB214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPay2+CB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E8BB214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbeIZVAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:00:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40187 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbeIZVAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:00:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id y8-v6so23671160wrh.7;
        Wed, 26 Sep 2018 07:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gABm/mTpsJHWbqy1LRBGQGVd1bR87vhw85AVVLzuZzM=;
        b=RPay2+CBgqcm/1GFRl/f3tuIdwdbvBSQhGjlDoKfc5/Zlk4Iq4mDdB9M0O2rliUrKl
         7+6O4qwW+Qf5iOa3IxD9REDeolt1RMwHW0B+nP3FCapS9PQwK/2lzzu7VCqTBQoOi9Ue
         lFPPgHeCh8NYxJYJPUD9kwU4tDREeYY7uJ8NqNioxWTtWgMq9SsDbDgRuUmsIBt4H9dI
         YTBjnUGy03nn1GL7DXwbFg01Hn91zYGifpa28YO7ErBRhQce2+IhZ4QhZVidS8YCD4y+
         uzqk1A1iDBvkGWPI/jVTok4rTTJmbCG6iu17gc0flP6uc2LXpbUuxjvtdv/sLk7M80bk
         KjeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gABm/mTpsJHWbqy1LRBGQGVd1bR87vhw85AVVLzuZzM=;
        b=Wd0BLGsp8/v94mg6LcwWv/3JiGGueKutc3G9ke465QVlz+eYgjAzfZxjDOCcQyCChr
         ZNBdKEn+aIuub2X9u3OOWPES+Day2liKJpENiYGe+pzEjeaRV599FWodgOYYYKyCOQ10
         Ioiz+V6R4KlXVtA/7yeOBo6WWliXWyXO3p0zS2dc7llhg3LHlOb8rtDGYTZBfMBrTGPC
         CtO8QQgiwG6jQM6/zMZuJrA08Dn7H/UN9skQY22gj8HCbHk7LX8O6Q8jPRmc3BBhJSKz
         GmRX32wGenV7Tm6VJSQpiBE3ZBNQ0Zys2LTr3bxftSYZPt6hRGwVrjAAiP4bSbiiQmvI
         Vfcg==
X-Gm-Message-State: ABuFfogI0zX8h4ZyFKLNL43wfVwDcapZcRo/mViCc3r99J6VAJ0mgjCt
        unQIEu6/6fJJ9U9s6wPz4pY=
X-Google-Smtp-Source: ACcGV62HkQgAKlIfWUdhxS6m9Hr64hgKLFD3whfW4CfP/GPALRlRyMY6iPYVOd0M+Xa3SjaXtLjCug==
X-Received: by 2002:a5d:6aca:: with SMTP id u10-v6mr5448321wrw.44.1537973214830;
        Wed, 26 Sep 2018 07:46:54 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id q200-v6sm29319151wmd.2.2018.09.26.07.46.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 07:46:54 -0700 (PDT)
Date:   Wed, 26 Sep 2018 16:46:53 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        David Lechner <david@lechnology.com>,
        Thierry Reding <treding@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>
Subject: Re: [PATCH v2 00/34] ARM: dts: tegra: apalis_t30: major revamp incl.
 v1.1 hardware support
Message-ID: <20180926144653.GD12980@ulmo>
References: <20180831163817.23970-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AkbCVLjbJ9qUtAXD"
Content-Disposition: inline
In-Reply-To: <20180831163817.23970-1-marcel@ziswiler.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AkbCVLjbJ9qUtAXD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 31, 2018 at 06:37:42PM +0200, Marcel Ziswiler wrote:
> This series is a major overhaul and adds support for the V1.1 hardware
> revision of the Toradex Apalis T30 system on module.
>=20
> Changes in v2:
> - Clean-up PCIe controller/port status' as well.
> - Also move serial UART "nvidia,tegra30-hsuart" compatible to module
>   level device trees.
> - Also add two missing newlines.
> - Also replace underscores in node names with dashes.
> - Explicitly disable input of BKL1_ON as well.
> - Replace underscores in node names with dashes.
> - When running some more tests I realized that the reg-addr should
>   really be 0x3f. Fix this.
> - Get rid of fake clocks simple bus as suggested by Rob.
> - Replace "[PATCH 27/28] ARM: tegra: apalis_t30: fix pcie switch vendor
>   compatible" with "[PATCH v2 26/34] dt-bindings: add broadcom (formerly
>   plx technology) vendor prefix" as suggested by Stefan.
> - New patch as suggested by Rob.
> - New patch.
> - Drop "[PATCH 01/28] ARM: tegra: apalis_t30: enable broken-hpi on emmc"
>   which should already be handled by the broken-hpi quirk as pointed out
>   by Dmitry. If I would find more eMMC parts which exhibit the issue I
>   will add them to the quirk as a separate patch.
> - Updated V1.1 device trees with all applicable previous fixes.
>=20
> Marcel Ziswiler (34):
>   ARM: tegra: apalis_t30: fix mmc1 cmd pull-up
>   ARM: tegra: apalis_t30: pull-up sd card detect pins
>   ARM: tegra: apalis_t30: add local-mac-address property
>   ARM: tegra: apalis_t30: reorder pcie properties
>   ARM: tegra: apalis_t30: annotate/clean-up pcie controller/port nodes
>   ARM: tegra: apalis_t30: reorder host1x/hdmi properties
>   ARM: tegra: apalis_t30: regulator clean-up
>   ARM: tegra: apalis_t30: add missing regulators
>   ARM: tegra: apalis_t30: annotate uarts and move compatible to board
>   ARM: tegra: apalis_t30: drop unused cami2c label
>   ARM: tegra: apalis_t30: white-space/newline clean-up
>   ARM: tegra: apalis_t30: drop unused mmc1/sd1 labels
>   ARM: tegra: apalis_t30: annotate mmc1/sd1
>   ARM: tegra: apalis_t30: move dr_mode property from phy to controller
>   ARM: tegra: apalis_t30: reorder backlight properties
>   ARM: tegra: apalis_t30: drop pwmleds
>   ARM: tegra: apalis_t30: pinmux clean-up
>   ARM: tegra: apalis_t30: add missing pinmux
>   ARM: tegra: apalis_t30: use proper irq-gpio for stmpe811
>   ARM: tegra: apalis_t30: further lm95245 temperature sensor annotation
>   ARM: tegra: apalis_t30: add i2c-thermtrip
>   ARM: tegra: apalis_t30: add proper emmc vmmc and vqmmc supplies
>   ARM: tegra: apalis_t30: enable emmc ddr52 mode
>   ARM: tegra: apalis_t30: get rid of fake clocks simple bus
>   ARM: tegra: apalis_t30: line break long compatible property line
>   dt-bindings: add broadcom (formerly plx technology) vendor prefix
>   ARM: tegra: apalis_t30: drop module level model and compatible
>   ARM: tegra: apalis_t30: drop obsolete spidev nodes
>   ARM: tegra: apalis_t30: hog group for pcie switch reset gpio
>   ARM: tegra: apalis_t30: rename hdmiddc to hdmi_ddc
>   ARM: tegra: apalis_t30: rename tps65911@2d, stmpe811@41 and
>     tps62362@60
>   ARM: tegra: apalis_t30: fix mcp2515 can controller interrupt polarity
>   ARM: tegra: apalis_t30: move hda node from carrier to module
>   ARM: tegra: apalis_t30: support v1.1 hardware revision
>=20
>  Documentation/devicetree/bindings/arm/tegra.txt    |    2 +
>  .../devicetree/bindings/vendor-prefixes.txt        |    1 +
>  arch/arm/boot/dts/Makefile                         |    1 +
>  arch/arm/boot/dts/tegra30-apalis-eval.dts          |  148 +--
>  arch/arm/boot/dts/tegra30-apalis-v1.1-eval.dts     |  266 +++++
>  arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi         | 1189 ++++++++++++++=
++++++
>  arch/arm/boot/dts/tegra30-apalis.dtsi              |  705 +++++++++---
>  7 files changed, 2064 insertions(+), 248 deletions(-)
>  create mode 100644 arch/arm/boot/dts/tegra30-apalis-v1.1-eval.dts
>  create mode 100644 arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi

Applied, thanks.

Thierry

--AkbCVLjbJ9qUtAXD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlurm9wACgkQ3SOs138+
s6HSCQ//R45gdNTX6DyNyNx6lx8nCarb1h634iBzL2MrJHbtfFzfkv6AyTTqig9Q
aDCp4Rq3j2CrZ9VWdYrOnD/xw00qUKZ8ltZrRz97qhGdYg0x8iv/c4AMXju861e2
72zujUoW/0/HdmUXLEultVPl6Bfvbcby+kTJNPjWMqVRZC49rFUs3q96Xe0wQu4L
2vQ0iO7qq8meNBA2JTq4wBSDibbfOtShzH0kiJ0U614Y/+fbRKBiO+b1Bwdk3PxH
bEN47VGJjsbq6CzKrjIqUW1Pl2XZeMAB6sNj4YAkfkHW61jZ5V0LQPtQqC3i8ziQ
byODReetNX/oboF1hkjPAlHOEunATt6qjPg+jxE4d0dNJLMqaUadwAt0TNJtv3mZ
qATruOQMV2euX3+zFjKzxPjpzL4V+BBSiMbuFQspk180KqBZkIHpzj4KmEo3uAAt
OivWss2NIxIwZHwFxTuC20KTny2dtfKYqfOkTY8f7h7t7TEdox8DAruCSFY1FGqF
Cidxdy+r/JwIj4Qhd6O+aNm5TPtWbdB6Hv+nEQ9ahqIKX2xV3hiFRL99l6vakMS1
IkNODVqPaOXnpsec2UQSUKaOUR6NT5OmyUiEkznQW0PBy9W5fazgtCQVfQa7wsyS
mapVdJPsjPA1pNU2tXpmSSfBA3n3mvuQQ5fr5THhJN/A9jXxiK4=
=OnPT
-----END PGP SIGNATURE-----

--AkbCVLjbJ9qUtAXD--
