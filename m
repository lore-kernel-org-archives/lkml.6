Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2D8C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00C621019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ifqNeXZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbfAVNVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:21:43 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38820 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728439AbfAVNVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:21:42 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so11480945plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 05:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=euK4ZIyk6B19PT813VSDOnPJkx4d5LHCeMqPJd1aM7s=;
        b=ifqNeXZWBx+cSJs+BkrC38f3XF88AhaIyImBMv0oNKRrpwVKoNXtInlwfbqYw0UebY
         +4EH3Ry0FtdIIDBbkAC/8XAds81tNArKoVFQLhRvfGLJLLno7l4BP+zpVtIQOvVYCxfd
         UeXzZ3Hewmv+k0WwxS+vGHQykIMx64UYi/3z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=euK4ZIyk6B19PT813VSDOnPJkx4d5LHCeMqPJd1aM7s=;
        b=XTy1mdgAHMod5R4jHuU9GW1R2SYpkhI/ECVytSRCDX09r+KszGWux+U2PKLXZyPkBS
         zocJacX8Fb+er/eaaAa67GKat8Le3jzshJGgWOo2lJ1Ht8PgF4W5HOl81Z6DN9yXBSxL
         vLgeJVpr6env4FCZbD7sYRmwHmKjcQyM0dLs8CbyI36tqcI43vNdZ73Mqk7GmPL6cQKm
         EEj/8FMIsN6zRf1dliOHaEwb0e0KgJ8pLVztxlv+K9WvzHOXkXcXE3vOuW2FjCyPQTvy
         XXpCRstaQOi8vR00Yr8fLHEdeuU4gB4FIwcifLGbDflP3rnhqGZvzyvzboJlsEcbGZbT
         7i3w==
X-Gm-Message-State: AJcUuke1hP12SMXnvDhwoR0aypZ4MCSL3QZFb3QnLDtkuAT3MUlKg+fL
        Aoij0rCklQ+UTHtvJDe1lYKGcQ==
X-Google-Smtp-Source: ALg8bN7o9RYueCBe0lZNaR5aIq2epf1WyUYhHSDbVeRj+xDQpH350xWmTJItTx1o4/fQxRnAchpVDg==
X-Received: by 2002:a17:902:583:: with SMTP id f3mr35085581plf.202.1548163302104;
        Tue, 22 Jan 2019 05:21:42 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id l185sm21609574pfl.54.2019.01.22.05.21.37
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Jan 2019 05:21:41 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     arnd@arndb.de, olof@lixom.net, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, dan.j.williams@intel.com,
        devicetree@vger.kernel.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, eric.long@unisoc.com,
        broonie@kernel.org, baolin.wang@linaro.org
Subject: [PATCH 1/3] dt-bindings: dmaengine: Add one new cell to present hardware slave id
Date:   Tue, 22 Jan 2019 21:20:51 +0800
Message-Id: <a9718ae1e97a5911f47874fe23c00ef297d7fed8.1548158832.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DMA engine clients can trigger DMA engine automatically by setting
the corresponding hardware slave id for the DMA engine. Thus add one
cell to present the hardware slave id for DMA clients.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 Documentation/devicetree/bindings/dma/sprd-dma.txt |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/sprd-dma.txt b/Documentation/devicetree/bindings/dma/sprd-dma.txt
index 7a10fea..7812cf0 100644
--- a/Documentation/devicetree/bindings/dma/sprd-dma.txt
+++ b/Documentation/devicetree/bindings/dma/sprd-dma.txt
@@ -6,8 +6,8 @@ Required properties:
 - compatible: Should be "sprd,sc9860-dma".
 - reg: Should contain DMA registers location and length.
 - interrupts: Should contain one interrupt shared by all channel.
-- #dma-cells: must be <1>. Used to represent the number of integer
-	cells in the dmas property of client device.
+- #dma-cells: must be <2>. Used to represent the channel id and slave id
+	of integer cells in the dmas property of client device.
 - #dma-channels : Number of DMA channels supported. Should be 32.
 - clock-names: Should contain the clock of the DMA controller.
 - clocks: Should contain a clock specifier for each entry in clock-names.
@@ -28,14 +28,16 @@ apdma: dma-controller@20100000 {
 
 Client:
 DMA clients connected to the Spreadtrum DMA controller must use the format
-described in the dma.txt file, using a two-cell specifier for each channel.
-The two cells in order are:
+described in the dma.txt file, using a three-cell specifier for each channel.
+The three cells in order are:
 1. A phandle pointing to the DMA controller.
 2. The channel id.
+3. The hardware slave id which is used for clients to trigger DMA engine
+automatically.
 
 spi0: spi@70a00000{
 	...
 	dma-names = "rx_chn", "tx_chn";
-	dmas = <&apdma 11>, <&apdma 12>;
+	dmas = <&apdma 11 11>, <&apdma 12 12>;
 	...
 };
-- 
1.7.9.5

