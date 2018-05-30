Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932512AbeE3Vxf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 17:53:35 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:38821 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932310AbeE3Vxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 17:53:31 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-gpio@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pci: qcom: include gpio/consumer.h
Date: Wed, 30 May 2018 23:53:06 +0200
Message-Id: <20180530215324.1178564-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:vWp/0v8x9WEIv7clsiVAqiZs2DUobQRTF9mPnKdvd0f2JjIsdbo
 /JTg/iLaf+PVgYKJedfF9NiG/5d0DhATvvndPZdUu45eYkqs8LO0U30t3yQEyScyuWi1lEl
 44r03FHZcdbK2ynVAaHCoORxjVerxJxBq8NyFH1ra/kv1MExcOboBzUvmpS0ExhUp13FNdu
 Xswv++Bb01IeZtTzeZ6mQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZOt2u/6IGd0=:7h344KbOCfOCUjxx9dDaJV
 Y+TVW80JZyMKb6j/NEMDrj9C0C6Ub5QA6toGiwBeSi6q9EnKDvKZctF+m6b0LAcGcTvsmCBWr
 9q9BP7r+Iiur1U/lseBfw9kUl6zTgyUbrmBL4IvEeBy8Dt/K/+6XfMrTDAV7mn7829a2gcttC
 +ZhQ48swv/8P2xW9HgquvQvF+WrjFimbGDfAkQixK+qWmt2v1d0TRIYR9txwENbcvpGMRv2Pj
 F1H+6fZ9CRN8VVaT6VPEZvQwzyE6gkMerBth3xYZhPvFOdK2OEDnW2/Mm7vXgBtt5FWj0nnx2
 zRq72Tuy4s5R0J/cPehUw89JZrjapR5Vq+5pa8mM3jSsbQvj5vUlkW+RX15QEI+kZbOKAtpFz
 GDgCAJLIYqTfV/zyyF3kcao0lq6Ks0/boINvrX0bZZ9Ge16wW16swovcKbZEEsw7pqCnDWY2t
 QXeyUMZhS6MQyCq1NUaGTNUFfKXv1LIaPL+7KTYR7G3dGvqz617hcsOdERlpca3XKgvHnE6BR
 fI+yUude7dQLCCVC7Tr7UspMNLJL3uLXArAOGxHVjiPQiFZHt0c+SWbZnus1A4WmOexlILEEJ
 LWm0TkQMQuHHRrrYB3dEWGyArF9HAJ1oV3F6XdZN6McOhY4ujiMQr5QSV2C5F+Dw8xZdwF5vb
 8EvmXotNlyxPEVmfc50TLowtlWf0Y3t2EVCa1cJ2ih7sGKlXk0Bemu78ML6rU7Lam6Jg=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_GPIOLIB is disabled, we run into a build failure:

drivers/pci/dwc/pcie-qcom.c: In function 'qcom_pcie_probe':
drivers/pci/dwc/pcie-qcom.c:1223:16: error: implicit declaration of function 'devm_gpiod_get_optional'; did you mean 'devm_regulator_get_optional'? [-Werror=implicit-function-declaration]
  pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_LOW);

Including gpio/consumer.h directly is the correct fix.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/dwc/pcie-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
index b65bbf7c284e..17df19db851e 100644
--- a/drivers/pci/dwc/pcie-qcom.c
+++ b/drivers/pci/dwc/pcie-qcom.c
@@ -10,7 +10,7 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
-- 
2.9.0
