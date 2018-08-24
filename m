Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AF6C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 01:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7BE21568
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 01:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Hn9SSvvo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED7BE21568
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbeHXFOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 01:14:53 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:62323 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725735AbeHXFOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 01:14:53 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w7O1fPr0000411;
        Fri, 24 Aug 2018 10:41:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w7O1fPr0000411
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535074887;
        bh=CzdodUwtZIgwu2wu5HeMR4NestBlGRCdpgz3kG8nWjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hn9SSvvodpg88kFXgfG1lpXSR8sAqS/3MU0YdjDmwUkbB9zS6t0VdH0O4rxkW65hn
         xqAAeM1q+VMw507sQVsdtZmDzM9YfNqPgRkj+E428EgmsUVCI2oZcEAIf1+w/Cg1YN
         /2w3KFTThl0qgGmzFMGIfnpUQDdWa6JTL0HhW+vGkgVK3xEaPCRdrFue1mDTmrLV4P
         50sOPF0juhOegv1ALpfNggTXwCXXPExD0o1XfZvOc1T/MwZpAQjbb3z/Oyg1Ed1jk3
         MlqJKC4T6C7GyAhv3AMwmgZCEJIgizQe+VcSGUbI5HDIS+3mF5+/abXuaBJENxOlFI
         vK9Ko9h0RjjTg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] dt-bindings: dmaengine: add DT binding for UniPhier MIO DMAC
Date:   Fri, 24 Aug 2018 10:41:12 +0900
Message-Id: <1535074873-15617-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535074873-15617-1-git-send-email-yamada.masahiro@socionext.com>
References: <1535074873-15617-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIO DMAC (Media IO DMA Controller) is used in UniPhier LD4,
Pro4, and sLD8 SoCs.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

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

