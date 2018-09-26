Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227B9C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D9420843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0y8vutT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D9420843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbeIZVCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:02:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54430 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbeIZVCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:02:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id c14-v6so2598704wmb.4;
        Wed, 26 Sep 2018 07:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4NPsaFQIKi2Vbh7rF47Pet2V+NYVqEnmfGB9TKKfKPk=;
        b=g0y8vutTdDdfFMhXf+PtYiNU/xs/5ehkgdzWKesA3pMIZg9Y/zfnlDm211mt94Hxrp
         tByt1Dt+iqBwhF/hE8F8U/edzL4T62m8Vskl2wkf/gaMIzSyySa3VccU1XevRzdOuHAw
         HPDbZLwoaqMbRO57wvlHHJ36bGY8Zv+0VbaK7gh/aWX/7eD9yc804+2E3/LQv8dxLh2S
         WtZYiIul7i7szPpR4/0SHSBjhZw8IxFPuji83wA7z1K8WYsDTR/B7Z0xfyyFja72Cp2f
         ohGrppqrkoaqmF/QJtR7O7/vHQzOBz9wqCFJvIu7I4+yGQJbF+qIS5kXQZICnLXuQokA
         byLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4NPsaFQIKi2Vbh7rF47Pet2V+NYVqEnmfGB9TKKfKPk=;
        b=e1ym1MKPwNTE8yFUkH1dCg08iZZDgv9N00ADU/ucbeLWIKhrVWz4xfIeEziTZCWwQA
         FkQF6FuxSekebO3Qq8ECRyv4gxm/CTNO/AKZEIAN7O/4qaSNEmK7xVZK9shC+96IV2jA
         NOW3ei9CKqtrpyF4vr2TrW5t7JmXpnBVuA6LllWqgYRK4f9c2K0RCB0CiQhQCHwZT95t
         kyfaQ8tufMyJt9acMeLxN55ih2e3HlTwZw5Jg5EE8x/bLgDyhgpJdS6te2X/uaAi1DGk
         FXhbd5im5cheoyyOGJ3GWyIyNozqvcWOGkbQgo2SI1BViCCX1qjDKwbevJnAu2QJUosJ
         SYBg==
X-Gm-Message-State: ABuFfogfIg/Nbii9KGRIhs4jgftF9yY8jB2gE3xL1q1P586/+yOVv7NX
        Df50Kt9l1rISH3TfvtzlpjA=
X-Google-Smtp-Source: ACcGV61DWShCmoLq7VDJRK3bzftQiWq8C+cutkwQ5XEnRGVgTCJdtm6zUK4zXf6Lvb9Zodq1JJ6L9w==
X-Received: by 2002:a1c:f53:: with SMTP id 80-v6mr1364960wmp.58.1537973327838;
        Wed, 26 Sep 2018 07:48:47 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id z8-v6sm5319396wmf.19.2018.09.26.07.48.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 07:48:47 -0700 (PDT)
Date:   Wed, 26 Sep 2018 16:48:46 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 00/34] ARM: dts: tegra: colibri_t30: major revamp
Message-ID: <20180926144846.GE12980@ulmo>
References: <20180901081248.22639-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vv4Sf/kQfcwinyKX"
Content-Disposition: inline
In-Reply-To: <20180901081248.22639-1-marcel@ziswiler.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vv4Sf/kQfcwinyKX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 01, 2018 at 10:12:14AM +0200, Marcel Ziswiler wrote:
> This series is a major overhaul for the Toradex Colibri T30 system on
> module.
>=20
> Changes in v2:
> - Also move serial UART "nvidia,tegra30-hsuart" compatible to module
>   level device trees.
> - Also replace underscores in node names with dashes.
> - Also replace underscores in UART annotations with dashes.
> - When running some more tests I realized that the reg-addr should
>   really be 0x3f. Fix this.
> - Get rid of fake clocks simple bus as suggested by Rob.
> - Drop "[PATCH 01/26] ARM: tegra: colibri_t30: enable broken-hpi on
>   emmc" which should already be handled by the broken-hpi quirk as
>   pointed out by Dmitry. If I would find more eMMC parts which exhibit
>   the issue I will add them to the quirk as a separate patch.
> - New patch as suggested by Rob.
> - New patch.
>=20
> Marcel Ziswiler (34):
>   ARM: tegra: colibri_t30: add local-mac-address property
>   ARM: tegra: colibri_t30: reorder host1x/hdmi properties
>   ARM: tegra: colibri_t30: regulator clean-up
>   ARM: tegra: colibri_t30: add missing regulators
>   ARM: tegra: colibri_t30: annotate uarts and move compatible to board
>   ARM: tegra: colibri_t30: white-space clean-up
>   ARM: tegra: colibri_t30: move dr_mode property from phy to controller
>   ARM: tegra: colibri_t30: reorder backlight properties
>   ARM: tegra: colibri_t30: drop pwmleds
>   ARM: tegra: colibri_t30: pinmux clean-up
>   ARM: tegra: colibri_t30: add missing pinmux
>   ARM: tegra: colibri_t30: use proper irq-gpio for stmpe811
>   ARM: tegra: colibri_t30: further lm95245 temperature sensor annotation
>   ARM: tegra: colibri_t30: add i2c-thermtrip
>   ARM: tegra: colibri_t30: add proper emmc vmmc and vqmmc supplies
>   ARM: tegra: colibri_t30: enable emmc ddr52 mode
>   ARM: tegra: colibri_t30: get rid of fake clocks simple bus
>   ARM: tegra: colibri_t30: line break long compatible property line
>   ARM: tegra: colibri_t30: move input include to carrier board
>   ARM: tegra: colibri_t30: remove unused nvidia,is-wired property
>   ARM: tegra: colibri_t30: add gpio hog to unreset usb ethernet chip
>   ARM: tegra: colibri_t30: enable hda over hdmi
>   ARM: tegra: colibri_t30: annotate sd card detect
>   ARM: tegra: colibri_t30: annotate ehci instance 1
>   ARM: tegra: colibri_t30: update compatibility comment
>   ARM: tegra: colibri_t30: drop module level model and compatible
>   ARM: tegra: colibri_t30: drop obsolete spidev node
>   ARM: tegra: colibri_t30: rename hdmiddc to hdmi_ddc
>   ARM: tegra: colibri_t30: rename tps65911@2d, stmpe811@41 and
>     tps62362@60
>   ARM: tegra: colibri_t30: fix mcp2515 can controller interrupt polarity
>   ARM: tegra: colibri_t30: remove unused mcp2515 can0 label
>   ARM: tegra: colibri_t30: add mcp2515 vdd and xceiver supplies
>   ARM: tegra: colibri_t30: annotate unused i2c busses
>   ARM: tegra: colibri_t30: annotate power I2C being on-module
>=20
>  arch/arm/boot/dts/tegra30-colibri-eval-v3.dts | 130 ++---
>  arch/arm/boot/dts/tegra30-colibri.dtsi        | 780 ++++++++++++++++++++=
+-----
>  2 files changed, 706 insertions(+), 204 deletions(-)

Applied, thanks.

Thierry

--vv4Sf/kQfcwinyKX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlurnE4ACgkQ3SOs138+
s6FiRRAAtJaWRYJXqqEhNMed5JnCOQrFf8sOHd+kyv/lRE63Vc58xGIhtgDXI3MF
WVzYu4wrRMeRQdzpSheETpWFUbbH9RK+2u8dkXpgRPVKDNdpTYrWBNhykSvAARDE
ZtuqPz8IAwpr4sKi6CFKI2mqkMCqF2I6YgAN1nAgdgx5lbhohsXFOb6lcEMvNoOq
B9eVC2p/jXAQfNJYaKF8VXrSdWfad2sD7V/4GATRtlMeT/Fb9nVKQPP4f9RwAHnk
+PTD2ROrOUMQoZo4Lx89Pbmp3VwxvnPY9sW1kGNBNVPWX4ivu0G5toV0Sn7EWhZW
nAsG/6XidLnqdqU0Q6RAOM5QYENsmfl16jIQqvYUZCGg35+7XKQ9IqE4+IFFA27w
IiX+8a66AinnGOleZF5L4M+rz1FJLagBUpKw4H88pYrmJbfH5629klbZgJ29czkg
dJ1Ro7znDo7E9UAss+kznnsKLZ2mhy+TpIUUMvR1nHxjm8lE3uDjDF3JI2kg/MrY
ZUOmwakZQzzZwLutQgVEvxE91ULHETwrhnfLBj4WQnMftKfe9Vq2ejLOXtJX5TLs
0YEF9kStpl0/nnXdPUWs/hhlqdJvdHXzWD69BVJqENIw92U1K/Rnu3McjA0tu/j5
VWp5G0kUZjMpnwrB8n/A9SVlyEITbMl4Gh0suwt+kpHmCoybqPY=
=W4g1
-----END PGP SIGNATURE-----

--vv4Sf/kQfcwinyKX--
