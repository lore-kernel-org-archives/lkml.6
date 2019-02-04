Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A10C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735572082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HzhvLDVC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbfBDN7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 08:59:11 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34685 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729055AbfBDN7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 08:59:10 -0500
Received: by mail-ot1-f65.google.com with SMTP id t5so13083152otk.1;
        Mon, 04 Feb 2019 05:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KF1X/3cj948PjMeFbZfRlquxhga99uxMWr3+oeJo3s0=;
        b=HzhvLDVCyjAlYQIP9Q99PYJ+n6RKuxMfJDeP/Xg8EYZJOrfoFS/vbUYy7rA2WFcSHQ
         xsL9MWk536KDRcU/JY8zguE0848nvpan9b7tk9o8g6ZccbN/XYRpZrSMQx/HNkTvFunc
         590R/45JEiKFOxrSUGRzMuI57rCsjfuGP4WhJS4YVYThyk6e7xiSEr9vwD2vfAIfZvL9
         78+d8MwK/ZMVjtIkZ7yI7I7NEYdkVtcf0u/0bAXds0+sbKMloMhNLAXwEiJcFle32BVn
         3pKfdbx96V8Jay8+VH/IFz6fKWDWrOopXfCIbDxE9sqNEN4lQwgzRzA6ndj8e4gemnwL
         EmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KF1X/3cj948PjMeFbZfRlquxhga99uxMWr3+oeJo3s0=;
        b=jDdG/eyTeyb2TitxKVtCgZYKMhFQQFwMo6V1vqCmjqkjYBLAUZZN3Rn+sa1PBMbBwI
         8gudMUG1iRXTCLSvyPyzRqIUmOOmDc5WMxvTl5lw3CvHh+5L+cAKEE8aoucYjVp0UiKw
         CRTJq/sndma/qUKtW/txql8x7xTKiwMGVs1nraTZQIRP6F92pSTf/VzwLmlPqeMtlXbo
         ceGqeWRS9TQHmhv0DmgNxDqhqpiHV2sMxylsQ0tkpZtdTMXx+YJOIQn5//a0VCCV4Ry5
         RZ2iXZMN5uD5DQZTYvNiYMbzAvK9PIqdjMYJ7ELw8hxTVRu8AD/RydeZsV91NYLWKwFE
         0R8Q==
X-Gm-Message-State: AJcUukeYylRUoo4LsLxgKZc3OHQr/3Iz+ua+Kxi9cKN9PxIbEA72XWnr
        qGQI+2hzQou4ezCtlpI1k0MVNm1OOZcLf+nO69o3Biy1
X-Google-Smtp-Source: ALg8bN7FU8oOdQZnUAXmiYPg3p0yWdVj2YngiQneYml9cjWV6TAYvY+/AgfilrX2oHq7gRPWkDTlYkWQK1Q+kior4os=
X-Received: by 2002:a9d:715d:: with SMTP id y29mr37903772otj.148.1549288749719;
 Mon, 04 Feb 2019 05:59:09 -0800 (PST)
MIME-Version: 1.0
References: <20190129102521.4141-1-linux.amoon@gmail.com> <20190129102521.4141-2-linux.amoon@gmail.com>
In-Reply-To: <20190129102521.4141-2-linux.amoon@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 4 Feb 2019 14:58:58 +0100
Message-ID: <CAFBinCDj=Y9HWEhJYMjo9FviAosxpHW5d61CceZ7HPV4ObZ79Q@mail.gmail.com>
Subject: Re: [PATCHv3 1/2] ARM64: dts: meson-gxbb-odroidc2: Fix usb phy reset warning
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On Tue, Jan 29, 2019 at 11:25 AM Anand Moon <linux.amoon@gmail.com> wrote:
>
> Add missing vin-supply node 5.0V regulator setting to power
> to usb ports, changes help fix the usb reset warning.
>
> [  795.380156] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> [  798.356073] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> [  801.331999] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> [  804.307919] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> [  807.283844] usb 1-1.2: reset high-speed USB device number 3 using dwc2
>
> Fixes: 5a0803bd5ae (ARM64: dts: meson-gxbb-odroidc2: Enable USB Nodes)
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> changes from prevoius
>
>  regulator                      use open bypass  opmode voltage current     min     max
> ---------------------------------------------------------------------------------------
>  regulator-dummy                  5    4      0 unknown     0mV     0mA     0mV     0mV
>     c9100000.usb                  1                                 0mA     0mV     0mV
>     c9100000.usb                  1                                 0mA     0mV     0mV
>     c9000000.usb                  1                                 0mA     0mV     0mV
>     c9000000.usb                  1                                 0mA     0mV     0mV
>  P5V0                             1    1      0 unknown  5000mV     0mA  5000mV  5000mV
>     USB_OTG_PWR                   4    2      0 unknown  5000mV     0mA  5000mV  5000mV
>        phy-c0000020.phy.1         2                                 0mA     0mV     0mV
>        phy-c0000000.phy.0         2                                 0mA     0mV     0mV
> --
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> index 2e1cd5e3a246..da729ed00408 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> @@ -28,6 +28,13 @@
>                 reg = <0x0 0x0 0x0 0x80000000>;
>         };
>
> +       p5v0: regulator-p5v0 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "P5V0";
> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;
> +       };
> +
>         usb_otg_pwr: regulator-usb-pwrs {
>                 compatible = "regulator-fixed";
>
> @@ -36,6 +43,8 @@
>                 regulator-min-microvolt = <5000000>;
>                 regulator-max-microvolt = <5000000>;
>
> +               vin-supply = <&p5v0>;
did you find out why this patch fixes the USB_OTG_PWR regulator?
based on just reading the patch I can't find an explanation myself

have you tested without this patch to rule out that you hit some bug
in the regulator framework back when you wrote the patch?
(I don't have an Odroid-C2 so I can't test this myself).


Regards
Martin
