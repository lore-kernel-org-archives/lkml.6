Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB2CC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DFE82082B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TroZrxvj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DFE82082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbeLFHxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 02:53:03 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36448 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728939AbeLFHxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 02:53:03 -0500
Received: by mail-ot1-f68.google.com with SMTP id k98so21223118otk.3;
        Wed, 05 Dec 2018 23:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OqjGBGWfRfE4hUd0Qd7wegjOt7lanVKH0PY9FFXP+nE=;
        b=TroZrxvj5+dzbXYfceCoHXYREEpID70hyf66TTgaTBdug7iy0XSqpQ7jtb5r4rF8ET
         mlDlj8mn5N0Es1BdSwFSwLAzsuiOskmg/bW6U4+mS0yqNcEAR9AAS0Ystz/kaYKawiAw
         HcZ7BNoM0yc/Kd6Rgvnev497pdxbJNL+ZhEK11JCkkWEm6+Ka+Ij2GUCS0mpWX9yve4g
         nZl4cb/AGB/bKMrb7kqjxWyANs0rkKFn5n/pGTHuf+lDAlNsCVLpUqlhUXENp9mSXf8z
         C25v3yPPPlKOcjOZI2JTMIPbU+WjXNZrJW4j9rsEAXYmLDePMBBhCVNnXNrN6IUX3/Na
         to8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OqjGBGWfRfE4hUd0Qd7wegjOt7lanVKH0PY9FFXP+nE=;
        b=WNKq77TjtsIN3Lun+wLa86612Rk+Ppl7ax5I4N6RyCLAwkaKaCYPs/Ds1aCoYK5y02
         M02c3tKaiMpmJnf0/gv3m9j1ryG/iSnqvoboBqGwFdVYCQCexQUghyH9MRC4zkUHhKqU
         KpfAgIPUVuNvjWod+WkOeAgAjM+0AxaSFqlnolgrHYF+Hg03optCn7ajqQ7iE8I+yj/G
         kGVJdTMcJL/b72Owa2wvuv7/i0OaIUb5Hi/3qVGhLskSYvE3ka1aKJy9kPg19xxi/IB8
         XliO1kaz2hongHHeRY7UMfKJ3jmNvVzgzihijDhDaScoBxUBHOvW91h0Mii3/JvyiU08
         1dDQ==
X-Gm-Message-State: AA+aEWZPXH8n8euWmZtqYrv0pZWdVCeMZkI4IlFQrfGi1VdnfdBVnggT
        5UwfLD2f2olEMAIo9QTHr5oA5Li4tk6ZzFUaGys=
X-Google-Smtp-Source: AFSGD/VsordDfgn+MkfIFBf2WRhXiIySi6n6BBtmUsqzf1wNG/K+R3t9EgOSg+srWXezeBsU1fnhA3xofK33ZV/w6FU=
X-Received: by 2002:a9d:3b4b:: with SMTP id z69mr16559206otb.167.1544082780979;
 Wed, 05 Dec 2018 23:53:00 -0800 (PST)
MIME-Version: 1.0
References: <20181204194025.2719-1-linux.amoon@gmail.com> <CAJKOXPcT-x0JWVw2CaxHzSthxbp3sDRcsa4Nc5gHYqUy98b_yw@mail.gmail.com>
 <CANAwSgSSOmTbqS4WUYZHXdB8XL5fjoiGbrh3unxufQ0gZXBPkQ@mail.gmail.com> <CAJKOXPdvk0Kip-RrFF3cwTpuXnFFL2PEi1U57=vMzNY7HVjTGw@mail.gmail.com>
In-Reply-To: <CAJKOXPdvk0Kip-RrFF3cwTpuXnFFL2PEi1U57=vMzNY7HVjTGw@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Thu, 6 Dec 2018 13:22:48 +0530
Message-ID: <CANAwSgTcAhkdDcvDgJZwyBnto78M5csF+L4RB-s5NmLgCksupQ@mail.gmail.com>
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

On Wed, 5 Dec 2018 at 21:49, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Wed, 5 Dec 2018 at 17:11, Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > Hi Krzysztof,
> >
> > Thanks for your review.
> > .
> > On Wed, 5 Dec 2018 at 19:36, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > On Tue, 4 Dec 2018 at 20:40, Anand Moon <linux.amoon@gmail.com> wrote:
> > > >
> > > > Add suspend-to-mem node to regulator core to be enabled or disabled
> > > > during system suspend and also support changing the regulator operating
> > > > mode during runtime and when the system enter sleep mode.
> > > >
> > > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > > ---
> > > > Tested on Odroid U3+
> > > > ---
> > > >  .../boot/dts/exynos4412-odroid-common.dtsi    | 72 +++++++++++++++++++
> > > >  1 file changed, 72 insertions(+)
> > > >
> > > > diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > > index 2caa3132f34e..837713a2ec3b 100644
> > > > --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > > +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > > @@ -285,6 +285,9 @@
> > > >                                 regulator-min-microvolt = <1800000>;
> > > >                                 regulator-max-microvolt = <1800000>;
> > > >                                 regulator-always-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-on-in-suspend;
> > > > +                               };
> > >
> > > Driver does not support suspend_enable so this will be noop. We could
> > > add this for DT-correctness (and full description of HW) but then I
> > > need explanation why this regulator has to stay on during suspend.
> > >
> >
> > Well I tried to study the suspend/resume feature from
> > *arch/arm/boot/dts/exynos4412-midas.dtsi*
> > and them I tried to apply the same with this on Odroid-U3 boards and
> > test these changes.
>
> Midas DTSI clearly has bugs then.
>
> >
> > > >                         };
> > > >
> > > >                         ldo3_reg: LDO3 {
> > > > @@ -292,6 +295,9 @@
> > > >                                 regulator-min-microvolt = <1800000>;
> > > >                                 regulator-max-microvolt = <1800000>;
> > > >                                 regulator-always-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > >
> > > The same but with suspend_disable.
> > >
> > > I am not saying that these are wrong but I would be happy to see
> > > explanations why you chosen these particular properties.
> > >
> >
> > Well I was not aware on the regulator-always-on cannot be set to off
> > in suspend mode.
> > Will drop this in the future patch where regulator-always-on; is set.
> >
> > > >                         };
> > > >
> > > >                         ldo4_reg: LDO4 {
> > > > @@ -299,6 +305,9 @@
> > > >                                 regulator-min-microvolt = <2800000>;
> > > >                                 regulator-max-microvolt = <2800000>;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-on-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo5_reg: LDO5 {
> > > > @@ -307,6 +316,9 @@
> > > >                                 regulator-max-microvolt = <1800000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-on-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo6_reg: LDO6 {
> > > > @@ -314,6 +326,9 @@
> > > >                                 regulator-min-microvolt = <1000000>;
> > > >                                 regulator-max-microvolt = <1000000>;
> > > >                                 regulator-always-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-on-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo7_reg: LDO7 {
> > > > @@ -321,18 +336,27 @@
> > > >                                 regulator-min-microvolt = <1000000>;
> > > >                                 regulator-max-microvolt = <1000000>;
> > > >                                 regulator-always-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-on-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo8_reg: LDO8 {
> > > >                                 regulator-name = "VDD10_HDMI_1.0V";
> > > >                                 regulator-min-microvolt = <1000000>;
> > > >                                 regulator-max-microvolt = <1000000>;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo10_reg: LDO10 {
> > > >                                 regulator-name = "VDDQ_MIPIHSI_1.8V";
> > > >                                 regulator-min-microvolt = <1800000>;
> > > >                                 regulator-max-microvolt = <1800000>;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo11_reg: LDO11 {
> > > > @@ -340,6 +364,9 @@
> > > >                                 regulator-min-microvolt = <1800000>;
> > > >                                 regulator-max-microvolt = <1800000>;
> > > >                                 regulator-always-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo12_reg: LDO12 {
> > > > @@ -348,6 +375,9 @@
> > > >                                 regulator-max-microvolt = <3300000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo13_reg: LDO13 {
> > > > @@ -356,6 +386,9 @@
> > > >                                 regulator-max-microvolt = <1800000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo14_reg: LDO14 {
> > > > @@ -364,6 +397,9 @@
> > > >                                 regulator-max-microvolt = <1800000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo15_reg: LDO15 {
> > > > @@ -372,6 +408,9 @@
> > > >                                 regulator-max-microvolt = <1000000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo16_reg: LDO16 {
> > > > @@ -380,6 +419,9 @@
> > > >                                 regulator-max-microvolt = <1800000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-on-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo20_reg: LDO20 {
> > > > @@ -387,6 +429,9 @@
> > > >                                 regulator-min-microvolt = <1800000>;
> > > >                                 regulator-max-microvolt = <1800000>;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo21_reg: LDO21 {
> > > > @@ -394,6 +439,9 @@
> > > >                                 regulator-min-microvolt = <2800000>;
> > > >                                 regulator-max-microvolt = <2800000>;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-on-in-suspend;
> > >
> > > That's unusual setting... enabled in suspend but not necessarily
> > > during work (no always-on).
> > >
> >
> > I kept the regulator required for emmc/sd card in
> > regulator-on-in-suspend in suspend mode.
> >
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo22_reg: LDO22 {
> > > > @@ -411,6 +459,9 @@
> > > >                                 regulator-max-microvolt = <1800000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         buck1_reg: BUCK1 {
> > > > @@ -419,6 +470,9 @@
> > > >                                 regulator-max-microvolt = <1100000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > >
> > > This is seriously wrong so I have doubts whether you tested the
> > > changes or you know what is happening with them. If you turn off
> > > memory bus regulator off, how the memory will work in
> > > Suspend-to-Memory mode?
> > >
> >
> > Well I did not find any issue in my testing but I might be wrong.
> > Ok I will drop this changes in the next version of the patch where
> > regulator-always-on is set.
>
> It worked fine because regulator-off-in-suspend is noop for buck1 but
> it is clearly wrong from logical point of view. Do you think that
> memory should be off in Suspend to RAM?
>
> > > >                         };
> > > >
> > > >                         buck2_reg: BUCK2 {
> > > > @@ -427,6 +481,9 @@
> > > >                                 regulator-max-microvolt = <1350000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-on-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         buck3_reg: BUCK3 {
> > > > @@ -435,6 +492,9 @@
> > > >                                 regulator-max-microvolt = <1050000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > >
> > > Looks suspicious as well.
> >
> > Ok I will drop this changes in the next version of the patch where
> > regulator-always-on is set.
> >
> > >
> > > Best regards,
> > > Krzysztof
> > >
> >
> > Well I have tested this patch as following
> > with only one issue, before enable suspend number of On-line cpu is 4
> > after resume number of On-line cpu is 1.
>
> If before your change number of resumed CPUs was 4, then you
> apparently break some things.
>

No bring of secondary cpu's is broken. I have check this without my dts changes.

[root@archlinux-u3 alarm]# echo 1 > /sys/power/pm_debug_messages
[root@archlinux-u3 alarm]# echo +30 > /sys/class/rtc/rtc0/wakealarm
[root@archlinux-u3 alarm]# echo -n mem > /sys/power/state
[   86.594308] PM: suspend entry (deep)
[   86.594762] PM: Syncing filesystems ... done.
[   86.899480] Freezing user space processes ... (elapsed 0.009 seconds) done.
[   86.911830] OOM killer disabled.
[   86.914121] Freezing remaining freezable tasks ... (elapsed 0.002
seconds) done.
[   86.921412] printk: Suspending console(s) (use no_console_suspend to debug)
[   86.971761] smsc95xx 1-2:1.0 eth0: entering SUSPEND2 mode
[   87.003552] dwc2 12480000.hsotg: suspending usb gadget g_ether
[   87.004504] dwc2 12480000.hsotg: dwc2_hsotg_ep_disable: called for ep0
[   87.004521] dwc2 12480000.hsotg: dwc2_hsotg_ep_disable: called for ep0
[   87.004594] dwc2 12480000.hsotg: new device is full-speed
[   87.006402] wake enabled for irq 119
[   87.006503] BUCK9: No configuration
[   87.006592] BUCK8_P3V3: No configuration
[   87.006631] BUCK7_2.0V: No configuration
[   87.006667] BUCK6_1.35V: No configuration
[   87.006703] VDDQ_CKEM1_2_1.2V: No configuration
[   87.006830] LDO26: No configuration
[   87.006868] VDDQ_LCD_1.8V: No configuration
[   87.006905] LDO24: No configuration
[   87.006939] LDO23: No configuration
[   87.006977] LDO22_VDDQ_MMC4_2.8V: No configuration
[   87.007013] TFLASH_2.8V: No configuration
[   87.007048] LDO20_1.8V: No configuration
[   87.007083] LDO19: No configuration
[   87.007119] LDO18: No configuration
[   87.007154] LDO17: No configuration
[   87.007190] VDD18_HSIC_1.8V: No configuration
[   87.007226] VDD10_HSIC_1.0V: No configuration
[   87.007262] VDD18_ABB0_2_1.8V: No configuration
[   87.007298] VDDQ_C2C_W_1.8V: No configuration
[   87.007333] VDD33_USB_3.3V: No configuration
[   87.007369] VDD18_ABB1_1.8V: No configuration
[   87.007405] VDDQ_MIPIHSI_1.8V: No configuration
[   87.007441] LDO9: No configuration
[   87.007477] VDD10_HDMI_1.0V: No configuration
[   87.007512] VDD10_XPLL_1.0V: No configuration
[   87.007548] VDD10_MPLL_1.0V: No configuration
[   87.007583] VDDQ_MMC1_3_1.8V: No configuration
[   87.007619] VDDQ_MMC2_2.8V: No configuration
[   87.007655] VDDQ_EXT_1.8V: No configuration
[   87.007691] VDDQ_M1_2_1.8V: No configuration
[   87.007727] VDD_ALIVE_1.0V: No configuration
[   87.014494] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[   87.024071] usb3503 0-0008: switched to STANDBY mode
[   87.024739] wake enabled for irq 123
[   87.066437] samsung-pinctrl 11000000.pinctrl: Setting external
wakeup interrupt mask: 0xfbfff7ff
[   87.086663] Disabling non-boot CPUs ...
[   87.230744] Enabling non-boot CPUs ...
[   88.229226] CPU1: failed to boot: -110
[   88.231113] Error taking CPU1 up: -110
[   88.234223] ------------[ cut here ]------------
[   88.234267] WARNING: CPU: 2 PID: 0 at
arch/arm/include/asm/proc-fns.h:126 secondary_start_kernel+0x214/0x270
[   88.234273] Modules linked in:
[   89.229219] CPU2: failed to boot: -110
[   89.230012] Error taking CPU2 up: -110
[   90.229071] CPU3: failed to boot: -110
[   90.229823] Error taking CPU3 up: -110
[   90.234887] s3c-i2c 13860000.i2c: slave address 0x00
[   90.234917] s3c-i2c 13860000.i2c: bus frequency set to 390 KHz
[   90.234955] s3c-i2c 13870000.i2c: slave address 0x00
[   90.234975] s3c-i2c 13870000.i2c: bus frequency set to 97 KHz
[   90.235012] s3c-i2c 13880000.i2c: slave address 0x00
[   90.235031] s3c-i2c 13880000.i2c: bus frequency set to 97 KHz
[   90.235067] s3c-i2c 138e0000.i2c: slave address 0x00
[   90.235086] s3c-i2c 138e0000.i2c: bus frequency set to 97 KHz
[   90.255430] s3c-rtc 10070000.rtc: rtc disabled, re-enabling
[   90.255985] usb usb1: root hub lost power or was reset
[   90.261948] s3c2410-wdt 10060000.watchdog: watchdog disabled
[   90.262139] wake disabled for irq 123
[   90.273868] usb3503 0-0008: switched to HUB mode
[   90.364530] wake disabled for irq 119
[   90.364688] dwc2 12480000.hsotg: resuming usb gadget g_ether
[   90.649045] usb 1-2: reset high-speed USB device number 2 using exynos-ehci
[   91.001232] usb 1-3: reset high-speed USB device number 3 using exynos-ehci
[   91.539004] usb 1-3.3: reset high-speed USB device number 4 using exynos-ehci
[   92.027260] OOM killer enabled.
[   92.030413] Restarting tasks ... done.
[   92.078154] PM: suspend exit
[root@archlinux-u3 alarm]# [   92.451624] smsc95xx 1-2:1.0 eth0: link
up, 100Mbps, full-duplex, lpa 0xC5E1

Here is the summary of the regulator to be turned off during suspend
regulator-off-in-suspend
LDO1, LDO2, LDO3, LDO6, LDO7, LDO8, LDO10, LDO11, LDO12, LDO13, LDO14,
LDO15, LDO16, LDO20, LDO21, LDO22, LDO25,BUCK4, BUCK5, BUCK6, BUCK7,
regulator-on-in-suspend
LDO4, LDO5, LD021, BUCK1, BUCK2, BUCK3.

Please let me know if this would be fine with you, so that I could
send patch v2.

Best Regards
-Anand
