Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04901C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F5F20659
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="EfFAIugu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F5F20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbeJLAKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 20:10:07 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:49999 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729948AbeJLAKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 20:10:06 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id w9BGf9b9007909;
        Fri, 12 Oct 2018 01:41:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w9BGf9b9007909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539276071;
        bh=iRhBghOfbe1mUlmrIyQZV10oc98t0c1hQwHeiRi6HsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EfFAIugur5+P/yKOZcFwMDRzefKTFFO9URQvQ68zHeOc7grCmOmw0/RldHxpLkB0k
         cHFKwlGbmXEr0yiZtpg96aJ661SUHq6Dh4XQjwtrafmaE7f5HWAobo5gm8UIHXy67U
         ZIkWJPsuTuQUvGpgUjjDVlZ4butc6D4h6f4DoVrJIqtmNCC3G49yLNIg3Ev7rSOqyA
         +8a6cMoNBt1XZeqjpm4OnijzJTWGIiiWelKrkNRzt4BCZ5F3rTvKu9zkL66RrfJCG1
         GNxUYFkgjb5Md7DjkkSk2g49i6Svl3B8CN99X6Z89Ni0kHzf+i6SHQRRsrIOMCdP0G
         r5KbtBi8fk+eQ==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 1/2] dt-bindings: dmaengine: add DT binding for UniPhier MIO DMAC
Date:   Fri, 12 Oct 2018 01:41:02 +0900
Message-Id: <1539276063-5103-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539276063-5103-1-git-send-email-yamada.masahiro@socionext.com>
References: <1539276063-5103-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIO DMAC (Media IO DMA Controller) is used in UniPhier LD4,
Pro4, and sLD8 SoCs.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v4: None
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

