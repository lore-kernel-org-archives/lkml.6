Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A0DC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4BAE208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AK/oiRM5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4BAE208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbeLEQLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:11:33 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35391 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbeLEQLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:11:33 -0500
Received: by mail-oi1-f194.google.com with SMTP id v6so17993081oif.2;
        Wed, 05 Dec 2018 08:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RM0jifnXc+G3NF8Fp9TP8tFcZPa719v9l8BRJVmH86o=;
        b=AK/oiRM5Yk9KocpLRVCRLC5iOhoAJ6bODTrF5Jf9XwiqHoA/X3+A6hBQuMLXoeseP3
         obdJCKQTq9iM43kxBuy5SAyQUKeWlEAjWVu7bXWcIjfI6x22CMDY9CxqNnDHsYIMLEfk
         YnM6uklEdPmwBtJhPtm36dHpl79CRErstWWGrRbOL813yrU2KYsiuUehLlaC9Og5JyRd
         C5sMwDvH2NPwcr6Uo9W62PgsaSbHCBy4cOGjhUQnEqwJo9EvFQaF/nCu0vcMJUbhO3LK
         pwsTtshHT1F8dw1gz+WYl4NiL0IuEiIJ7T4GaH15zNbKBWVeGsquXRBAu8gzB6ORS3b5
         wdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RM0jifnXc+G3NF8Fp9TP8tFcZPa719v9l8BRJVmH86o=;
        b=rfUKeXe7TEQSKBT3+hHiL+aktgonmQRNV+YVhg3fYn3QADEtrzF4hOtMgMkey4wDjT
         gsaT7u3YC6a80GdvXOiVbMUSyAFJkXoCYVVwZxzKK/vRtIm3n6D7taFItjjDn5zNc2ga
         RVqX9ql7crF0vbgrEsoWQkDvcNdHNAL+m+AqjWdNwBty2VKigQqOkZsPFWJ198jzHiVf
         arPx+hfe0/q7Z/qVRM2/4wuzqw0x0Ku1cNZvArSowqrQXXt1A6VHz6ErWhkMwr6FCKUF
         oTeKkwBhN7fU1sh4VG+tGG5ZKr48+C2Gye+Sf9OeRjLndjSMJ4g+e73B3gBuXJ3fQxBg
         8fGw==
X-Gm-Message-State: AA+aEWaWs4hepbRLoHwPwSMVIELlwTU1FIMAbDOCNxnplJ4+hGbY/NNp
        gaz/JZkPlEX/osajWRH7HtveICqdUNFtoGNHKnNYWPqL
X-Google-Smtp-Source: AFSGD/VR5nmDnxBw8CMXD1NnWp5ZSpKNVHYpVp6+3OSn6Uibe+S3aUuo0SC71/FK244i7ZpaOp+uwS30vIFqb0MpiuE=
X-Received: by 2002:aca:915:: with SMTP id 21mr15587827oij.163.1544026291486;
 Wed, 05 Dec 2018 08:11:31 -0800 (PST)
MIME-Version: 1.0
References: <20181204194025.2719-1-linux.amoon@gmail.com> <CAJKOXPcT-x0JWVw2CaxHzSthxbp3sDRcsa4Nc5gHYqUy98b_yw@mail.gmail.com>
In-Reply-To: <CAJKOXPcT-x0JWVw2CaxHzSthxbp3sDRcsa4Nc5gHYqUy98b_yw@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 5 Dec 2018 21:41:19 +0530
Message-ID: <CANAwSgSSOmTbqS4WUYZHXdB8XL5fjoiGbrh3unxufQ0gZXBPkQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: exynos: Add proper regulator states for
 suspend-to-mem for odroid-u3
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for your review.
.
On Wed, 5 Dec 2018 at 19:36, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Tue, 4 Dec 2018 at 20:40, Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > Add suspend-to-mem node to regulator core to be enabled or disabled
> > during system suspend and also support changing the regulator operating
> > mode during runtime and when the system enter sleep mode.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > Tested on Odroid U3+
> > ---
> >  .../boot/dts/exynos4412-odroid-common.dtsi    | 72 +++++++++++++++++++
> >  1 file changed, 72 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > index 2caa3132f34e..837713a2ec3b 100644
> > --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > @@ -285,6 +285,9 @@
> >                                 regulator-min-microvolt = <1800000>;
> >                                 regulator-max-microvolt = <1800000>;
> >                                 regulator-always-on;
> > +                               regulator-state-mem {
> > +                                       regulator-on-in-suspend;
> > +                               };
>
> Driver does not support suspend_enable so this will be noop. We could
> add this for DT-correctness (and full description of HW) but then I
> need explanation why this regulator has to stay on during suspend.
>

Well I tried to study the suspend/resume feature from
*arch/arm/boot/dts/exynos4412-midas.dtsi*
and them I tried to apply the same with this on Odroid-U3 boards and
test these changes.

> >                         };
> >
> >                         ldo3_reg: LDO3 {
> > @@ -292,6 +295,9 @@
> >                                 regulator-min-microvolt = <1800000>;
> >                                 regulator-max-microvolt = <1800000>;
> >                                 regulator-always-on;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
>
> The same but with suspend_disable.
>
> I am not saying that these are wrong but I would be happy to see
> explanations why you chosen these particular properties.
>

Well I was not aware on the regulator-always-on cannot be set to off
in suspend mode.
Will drop this in the future patch where regulator-always-on; is set.

> >                         };
> >
> >                         ldo4_reg: LDO4 {
> > @@ -299,6 +305,9 @@
> >                                 regulator-min-microvolt = <2800000>;
> >                                 regulator-max-microvolt = <2800000>;
> >                                 regulator-boot-on;
> > +                               regulator-state-mem {
> > +                                       regulator-on-in-suspend;
> > +                               };
> >                         };
> >
> >                         ldo5_reg: LDO5 {
> > @@ -307,6 +316,9 @@
> >                                 regulator-max-microvolt = <1800000>;
> >                                 regulator-always-on;
> >                                 regulator-boot-on;
> > +                               regulator-state-mem {
> > +                                       regulator-on-in-suspend;
> > +                               };
> >                         };
> >
> >                         ldo6_reg: LDO6 {
> > @@ -314,6 +326,9 @@
> >                                 regulator-min-microvolt = <1000000>;
> >                                 regulator-max-microvolt = <1000000>;
> >                                 regulator-always-on;
> > +                               regulator-state-mem {
> > +                                       regulator-on-in-suspend;
> > +                               };
> >                         };
> >
> >                         ldo7_reg: LDO7 {
> > @@ -321,18 +336,27 @@
> >                                 regulator-min-microvolt = <1000000>;
> >                                 regulator-max-microvolt = <1000000>;
> >                                 regulator-always-on;
> > +                               regulator-state-mem {
> > +                                       regulator-on-in-suspend;
> > +                               };
> >                         };
> >
> >                         ldo8_reg: LDO8 {
> >                                 regulator-name = "VDD10_HDMI_1.0V";
> >                                 regulator-min-microvolt = <1000000>;
> >                                 regulator-max-microvolt = <1000000>;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> >                         };
> >
> >                         ldo10_reg: LDO10 {
> >                                 regulator-name = "VDDQ_MIPIHSI_1.8V";
> >                                 regulator-min-microvolt = <1800000>;
> >                                 regulator-max-microvolt = <1800000>;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> >                         };
> >
> >                         ldo11_reg: LDO11 {
> > @@ -340,6 +364,9 @@
> >                                 regulator-min-microvolt = <1800000>;
> >                                 regulator-max-microvolt = <1800000>;
> >                                 regulator-always-on;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> >                         };
> >
> >                         ldo12_reg: LDO12 {
> > @@ -348,6 +375,9 @@
> >                                 regulator-max-microvolt = <3300000>;
> >                                 regulator-always-on;
> >                                 regulator-boot-on;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> >                         };
> >
> >                         ldo13_reg: LDO13 {
> > @@ -356,6 +386,9 @@
> >                                 regulator-max-microvolt = <1800000>;
> >                                 regulator-always-on;
> >                                 regulator-boot-on;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> >                         };
> >
> >                         ldo14_reg: LDO14 {
> > @@ -364,6 +397,9 @@
> >                                 regulator-max-microvolt = <1800000>;
> >                                 regulator-always-on;
> >                                 regulator-boot-on;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> >                         };
> >
> >                         ldo15_reg: LDO15 {
> > @@ -372,6 +408,9 @@
> >                                 regulator-max-microvolt = <1000000>;
> >                                 regulator-always-on;
> >                                 regulator-boot-on;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> >                         };
> >
> >                         ldo16_reg: LDO16 {
> > @@ -380,6 +419,9 @@
> >                                 regulator-max-microvolt = <1800000>;
> >                                 regulator-always-on;
> >                                 regulator-boot-on;
> > +                               regulator-state-mem {
> > +                                       regulator-on-in-suspend;
> > +                               };
> >                         };
> >
> >                         ldo20_reg: LDO20 {
> > @@ -387,6 +429,9 @@
> >                                 regulator-min-microvolt = <1800000>;
> >                                 regulator-max-microvolt = <1800000>;
> >                                 regulator-boot-on;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> >                         };
> >
> >                         ldo21_reg: LDO21 {
> > @@ -394,6 +439,9 @@
> >                                 regulator-min-microvolt = <2800000>;
> >                                 regulator-max-microvolt = <2800000>;
> >                                 regulator-boot-on;
> > +                               regulator-state-mem {
> > +                                       regulator-on-in-suspend;
>
> That's unusual setting... enabled in suspend but not necessarily
> during work (no always-on).
>

I kept the regulator required for emmc/sd card in
regulator-on-in-suspend in suspend mode.

> > +                               };
> >                         };
> >
> >                         ldo22_reg: LDO22 {
> > @@ -411,6 +459,9 @@
> >                                 regulator-max-microvolt = <1800000>;
> >                                 regulator-always-on;
> >                                 regulator-boot-on;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> >                         };
> >
> >                         buck1_reg: BUCK1 {
> > @@ -419,6 +470,9 @@
> >                                 regulator-max-microvolt = <1100000>;
> >                                 regulator-always-on;
> >                                 regulator-boot-on;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
>
> This is seriously wrong so I have doubts whether you tested the
> changes or you know what is happening with them. If you turn off
> memory bus regulator off, how the memory will work in
> Suspend-to-Memory mode?
>

Well I did not find any issue in my testing but I might be wrong.
Ok I will drop this changes in the next version of the patch where
regulator-always-on is set.

> >                         };
> >
> >                         buck2_reg: BUCK2 {
> > @@ -427,6 +481,9 @@
> >                                 regulator-max-microvolt = <1350000>;
> >                                 regulator-always-on;
> >                                 regulator-boot-on;
> > +                               regulator-state-mem {
> > +                                       regulator-on-in-suspend;
> > +                               };
> >                         };
> >
> >                         buck3_reg: BUCK3 {
> > @@ -435,6 +492,9 @@
> >                                 regulator-max-microvolt = <1050000>;
> >                                 regulator-always-on;
> >                                 regulator-boot-on;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
>
> Looks suspicious as well.

Ok I will drop this changes in the next version of the patch where
regulator-always-on is set.

>
> Best regards,
> Krzysztof
>

Well I have tested this patch as following
with only one issue, before enable suspend number of On-line cpu is 4
after resume number of On-line cpu is 1.

# lscpu
Architecture:        armv7l
Byte Order:          Little Endian
CPU(s):              4
On-line CPU(s) list: 0-3
Thread(s) per core:  1
Core(s) per socket:  4
Socket(s):           1
Vendor ID:           ARM
Model:               0
Model name:          Cortex-A9
Stepping:            r3p0
CPU max MHz:         1704.0000
CPU min MHz:         200.0000
BogoMIPS:            48.00
Flags:               half thumb fastmult vfp edsp neon vfpv3 tls vfpd32
#
# echo 1 > /sys/power/pm_debug_messages
# echo +30 > /sys/class/rtc/rtc0/wakealarm
#  echo -n mem > /sys/power/state
[   86.584147] PM: suspend entry (deep)
[   86.584684] PM: Syncing filesystems ... done.
[   86.735819] Freezing user space processes ... (elapsed 0.003 seconds) done.
[   86.742319] OOM killer disabled.
[   86.744018] Freezing remaining freezable tasks ... (elapsed 0.002
seconds) done.
[   86.751479] printk: Suspending console(s) (use no_console_suspend to debug)
[   86.792770] smsc95xx 1-2:1.0 eth0: entering SUSPEND2 mode
[   86.821751] dwc2 12480000.hsotg: suspending usb gadget g_ether
[   86.822560] dwc2 12480000.hsotg: new device is full-speed
[   86.822666] dwc2 12480000.hsotg: dwc2_hsotg_ep_disable: called for ep0
[   86.822682] dwc2 12480000.hsotg: dwc2_hsotg_ep_disable: called for ep0
[   86.824507] wake enabled for irq 119
[   86.824592] BUCK9: No configuration
[   86.824672] BUCK8_P3V3: No configuration
[   86.824706] BUCK7_2.0V: No configuration
[   86.824738] BUCK6_1.35V: No configuration
[   86.824770] VDDQ_CKEM1_2_1.2V: No configuration
[   86.826766] LDO26: No configuration
[   86.826802] VDDQ_LCD_1.8V: No configuration
[   86.826834] LDO24: No configuration
[   86.826866] LDO23: No configuration
[   86.826898] LDO22_VDDQ_MMC4_2.8V: No configuration
[   86.826930] TFLASH_2.8V: No configuration
[   86.826962] LDO20_1.8V: No configuration
[   86.826994] LDO19: No configuration
[   86.827026] LDO18: No configuration
[   86.827057] LDO17: No configuration
[   86.827516] VDDQ_C2C_W_1.8V: No configuration
[   86.828324] VDDQ_MIPIHSI_1.8V: No configuration
[   86.828359] LDO9: No configuration
[   86.828818] VDDQ_MMC1_3_1.8V: No configuration
[   86.828851] VDDQ_MMC2_2.8V: No configuration
[   86.828884] VDDQ_EXT_1.8V: No configuration
[   86.828935] VDD_ALIVE_1.0V: No configuration
[   86.839760] usb3503 0-0008: switched to STANDBY mode
[   86.840336] wake enabled for irq 123
[   86.855834] samsung-pinctrl 11000000.pinctrl: Setting external
wakeup interrupt mask: 0xfbfff7ff
[   86.871661] Disabling non-boot CPUs ...
[   87.016430] Enabling non-boot CPUs ...
[   88.009557] CPU1: failed to boot: -110
[   88.010324] Error taking CPU1 up: -110
[   89.009841] CPU2: failed to boot: -110
[   89.011290] Error taking CPU2 up: -110
[   90.009615] CPU3: failed to boot: -110
[   90.010258] Error taking CPU3 up: -110
[   90.012152] s3c-i2c 13860000.i2c: slave address 0x00
[   90.012174] s3c-i2c 13860000.i2c: bus frequency set to 390 KHz
[   90.012208] s3c-i2c 13870000.i2c: slave address 0x00
[   90.012225] s3c-i2c 13870000.i2c: bus frequency set to 97 KHz
[   90.012257] s3c-i2c 13880000.i2c: slave address 0x00
[   90.012274] s3c-i2c 13880000.i2c: bus frequency set to 97 KHz
[   90.012306] s3c-i2c 138e0000.i2c: slave address 0x00
[   90.012323] s3c-i2c 138e0000.i2c: bus frequency set to 97 KHz
[   90.028694] s3c-rtc 10070000.rtc: rtc disabled, re-enabling
[   90.029174] usb usb1: root hub lost power or was reset
[   90.032911] s3c2410-wdt 10060000.watchdog: watchdog disabled
[   90.033064] wake disabled for irq 123
[   90.041886] usb3503 0-0008: switched to HUB mode
[   90.127583] wake disabled for irq 119
[   90.127865] dwc2 12480000.hsotg: resuming usb gadget g_ether
[   90.429505] usb 1-2: reset high-speed USB device number 2 using exynos-ehci
[   90.781458] usb 1-3: reset high-speed USB device number 3 using exynos-ehci
[   91.366725] OOM killer enabled.
[   91.369869] Restarting tasks ... done.
[   91.419515] PM: suspend exit
# [   92.229649] smsc95xx 1-2:1.0 eth0: link up, 100Mbps, full-duplex,
lpa 0xC5E1
# lscpu
Architecture:         armv7l
Byte Order:           Little Endian
CPU(s):               4
On-line CPU(s) list:  0
Off-line CPU(s) list: 1-3
Thread(s) per core:   1
Core(s) per socket:   1
Socket(s):            1
Vendor ID:            ARM
Model:                0
Model name:           Cortex-A9
Stepping:             r3p0
CPU max MHz:          1704.0000
CPU min MHz:          200.0000
BogoMIPS:             24.00
Flags:                half thumb fastmult vfp edsp neon vfpv3 tls vfpd32

Best Regards
-Anand
