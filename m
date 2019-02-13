Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4925FC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1941C222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GibGtyYY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389132AbfBMHhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:37:31 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41519 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732703AbfBMHh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:37:29 -0500
Received: by mail-pg1-f193.google.com with SMTP id m1so754562pgq.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 23:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=IuEgx9iAHvTk1jDMUjBUTSMxKsXFBOFl5qP8s21qcdQ=;
        b=GibGtyYYnadfSrBALKN4QjZ4yKIUveoDbLl1BXiBMDObJ/35M4XJgslpfEPm+EPI/K
         wwcmpDOMoz7cc0AMDXRmhpJFpgU9EoHuKIKFRyep+6VTGkmlDO1XjyCEK+XQT3avcYrL
         jFrPUgx/GQb3XWrPrumSI+6/sWvyyQe31JrvLTLqNTjvjQ3IywJjE8LMpFvtOa+WGTd7
         +tybEn6yQQfBZTz/T7dBZR97lAGAL2ovbBlYM4D6cV7oQvpO9r0hubv9GtltDsxiS0B2
         ORfxjcxcDOZAFxqtsWRGSaWfQJe400tTo6SUWrGGLAuj3/GHvc6sJydJpevej7eVaWmS
         ZyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=IuEgx9iAHvTk1jDMUjBUTSMxKsXFBOFl5qP8s21qcdQ=;
        b=neCu90Wd+1SjnRMabZLCK9SfpwGDcSJHW8ZrojxH0SScuIWc2EzipASdecPSLoDNp6
         SDAl+o0/vOQevH+j1lruUhqtpsQlJ8Yi/l0E31/Tt1R4qwtbtZWnYhpj0QS45l8YAqU0
         ocrVOeLqm+I6ndQ8B1grlnmFOM+zpdHPtHhOiT88pJsX55tbOvtGjQWBKcbjSSm3yZ3B
         MsA1vR1g/HDDs+hv+HMUuK09G8wdcuUB9cwPPgo+aEZGAOk4HBM2SXSLPOwF9AOXax5C
         ObXuJbeDhAsNE4Gkg9OvjqU2y9fWeOFoEc5eMmjGJTyyPeE0FvIkbU3CVlQQIBJQC2vQ
         AX0A==
X-Gm-Message-State: AHQUAuZR4sxFbNgWx3TW5zxG8rChRysr9Rjda5+2RESucdq1WCgPtCLZ
        MwRD/vTWKOhT73CL4UIt5JrVpQ==
X-Google-Smtp-Source: AHgI3IZ65QqQUIyrR8QGpQPFUGxRmshOBJVc62SkwrOkI5xV7vu4+NBBmZeGKdwlHGHdediqmyxtZg==
X-Received: by 2002:a63:da14:: with SMTP id c20mr7390174pgh.233.1550043448750;
        Tue, 12 Feb 2019 23:37:28 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id m67sm27060706pfm.73.2019.02.12.23.37.24
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Feb 2019 23:37:28 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, lanqing.liu@unisoc.com,
        baolin.wang@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: spi: Add the DMA properties for the SPI dma mode
Date:   Wed, 13 Feb 2019 15:36:10 +0800
Message-Id: <2be9d6de92507e5886433fb2cd55117c63b63d72.1550043082.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <11e55b5f9b0d83649a5b81c7e3fdb667cd3ddc5b.1550043082.git.baolin.wang@linaro.org>
References: <11e55b5f9b0d83649a5b81c7e3fdb667cd3ddc5b.1550043082.git.baolin.wang@linaro.org>
In-Reply-To: <11e55b5f9b0d83649a5b81c7e3fdb667cd3ddc5b.1550043082.git.baolin.wang@linaro.org>
References: <11e55b5f9b0d83649a5b81c7e3fdb667cd3ddc5b.1550043082.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lanqing Liu <lanqing.liu@unisoc.com>

Add the DMA properties for the SPI dma mode.

Signed-off-by: Lanqing Liu <lanqing.liu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from v1:
 - Remove sprd,dma-slave-ids property.
---
 Documentation/devicetree/bindings/spi/spi-sprd.txt |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-sprd.txt b/Documentation/devicetree/bindings/spi/spi-sprd.txt
index bad211a..3c7eacc 100644
--- a/Documentation/devicetree/bindings/spi/spi-sprd.txt
+++ b/Documentation/devicetree/bindings/spi/spi-sprd.txt
@@ -14,6 +14,11 @@ Required properties:
 	address on the SPI bus. Should be set to 1.
 - #size-cells: Should be set to 0.
 
+Optional properties:
+dma-names: Should contain names of the SPI used DMA channel.
+dmas: Should contain DMA channels and DMA slave ids which the SPI used
+	sorted in the same order as the dma-names property.
+
 Example:
 spi0: spi@70a00000{
 	compatible = "sprd,sc9860-spi";
@@ -21,6 +26,8 @@ spi0: spi@70a00000{
 	interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 	clock-names = "spi", "source","enable";
 	clocks = <&clk_spi0>, <&ext_26m>, <&clk_ap_apb_gates 5>;
+	dma-names = "rx_chn", "tx_chn";
+	dmas = <&apdma 11 11>, <&apdma 12 12>;
 	#address-cells = <1>;
 	#size-cells = <0>;
 };
-- 
1.7.9.5

