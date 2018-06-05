Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752264AbeFETJb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 15:09:31 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35633 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751915AbeFETJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 15:09:30 -0400
X-Google-Smtp-Source: ADUXVKIFGoorStCWkgmrNN19zCrjFRxDhDgk8ib1IqDRjmIFf8fcenheMnkEEN3wv5/TvSmbSQLfRUzanbgRFLd8Pr0=
MIME-Version: 1.0
In-Reply-To: <1528188743-12798-1-git-send-email-narmstrong@baylibre.com>
References: <1528188743-12798-1-git-send-email-narmstrong@baylibre.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 5 Jun 2018 21:09:09 +0200
Message-ID: <CAFBinCCF7v40PrtL3HVf9X-fEVx7P2uOVePa5wQ_y6s7uLKmnw@mail.gmail.com>
Subject: Re: [PATCH] ARM64: dts: meson-gxl-s905x-p212: Add phy-supply for usb0
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 10:52 AM, Neil Armstrong <narmstrong@baylibre.com> wrote:
> Like LibreTech-CC, the USB0 needs the 5V regulator to be enabled to power the
> devices on the P212 Reference Design based boards.
>
> Fixes: b9f07cb4f41f ("ARM64: dts: meson-gxl-s905x-p212: enable the USB controller")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

out of curiosity: I guess you tested this using u-boot?
if anyone else is interested: the only other way to test this is by
ensuring that the hdmi_5v regulator is turned off by Linux (by
removing it from the HDMI nodes) and then plugging in a USB device ->
if it doesn't get VBUS then the hdmi_5v regulator is the cause (and
needs to be kept/turned on by the USB code, just like Neil's patch
does)

> ---
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
> index 0cfd701..a1b3101 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
> @@ -189,3 +189,10 @@
>  &usb0 {
>         status = "okay";
>  };
> +
> +&usb2_phy0 {
> +       /*
> +        * HDMI_5V is also used as supply for the USB VBUS.
> +        */
> +       phy-supply = <&hdmi_5v>;
> +};
> --
> 2.7.4
>
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
