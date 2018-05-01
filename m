Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753120AbeEADBj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 23:01:39 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42485 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751693AbeEADBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 23:01:36 -0400
X-Google-Smtp-Source: AB8JxZqz3kLNyEuVWodH/VK0pA8CRFFXXquPZpQpM0+ZTtZs/tCmBVLonj2/AjO1eMJkteiMS7hUVQ==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: linus.walleij@linaro.org, afaerber@suse.de, rdunlap@infradead.org,
        sfr@canb.auug.org.au
Cc: linux-next@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH][next] pinctrl: actions: Fix Kconfig dependency and help text
Date: Tue,  1 May 2018 08:30:47 +0530
Message-Id: <20180501030047.305-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Fix Kconfig dependency for Actions Semi S900 pinctrl driver which
generates below warning in x86:

WARNING: unmet direct dependencies detected for PINCTRL_OWL
  Depends on [n]: PINCTRL [=y] && (ARCH_ACTIONS || COMPILE_TEST [=n]) && OF [=n]
  Selected by [y]:
  - PINCTRL_S900 [=y] && PINCTRL [=y]

2. Add help text for OWL pinctrl driver

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pinctrl/actions/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/actions/Kconfig b/drivers/pinctrl/actions/Kconfig
index 1c7309c90f0d..ede97cdbbc12 100644
--- a/drivers/pinctrl/actions/Kconfig
+++ b/drivers/pinctrl/actions/Kconfig
@@ -1,12 +1,14 @@
 config PINCTRL_OWL
-	bool
+	bool "Actions Semi OWL pinctrl driver"
 	depends on (ARCH_ACTIONS || COMPILE_TEST) && OF
 	select PINMUX
 	select PINCONF
 	select GENERIC_PINCONF
+	help
+	  Say Y here to enable Actions Semi OWL pinctrl driver
 
 config PINCTRL_S900
 	bool "Actions Semi S900 pinctrl driver"
-	select PINCTRL_OWL
+	depends on PINCTRL_OWL
 	help
 	  Say Y here to enable Actions Semi S900 pinctrl driver
-- 
2.14.1
