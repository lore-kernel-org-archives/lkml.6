Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71107C1B0FD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 294D92054F
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="S9Vm3z4B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbfARW3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 17:29:21 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38503 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729932AbfARW3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 17:29:20 -0500
Received: by mail-ot1-f65.google.com with SMTP id e12so15829198otl.5;
        Fri, 18 Jan 2019 14:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xuPmhton+yX3VA6muOEeXBbfE8RTlQObRyhUQXHiKAI=;
        b=S9Vm3z4BNCRj2UH7sKeYVNcKp749mkNvbKeIajajDIMj3p6qhIL8/xZ9wGNqq8rQHI
         9cOgtQliDJKqYfxcb+bWc5xKVrqdjtegGvDFwUnoqK23PliOwg0LEeaI8tt+vGKSkXiD
         dWf1kCtRn7nPdyMENuhdZlZFRKjeQGuIVQUxrZRN2EHYbtRCYh19JXf9kbgqXzfmNCX/
         BbqGcNCwbg92n7WMHGmWEv+O6xy3YvlU0D2vJua0R0aaoY4P0rFOM7R592fWXHXhBr8W
         cDvlB6wCTETA8hqyuN3c2VgOcawyaWtGFr9BLwjhLb7GwQHaiXc2VBBEC4ledKEY71R8
         6AFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xuPmhton+yX3VA6muOEeXBbfE8RTlQObRyhUQXHiKAI=;
        b=NKq/689Y6kSCItqOVP6AAomQe+isbQsBI2twVV8T/TyiBgE7uuqOUQ0W1Zwj2rLWpv
         1Hr4duQIy32+8/t0hmtVbjS0bT/DrRnc10NuJfLOMMZVvw7SQ7A/6+amVKgcf8U1718L
         /lN/mUZp/GPWhzEtm4PTRsn/3u9ieMKVbv7zX5Zf6IzWWUIlS2q0FGFBw1SuJuv8ZENS
         NfbBB0tKma0fPtTvqUkz5JHvUMRM2ikzLc6HmTOGaOHm7muD4YKnLXvYyZSJDAn1j1J7
         25dmMe+TZh2VsZOWY3LUCntyqdzX6cF+qzr8TZCgitcA3jVjDKZY6OlAQZBSxRACol/v
         CtbA==
X-Gm-Message-State: AJcUukcnlzcJ+V04/+nYZBuAQ1z7fdGgoajYFTqqTd+DAacrqIWYlng2
        4m6C7WPVjwjv7nC28KmhAcY80dNd6n+7UcOX2TgThIfL
X-Google-Smtp-Source: ALg8bN4d5HjHdtfOJ/6DIUBXOrk78hsXNjOMxJAiSXWGu4Ke5iRldaWx9dI1JkQakC2EzKqnce2wIn/ZBnn53shz6Vs=
X-Received: by 2002:a9d:a48:: with SMTP id 66mr12962970otg.308.1547850559350;
 Fri, 18 Jan 2019 14:29:19 -0800 (PST)
MIME-Version: 1.0
References: <20190113181808.5768-1-linux.amoon@gmail.com>
In-Reply-To: <20190113181808.5768-1-linux.amoon@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 18 Jan 2019 23:29:08 +0100
Message-ID: <CAFBinCCD4o0cXEht_7bgV6moCK2WfVRvZq8UUZD3gDo-TaRKbQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: meson8b: odroidc1: Enable usb phy node
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Emiliano Ingrassia <ingrassia@epigenesys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

thank you for this patch!

On Sun, Jan 13, 2019 at 7:18 PM Anand Moon <linux.amoon@gmail.com> wrote:
>
> Add missing vbus-supply link to phy controller for usb_phy0
> and usb_phy1 nodes, this changes fixed the power issue
> on usb ports usb, changes help fix usb reset warning.
I trust you on the fact that GPIOAO_5 controls VBUS of USB0 and USB1

to me the schematics are not 100% clear or I'm bad at interpreting them:
- I'll refer to odroid-c1+_rev0.4_20150615.pdf
- page 1 lists GPIOAO.BIT5 as input for the PWREN signal of the
USB_OTG controller (usb0)
- page 1 also shows a PWREN signal in the USB_HOST controller (usb1)
but not it's input
- based on your patch I assume that PWREN is the same signal for both
USB controllers

> [  821.991470] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> [  825.243385] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> [  828.151310] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> [  830.991241] usb 1-1.2: reset high-speed USB device number 3 using dwc2
>
> Fixes: 2eb79a4d15ff (ARM: dts: meson: enabling the USB Host controller on Odroid-C1/C1+ board)
you already split your original patch into two, however I suggest
splitting these patches differently:
- this one (personally I would choose "ARM: dts: meson8b: odroidc1:
fix USB VBUS supplies" as title), which contains the Fixes tag, adds
the "usb_vbus" and references it in the "usb0" and "usb1" nodes
- enables usb0_phy and usb0 as part of your second patch (I would call
that "ARM: dts: meson8b: odroidc1: enable the OTG capable USB
controller")

> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> Rebased on Kevin's amlogic/v5.0/fixes branch
>
> [alarm@archl-c1t ~]$ lsusb -t
> /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
>     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
>         |__ Port 1: Dev 4, If 0, Class=Mass Storage, Driver=usb-storage, 480M
>         |__ Port 3: Dev 3, If 0, Class=Video, Driver=uvcvideo, 480M
>         |__ Port 3: Dev 3, If 1, Class=Video, Driver=uvcvideo, 480M
>         |__ Port 3: Dev 3, If 2, Class=Audio, Driver=snd-usb-audio, 480M
>         |__ Port 3: Dev 3, If 3, Class=Audio, Driver=snd-usb-audio, 480M
> [alarm@archl-c1t ~]$
> [alarm@archl-c1t ~]$ lsusb -v|egrep "^Bus|MaxPower"
> Couldn't open device, some information will be missing
> Bus 001 Device 003: ID 1b71:0056 Fushicai
>     MaxPower              500mA
> Couldn't open device, some information will be missing
> Bus 001 Device 004: ID 152d:0578 JMicron Technology Corp. / JMicron USA Technology Corp. JMS567 SATA 6Gb/s bridge
>     MaxPower               30mA
> Couldn't open device, some information will be missing
> Couldn't open device, some information will be missing
> Bus 001 Device 002: ID 05e3:0610 Genesys Logic, Inc. 4-port hub
>     MaxPower              100mA
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
>     MaxPower                0mA
> ---
>  arch/arm/boot/dts/meson8b-odroidc1.dts | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
> index 0f0a46ddf3ff..a49a8509b288 100644
> --- a/arch/arm/boot/dts/meson8b-odroidc1.dts
> +++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
> @@ -83,6 +83,19 @@
>                 regulator-max-microvolt = <5000000>;
>         };
>
> +       usb_vbus: regulator-usb-vbus {
please add a comment here with some details about the regulator and
add a hint that the signal in the schematics is called "PWREN"

> +               compatible = "regulator-fixed";
> +
> +               regulator-name = "USB_VBUS";
> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;
> +
> +               vin-supply = <&p5v0>;
> +
> +               gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +       };
> +
>         tflash_vdd: regulator-tflash_vdd {
>                 /*
>                  * signal name from schematics: TFLASH_VDD_EN
> @@ -293,8 +306,18 @@
>         pinctrl-names = "default";
>  };
>
> +&usb0_phy {
> +       status = "okay";
> +       vbus-supply = <&usb_vbus>;
> +};
> +
>  &usb1_phy {
>         status = "okay";
> +       vbus-supply = <&usb_vbus>;
> +};
> +
> +&usb0 {
> +       status = "okay";
>  };
I believe there's a problem with the usb/usb_phy nodes here. on my
Odroid-C1 this results in:
# cat /sys/kernel/debug/regulator/regulator_summary | grep USB_VBUS
   USB_VBUS                      0    0      0 unknown  5000mV     0mA
 5000mV  5000mV
(open count is 0)

if I move "vbus-supply" to the "usb1" node (just as an example) then I get:
# cat /sys/kernel/debug/regulator/regulator_summary | grep USB_VBUS
   USB_VBUS                      1    1      0 unknown  5000mV     0mA
 5000mV  5000mV

unfortunately neither your original patch nor the modified version
seem to enable USB VBUS on my Odroid-C1.
I have documented my findings already back in December, see "USB
issues on Odroid-C1" [0]
help on that would be highly appreciated :)

on which board revision have you tested this patch?


Regards
Martin


[0] http://lists.infradead.org/pipermail/linux-amlogic/2018-December/009451.html
