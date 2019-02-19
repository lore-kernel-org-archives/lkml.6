Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C0AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A052147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jPXPgTjA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbfBSLkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 06:40:52 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39722 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbfBSLkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 06:40:51 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so10325998pld.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 03:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HIz4WqHdWYeQ3lkgJK9b2XM4IGZAxsw+zj/jLhdUw3c=;
        b=jPXPgTjADVt2+smuFo/EEaOowKhqwX/01aQQpu94dpBEHTRqdZHCopqJ48PyFWUn17
         7KY8rIbKUV0L7zhDsDIbs7H3i7rOrmEXdlHQBwYSZ5KJXr3ivJiSOuLxL9VtQploH7vh
         7Ens8nI7UIuMaOKegIVWFfkYf62F/5wwxmXF3z7TXW+7WXASELjtG+uSqVbhl8RRYdJe
         ZowRGNrjstb/mKNMQ7t+il98T+91tjjz/gi3hpA9M11smQuV0WF7E3T9I34qPlxpPCqK
         mM7OO602/MJCNBkpR1OxbraamnM5CfA4PnM8PXu+68VbiIlNQxOeZ3qoGSFz41kUvv8i
         nqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HIz4WqHdWYeQ3lkgJK9b2XM4IGZAxsw+zj/jLhdUw3c=;
        b=OMq3+K5mfyhn1yKrIJPUYiIqM1m3XWka2Ud2gcjPU4bd+pcgMs76DTzIYx1MRamsM/
         OXoiTJa/l8v3kz7z645tnT33LQGx8V3ZaJLx5PUijpNPXtcu6Lz1+h+HrTRxwdSBwtZA
         80QJ5iVAPenqIqlDfOb/eIZ1vJlYv99lUpPltgBTx1ElEDh9EExKMSGrDE0LvFdSCEfg
         u+8Xgz8nqMZB7RvM75bwVU1Ih/7GS0UKIi3RxIFxtC35ic1VKGK52MlBcTWi2s1XCuqI
         7JT2hxPXP8q0gpapw+RswzGdcd7/bmkjQUyeci3jMX5/EZl5GEFrAv412mtMklUvTHt2
         HeEA==
X-Gm-Message-State: AHQUAuaXxal6DLWP5HlNyPg/vU3dOP4yelwq2UEn1X+FjJutpgCUIeqp
        b6670u8KRPA79gMDMjYQTX13aQ==
X-Google-Smtp-Source: AHgI3Ia4opb4C4j1RKzH/PI1euLWE6o1bbHCPXTT8YroDhOvbZoZL+hUVjvkrJu+a5QTkLZ7sMeHrw==
X-Received: by 2002:a17:902:a514:: with SMTP id s20mr20268782plq.242.1550576450476;
        Tue, 19 Feb 2019 03:40:50 -0800 (PST)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id t3sm32250678pfa.50.2019.02.19.03.40.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Feb 2019 03:40:49 -0800 (PST)
From:   Yash Shah <yash.shah@sifive.com>
To:     palmer@sifive.com, linux-spi@vger.kernel.org,
        linux-riscv@lists.infradead.org, broonie@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, paul.walmsley@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH 1/2] spi: sifive: Add DT documentation for SiFive SPI controller
Date:   Tue, 19 Feb 2019 17:10:06 +0530
Message-Id: <1550576407-17778-2-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550576407-17778-1-git-send-email-yash.shah@sifive.com>
References: <1550576407-17778-1-git-send-email-yash.shah@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT documentation for SPI controller added.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Yash Shah <yash.shah@sifive.com>
---
 .../devicetree/bindings/spi/spi-sifive.txt         | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sifive.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-sifive.txt b/Documentation/devicetree/bindings/spi/spi-sifive.txt
new file mode 100644
index 0000000..3f5c6e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-sifive.txt
@@ -0,0 +1,37 @@
+SiFive SPI controller Device Tree Bindings
+------------------------------------------
+
+Required properties:
+- compatible		: Should be "sifive,<chip>-spi" and "sifive,spi<version>".
+			  Supported compatible strings are:
+			  "sifive,fu540-c000-spi" for the SiFive SPI v0 as integrated
+			  onto the SiFive FU540 chip, and "sifive,spi0" for the SiFive
+			  SPI v0 IP block with no chip integration tweaks.
+			  Please refer to sifive-blocks-ip-versioning.txt for details
+- reg			: Physical base address and size of SPI registers map
+			  A second (optional) range can indicate memory mapped flash
+- interrupts		: Must contain one entry
+- interrupt-parent	: Must be core interrupt controller
+- clocks		: Must reference the frequency given to the controller
+- #address-cells	: Must be '1', indicating which CS to use
+- #size-cells		: Must be '0'
+
+Optional properties:
+- sifive,fifo-depth		: Depth of hardware queues; defaults to 8
+- sifive,max-bits-per-word	: Maximum bits per word; defaults to 8
+
+SPI RTL that corresponds to the IP block version numbers can be found here:
+https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/spi
+
+Example:
+	spi: spi@10040000 {
+		compatible = "sifive,fu540-c000-spi", "sifive,spi0";
+		reg = <0x0 0x10040000 0x0 0x1000 0x0 0x20000000 0x0 0x10000000>;
+		interrupt-parent = <&plic>;
+		interrupts = <51>;
+		clocks = <&tlclk>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		sifive,fifo-depth = <8>;
+		sifive,max-bits-per-word = <8>;
+	};
-- 
1.9.1

