Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E164C43612
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C839C20868
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="afhPf+/A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbfAONrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:47:42 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34892 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbfAONrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:47:40 -0500
Received: by mail-pl1-f195.google.com with SMTP id p8so1330895plo.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 05:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ll6G7H6g2hrlSHKMGdHliIHSg/LmHRKVCWDufi604es=;
        b=afhPf+/AFgSiaeZ3wgDf7gCHK4jm7lzRvezQGcUKH0vah5oY24CEyIgHwho2UQGJju
         fWhPmSQgnZsRdLr2uzhsrSEs3GmSR0LVCU+FoONj3Xf9ayn5sk8flu9UQRip/LBqd864
         uGakXmzHHyyk11OaWHqJxXny9svFskj+xj5WM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ll6G7H6g2hrlSHKMGdHliIHSg/LmHRKVCWDufi604es=;
        b=RtI/yW9+HkkOfpLmmjWNMnkwRf6uJYCK+1I1brZcF/Q6o5ID3DpujAh91O1NQZAf7Z
         UdlyR6cU2C271l7PodAVeFmAW8hdlqFUkpXJdLjrOylmAO6hRYw98alfRv3JEY3yKcP5
         SE5ObgayTLHaFN4wRiESqy5G4V1WQysNVzxsYEF5br4o3Q8hUTxrR5wkN3IT+AHRqufH
         a33uNw1mWdRUFbnyH0B9CbN8yv6h5jwEOVTwNrozic03iA5lJbCPUrFzlnRAHcs/XB/S
         Y9/1IpCREnQWunUt50yAlmQljroVtE0Mbm5QTbpmrD9lUZAN8kpxQA6QadLe0F/yCiXw
         F7Xg==
X-Gm-Message-State: AJcUukfKy/aHJgeUVGEVeqlu6tm+DXp8WF05ZswtFoHoo+p1b8OhCPMF
        gK1UEXEDGfgWw/L5wkcTXJ+DSw==
X-Google-Smtp-Source: ALg8bN5QpnXEfChC2Tx7vpbQfYShJYYexiPijB51L0AJU4szCElkUpsP7eC4pgMILRRYJOScCiP/pg==
X-Received: by 2002:a17:902:27e6:: with SMTP id i35mr4154891plg.222.1547560059939;
        Tue, 15 Jan 2019 05:47:39 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id y71sm5979422pfi.123.2019.01.15.05.47.36
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Jan 2019 05:47:39 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, lanqing.liu@unisoc.com,
        baolin.wang@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] dt-bindings: spi: Add the DMA properties for the SPI dma mode
Date:   Tue, 15 Jan 2019 21:46:52 +0800
Message-Id: <7538d5806003b8f67e7e0d35638315974b7c2b50.1547559542.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <ab49bb74e921474aa9390f81cdf65f32c3d9d898.1547559542.git.baolin.wang@linaro.org>
References: <ab49bb74e921474aa9390f81cdf65f32c3d9d898.1547559542.git.baolin.wang@linaro.org>
In-Reply-To: <ab49bb74e921474aa9390f81cdf65f32c3d9d898.1547559542.git.baolin.wang@linaro.org>
References: <ab49bb74e921474aa9390f81cdf65f32c3d9d898.1547559542.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lanqing Liu <lanqing.liu@spreadtrum.com>

Add the DMA properties for the SPI dma mode.

Signed-off-by: Lanqing Liu <lanqing.liu@spreadtrum.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 Documentation/devicetree/bindings/spi/spi-sprd.txt |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-sprd.txt b/Documentation/devicetree/bindings/spi/spi-sprd.txt
index bad211a..01ef53f 100644
--- a/Documentation/devicetree/bindings/spi/spi-sprd.txt
+++ b/Documentation/devicetree/bindings/spi/spi-sprd.txt
@@ -14,6 +14,12 @@ Required properties:
 	address on the SPI bus. Should be set to 1.
 - #size-cells: Should be set to 0.
 
+Optional properties:
+dma-names: Should contain names of the SPI used DMA channel.
+dmas: Should contain DMA channels which the SPI used sorted in the
+	same order as the dma-names property.
+sprd,dma-slave-ids: Should contain the DMA number that the SPI hardware required.
+
 Example:
 spi0: spi@70a00000{
 	compatible = "sprd,sc9860-spi";
@@ -21,6 +27,9 @@ spi0: spi@70a00000{
 	interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 	clock-names = "spi", "source","enable";
 	clocks = <&clk_spi0>, <&ext_26m>, <&clk_ap_apb_gates 5>;
+	dma-names = "rx_chn", "tx_chn";
+	dmas = <&apdma 11>, <&apdma 12>;
+	sprd,dma-slave-ids = <11 12>;
 	#address-cells = <1>;
 	#size-cells = <0>;
 };
-- 
1.7.9.5

