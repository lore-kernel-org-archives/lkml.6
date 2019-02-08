Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C6BC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B26FD20663
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfBHMY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:24:57 -0500
Received: from mx.socionext.com ([202.248.49.38]:27736 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726547AbfBHMY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:24:56 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 08 Feb 2019 21:24:54 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 09A79180D62;
        Fri,  8 Feb 2019 21:24:55 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 8 Feb 2019 21:24:54 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 787901A04E1;
        Fri,  8 Feb 2019 21:24:54 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 640961202F1;
        Fri,  8 Feb 2019 21:24:54 +0900 (JST)
From:   Sugaya Taichi <sugaya.taichi@socionext.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: [PATCH v2 01/15] dt-bindings: sram: milbeaut: Add binding for Milbeaut smp-sram
Date:   Fri,  8 Feb 2019 21:25:33 +0900
Message-Id: <1549628733-30171-1-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Milbeaut M10V SoC needs a part of sram for smp, so this adds the
M10V sram compatible and binding.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 .../devicetree/bindings/sram/milbeaut-smp-sram.txt | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sram/milbeaut-smp-sram.txt

diff --git a/Documentation/devicetree/bindings/sram/milbeaut-smp-sram.txt b/Documentation/devicetree/bindings/sram/milbeaut-smp-sram.txt
new file mode 100644
index 0000000..194f6a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/sram/milbeaut-smp-sram.txt
@@ -0,0 +1,24 @@
+Milbeaut SRAM for smp bringup
+
+Milbeaut SoCs use a part of the sram for the bringup of the secondary cores.
+Once they get powered up in the bootloader, they stay at the specific part
+of the sram.
+Therefore the part needs to be added as the sub-node of mmio-sram.
+
+Required sub-node properties:
+- compatible : should be "socionext,milbeaut-smp-sram"
+
+Example:
+
+        sram: sram@0 {
+                compatible = "mmio-sram";
+                reg = <0x0 0x10000>;
+                #address-cells = <1>;
+                #size-cells = <1>;
+                ranges = <0 0x0 0x10000>;
+
+                smp-sram@f100 {
+                        compatible = "socionext,milbeaut-smp-sram";
+                        reg = <0xf100 0x20>;
+                };
+        };
-- 
1.9.1

