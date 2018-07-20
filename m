Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A343FECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29BF72064D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29BF72064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbeGTJGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 05:06:10 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38038 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727762AbeGTJGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 05:06:10 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 101F2207AD; Fri, 20 Jul 2018 10:19:02 +0200 (CEST)
Received: from localhost (unknown [37.170.73.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6A78120618;
        Fri, 20 Jul 2018 10:19:00 +0200 (CEST)
Date:   Fri, 20 Jul 2018 10:18:59 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: at91: DT for 4.19
Message-ID: <20180720081859.GA22228@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, Olof,

Here are the unusually large DT PR for AT91. It contains mainly new DTs.

There is a pm.c change that I'm including here so it is along with the
corresponding DT changes.

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.19-dt

for you to fetch changes up to c8cbc1c20c29697e7335a5044fe6c60aa5c6e922:

  ARM: dts: at91: fix typos for SSC TD functions (2018-07-20 10:05:14 +0200)

----------------------------------------------------------------
AT91 DT for 4.19:

 - New boards from Laird: WB45N, WB50N, SOM60 modules and DVK, Gatwick
 - fix the PMC compatibles

----------------------------------------------------------------
Alexandre Belloni (4):
      dt-bindings: arm: remove PMC bindings
      dt-bindings: clk: at91: Document all the PMC compatibles
      ARM: at91: fix USB clock detection handling
      ARM: dts: fix PMC compatible

Ben Whitten (6):
      dt-bindings: add laird and giantec vendor prefix
      ARM: dts: at91: add labels to soc dtsi for derivative boards
      ARM: dts: add support for Laird WB45N cpu module and DVK
      ARM: dts: add support for Laird WB50N cpu module and DVK
      ARM: dts: add support for Gatwick board based on WB50N
      ARM: dts: add support for Laird SOM60 module and DVK boards

Claudiu Beznea (1):
      ARM: dts: at91: fix typos for SSC TD functions

 .../devicetree/bindings/arm/atmel-pmc.txt          |  14 --
 .../devicetree/bindings/clock/at91-clock.txt       |   9 +-
 .../devicetree/bindings/vendor-prefixes.txt        |   2 +
 arch/arm/boot/dts/Makefile                         |   4 +
 arch/arm/boot/dts/at91-dvk_som60.dts               |  95 +++++++++
 arch/arm/boot/dts/at91-dvk_su60_somc.dtsi          | 159 ++++++++++++++
 arch/arm/boot/dts/at91-dvk_su60_somc_lcm.dtsi      |  90 ++++++++
 arch/arm/boot/dts/at91-gatwick.dts                 | 121 +++++++++++
 arch/arm/boot/dts/at91-som60.dtsi                  | 230 +++++++++++++++++++++
 arch/arm/boot/dts/at91-wb45n.dts                   |  64 ++++++
 arch/arm/boot/dts/at91-wb45n.dtsi                  | 165 +++++++++++++++
 arch/arm/boot/dts/at91-wb50n.dts                   | 112 ++++++++++
 arch/arm/boot/dts/at91-wb50n.dtsi                  | 198 ++++++++++++++++++
 arch/arm/boot/dts/at91sam9261.dtsi                 |   2 +-
 arch/arm/boot/dts/at91sam9263.dtsi                 |   2 +-
 arch/arm/boot/dts/at91sam9rl.dtsi                  |   2 +-
 arch/arm/boot/dts/at91sam9x5.dtsi                  |   8 +-
 arch/arm/boot/dts/sama5d2-pinfunc.h                |   4 +-
 arch/arm/boot/dts/sama5d3.dtsi                     |   8 +-
 arch/arm/boot/dts/sama5d4.dtsi                     |   2 +-
 arch/arm/mach-at91/pm.c                            |   5 +
 21 files changed, 1263 insertions(+), 33 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/atmel-pmc.txt
 create mode 100644 arch/arm/boot/dts/at91-dvk_som60.dts
 create mode 100644 arch/arm/boot/dts/at91-dvk_su60_somc.dtsi
 create mode 100644 arch/arm/boot/dts/at91-dvk_su60_somc_lcm.dtsi
 create mode 100644 arch/arm/boot/dts/at91-gatwick.dts
 create mode 100644 arch/arm/boot/dts/at91-som60.dtsi
 create mode 100644 arch/arm/boot/dts/at91-wb45n.dts
 create mode 100644 arch/arm/boot/dts/at91-wb45n.dtsi
 create mode 100644 arch/arm/boot/dts/at91-wb50n.dts
 create mode 100644 arch/arm/boot/dts/at91-wb50n.dtsi

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
