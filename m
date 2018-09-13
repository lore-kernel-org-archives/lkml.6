Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC76EC070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 00:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9391521479
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 00:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="z/TWjRRD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9391521479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbeIMF7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 01:59:17 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:59704 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbeIMF7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 01:59:17 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id w8D0pLtR019994;
        Thu, 13 Sep 2018 09:51:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w8D0pLtR019994
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1536799882;
        bh=4ks2z2OToVs52EUl/Ow1jOy3lg6t8i6aoijLCPSqC0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z/TWjRRDM6Mlo3FbmbMXypnGt3C1cCJ7eAwyMqo36uePye9yIKJhzmJP/QRZ8WMAL
         2XSNBtSjS00U8X0nSl4DqRx4ZYqSmDYdxCUyNdLWm7F84+28q7fdFfWEi4+G0pzP5J
         9eAec1lHKxzea7EDD325sPcRRhq46o5KTxgicj/MRc2iev9Ed2bE0EjCU4u+zMuYA9
         qlJXB7IduHLn6e8FA9rQqQXDebPNrnOAGHmZOUDEPoQGgYZKm3TJBoO8lLywK+qERI
         sZkw0CDT5/ISXU6O0BlWlfGC1oICp+WYF8FUaF27oyvHgbg91mdahoY9hKBGTV3+9j
         ldmGdbhk8U0xQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/2] dt-bindings: dmaengine: add DT binding for UniPhier MIO DMAC
Date:   Thu, 13 Sep 2018 09:51:08 +0900
Message-Id: <1536799869-10643-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536799869-10643-1-git-send-email-yamada.masahiro@socionext.com>
References: <1536799869-10643-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIO DMAC (Media IO DMA Controller) is used in UniPhier LD4,
Pro4, and sLD8 SoCs.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v3:
 - Add Rob's Reviewed-by

Changes in v2:
 - Rename the node "dmac" to "dma-controller"
 - Remove dma-channels property

 .../devicetree/bindings/dma/uniphier-mio-dmac.txt  | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt

diff --git a/Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt b/Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt
new file mode 100644
index 0000000..b12388d
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt
@@ -0,0 +1,25 @@
+UniPhier Media IO DMA controller
+
+This works as an external DMA engine for SD/eMMC controllers etc.
+found in UniPhier LD4, Pro4, sLD8 SoCs.
+
+Required properties:
+- compatible: should be "socionext,uniphier-mio-dmac".
+- reg: offset and length of the register set for the device.
+- interrupts: a list of interrupt specifiers associated with the DMA channels.
+- clocks: a single clock specifier.
+- #dma-cells: should be <1>. The single cell represents the channel index.
+
+Example:
+	dmac: dma-controller@5a000000 {
+		compatible = "socionext,uniphier-mio-dmac";
+		reg = <0x5a000000 0x1000>;
+		interrupts = <0 68 4>, <0 68 4>, <0 69 4>, <0 70 4>,
+			     <0 71 4>, <0 72 4>, <0 73 4>, <0 74 4>;
+		clocks = <&mio_clk 7>;
+		#dma-cells = <1>;
+	};
+
+Note:
+In the example above, "interrupts = <0 68 4>, <0 68 4>, ..." is not a typo.
+The first two channels share a single interrupt line.
-- 
2.7.4

