Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752323AbeEVT7D (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 15:59:03 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35482 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751586AbeEVT7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 15:59:00 -0400
X-Google-Smtp-Source: AB8JxZp2t7SC0UEygvXcw+IZZyc/PDvBu30m436E2+GYMR4IlJCt0773ZvYmnPHbMLwP4Wnj8SBRNw==
From: Niklas Cassel <niklas.cassel@linaro.org>
To: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc: Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: fix regulator property name for wlan pcie endpoint
Date: Tue, 22 May 2018 21:57:57 +0200
Message-Id: <20180522195758.24607-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The property name vddpe-supply is not included in
Documentation/devicetree/bindings/pci/qcom,pcie.txt
nor in the pcie-qcom PCIe Root Complex driver.

This property name was used in an initial patchset for pcie-qcom,
but was renamed in a later revision.

Therefore, the regulator is currently never enabled, leaving us with
unoperational wlan.

Fix this by using the correct regulator property name, so that wlan
comes up correctly.

Fixes: 1c8ca74a2ea1 ("arm64: dts: apq8096-db820c: Enable wlan and bt en pins")
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
Bluetooth needs a similar patch, but since bluetooth needs some more
work, submit this right now, so we at least have working wlan.

 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index 818bf0efd501..804268f54f37 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -203,7 +203,7 @@
 			pcie@600000 {
 				status = "okay";
 				perst-gpio = <&msmgpio 35 GPIO_ACTIVE_LOW>;
-				vddpe-supply = <&wlan_en>;
+				vddpe-3v3-supply = <&wlan_en>;
 				vddpe1-supply = <&bt_en>;
 			};
 
-- 
2.17.0
