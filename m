Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751540AbeDEV3u (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 17:29:50 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35101 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbeDEV3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 17:29:48 -0400
X-Google-Smtp-Source: AIpwx4+GLbtYb91ilcuNHDLppCITWh/bkxzPtWZnF4M6AYs61PLQtGNPY3SVoQmw5lJe7U2KU6EmWvcGvnxIAqbl5Xg=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3Cr34cOcUbxbznHHvUdz1qd0=YLBF8-cc6NF5cgFmK1g@mail.gmail.com>
References: <CAK8P3a3Cr34cOcUbxbznHHvUdz1qd0=YLBF8-cc6NF5cgFmK1g@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 5 Apr 2018 23:29:46 +0200
X-Google-Sender-Auth: _O09kikotZW7A8u_IaRKd-pWjrs
Message-ID: <CAK8P3a1XKmHjhPe=Vv2TsV_BtNo98M8DcdJqBEHwXRA=Tze73Q@mail.gmail.com>
Subject: Re: [GIT PULL 2/3] ARM: SoC platform updates for 4.17
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        arm-soc <arm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w35LTv4N022042

On Thu, Apr 5, 2018 at 11:22 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> The following changes since commit 661e50bc853209e41a5c14a290ca4decc43cbfd1:
>
>   Linux 4.16-rc4 (2018-03-04 14:54:11 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-soc
>
> for you to fetch changes up to cd903711fd9dce808b5cc07e509135886d962b0c:
>
>   arm: npcm: modify configuration for the NPCM7xx BMC. (2018-04-05
> 14:49:08 +0200)
>
> ----------------------------------------------------------------
> ARM: SoC platform updates for 4.17
>
> This release brings up a new platform based on the old ARM9 core: the
> Nuvoton NPCM is used as a baseboard management controller, competing
> with the better known ASpeed AST2xx series.
>
> Another important change is the addition of ARMv7-A based chips
> in mach-stm32. The older parts in this platform are ARMv7-M based
> microcontrollers, now they are expanding to general-purpose workloads.
>
> The other changes are the usual defconfig updates to enable additional
> drivers, lesser bugfixes. The largest updates as often are the ongoing
> OMAP cleanups, but we also have a number of changes for the older
> PXA and davinci platforms this time.
>
> For the Renesas shmobile/r-car platform, some new infrastructure
> is needed to make the watchdog work correctly.
>
> Supporting Multiprocessing on Allwinner A80 required a significant
> amount of new code, but is not doing anything unexpected.

One clear sign that the branch is indeed bigger than usual: the
shortlog+diffstat exceeds the 100KB limit for the linux-arm-kernel
mailing list.

Here is the shorter version:

$ git shortlog --no-merges -sne v4.16-rc4..armsoc-dt

    29 Gregory CLEMENT <gregory.clement@bootlin.com>
    28 Simon Horman <horms+renesas@verge.net.au>
    27 Fabio Estevam <fabio.estevam@nxp.com>
    24 Jacopo Mondi <jacopo+renesas@jmondi.org>
    22 Patrice Chotard <patrice.chotard@st.com>
    19 Michal Simek <michal.simek@xilinx.com>
    18 Sean Wang <sean.wang@mediatek.com>
    16 Geert Uytterhoeven <geert+renesas@glider.be>
    16 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
    15 Marcel Ziswiler <marcel.ziswiler@toradex.com>
    14 Chen-Yu Tsai <wens@csie.org>
    14 Maciej Purski <m.purski@samsung.com>
    10 Bartosz Golaszewski <brgl@bgdev.pl>
    10 Stefan Agner <stefan@agner.ch>
    10 Sylwester Nawrocki <s.nawrocki@samsung.com>
    10 Wolfram Sang <wsa+renesas@sang-engineering.com>
     9 Amelie Delaunay <amelie.delaunay@st.com>
     9 Dave Gerlach <d-gerlach@ti.com>
     9 Joel Stanley <joel@jms.id.au>
     9 Kishon Vijay Abraham I <kishon@ti.com>
     9 Quentin Schulz <quentin.schulz@bootlin.com>
     8 Andrew F. Davis <afd@ti.com>
     8 Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
     8 Marcus Cooper <codekipper@gmail.com>
     8 Niklas Cassel <niklas.cassel@axis.com>
     8 Peter Rosin <peda@axentia.se>
     7 Baolin Wang <baolin.wang@linaro.org>
     7 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
     7 Klaus Goger <klaus.goger@theobroma-systems.com>
     7 Linus Walleij <linus.walleij@linaro.org>
     7 Tero Kristo <t-kristo@ti.com>
     7 Viresh Kumar <viresh.kumar@linaro.org>
     6 Anson Huang <Anson.Huang@nxp.com>
     6 Baruch Siach <baruch@tkos.co.il>
     6 Krzysztof Kozlowski <krzk@kernel.org>
     6 Ludovic Barre <ludovic.barre@st.com>
     6 Rob Herring <robh@kernel.org>
     6 Tomer Maimon <tmaimon77@gmail.com>
     5 Jernej Skrabec <jernej.skrabec@siol.net>
     5 Jerome Brunet <jbrunet@baylibre.com>
     5 Joonas Kylmälä <joonas.kylmala@iki.fi>
     5 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
     5 Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
     5 Stefan Wahren <stefan.wahren@i2se.com>
     5 Yixun Lan <yixun.lan@amlogic.com>
     4 Benjamin Gaignard <benjamin.gaignard@st.com>
     4 Biju Das <biju.das@bp.renesas.com>
     4 Georgi Djakov <georgi.djakov@linaro.org>
     4 Harald Geyer <harald@ccbib.org>
     4 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
     4 Mikko Perttunen <mperttunen@nvidia.com>
     4 Neil Armstrong <narmstrong@baylibre.com>
     4 Rajendra Nayak <rnayak@codeaurora.org>
     4 Sebastian Reichel <sre@kernel.org>
     4 Simon Shields <simon@lineageos.org>
     4 Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
     3 Adam Ford <aford173@gmail.com>
     3 Giulio Benetti <giulio.benetti@micronovasrl.com>
     3 Hauke Mehrtens <hauke@hauke-m.de>
     3 Icenowy Zheng <icenowy@aosc.io>
     3 Jian Hu <jian.hu@amlogic.com>
     3 John Keeping <john@metanate.com>
     3 Lucas Stach <l.stach@pengutronix.de>
     3 Magnus Damm <damm+renesas@opensource.se>
     3 Marco Franchi <marcofrk@gmail.com>
     3 Marek Szyprowski <m.szyprowski@samsung.com>
     3 Ryder Lee <ryder.lee@mediatek.com>
     3 Sekhar Nori <nsekhar@ti.com>
     3 Tony Lindgren <tony@atomide.com>
     3 Vicente Bergas <vicencb@gmail.com>
     3 Yuantian Tang <andy.tang@nxp.com>
     2 Alexandre Belloni <alexandre.belloni@bootlin.com>
     2 Alexandre Torgue <alexandre.torgue@st.com>
     2 Andrey Smirnov <andrew.smirnov@gmail.com>
     2 Andrzej Hajda <a.hajda@samsung.com>
     2 Benoît Thébaudeau <benoit.thebaudeau.dev@gmail.com>
     2 Chris Zhong <zyw@rock-chips.com>
     2 Christian Hemp <c.hemp@phytec.de>
     2 Dien Pham <dien.pham.ry@renesas.com>
     2 Dien Pham <dien.pham.ry@rvc.renesas.com>
     2 Dinh Nguyen <dinguyen@kernel.org>
     2 Dmitry Osipenko <digetx@gmail.com>
     2 Emiliano Ingrassia <ingrassia@epigenesys.com>
     2 Fabrizio Castro <fabrizio.castro@bp.renesas.com>
     2 Heiko Stuebner <heiko@sntech.de>
     2 Jorge Ramirez-Ortiz <jramirez@baylibre.com>
     2 Jörg Krause <joerg.krause@embedded.rocks>
     2 Lei YU <mine260309@gmail.com>
     2 Lothar Waßmann <LW@KARO-electronics.de>
     2 Marco Franchi <marco.franchi@nxp.com>
     2 Marek Vasut <marek.vasut@gmail.com>
     2 Masahiro Yamada <yamada.masahiro@socionext.com>
     2 Miquel Raynal <miquel.raynal@bootlin.com>
     2 Preetham Ramchandra <pchandru@nvidia.com>
     2 Robin Murphy <robin.murphy@arm.com>
     2 Rui Miguel Silva <rui.silva@linaro.org>
     2 Shawn Guo <shawnguo@kernel.org>
     2 Shawn Lin <shawn.lin@rock-chips.com>
     2 Shunqian Zheng <zhengsq@rock-chips.com>
     2 Stefan Mavrodiev <stefan@olimex.com>
     2 Stefan Monnier <monnier@iro.umontreal.ca>
     2 Stefan Riedmueller <s.riedmueller@phytec.de>
     2 Suman Anna <s-anna@ti.com>
     2 Tuomas Tynkkynen <tuomas@tuxera.com>
     2 Wadim Egorov <w.egorov@phytec.de>
     1 Aapo Vienamo <aapo@tuxera.com>
     1 Andrea Merello <andrea.merello@gmail.com>
     1 Andrew Jeffery <andrew@aj.id.au>
     1 Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
     1 Bai Ping <ping.bai@nxp.com>
     1 Bartosz Golaszewski <bgolaszewski@baylibre.com>
     1 Bjorn Andersson <bjorn.andersson@linaro.org>
     1 Brendan Higgins <brendanhiggins@google.com>
     1 Brian Norris <briannorris@chromium.org>
     1 Chunfeng Yun <chunfeng.yun@mediatek.com>
     1 Craig Tatlor <ctatlor97@gmail.com>
     1 Daniele Debernardi <drebrez@gmail.com>
     1 David Lechner <david@lechnology.com>
     1 Dmitry Shmidt <dimitrysh@google.com>
     1 Emmanuel Vadot <manu@freebsd.org>
     1 Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
     1 Eric Anholt <eric@anholt.net>
     1 Felix Brack <fb@ltec.ch>
     1 Florian Fainelli <f.fainelli@gmail.com>
     1 Fugang Duan <fugang.duan@nxp.com>
     1 Henry Zhang <henryzhang62@gmail.com>
     1 Huazhong Tan <tanhuazhong@huawei.com>
     1 INAGAKI Hiroshi <musashino.open@gmail.com>
     1 Ian Ray <ian.ray@ge.com>
     1 Ilia Lin <ilialin@codeaurora.org>
     1 Jagan Teki <jagannadh.teki@gmail.com>
     1 Jelle van der Waa <jelle@vdwaa.nl>
     1 Jon Nettleton <jon@solid-run.com>
     1 Ken Chen <chen.kenyy@inventec.com>
     1 Ken Lin <yungching0725@gmail.com>
     1 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
     1 Leo Yan <leo.yan@linaro.org>
     1 Levin Du <djw@t-chip.com.cn>
     1 Linus Lüssing <linus.luessing@c0d3.blue>
     1 Martin Kaiser <martin@kaiser.cx>
     1 Martyn Welch <martyn.welch@collabora.co.uk>
     1 Mathieu Malaterre <malat@debian.org>
     1 Maxime Ripard <maxime.ripard@free-electrons.com>
     1 Michael Lyle <mlyle@lyle.org>
     1 Murali Karicheri <m-karicheri2@ti.com>
     1 Nicolas Ferre <nicolas.ferre@microchip.com>
     1 Nobuhiro Iwamatsu <nobuhiro.iwamatsu@cybertrust.co.jp>
     1 P L Sai Krishna <lakshmi.sai.krishna.potthuri@xilinx.com>
     1 Pavel Machek <pavel@ucw.cz>
     1 Peter Senna Tschudin <peter.senna@collabora.com>
     1 Peter Ujfalusi <peter.ujfalusi@ti.com>
     1 Philipp Puschmann <pp@emlix.com>
     1 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
     1 Ravikumar Kattekola <rk@ti.com>
     1 Roger Quadros <rogerq@ti.com>
     1 Roy Pledge <roy.pledge@nxp.com>
     1 Russell King <rmk+kernel@arm.linux.org.uk>
     1 Russell King <rmk+kernel@armlinux.org.uk>
     1 Ryan Harkin <ryan.harkin@linaro.org>
     1 Santiago Esteban <Santiago.Esteban@microchip.com>
     1 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
     1 Shyam Saini <shyam@amarulasolutions.com>
     1 Sudeep Holla <sudeep.holla@arm.com>
     1 Takeshi Kihara <takeshi.kihara.df@renesas.com>
     1 Thierry Reding <treding@nvidia.com>
     1 Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
     1 Zhang Ying-22455 <ying.zhang22455@nxp.com>
     1 Zhiyong Tao <zhiyong.tao@mediatek.com>
     1 oscardagrach <ryan@edited.us>

$ git diff --dirstat=0 v4.16-rc4..armsoc-dt
   0.0% Documentation/devicetree/bindings/arm/cpu-enable-method/
   0.0% Documentation/devicetree/bindings/arm/mediatek/
   0.0% Documentation/devicetree/bindings/arm/npcm/
   0.0% Documentation/devicetree/bindings/arm/omap/
   0.0% Documentation/devicetree/bindings/arm/samsung/
   0.0% Documentation/devicetree/bindings/arm/tegra/
   0.2% Documentation/devicetree/bindings/arm/
   0.0% Documentation/devicetree/bindings/bus/
   0.0% Documentation/devicetree/bindings/crypto/
   0.0% Documentation/devicetree/bindings/dma/
   0.0% Documentation/devicetree/bindings/gpu/
   0.0% Documentation/devicetree/bindings/memory-controllers/ti/
   0.0% Documentation/devicetree/bindings/phy/
   0.0% Documentation/devicetree/bindings/pinctrl/
   0.0% Documentation/devicetree/bindings/sound/
   0.0% Documentation/devicetree/bindings/watchdog/
  75.5% arch/arm/boot/dts/
   0.0% arch/arm/configs/
   1.0% arch/arm64/boot/dts/allwinner/
   0.0% arch/arm64/boot/dts/altera/
   4.4% arch/arm64/boot/dts/amlogic/
   0.0% arch/arm64/boot/dts/arm/
   0.2% arch/arm64/boot/dts/exynos/
   0.6% arch/arm64/boot/dts/freescale/
   0.2% arch/arm64/boot/dts/hisilicon/
   3.0% arch/arm64/boot/dts/marvell/
   1.7% arch/arm64/boot/dts/mediatek/
   1.0% arch/arm64/boot/dts/nvidia/
   0.1% arch/arm64/boot/dts/qcom/
   3.7% arch/arm64/boot/dts/renesas/
   1.3% arch/arm64/boot/dts/rockchip/
   0.8% arch/arm64/boot/dts/socionext/
   0.4% arch/arm64/boot/dts/sprd/
   3.6% arch/arm64/boot/dts/xilinx/
   0.0% arch/arm64/
   0.0% drivers/clk/imx/
   0.0% drivers/soc/amlogic/
   0.7% include/dt-bindings/clock/
   0.1% include/dt-bindings/gpio/
   0.0% include/dt-bindings/mfd/
   0.0% include/dt-bindings/power/
   0.3% include/dt-bindings/reset/
