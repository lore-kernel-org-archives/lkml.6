Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751924AbeDYJdR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 05:33:17 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:13791 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751567AbeDYJdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 05:33:03 -0400
X-UUID: ad99b6db2ee6483eae5d802b2f126b2d-20180425
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <sre@kernel.org>,
        <lee.jones@linaro.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@free-electrons.com>, <matthias.bgg@gmail.com>,
        <eddie.huang@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Sean Wang" <sean.wang@mediatek.com>
Subject: [PATCH v2 02/17] dt-bindings: rtc: mt6397: add bindings for MediaTek PMIC based RTC
Date: Wed, 25 Apr 2018 17:32:28 +0800
Message-ID: <ae63c2a511e40ab4f6778197a1f15e41505d5682.1524646231.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1524646231.git.sean.wang@mediatek.com>
References: <cover.1524646231.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add device-tree binding for MediaTek PMIC based RTC

Cc: devicetree@vger.kernel.org
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../devicetree/bindings/rtc/rtc-mt6397.txt         | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mt6397.txt

diff --git a/Documentation/devicetree/bindings/rtc/rtc-mt6397.txt b/Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
new file mode 100644
index 0000000..6e97248
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
@@ -0,0 +1,29 @@
+Device-Tree bindings for MediaTek PMIC based RTC
+
+MediaTek PMIC based RTC is an independent function of MediaTek PMIC that works
+as a type of multi-function device (MFD). The RTC can be configured and set up
+with PMIC wrapper bus which is a common resource shared with the other
+functions found on the same PMIC.
+
+For MediaTek PMIC MFD bindings, see:
+Documentation/devicetree/bindings/mfd/mt6397.txt
+
+For MediaTek PMIC wrapper bus bindings, see:
+Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
+
+Required properties:
+- compatible: Should be one of follows
+	"mediatek,mt6323-rtc": for MT6323 PMIC
+	"mediatek,mt6397-rtc": for MT6397 PMIC
+
+Example:
+
+	pmic {
+		compatible = "mediatek,mt6323";
+
+		...
+
+		rtc {
+			compatible = "mediatek,mt6323-rtc";
+		};
+	};
-- 
2.7.4
