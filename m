Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752111AbeBHJlf convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 04:41:35 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37675 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeBHJla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 04:41:30 -0500
X-Google-Smtp-Source: AH8x224uER5dFl/wCo62js/BZnOFXwkzC8d1JAXFzyAfQx1f3DSw7QHl0iSHGuKQWGex5huidU3dPQ==
MIME-Version: 1.0
In-Reply-To: <1836483.rFXKcXDauj@jernej-laptop>
References: <20180206131647.41700-1-icenowy@aosc.io> <20180208090042.364is5ctofhuao4i@flea>
 <9e77487f83b226ad7700715251178ce8@aosc.io> <1836483.rFXKcXDauj@jernej-laptop>
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 8 Feb 2018 17:41:06 +0800
X-Gmail-Original-Message-ID: <CAGb2v66bpo8V-e+br2aKcYXSjhte5sobizr_7QqnJWeY_58UOw@mail.gmail.com>
Message-ID: <CAGb2v66bpo8V-e+br2aKcYXSjhte5sobizr_7QqnJWeY_58UOw@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v4] ARM: sun8i: h2+: add support for
 Banana Pi M2 Zero board
To: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc: linux-sunxi <linux-sunxi@googlegroups.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 8, 2018 at 5:28 PM, Jernej Škrabec <jernej.skrabec@siol.net> wrote:
> Dne četrtek, 08. februar 2018 ob 10:15:35 CET je Icenowy Zheng napisal(a):
>> 在 2018-02-08 17:00，Maxime Ripard 写道：
>>
>> > On Tue, Feb 06, 2018 at 09:16:47PM +0800, Icenowy Zheng wrote:
>> >> Banana Pi M2 Zero board is a H2+-based board by Sinovoip, with a form
>> >> factor and GPIO holes similar to Raspberry Pi Zero.
>> >>
>> >> It features:
>> >> - Allwinner H2+ SoC
>> >> - Single-chip (16-bit) 512MiB DDR3 DRAM
>> >> - Ampak AP6212 Wi-Fi/Bluetooth module
>> >> - MicroSD slot
>> >> - Two MicroUSB Type-B ports (one can only be used to power the board
>> >> and
>> >>
>> >>   the other features OTG functionality)
>> >>
>> >> - Two keys, a reset and a GPIO-connected key.
>> >> - HDMI Type-C (miniHDMI) connector connected to the HDMI part of H2+.
>> >> - CSI connector to connect the camera sensor provided by Sinovoip.
>> >>
>> >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> >> ---
>> >> Changes in v4:
>> >> - Use SPDX license identifier.
>> >>
>> >> Changes in v3:
>> >> - Add comments about Vbus problem in &usbphy node.
>> >>
>> >> Changes in v2:
>> >> - Use high active SD card detect on the production batch.
>> >>
>> >>  arch/arm/boot/dts/Makefile                         |   1 +
>> >>  .../boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts    | 126
>> >>
>> >> +++++++++++++++++++++
>> >>
>> >>  2 files changed, 127 insertions(+)
>> >>  create mode 100644
>> >>
>> >> arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
>> >>
>> >> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> >> index ade7a38543dc..d5a17e6e8b0f 100644
>> >> --- a/arch/arm/boot/dts/Makefile
>> >> +++ b/arch/arm/boot/dts/Makefile
>> >> @@ -974,6 +974,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
>> >>
>> >>    sun8i-a83t-cubietruck-plus.dtb \
>> >>    sun8i-a83t-tbs-a711.dtb \
>> >>    sun8i-h2-plus-orangepi-r1.dtb \
>> >>
>> >> +  sun8i-h2-plus-bananapi-m2-zero.dtb \
>> >>
>> >>    sun8i-h2-plus-orangepi-zero.dtb \
>> >>    sun8i-h3-bananapi-m2-plus.dtb \
>> >>    sun8i-h3-beelink-x2.dtb \
>> >>
>> >> diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
>> >> b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
>> >> new file mode 100644
>> >> index 000000000000..e2ee65a5bf92
>> >> --- /dev/null
>> >> +++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
>> >> @@ -0,0 +1,126 @@
>> >> +/*
>> >> + * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
>> >> + *
>> >> + * Based on sun8i-h3-bananapi-m2-plus.dts, which is:
>> >> + *   Copyright (C) 2016 Chen-Yu Tsai <wens@csie.org>
>> >> + *
>> >> + * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> >
>> > Sorry to be a bit picky about this, but this should be your very first
>> > line, see arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts for
>> > example.
>>
>> I think it's also OK here, see
>> arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts.
>
> Lincesing rules [1] says it should be in first possible line which can contain
> comment.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/
> Documentation/process/license-rules.rst#n57

I confess I only read the license line rule some time after I posted that
patch.

ChenYu

>>
>> > Thanks!
>> > Maxime
>>
>> --
>> You received this message because you are subscribed to the Google Groups
>> "linux-sunxi" group. To unsubscribe from this group and stop receiving
>> emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
>> For more options, visit https://groups.google.com/d/optout.
>
>
>
>
