Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753747AbeBGJKk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 04:10:40 -0500
Received: from mx.socionext.com ([202.248.49.38]:3327 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753572AbeBGJKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 04:10:37 -0500
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [RESEND PATCH v2 0/9] add UniPhier audio system support
Date: Wed,  7 Feb 2018 18:10:40 +0900
Message-Id: <20180207091049.24700-1-suzuki.katsuhiro@socionext.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

This is the resend of patchset passed 3 weeks.
https://lkml.org/lkml/2018/1/19/122


This series adds support for Socionext audio system for
UniPhier LD11/LD20 SoCs. This driver supports I2S output
for Line-In, Line-Out and S/PDIF output.

UniPhier AIO DAI driver provides sound devices such as I2S, S/PDIF.
Since the AIO has mixed register map for those I/Os, it is hard to
split register areas for each sound devices.

---

Changes in v2:
  - Add comments to aiodma_irq()
  - Add members to struct uniphier_aio_sub and add methods
    for compress audio
  - Expose clocking to userspace
  - Fix bad name 'srcport' to 'src'
  - Split DMA, DAI patches from large one
  - Validate parameters in hw_params()
  - Add error checks
  - Fix typo in error messages
  - Change license comment style to C++ from C

Katsuhiro Suzuki (9):
  ASoC: uniphier: add DT bindings documentation for UniPhier AIO
  ASoC: uniphier: add support for UniPhier AIO common driver
  ASoC: uniphier: add support for UniPhier AIO DMA driver
  ASoC: uniphier: add support for UniPhier AIO CPU DAI driver
  ASoC: uniphier: add support for UniPhier AIO compress audio
  ASoC: uniphier: add support for UniPhier LD11/LD20 AIO driver
  arm64: dts: uniphier: add sound node for UniPhier
  arm64: dts: uniphier: add speaker out for UniPhier LD11/LD20 boards
  arm64: dts: uniphier: add compress audio out for UniPhier LD11/LD20

 .../devicetree/bindings/sound/uniphier,aio.txt     |   36 +
 .../boot/dts/socionext/uniphier-ld11-global.dts    |  120 +++
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi   |   31 +
 .../boot/dts/socionext/uniphier-ld20-global.dts    |  120 +++
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   |   35 +
 sound/soc/uniphier/Kconfig                         |   22 +
 sound/soc/uniphier/Makefile                        |    6 +
 sound/soc/uniphier/aio-compress.c                  |  440 ++++++++
 sound/soc/uniphier/aio-core.c                      | 1104 ++++++++++++++++++++
 sound/soc/uniphier/aio-cpu.c                       |  570 ++++++++++
 sound/soc/uniphier/aio-dma.c                       |  318 ++++++
 sound/soc/uniphier/aio-ld11.c                      |  431 ++++++++
 sound/soc/uniphier/aio-reg.h                       |  462 ++++++++
 sound/soc/uniphier/aio.h                           |  355 +++++++
 14 files changed, 4050 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/uniphier,aio.txt
 create mode 100644 sound/soc/uniphier/aio-compress.c
 create mode 100644 sound/soc/uniphier/aio-core.c
 create mode 100644 sound/soc/uniphier/aio-cpu.c
 create mode 100644 sound/soc/uniphier/aio-dma.c
 create mode 100644 sound/soc/uniphier/aio-ld11.c
 create mode 100644 sound/soc/uniphier/aio-reg.h
 create mode 100644 sound/soc/uniphier/aio.h

-- 
2.15.0
