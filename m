Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B45C6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 02:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 197A82082B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 02:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 197A82082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbeJaLaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 07:30:16 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41041 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbeJaLaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 07:30:16 -0400
Received: by mail-ed1-f68.google.com with SMTP id x31-v6so12306535edd.8;
        Tue, 30 Oct 2018 19:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6xev504+9+t26CT3h73rk74WjG5WJeIvT+HvtmntYd8=;
        b=Z/lL9RjQMOD7RU6AeZzPmZtJMJu/2gncI/tqfD8fE0pVcObWnwM9KbI93vP5r748Cu
         XDUKRewL/PenuFxme/73Cww84DIysFwAwlY8oGbOVHCpz5WKCE/mYGsrAfQY3iOyIUvr
         mo5AKHtBtCEUtLLVcDU6S/sEkKk5lCKkyfTFxdp0DUw3gSMYZlsuy7Jz5Cev8HdKlbYC
         cMSY4jo1GXFjDKkwMWNwBK1eYd1dQoJE7Q65GEYu6jqHkWrgTHKVY/2ibj8JKNrAnoet
         8CKXwMBMohj+j/62c8a8joA0TYSWqBYzzI1J2c6r+2ezNfe6pwvpd4n3ttbHw9nMTnjT
         dQOA==
X-Gm-Message-State: AGRZ1gIjPXN/SWAunDIWKFcFm2WGwtZIqJAaLwrZwkYq598x/Yyv+Ckb
        jmUDvbHm6qW/hx1g6Gp3uea6M40p2kw=
X-Google-Smtp-Source: AJdET5cwnA9z4MA9CMWU+DtTFqotMPGJIffVH4NEN0Z8aglbRh67vZAiSy/Jlf+GLulmjQ3LNnnFcw==
X-Received: by 2002:a50:aa98:: with SMTP id q24-v6mr581493edc.93.1540953253696;
        Tue, 30 Oct 2018 19:34:13 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id w31-v6sm8409458edb.8.2018.10.30.19.34.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 19:34:12 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id r10-v6so14753286wrv.6;
        Tue, 30 Oct 2018 19:34:12 -0700 (PDT)
X-Received: by 2002:a5d:4844:: with SMTP id n4-v6mr1030928wrs.28.1540953252313;
 Tue, 30 Oct 2018 19:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <20181023185330.10472-1-oskari@lemmela.net> <20181025133017.2rdnbgmvdlx67kcz@earth.universe>
In-Reply-To: <20181025133017.2rdnbgmvdlx67kcz@earth.universe>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 31 Oct 2018 10:33:58 +0800
X-Gmail-Original-Message-ID: <CAGb2v64oGFyUenJ9-054RCXoG0Z+z5ziiTiL95Ga-5yy3xFyxw@mail.gmail.com>
Message-ID: <CAGb2v64oGFyUenJ9-054RCXoG0Z+z5ziiTiL95Ga-5yy3xFyxw@mail.gmail.com>
Subject: Re: [PATCH v5 00/11] AXP8x3 AC and battery power supply support
To:     sebastian.reichel@collabora.com, oskari@lemmela.net
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 3:08 AM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> Patches 1, 2 & 9 look good to me and do not seem to have any
> dependencies. I plan to merge them after the merge window
> for 4.20 closes.

Patches 2, 3 & 4 aren't needed. They aren't in the correct format
for model-specific + fallback compatibles either.

ChenYu

>
> -- Sebastian
>
> On Tue, Oct 23, 2018 at 09:53:19PM +0300, Oskari Lemmela wrote:
> > AXP813 AC power supply support with input current and
> > voltage limiting support.
> >
> > AXP803 AC and battery power supply support.
> >
> > Changes in v5:
> > * Return correct input current limit for values 0x6 and 0x7
> > * Add specific compatibles for AXP803
> > * Change commit messages
> > * Add Vasily Khoruzhick Pinebook DTS patch
> >
> > Changes in v4:
> > * Change order of axp20x-gpio in axp20x.c
> > * Fix indentation and spaces to tabs in axp20x.c
> >
> > Changes in v3:
> > * Reorder ac_power_supply DT node
> > * Rename axp20x_ac_power_set_property function
> > * Split mfd commit
> >
> > Changes in v2:
> > * Reuse axp813 compatibles for axp803
> > * Refactor axp20x_ac_power.c
> >
> > Oskari Lemmela (10):
> >   dt-bindings: power: supply: axp20x: add AXP813 AC power DT binding
> >   dt-bindings: power: supply: axp20x: add AXP803 power bindings
> >   dt-bindings: gpio: gpio-axp209: add AXP803 GPIO bindings
> >   dt-bindings: iio: adc: add AXP803 ADC bindings
> >   ARM: dts: axp81x: add AC power supply subnode
> >   arm64: dts: allwinner: axp803: add AC and battery power supplies
> >   arm64: dts: allwinner: a64: sopine-baseboard: enable power supplies
> >   power: supply: add AC power supply driver for AXP813
> >   mfd: axp20x: Add AC power supply cell for AXP813
> >   mfd: axp20x: Add supported cells for AXP803
> >
> > Vasily Khoruzhick (1):
> >   arm64: dts: allwinner: a64: pinebook: enable power supplies
> >
> >  .../devicetree/bindings/gpio/gpio-axp209.txt  |  2 +
> >  .../bindings/iio/adc/axp20x_adc.txt           |  2 +
> >  .../bindings/power/supply/axp20x_ac_power.txt |  4 +
> >  .../bindings/power/supply/axp20x_battery.txt  |  1 +
> >  arch/arm/boot/dts/axp81x.dtsi                 |  5 +
> >  arch/arm64/boot/dts/allwinner/axp803.dtsi     | 33 +++++++
> >  .../dts/allwinner/sun50i-a64-pinebook.dts     |  8 ++
> >  .../allwinner/sun50i-a64-sopine-baseboard.dts |  8 ++
> >  drivers/mfd/axp20x.c                          | 20 ++++
> >  drivers/power/supply/axp20x_ac_power.c        | 94 +++++++++++++++++++
> >  include/linux/mfd/axp20x.h                    |  1 +
> >  11 files changed, 178 insertions(+)
> >
> > --
> > 2.17.1
> >
