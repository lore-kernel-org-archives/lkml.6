Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38829C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9696206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7nrefU1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9696206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbeKTEuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:50:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:51878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730160AbeKTEuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 23:50:54 -0500
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1AFF21104;
        Mon, 19 Nov 2018 18:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542651972;
        bh=jQf1Bb8hi7YDelC5XWCUyfk0FQssGT0UgFTNl+w3Ri0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F7nrefU1L3ZoYUXtom+yfAvSlBnM9Hj+06BZIDU8w9HnOQ1eVk+SsMfTXiZwtL2gV
         eLGgwirGbTyf4l/C3XQulCEQ/nnJSACDbb3gqJCQ55GlP3rXnaCVHPW9tHEaCIgPkj
         hfHOeNDOeT+nPMBXv3jawjBRx0uZyJWsuxdA1DHY=
Received: by mail-qk1-f170.google.com with SMTP id n12so50211180qkh.11;
        Mon, 19 Nov 2018 10:26:11 -0800 (PST)
X-Gm-Message-State: AGRZ1gKdY+mYysz+U165u1QBgSMXkJLC0JrpIdnqU3l1SE+sc7acAw2j
        Gkn7H07nZBnEErm5UWVNYRSaS+p8vVCnB7+jAA==
X-Google-Smtp-Source: AJdET5cRI4HzoDR/OY5KXEzpi5x67CKCTyOTrBOmv/Ubf/NFU4aYYH1VKbc6dvtYuzRjIzW1Zgal4EHcrwlXuvOSgkc=
X-Received: by 2002:ae9:ef14:: with SMTP id d20mr21757242qkg.147.1542651971056;
 Mon, 19 Nov 2018 10:26:11 -0800 (PST)
MIME-Version: 1.0
References: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org> <20181119170939.19153-5-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20181119170939.19153-5-manivannan.sadhasivam@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 19 Nov 2018 12:25:58 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLf_9ryCUtUkkE6P4GS8tC7nQ0pLHwLCQzy_HLJNTNMrw@mail.gmail.com>
Message-ID: <CAL_JsqLf_9ryCUtUkkE6P4GS8tC7nQ0pLHwLCQzy_HLJNTNMrw@mail.gmail.com>
Subject: Re: [PATCH 04/16] arm: dts: Add devicetree for RDA8810PL SoC
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, zhao_steven@263.net,
        service@rdamicro.com,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 11:11 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Add initial device tree for RDA8810PL SoC from RDA Microelectronics.
>
> Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm/boot/dts/rda8810pl.dtsi | 95 ++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 arch/arm/boot/dts/rda8810pl.dtsi
>
> diff --git a/arch/arm/boot/dts/rda8810pl.dtsi b/arch/arm/boot/dts/rda8810=
pl.dtsi
> new file mode 100644
> index 000000000000..7f1ff2021eff
> --- /dev/null
> +++ b/arch/arm/boot/dts/rda8810pl.dtsi
> @@ -0,0 +1,95 @@
> +/*
> + * RDA8810PL SoC
> + *
> + * Copyright (c) 2017 Andreas F=C3=A4rber
> + * Copyright (c) 2018 Manivannan Sadhasivam
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR MIT)

Goes on 1st line. checkpatch.pl will tell you this.

> + */
> +
> +/ {
> +       compatible =3D "rda,8810pl";
> +       #address-cells =3D <1>;
> +       #size-cells =3D <1>;
> +
> +       aliases {
> +               serial0 =3D &uart0;
> +               serial1 =3D &uart1;
> +               serial2 =3D &uart2;
> +       };
> +
> +       cpus {
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +
> +               cpu@0 {
> +                       device_type =3D "cpu";
> +                       compatible =3D "arm,cortex-a5";
> +                       reg =3D <0x0>;
> +               };
> +       };
> +
> +       soc {

soc@0

> +               compatible =3D "simple-bus";
> +               #address-cells =3D <1>;
> +               #size-cells =3D <1>;
> +               ranges =3D <0x0 0x0 0x80000000>;
> +
> +               sram@100000 {
> +                       compatible =3D "mmio-sram";
> +                       reg =3D <0x100000 0x10000>;

Based on the address of this and everything else, perhaps you should
move this to the top-level (or another bus node) and then either get
rid of the soc node level or make it start at 0x20000000. Kind of
depends on what the rest of the memory map looks like.

> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <1>;
> +                       ranges;
> +               };
> +
> +               apb@20800000 {
> +                       compatible =3D "simple-bus";
> +                       reg =3D <0x20800000 0x100000>;
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <1>;
> +                       ranges =3D <0x0 0x20800000 0x100000>;
> +               };
> +
> +               apb@20900000 {
> +                       compatible =3D "simple-bus";
> +                       reg =3D <0x20900000 0x100000>;

By definition of a simple-bus, it should not have any registers. Or
you should also have a specific compatible.

> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <1>;
> +                       ranges =3D <0x0 0x20900000 0x100000>;
> +               };
> +
> +               apb@20a00000 {
> +                       compatible =3D "simple-bus";
> +                       reg =3D <0x20a00000 0x100000>;
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <1>;
> +                       ranges =3D <0x0 0x20a00000 0x100000>;
> +
> +                       uart0: serial@0 {
> +                               compatible =3D "rda,8810pl-uart";
> +                               reg =3D <0x0 0x1000>;
> +                               status =3D "disabled";
> +                       };
> +
> +                       uart1: serial@10000 {
> +                               compatible =3D "rda,8810pl-uart";
> +                               reg =3D <0x10000 0x1000>;
> +                               status =3D "disabled";
> +                       };
> +
> +                       uart2: serial@90000 {
> +                               compatible =3D "rda,8810pl-uart";
> +                               reg =3D <0x90000 0x1000>;
> +                               status =3D "disabled";
> +                       };
> +               };
> +
> +               l2: cache-controller@21100000 {
> +                       compatible =3D "arm,pl310-cache";
> +                       reg =3D <0x21100000 0x1000>;
> +                       cache-unified;
> +                       cache-level =3D <2>;
> +               };
> +       };
> +};
> --
> 2.17.1
>
