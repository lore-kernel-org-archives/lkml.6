Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B63C5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 20:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F9821470
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 20:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ue9dy8DQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F9821470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbeJQEsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 00:48:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbeJQEsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 00:48:23 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D58220869;
        Tue, 16 Oct 2018 20:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539723370;
        bh=4kAOA83L4Dtm9NvEWG0u+peOSyFPsTjG4GxUfEyDFBU=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=Ue9dy8DQ50s5mUxaxtQ+r/doH1Ts4vSP8cQgg1zI6ySSKusGkVM0iBCQUcKIV0nSR
         j+vuN0lFliwZUNpxZwOcuOCAec6p9zXT3+0g3tHlZF5FVwfOYIDs6fMyq2ceU7EPX2
         b3dz00wFoj9+pJO64ORg4vJ9L8RfylPkCrd4RSLA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180922181709.13007-2-gregory.clement@bootlin.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20180922181709.13007-1-gregory.clement@bootlin.com>
 <20180922181709.13007-2-gregory.clement@bootlin.com>
Message-ID: <153972336963.5275.5425208133793471350@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/6] dt-bindings: ap806: add the cluster clock node in the syscon
 file
Date:   Tue, 16 Oct 2018 13:56:09 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gregory CLEMENT (2018-09-22 11:17:04)
> Document the device tree binding for the cluster clock controllers found
> in the Armada 7K/8K SoCs.
> =

> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---

Please Cc relevant DT maintainers and lists when submitting binding patches.

>  .../arm/marvell/ap806-system-controller.txt   | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> =

> diff --git a/Documentation/devicetree/bindings/arm/marvell/ap806-system-c=
ontroller.txt b/Documentation/devicetree/bindings/arm/marvell/ap806-system-=
controller.txt
> index 3fd21bb7cb37..8f281816a6b8 100644
> --- a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controll=
er.txt
> +++ b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controll=
er.txt
> @@ -136,3 +136,25 @@ ap_syscon1: system-controller@6f8000 {
>                 #thermal-sensor-cells =3D <1>;
>         };
>  };
> +
> +Cluster clocks:
> +---------------
> +
> +Device Tree Clock bindings for cluster clock of AP806 Marvell. Each
> +cluster contain up to 2 CPUs running at the same frequency.
> +
> +Required properties:
> +- compatible: must be  "marvell,ap806-cpu-clock";
> +- #clock-cells : should be set to 1.
> +- clocks : shall be the input parents clock phandle for the clock.
> +
> +ap_syscon1: system-controller@6f8000 {
> +       compatible =3D "syscon", "simple-mfd";
> +       reg =3D <0x6f8000 0x1000>;
> +
> +       cpu_clk: clock-cpu {
> +               compatible =3D "marvell,ap806-cpu-clock";
> +               clocks =3D <&ap_clk 0>, <&ap_clk 1>;
> +               #clock-cells =3D <1>;
> +       };
> +};
