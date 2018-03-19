Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933156AbeCSNRH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 09:17:07 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:38450 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932584AbeCSNRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 09:17:05 -0400
X-Google-Smtp-Source: AG47ELsSxTh27Au1TqqyPyX96uRL2G5ALGM+DMOLlyHfHd6lxAk4cOdhXswe39LRPbPW1zanGq/yKbGCWfapzyZR/vs=
MIME-Version: 1.0
In-Reply-To: <1521168778-27236-1-git-send-email-david@lechnology.com>
References: <1521168778-27236-1-git-send-email-david@lechnology.com>
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Mon, 19 Mar 2018 14:17:01 +0100
Message-ID: <CAMpxmJX-AxhpPpCnWoaSGYmNh3o8iRjdKacnmozsPWmhpcGdTg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v8_00=2F42=5D_ARM=3A_davinci=3A_convert_to_common?=
        =?UTF-8?Q?_clock_framework=E2=80=8B?=
To: David Lechner <david@lechnology.com>
Cc: linux-clk@vger.kernel.org,
        linux-devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>, Adam Ford <aford173@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-16 3:52 GMT+01:00 David Lechner <david@lechnology.com>:
> This series converts mach-davinci to use the common clock framework.
>
> The series works like this, the first 19 patches create new clock drivers
> using the common clock framework. There are basically 3 groups of clocks -
> PLL, PSC and CFGCHIP (syscon). There are six different SoCs that each have
> unique init data, which is the reason for so many patches.
>
> Then, starting with "ARM: davinci: pass clock as parameter to
> davinci_timer_init()", we get the mach code ready for the switch by adding the
> code needed for the new clock drivers and adding #ifndef CONFIG_COMMON_CLK
> around the legacy clocks so that we can switch easily between the old and the
> new.
>
> "ARM: davinci: switch to common clock framework" actually flips the switch
> to start using the new clock drivers. Then the next 8 patches remove all
> of the old clock code.
>
> The final three patches add device tree clock support to the one SoC that
> supports it.
>
> This series has been tested on LEGO MINDSTORMS EV3 (device tree) and TI
> OMAP-L138 LCDK (both device tree and legacy board file).
>

Hi David,

thanks, with the u-boot fix everything seems to work fine. I tested
da850-lcdk and da850-evm boards in DT and board file modes.

I'll be working with this series in the following days and will do
some thorough testing and rebase my aemif series on top of it. I'll
also use the recently merged reset support for board files to get rid
of the exported reset functions.

Thanks for your work!

Best regards,
Bartosz Golaszewski
