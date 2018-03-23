Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752489AbeCWJUH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 05:20:07 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:24959 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752009AbeCWJPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 05:15:31 -0400
X-UUID: 0eb758de64fc4f2bb60390d1187e0327-20180323
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <sre@kernel.org>,
        <lee.jones@linaro.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@free-electrons.com>, <eddie.huang@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 02/16] dt-bindings: rtc: mediatek: add bindings for PMIC RTC
Date: Fri, 23 Mar 2018 17:14:59 +0800
Message-ID: <5846e8be319c4836808c8127d5bb51b7e999e896.1521794177.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1521794176.git.sean.wang@mediatek.com>
References: <cover.1521794176.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23736.004
X-TM-AS-Result: No-5.369500-8.000000-10
X-TMASE-MatchedRID: JLDJ3zY9u2kxFdXyW/P+XRWCVBr+Ay98TJDl9FKHbrm7qpOHKudqczQz
        47GqDWjpnD3AxwqeC/r+5j8x5GH+mf+rTYoF7Kee05yZiz1u26Rdxx6WRf+5sM7EPIkVcg+Oxtf
        MCZzvZ+lPN9Ds5e3i44Ay6p60ZV62fJ5/bZ6npdg7AFczfjr/7JJ0UX/rKgouzOHrU8JWvsOZ7v
        bKAdnMwEolWaGFokF9vyjT7c4jENc=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.369500-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23736.004
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add device-tree binding for MediaTek PMIC based RTC.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../devicetree/bindings/rtc/rtc-mt6397.txt         | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mt6397.txt

diff --git a/Documentation/devicetree/bindings/rtc/rtc-mt6397.txt b/Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
new file mode 100644
index 0000000..83ff6be
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
@@ -0,0 +1,39 @@
+Device-Tree bindings for MediaTek PMIC based RTC
+
+MediaTek PMIC based RTC is an independent function of MediaTek PMIC which
+is working as a multi-function device (MFD). And the RTC can be configured and
+set up via PMIC wrapper bus. Which is also common resource shared among the
+other functions present on the PMIC.
+
+For MediaTek PMIC wrapper bus bindings, see:
+Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
+
+Required parent node:
+- pmic
+  For MediaTek PMIC MFD bindings, see:
+  Documentation/devicetree/bindings/mfd/mt6397.txt
+
+Required properties:
+- compatible: Should be one of follows
+	"mediatek,mt6323-rtc": for MT6323 PMIC
+	"mediatek,mt6397-rtc": for MT6397 PMIC
+
+Optional child node:
+- power-off
+  For Power-Off Device for MediaTek PMIC RTC bindings, see:
+  Documentation/devicetree/bindings/power/reset/mt6397-rtc-poweroff.txt
+
+Example:
+
+	pmic {
+		compatible = "mediatek,mt6323";
+
+		...
+		rtc {
+			compatible = "mediatek,mt6323-rtc";
+
+			power-off {
+				compatible = "mediatek,mt6323-rtc-poweroff";
+			};
+		};
+};
-- 
2.7.4
