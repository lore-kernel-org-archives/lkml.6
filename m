Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753183AbeDRX3T (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 19:29:19 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:46641 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753038AbeDRX3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 19:29:17 -0400
X-Google-Smtp-Source: AIpwx48vrYtLNyt2KTtZPYSraj/58Lzn8bpWJ22AW2YrySJ7RCCsqBbba+qjksxqSoP3ophF0x5OEg==
From: Evan Green <evgreen@chromium.org>
To: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Guenter Roeck <groeck@chromium.org>, Evan Green <evgreen@chromium.org>
Subject: [PATCH] soc: Unconditionally include qcom Makefile
Date: Wed, 18 Apr 2018 16:28:47 -0700
Message-Id: <20180418232847.17020-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.13.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <groeck@chromium.org>

Incoming Qualcomm changes for GENI, i2c [1], and cmd-db [2] are enabled
with COMPILE_TEST in drivers/soc/qcom. For this to work, the Makefile
in that directory has to be included unconditionally, rather than only
if ARCH_QCOM is enabled.

Example of the errors seen on allmodconfig with the GENI, i2c, and
cmd-db patches applied:

Kernel: arch/x86/boot/bzImage is ready  (#1)
ERROR: "geni_se_select_mode" [drivers/tty/serial/qcom_geni_serial.ko] undefined!
ERROR: "geni_se_init" [drivers/tty/serial/qcom_geni_serial.ko] undefined!
ERROR: "geni_se_config_packing" [drivers/tty/serial/qcom_geni_serial.ko] undefined!
ERROR: "geni_se_resources_on" [drivers/tty/serial/qcom_geni_serial.ko] undefined!
ERROR: "geni_se_resources_off" [drivers/tty/serial/qcom_geni_serial.ko] undefined!
ERROR: "geni_se_tx_dma_unprep" [drivers/i2c/busses/i2c-qcom-geni.ko] undefined!
ERROR: "geni_se_tx_dma_prep" [drivers/i2c/busses/i2c-qcom-geni.ko] undefined!
ERROR: "geni_se_rx_dma_unprep" [drivers/i2c/busses/i2c-qcom-geni.ko] undefined!
ERROR: "geni_se_rx_dma_prep" [drivers/i2c/busses/i2c-qcom-geni.ko] undefined!
ERROR: "geni_se_select_mode" [drivers/i2c/busses/i2c-qcom-geni.ko] undefined!
ERROR: "geni_se_config_packing" [drivers/i2c/busses/i2c-qcom-geni.ko] undefined!
ERROR: "geni_se_init" [drivers/i2c/busses/i2c-qcom-geni.ko] undefined!
ERROR: "geni_se_resources_off" [drivers/i2c/busses/i2c-qcom-geni.ko] undefined!
ERROR: "geni_se_resources_on" [drivers/i2c/busses/i2c-qcom-geni.ko] undefined!
make[1]: *** [scripts/Makefile.modpost:92: __modpost] Error 1
make: *** [Makefile:1237: modules] Error 2

[1] https://patchwork.ozlabs.org/cover/893437/
[2] https://lkml.org/lkml/2018/4/10/714

Signed-off-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Evan Green <evgreen@chromium.org>
---
 drivers/soc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 40523577bdaa..113e884697fd 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -14,7 +14,7 @@ obj-$(CONFIG_ARCH_MXC)		+= imx/
 obj-$(CONFIG_SOC_XWAY)		+= lantiq/
 obj-y				+= mediatek/
 obj-$(CONFIG_ARCH_MESON)	+= amlogic/
-obj-$(CONFIG_ARCH_QCOM)		+= qcom/
+obj-y				+= qcom/
 obj-y				+= renesas/
 obj-$(CONFIG_ARCH_ROCKCHIP)	+= rockchip/
 obj-$(CONFIG_SOC_SAMSUNG)	+= samsung/
-- 
2.17.0.484.g0c8726318c-goog
