Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20F9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6D720851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXiZIi35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C6D720851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbeKTEyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:54:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:52912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730209AbeKTEyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 23:54:03 -0500
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E70E21104;
        Mon, 19 Nov 2018 18:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542652159;
        bh=bct6VpAw0+f2uArPcOI6UU9FWzGKhBXor2G0P/BDJbs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YXiZIi353GpOyiezFnYfkMWqujH7utpGXpn5gCaM2L06fvFRLJiTFVVMHJ2AiQSF8
         ClCWiARS8V/WGT9yIC5RlLKXarAOGpIe/OlxFUdOVrTYRkfwAA7OEXNj7oTQpYO2Kr
         82zXTUSpBiDglgwtQDL+xerKEwVbpCwPXi7d2qjE=
Received: by mail-qk1-f173.google.com with SMTP id o125so50256135qkf.3;
        Mon, 19 Nov 2018 10:29:19 -0800 (PST)
X-Gm-Message-State: AGRZ1gIjvLO5xRNgsUHuKXCBuK9b/tZAf3WfjHSXUXA0FURUa4wK0Fdq
        iUhVu07Yov07Y6YyjkH4jGCt8EhFHNYEsPk+8A==
X-Google-Smtp-Source: AJdET5dK0MYEX/57OYnfOme2DZDztVavB0dpHxaJ2D4CBDhDOUis7A8IKQSPh3Lpd3Vk7LyH4zPPg55NQYMyATS4Qok=
X-Received: by 2002:ae9:c306:: with SMTP id n6mr21951866qkg.79.1542652158850;
 Mon, 19 Nov 2018 10:29:18 -0800 (PST)
MIME-Version: 1.0
References: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org> <20181119170939.19153-9-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20181119170939.19153-9-manivannan.sadhasivam@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 19 Nov 2018 12:29:07 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL3B3y3hYv-yf3wzXiUsvnM9pCYE7u_Y0i4zT7wFti5GA@mail.gmail.com>
Message-ID: <CAL_JsqL3B3y3hYv-yf3wzXiUsvnM9pCYE7u_Y0i4zT7wFti5GA@mail.gmail.com>
Subject: Re: [PATCH 08/16] arm: dts: rda8810pl: Add interrupt controller support
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
> Add interrupt controller support for RDA Micro RDA8810PL SoC.

There's no point in splitting this to a separate patch. Without it,
the DT is not functional.

> Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm/boot/dts/rda8810pl.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/rda8810pl.dtsi b/arch/arm/boot/dts/rda8810=
pl.dtsi
> index 7f1ff2021eff..093d6980bfbd 100644
> --- a/arch/arm/boot/dts/rda8810pl.dtsi
> +++ b/arch/arm/boot/dts/rda8810pl.dtsi
> @@ -9,6 +9,7 @@
>
>  / {
>         compatible =3D "rda,8810pl";
> +       interrupt-parent =3D <&intc>;
>         #address-cells =3D <1>;
>         #size-cells =3D <1>;
>
> @@ -49,6 +50,13 @@
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
>                         ranges =3D <0x0 0x20800000 0x100000>;
> +
> +                       intc: interrupt-controller {


unit-address?

> +                               compatible =3D "rda,8810pl-intc";
> +                               reg =3D <0x0 0x1000>;
> +                               interrupt-controller;
> +                               #interrupt-cells =3D <2>;
> +                       };
>                 };
>
>                 apb@20900000 {
> --
> 2.17.1
>
