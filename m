Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbeCPHIS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 03:08:18 -0400
Received: from mx.socionext.com ([202.248.49.38]:27537 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750814AbeCPHIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 03:08:17 -0400
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Rob Herring <robh+dt@kernel.org>
Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH 0/2] add syscon property to binding document
Date: Fri, 16 Mar 2018 16:08:11 +0900
Message-Id: <20180316070813.17969-1-suzuki.katsuhiro@socionext.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds syscon property for specifying soc-glue core.

The soc-glue core is used for changing the state of S/PDIF signal
output pin to signal output state or Hi-Z state. After resetting of
SoC Hi-Z state is selected.

Currently, we set this mode in local changed U-Boot or some
bootloaders fixedly. This patch removes dependencies of bootloader
from UniPhier audio system driver.

Katsuhiro Suzuki (2):
  ASoC: uniphier: add syscon property to binding document
  ASoC: uniphier: add syscon property for UniPhier sound system

 .../devicetree/bindings/sound/uniphier,aio.txt      |  8 ++++++++
 sound/soc/uniphier/aio-core.c                       | 21 +++++++++++++++++++++
 sound/soc/uniphier/aio-cpu.c                        | 11 +++++++++++
 sound/soc/uniphier/aio-reg.h                        |  3 +++
 sound/soc/uniphier/aio.h                            |  2 ++
 5 files changed, 45 insertions(+)

-- 
2.16.2
