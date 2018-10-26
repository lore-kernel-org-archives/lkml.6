Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33844ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F382020834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F382020834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbeJZQ1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:27:37 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51618 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725907AbeJZQ1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:27:37 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 99CFFCE03FEB3;
        Fri, 26 Oct 2018 15:51:34 +0800 (CST)
Received: from localhost (10.177.19.219) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Fri, 26 Oct 2018
 15:51:27 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <marc.zyngier@arm.com>, <tglx@linutronix.de>,
        <guohanjun@huawei.com>, <yangyingliang@huawei.com>
Subject: [PATCH v2 4/4] dt-bindings/irqchip/mbigen: add example of MBIGEN generate SPIs
Date:   Fri, 26 Oct 2018 15:51:20 +0800
Message-ID: <1540540280-26612-5-git-send-email-yangyingliang@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.1
In-Reply-To: <1540540280-26612-1-git-send-email-yangyingliang@huawei.com>
References: <1540540280-26612-1-git-send-email-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.19.219]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now MBIGEN can support to generate SPIs by writing
GICD_SETSPIR. Add dt example to help document.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 .../interrupt-controller/hisilicon,mbigen-v2.txt        | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/hisilicon,mbigen-v2.txt b/Documentation/devicetree/bindings/interrupt-controller/hisilicon,mbigen-v2.txt
index a6813a0..298c033 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/hisilicon,mbigen-v2.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/hisilicon,mbigen-v2.txt
@@ -10,7 +10,7 @@ Hisilicon designed mbigen to collect and generate interrupt.
 
 
 Non-pci devices can connect to mbigen and generate the
-interrupt by writing ITS register.
+interrupt by writing GICD or ITS register.
 
 The mbigen chip and devices connect to mbigen have the following properties:
 
@@ -64,6 +64,13 @@ Examples:
 				num-pins = <2>;
 				#interrupt-cells = <2>;
 			};
+
+			mbigen_spi_example:spi_example {
+				interrupt-controller;
+				msi-parent = <&gic>;
+				num-pins = <2>;
+				#interrupt-cells = <2>;
+			};
 	};
 
 Devices connect to mbigen required properties:
@@ -82,3 +89,11 @@ Examples:
 		interrupts =	<656 1>,
 				<657 1>;
 	};
+
+	spi_example: spi0@0 {
+		compatible = "spi,example";
+		reg = <0 0 0 0>;
+		interrupt-parent = <&mbigen_spi_example>;
+		interrupts = <13 4>,
+			     <14 4>;
+	};
-- 
1.8.3


