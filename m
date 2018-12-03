Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44EFC65BAE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A47F20834
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KHwOLNe9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A47F20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbeLCJwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:52:21 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:34397 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbeLCJwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:52:21 -0500
Received: by mail-it1-f194.google.com with SMTP id x124so7961496itd.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 01:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qlA+Ve7B0ClpzM1pZ9TLkwyLB5aC59cq0OOd3p7iTDU=;
        b=KHwOLNe9jToVnytNapGRrK8uBcRyJB7uVy8FlJn8uhIVd52smg8Yx5x7/6eRlmOPVg
         AYPvZkKdX0XKxs7/rDMvdJPOHI11hv4c8WhWt0VgncYAjyjMvkjyw16zOThL6cd+PBIb
         KIsbEOgM41lW3adQafkRadYQb32J4dNmHnNTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qlA+Ve7B0ClpzM1pZ9TLkwyLB5aC59cq0OOd3p7iTDU=;
        b=l/PsXGU7a/8r2HV0wLohoUYet9J3+8UJLNWU+dvP3RwmZOq8xfc27y0dCIOwzQEH6+
         Qv4Kw3WLglfNo0Gw/uyl/D52MTEIgrVU92q19z54aw9JhSYcL3cd3iv+aPQU2pSEPjdC
         GPLzjjbm1MNFshsPDLOz1bxHBU5jaTC+U1sOx3dYVNp+uriyByxy4tSw4hyiuLCqPdqN
         jmzamgZPSmRPnFSw3GiMaYH9h+tlfBkPoyIdrsb65i2c0m3wpNLoCEWxUFO4s8W9GCpk
         F1wmmnZTkAdfqtiWdKCpHfoNc6k0bwUchSus8NsVU/We4FeZfPR0sCO6SmS/QCDJ51lg
         sIVQ==
X-Gm-Message-State: AA+aEWbZ4o0YvhELXFTsr1XWoK4D05oyWAmuEegWf2xgH+kitercv3xH
        wRnLICCZqIfpWKsH2TB6pZjFjtkXdh3t2JGnRIaLMA==
X-Google-Smtp-Source: AFSGD/VSuBnkXddzpk+LOXKAE6/jzMC+dF5S8T4A9Nkvdk2RIzi0lduFAHRO3/G52qKhdWprKhjcwVkVSl2Z4IkWaWc=
X-Received: by 2002:a24:10cb:: with SMTP id 194mr7446972ity.173.1543830722223;
 Mon, 03 Dec 2018 01:52:02 -0800 (PST)
MIME-Version: 1.0
References: <20181130075849.16941-1-wens@csie.org> <20181130075849.16941-6-wens@csie.org>
In-Reply-To: <20181130075849.16941-6-wens@csie.org>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 3 Dec 2018 15:21:50 +0530
Message-ID: <CAMty3ZAuBM0s3eNhQBySSaUrUAkiF=Hk+Ab=gsN=QucLJv0zyw@mail.gmail.com>
Subject: Re: [PATCH 5/6] [DO NOT MERGE] ARM: dts: sunxi: bananapi-m2p: Add
 HDF5640 camera module
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-media <linux-media@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 1:29 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> The Bananapi M2+ comes with an optional sensor based on the ov5640 from
> Omnivision. Enable the support for it in the DT.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi b/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
> index b3283aeb5b7d..d97a98acf378 100644
> --- a/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
> +++ b/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
> @@ -89,6 +89,42 @@
>                 };
>         };
>
> +       reg_cam_avdd: cam-avdd {
> +               compatible = "regulator-fixed";
> +               regulator-name = "csi-avdd";
> +               regulator-min-microvolt = <2800000>;
> +               regulator-max-microvolt = <2800000>;
> +               startup-delay-us = <200>; /* 50 us + board delays */
> +               enable-active-high;
> +               gpio = <&pio 3 14 GPIO_ACTIVE_HIGH>; /* PD14 */
> +       };
> +
> +       reg_cam_dovdd: cam-dovdd {
> +               compatible = "regulator-fixed";
> +               regulator-name = "csi-dovdd";
> +               regulator-min-microvolt = <2800000>;
> +               regulator-max-microvolt = <2800000>;
> +               /*
> +                * This regulator also powers the pull-ups for the I2C bus.
> +                * For some reason, if this is turned off, subsequent use
> +                * of the I2C bus, even when turned on, does not work.
> +                */
> +               startup-delay-us = <200>; /* 50 us + board delays */
> +               regulator-always-on;
> +               enable-active-high;
> +               gpio = <&pio 3 14 GPIO_ACTIVE_HIGH>; /* PD14 */
> +       };
> +
> +       reg_cam_dvdd: cam-dvdd {
> +               compatible = "regulator-fixed";
> +               regulator-name = "csi-dvdd";
> +               regulator-min-microvolt = <1500000>;
> +               regulator-max-microvolt = <1500000>;
> +               startup-delay-us = <200>; /* 50 us + board delays */
> +               enable-active-high;
> +               gpio = <&pio 3 14 GPIO_ACTIVE_HIGH>; /* PD14 */
> +       };
> +
>         reg_gmac_3v3: gmac-3v3 {
>                       compatible = "regulator-fixed";
>                       regulator-name = "gmac-3v3";
> @@ -106,6 +142,26 @@
>         };
>  };
>
> +&csi {
> +       status = "okay";
> +
> +       port {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               /* Parallel bus endpoint */
> +               csi_from_ov5640: endpoint {
> +                       remote-endpoint = <&ov5640_to_csi>;
> +                       bus-width = <8>;
> +                       data-shift = <2>;

If I'm not wrong, the data-shift is not available in sun6i at-least in
conf register.
