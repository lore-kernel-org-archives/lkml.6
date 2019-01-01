Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57516C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 04:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261FF218A4
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 04:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfAAEvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 23:51:48 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:25631 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726740AbfAAEvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 23:51:47 -0500
X-UUID: 8ce289e17586401d993d3975de54b94f-20190101
X-UUID: 8ce289e17586401d993d3975de54b94f-20190101
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1149457836; Tue, 01 Jan 2019 12:51:40 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 1 Jan 2019 12:51:38 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 1 Jan 2019 12:51:37 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <arnd@arndb.de>,
        <yingjoe.chen@mediatek.com>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH 01/13] dt-binding: mediatek: Get rid of mediatek,larb for multimedia HW
Date:   Tue, 1 Jan 2019 12:51:04 +0800
Message-ID: <1546318276-18993-2-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After adding device_link between the consumer with the smi-larbs,
if the consumer call its owner pm_runtime_get(_sync), the
pm_runtime_get(_sync) of smi-larb and smi-common will be called
automatically. Thus, the consumer don't need the property.

And IOMMU also know which larb this consumer connects with from
iommu id in the "iommus=" property.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
I guess it should go through Matthias's tree if the patch is ok,
thus I don't separate to different patches. If it's really needed,
please feel free to tell me.
---
 .../devicetree/bindings/display/mediatek/mediatek,disp.txt       | 9 ---------
 .../devicetree/bindings/media/mediatek-jpeg-decoder.txt          | 4 ----
 Documentation/devicetree/bindings/media/mediatek-mdp.txt         | 8 --------
 Documentation/devicetree/bindings/media/mediatek-vcodec.txt      | 4 ----
 4 files changed, 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
index 8469de5..464b92f 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
@@ -56,8 +56,6 @@ Required properties (DMA function blocks):
 	"mediatek,<chip>-disp-rdma"
 	"mediatek,<chip>-disp-wdma"
   the supported chips are mt2701 and mt8173.
-- larb: Should contain a phandle pointing to the local arbiter device as defined
-  in Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
 - iommus: Should point to the respective IOMMU block with master port as
   argument, see Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
   for details.
@@ -78,7 +76,6 @@ ovl0: ovl@1400c000 {
 	power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 	clocks = <&mmsys CLK_MM_DISP_OVL0>;
 	iommus = <&iommu M4U_PORT_DISP_OVL0>;
-	mediatek,larb = <&larb0>;
 };
 
 ovl1: ovl@1400d000 {
@@ -88,7 +85,6 @@ ovl1: ovl@1400d000 {
 	power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 	clocks = <&mmsys CLK_MM_DISP_OVL1>;
 	iommus = <&iommu M4U_PORT_DISP_OVL1>;
-	mediatek,larb = <&larb4>;
 };
 
 rdma0: rdma@1400e000 {
@@ -98,7 +94,6 @@ rdma0: rdma@1400e000 {
 	power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 	clocks = <&mmsys CLK_MM_DISP_RDMA0>;
 	iommus = <&iommu M4U_PORT_DISP_RDMA0>;
-	mediatek,larb = <&larb0>;
 };
 
 rdma1: rdma@1400f000 {
@@ -108,7 +103,6 @@ rdma1: rdma@1400f000 {
 	power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 	clocks = <&mmsys CLK_MM_DISP_RDMA1>;
 	iommus = <&iommu M4U_PORT_DISP_RDMA1>;
-	mediatek,larb = <&larb4>;
 };
 
 rdma2: rdma@14010000 {
@@ -118,7 +112,6 @@ rdma2: rdma@14010000 {
 	power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 	clocks = <&mmsys CLK_MM_DISP_RDMA2>;
 	iommus = <&iommu M4U_PORT_DISP_RDMA2>;
-	mediatek,larb = <&larb4>;
 };
 
 wdma0: wdma@14011000 {
@@ -128,7 +121,6 @@ wdma0: wdma@14011000 {
 	power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 	clocks = <&mmsys CLK_MM_DISP_WDMA0>;
 	iommus = <&iommu M4U_PORT_DISP_WDMA0>;
-	mediatek,larb = <&larb0>;
 };
 
 wdma1: wdma@14012000 {
@@ -138,7 +130,6 @@ wdma1: wdma@14012000 {
 	power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 	clocks = <&mmsys CLK_MM_DISP_WDMA1>;
 	iommus = <&iommu M4U_PORT_DISP_WDMA1>;
-	mediatek,larb = <&larb4>;
 };
 
 color0: color@14013000 {
diff --git a/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt b/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt
index 044b119..7978f21 100644
--- a/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt
+++ b/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt
@@ -15,9 +15,6 @@ Required properties:
 - clock-names: must contain "jpgdec-smi" and "jpgdec".
 - power-domains: a phandle to the power domain, see
   Documentation/devicetree/bindings/power/power_domain.txt for details.
-- mediatek,larb: must contain the local arbiters in the current Socs, see
-  Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
-  for details.
 - iommus: should point to the respective IOMMU block with master port as
   argument, see Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
   for details.
@@ -32,7 +29,6 @@ Example:
 		clock-names = "jpgdec-smi",
 			      "jpgdec";
 		power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
-		mediatek,larb = <&larb2>;
 		iommus = <&iommu MT2701_M4U_PORT_JPGDEC_WDMA>,
 			 <&iommu MT2701_M4U_PORT_JPGDEC_BSDMA>;
 	};
diff --git a/Documentation/devicetree/bindings/media/mediatek-mdp.txt b/Documentation/devicetree/bindings/media/mediatek-mdp.txt
index 0d03e3a..df69c5a 100644
--- a/Documentation/devicetree/bindings/media/mediatek-mdp.txt
+++ b/Documentation/devicetree/bindings/media/mediatek-mdp.txt
@@ -27,9 +27,6 @@ Required properties (DMA function blocks, child node):
 - iommus: should point to the respective IOMMU block with master port as
   argument, see Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
   for details.
-- mediatek,larb: must contain the local arbiters in the current Socs, see
-  Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
-  for details.
 
 Example:
 	mdp_rdma0: rdma@14001000 {
@@ -40,7 +37,6 @@ Example:
 			 <&mmsys CLK_MM_MUTEX_32K>;
 		power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 		iommus = <&iommu M4U_PORT_MDP_RDMA0>;
-		mediatek,larb = <&larb0>;
 		mediatek,vpu = <&vpu>;
 	};
 
@@ -51,7 +47,6 @@ Example:
 			 <&mmsys CLK_MM_MUTEX_32K>;
 		power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 		iommus = <&iommu M4U_PORT_MDP_RDMA1>;
-		mediatek,larb = <&larb4>;
 	};
 
 	mdp_rsz0: rsz@14003000 {
@@ -81,7 +76,6 @@ Example:
 		clocks = <&mmsys CLK_MM_MDP_WDMA>;
 		power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 		iommus = <&iommu M4U_PORT_MDP_WDMA>;
-		mediatek,larb = <&larb0>;
 	};
 
 	mdp_wrot0: wrot@14007000 {
@@ -90,7 +84,6 @@ Example:
 		clocks = <&mmsys CLK_MM_MDP_WROT0>;
 		power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 		iommus = <&iommu M4U_PORT_MDP_WROT0>;
-		mediatek,larb = <&larb0>;
 	};
 
 	mdp_wrot1: wrot@14008000 {
@@ -99,5 +92,4 @@ Example:
 		clocks = <&mmsys CLK_MM_MDP_WROT1>;
 		power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 		iommus = <&iommu M4U_PORT_MDP_WROT1>;
-		mediatek,larb = <&larb4>;
 	};
diff --git a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
index 2a615d8..a5d82a7 100644
--- a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
+++ b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
@@ -9,7 +9,6 @@ Required properties:
 - reg : Physical base address of the video codec registers and length of
   memory mapped region.
 - interrupts : interrupt number to the cpu.
-- mediatek,larb : must contain the local arbiters in the current Socs.
 - clocks : list of clock specifiers, corresponding to entries in
   the clock-names property.
 - clock-names: encoder must contain "venc_sel_src", "venc_sel",,
@@ -39,7 +38,6 @@ vcodec_dec: vcodec@16000000 {
           <0 0x16027800 0 0x800>,   /*VP8_VL*/
           <0 0x16028400 0 0x400>;   /*VP9_VD*/
     interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_LOW>;
-    mediatek,larb = <&larb1>;
     iommus = <&iommu M4U_PORT_HW_VDEC_MC_EXT>,
              <&iommu M4U_PORT_HW_VDEC_PP_EXT>,
              <&iommu M4U_PORT_HW_VDEC_AVC_MV_EXT>,
@@ -74,8 +72,6 @@ vcodec_dec: vcodec@16000000 {
           <0 0x19002000 0 0x1000>;    /*VENC_LT_SYS*/
     interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_LOW>,
 		 <GIC_SPI 202 IRQ_TYPE_LEVEL_LOW>;
-    mediatek,larb = <&larb3>,
-		    <&larb5>;
     iommus = <&iommu M4U_PORT_VENC_RCPU>,
              <&iommu M4U_PORT_VENC_REC>,
              <&iommu M4U_PORT_VENC_BSDMA>,
-- 
1.9.1

