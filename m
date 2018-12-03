Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9438CC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F51F20848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:46:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F51F20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbeLCDpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 22:45:43 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16064 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725806AbeLCDpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 22:45:42 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0B34BBF5306AA;
        Mon,  3 Dec 2018 11:45:37 +0800 (CST)
Received: from vm100-107-113-134.huawei.com (100.107.113.134) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.408.0; Mon, 3 Dec 2018 11:45:30 +0800
From:   Yu Chen <chenyu56@huawei.com>
To:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <suzhuangluan@hisilicon.com>, <kongfei@hisilicon.com>,
        Yu Chen <chenyu56@huawei.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "John Stultz" <john.stultz@linaro.org>,
        Binghui Wang <wangbinghui@hisilicon.com>
Subject: [PATCH v1 03/12] dt-bindings: misc: Add bindings for HiSilicon usb hub and data role switch functionality on HiKey960
Date:   Mon, 3 Dec 2018 11:45:06 +0800
Message-ID: <20181203034515.91412-4-chenyu56@huawei.com>
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

This patch adds binding documentation to support usb hub and usb
data role switch of Hisilicon HiKey&HiKey960 Board.

Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Binghui Wang <wangbinghui@hisilicon.com>
Signed-off-by: Yu Chen <chenyu56@huawei.com>
--
v1:
1) Fix some format errors as suggested by Sergei.
2) Modify gpio description to use gpiod API.
--
---
 .../bindings/misc/hisilicon-hikey-usb.txt          | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt

diff --git a/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt b/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt
new file mode 100644
index 000000000000..f3413d851e18
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt
@@ -0,0 +1,36 @@
+Support usb hub and usb data role switch of Hisilicon HiKey&HiKey960 Board.
+
+-----------------------------
+
+Required properties:
+- compatible: "hisilicon,gpio-hubv1","hisilicon,hikey960-usb"
+- typc-vbus-int-gpio: gpio to control the vbus of typeC port
+- typc-vbus-enable-val: gpio value that enable the vbus of typeC port
+- otg-gpio: gpio to switch DP&DM between the hub and typeC port
+- hub-vdd33-en-gpio: gpio to enable the power of hub
+- pinctrl-0: pinctrl config
+
+Example
+-----
+
+	hisi_hikey_usb: hisi_hikey_usb {
+		compatible = "hisilicon,hikey960-usb";
+		typec-vbus-gpios = <&gpio25 2 0>;
+		typc-vbus-enable-val = <1>;
+		otg-switch-gpios = <&gpio25 6 0>;
+		hub-vdd33-en-gpios = <&gpio5 6 0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usbhub5734_pmx_func>;
+
+		port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			hikey_usb_ep: endpoint@0 {
+				reg = <0>;
+				device_type = "usb-role-switch";
+				remote-endpoint = <&dwc3_role_switch_notify>;
+			};
+		};
+
+	};
-- 
2.15.0-rc2

