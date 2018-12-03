Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58327C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264772145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 264772145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbeLCDpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 22:45:43 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16068 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725807AbeLCDpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 22:45:42 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2287D961ED49E;
        Mon,  3 Dec 2018 11:45:37 +0800 (CST)
Received: from vm100-107-113-134.huawei.com (100.107.113.134) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.408.0; Mon, 3 Dec 2018 11:45:29 +0800
From:   Yu Chen <chenyu56@huawei.com>
To:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <suzhuangluan@hisilicon.com>, <kongfei@hisilicon.com>,
        Yu Chen <chenyu56@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Binghui Wang <wangbinghui@hisilicon.com>
Subject: [PATCH v1 02/12] dt-bindings: phy: Add support for HiSilicon's hi3660 USB PHY
Date:   Mon, 3 Dec 2018 11:45:05 +0800
Message-ID: <20181203034515.91412-3-chenyu56@huawei.com>
X-Mailer: git-send-email 2.15.0-rc2
In-Reply-To: <20181203034515.91412-1-chenyu56@huawei.com>
References: <20181203034515.91412-1-chenyu56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.107.113.134]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds binding documentation for supporting the hi3660 usb
phy on boards like the HiKey960.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Binghui Wang <wangbinghui@hisilicon.com>
Signed-off-by: Yu Chen <chenyu56@huawei.com>
--
v1: Fix some format error as suggested by Rob.
--
---
 .../devicetree/bindings/phy/phy-hi3660-usb3.txt     | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt b/Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
new file mode 100644
index 000000000000..8ea52d51aa13
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
@@ -0,0 +1,21 @@
+Hisilicon hi3660 usb PHY
+-----------------------
+
+Required properties:
+- compatible: should be "hisilicon,hi3660-usb-phy"
+- #phy-cells: must be 0
+- hisilicon,pericrg-syscon: phandle of syscon used to control phy.
+- hisilicon,pctrl-syscon: phandle of syscon used to control phy.
+- hisilicon,usb3-otg-bc-syscon: phandle of syscon used to control phy.
+- hisilicon,eye-diagram-param: parameter set for phy
+Refer to phy/phy-bindings.txt for the generic PHY binding properties
+
+Example:
+	usb-phy {
+		compatible = "hisilicon,hi3660-usb-phy";
+		#phy-cells = <0>;
+		hisilicon,pericrg-syscon = <&crg_ctrl>;
+		hisilicon,pctrl-syscon = <&pctrl>;
+		hisilicon,usb3-otg-bc-syscon = <&usb3_otg_bc>;
+		hisilicon,eye-diagram-param = <0x22466e4>;
+	};
-- 
2.15.0-rc2

