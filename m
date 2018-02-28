Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932311AbeB1Oly (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 09:41:54 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33848 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932256AbeB1Ols (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 09:41:48 -0500
X-Google-Smtp-Source: AH8x226ue2bk3d5o497aOVG/ngWD+85SxikvtT80kIJMVIGJMmB24gY4ZlVxQCawKOWw1frtwveSjQ==
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>, cphealy@gmail.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 16/22] nvmem: meson-efuse: Do no gate COMPILE_TEST with MESON_SM
Date: Wed, 28 Feb 2018 06:41:00 -0800
Message-Id: <20180228144106.16363-17-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180228144106.16363-1-andrew.smirnov@gmail.com>
References: <20180228144106.16363-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Being able to build this driver when COMPILE_TEST is selected is still
useful even when MESON_SM is not selected, since selecting this
driver as a module and doing "make modules" will result in successful
build and would detect trivial coding errors. For an example of type
of errors that could be prevented see [1] and [2]

[1] lkml.kernel.org/r/20171227225956.14442-12-andrew.smirnov@gmail.com
[2] https://marc.info/?l=linux-arm-kernel&m=151461599104358&w=2

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Carlo Caione <carlo@caione.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: cphealy@gmail.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/nvmem/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index ff505af064ba..42e84e1b2a26 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -147,7 +147,7 @@ config NVMEM_VF610_OCOTP
 
 config MESON_EFUSE
 	tristate "Amlogic Meson GX eFuse Support"
-	depends on (ARCH_MESON || COMPILE_TEST) && MESON_SM
+	depends on (ARCH_MESON && MESON_SM) || COMPILE_TEST
 	help
 	  This is a driver to retrieve specific values from the eFuse found on
 	  the Amlogic Meson GX SoCs.
-- 
2.14.3
