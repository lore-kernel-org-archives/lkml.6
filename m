Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751507AbeBWBRf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 20:17:35 -0500
Received: from mx.socionext.com ([202.248.49.38]:37509 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751387AbeBWBRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 20:17:24 -0500
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH v2 0/2] ASoC: add support for ROHM BD28623 codec
Date: Fri, 23 Feb 2018 10:17:15 +0900
Message-Id: <20180223011717.2799-1-suzuki.katsuhiro@socionext.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for ROHM BD28623MUV class D speaker
amplifier codec driver.

This driver only refers information of HW specification document
that can be derivered at website of ROHM.

http://www.rohm.com/web/global/products/-/product/BD28623MUV

---

Changes in v2:
  - Change gpio properties to optional
  - Change VCCA, VCCP-supply to mandatory
  - Fix lisence comment style
  - Use _cansleep() version for manipulating GPIO
  - Use ASoC component remove() function instead of
    platform remove() function to power off this IC
  - Remove update function that was just alias of gpiod_set_value


Katsuhiro Suzuki (2):
  ASoC: add DT bindings documentation for ROHM BD28623 codec
  ASoC: support ROHM BD28623 codec

 .../devicetree/bindings/sound/rohm,bd28623.txt     |  29 +++
 sound/soc/codecs/Kconfig                           |   8 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/bd28623.c                         | 242 +++++++++++++++++++++
 4 files changed, 281 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rohm,bd28623.txt
 create mode 100644 sound/soc/codecs/bd28623.c

-- 
2.16.1
