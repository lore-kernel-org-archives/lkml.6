Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B9DC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D84725E23
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D84725E23
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933944AbeF0LQq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 07:16:46 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:46138 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S933275AbeF0LQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 07:16:43 -0400
X-UUID: 9d579a0245e5450c8175690966d3232c-20180627
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <houlong.wei@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1220305756; Wed, 27 Jun 2018 19:16:39 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 27 Jun 2018 19:16:39 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 27 Jun 2018 19:16:38 +0800
From:   Houlong Wei <houlong.wei@mediatek.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        CK HU <ck.hu@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Monica Wang <monica.wang@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>, <ginny.chen@mediatek.com>,
        <enzhu.wang@mediatek.com>
Subject: [PATCH v22 1/4] dt-bindings: soc: Add documentation for the MediaTek GCE unit
Date:   Wed, 27 Jun 2018 19:16:09 +0800
Message-ID: <1530098172-31385-2-git-send-email-houlong.wei@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1530098172-31385-1-git-send-email-houlong.wei@mediatek.com>
References: <1530098172-31385-1-git-send-email-houlong.wei@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds documentation for the MediaTek Global Command Engine (GCE) unit
found in MT8173 SoCs.

Signed-off-by: Houlong Wei <houlong.wei@mediatek.com>
Signed-off-by: HS Liao <hs.liao@mediatek.com>
---
Hi Rob,
  I don't add your ACK in this version since the dt-binding description
has been changed. Thanks.
---
 .../devicetree/bindings/mailbox/mtk-gce.txt        |   65 ++++++++++++++++++++
 include/dt-bindings/gce/mt8173-gce.h               |   48 +++++++++++++++
 2 files changed, 113 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/mtk-gce.txt
 create mode 100644 include/dt-bindings/gce/mt8173-gce.h

diff --git a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
new file mode 100644
index 0000000..26f65a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
@@ -0,0 +1,65 @@
+MediaTek GCE
+===============
+
+The Global Command Engine (GCE) is used to help read/write registers with
+critical time limitation, such as updating display configuration during the
+vblank. The GCE can be used to implement the Command Queue (CMDQ) driver.
+
+CMDQ driver uses mailbox framework for communication. Please refer to
+mailbox.txt for generic information about mailbox device-tree bindings.
+
+Required properties:
+- compatible: Must be "mediatek,mt8173-gce"
+- reg: Address range of the GCE unit
+- interrupts: The interrupt signal from the GCE block
+- clock: Clocks according to the common clock binding
+- clock-names: Must be "gce" to stand for GCE clock
+- thread-num: Maximum threads count of GCE.
+- #mbox-cells: Should be 4.
+	<&phandle channel timeout priority atomic_exec>
+	phandle: Label name of a gce node.
+	channel: Channel of mailbox. Be equal to the thread id of GCE.
+	timeout: Maximum time of software waiting GCE processing done, in unit
+		of millisecond.
+	priority: Priority of GCE thread.
+	atomic_exec: GCE processing continuous packets of commands in atomic
+		way.
+
+Required properties for a client device:
+- mboxes: Client use mailbox to communicate with GCE, it should have this
+  property and list of phandle, mailbox specifiers.
+- gce-subsys: Specify the sub-system id which is corresponding to the register
+  address.
+
+Optional properties for a client device:
+- gce-event: Specify the event if the client has any. Because the event is
+  parsed by client, so client can replace 'gce-event' with other meaningful
+  name.
+
+Some vaules of properties are defined in 'dt-bindings/gce/mt8173-gce.h'. Such as
+thread number, sub-system ids, thread priority, event ids.
+
+Example:
+
+	gce: gce@10212000 {
+		compatible = "mediatek,mt8173-gce";
+		reg = <0 0x10212000 0 0x1000>;
+		interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&infracfg CLK_INFRA_GCE>;
+		clock-names = "gce";
+		thread-num = CMDQ_THR_MAX_COUNT;
+		#mbox-cells = <4>;
+	};
+
+Example for a client device:
+
+	mmsys: clock-controller@14000000 {
+		compatible = "mediatek,mt8173-mmsys";
+		mboxes = <&gce 0 2000 CMDQ_THR_PRIO_LOWEST 1>,
+			 <&gce 1 2000 CMDQ_THR_PRIO_LOWEST 1>;
+		gce-subsys = <SUBSYS_1400XXXX>;
+		mutex-event-eof = <CMDQ_EVENT_MUTEX0_STREAM_EOF
+				CMDQ_EVENT_MUTEX1_STREAM_EOF>;
+
+		...
+	};
diff --git a/include/dt-bindings/gce/mt8173-gce.h b/include/dt-bindings/gce/mt8173-gce.h
new file mode 100644
index 0000000..89eb3b8
--- /dev/null
+++ b/include/dt-bindings/gce/mt8173-gce.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018 MediaTek Inc.
+ * Author: Houlong Wei <houlong.wei@mediatek.com>
+ *
+ */
+
+#ifndef _DT_BINDINGS_GCE_MT8173_H
+#define _DT_BINDINGS_GCE_MT8173_H
+
+#define CMDQ_NO_TIMEOUT		0xffffffff
+
+#define CMDQ_THR_MAX_COUNT	16
+
+/* GCE HW thread priority */
+#define CMDQ_THR_PRIO_LOWEST	0
+#define CMDQ_THR_PRIO_HIGHEST	1
+
+/* GCE SUBSYS */
+#define SUBSYS_1400XXXX		1
+#define SUBSYS_1401XXXX		2
+#define SUBSYS_1402XXXX		3
+
+/* GCE HW EVENT */
+#define CMDQ_EVENT_DISP_OVL0_SOF		11
+#define CMDQ_EVENT_DISP_OVL1_SOF		12
+#define CMDQ_EVENT_DISP_RDMA0_SOF		13
+#define CMDQ_EVENT_DISP_RDMA1_SOF		14
+#define CMDQ_EVENT_DISP_RDMA2_SOF		15
+#define CMDQ_EVENT_DISP_WDMA0_SOF		16
+#define CMDQ_EVENT_DISP_WDMA1_SOF		17
+#define CMDQ_EVENT_DISP_OVL0_EOF		39
+#define CMDQ_EVENT_DISP_OVL1_EOF		40
+#define CMDQ_EVENT_DISP_RDMA0_EOF		41
+#define CMDQ_EVENT_DISP_RDMA1_EOF		42
+#define CMDQ_EVENT_DISP_RDMA2_EOF		43
+#define CMDQ_EVENT_DISP_WDMA0_EOF		44
+#define CMDQ_EVENT_DISP_WDMA1_EOF		45
+#define CMDQ_EVENT_MUTEX0_STREAM_EOF		53
+#define CMDQ_EVENT_MUTEX1_STREAM_EOF		54
+#define CMDQ_EVENT_MUTEX2_STREAM_EOF		55
+#define CMDQ_EVENT_MUTEX3_STREAM_EOF		56
+#define CMDQ_EVENT_MUTEX4_STREAM_EOF		57
+#define CMDQ_EVENT_DISP_RDMA0_UNDERRUN		63
+#define CMDQ_EVENT_DISP_RDMA1_UNDERRUN		64
+#define CMDQ_EVENT_DISP_RDMA2_UNDERRUN		65
+
+#endif
-- 
1.7.9.5

