Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752147AbeCWJPl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 05:15:41 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:39333 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752101AbeCWJPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 05:15:38 -0400
X-UUID: fa64d74719924904b8dd85ea65d82b11-20180323
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <sre@kernel.org>,
        <lee.jones@linaro.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@free-electrons.com>, <eddie.huang@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 01/16] dt-bindings: power: reset: mediatek: add bindings for power device
Date: Fri, 23 Mar 2018 17:14:58 +0800
Message-ID: <c5527464207b02d40f1c2682feb97ebf5dd443be.1521794176.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1521794176.git.sean.wang@mediatek.com>
References: <cover.1521794176.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23736.004
X-TM-AS-Result: No-5.077600-8.000000-10
X-TMASE-MatchedRID: TEv/LuC73NgxFdXyW/P+XRWCVBr+Ay98TJDl9FKHbrm8NrbzjPvzJ0d0
        Rzx07LDV96TYN1fO8g6y9AsAxk+TJTlyVH8jNStNngIgpj8eDcAZ1CdBJOsoY8RB0bsfrpPIx1F
        PlNAAmcD3btvyVy2hl6jcCaDKbZhtJpjtEGVHKBNYGgyI8kGmsp6oP1a0mRIj
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.077600-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23736.004
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add device-tree binding for the power device responsible for shutdown a
remote SoC, which is a tiny circuit block present on MediaTek PMIC based
RTC.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../bindings/power/reset/mt6397-rtc-poweroff.txt   | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/mt6397-rtc-poweroff.txt

diff --git a/Documentation/devicetree/bindings/power/reset/mt6397-rtc-poweroff.txt b/Documentation/devicetree/bindings/power/reset/mt6397-rtc-poweroff.txt
new file mode 100644
index 0000000..75a9d7d
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/mt6397-rtc-poweroff.txt
@@ -0,0 +1,24 @@
+Device-Tree bindings for Power Device on MediaTek PMIC RTC
+
+The power device is responsible for externally power off or on the remote
+MediaTek SoC through the a tiny circuit block BBPU inside PMIC RTC.
+
+Required parent node:
+- rtc
+	For MediaTek PMIC RTC bindings, see:
+	Documentation/devicetree/bindings/mfd/mt6397.txt
+
+Required properties:
+- compatible: Should be one of follows
+	"mediatek,mt6323-rtc-poweroff": for MT6323 PMIC
+	"mediatek,mt6397-rtc-poweroff": for MT6397 PMIC
+
+Example:
+
+	rtc {
+		compatible = "mediatek,mt6323-rtc";
+
+		power-off {
+			compatible = "mediatek,mt6323-rtc-poweroff";
+		};
+	};
-- 
2.7.4
