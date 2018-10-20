Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36AAECDE44
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 13:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CBA2152D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 13:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RdWIrKup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88CBA2152D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbeJTWBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 18:01:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38674 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbeJTWBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 18:01:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id d10-v6so624466wrs.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 06:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TwLCHpP8kf+4rr/NbIN453XbTBZTe4XodmQVrexotJY=;
        b=RdWIrKupHcDvm18Sfo9zS/lrKGcwiUvge3qibXzdVmaed+ACU+7HnBHQMPlvut8W5J
         FgOsCoi5GXfb2mujHsZ/AVCommDwAPmYQAOFpg/gajevBp4NHPqDjKmKKdlQ6WXPKahy
         Azs+icTGaoh5BQ3NDLvsUBoNR05C/khgIIYl62Hg5tVHcD+t3sCZEGKBGEBoOVNDFyRp
         AU72yPT+gMZak0Q/frX18AUp3iVrOh7COPpxh0o2X2qwjtryQ45M14k/UmnR0l4TCpdX
         OPgf/MmBaKcTStXOQBNp17zc6nEHSBB+Kkcbsay2SPd5y9WYUThXFNgJZ2ljGpjau9fb
         +VuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TwLCHpP8kf+4rr/NbIN453XbTBZTe4XodmQVrexotJY=;
        b=Av6rZx0S3vxW2jbwsH5TfmnyhTnnU3NqjsyeI+E6UMknHK9G3dAwleg/SveihJlrZe
         fyu6w1BlV+S57swXQggDQiIeZ/+aq07sg/aS8wC6qiDdMq/jETvFAx5fX1o6F3R8xQQ0
         kyEZwtMv472M7qeQYPl+askq3F8oNcbEMrds8a9S/3LuBAI8Ng6wDlXITzc9tP2tUO6S
         2TetAzGSpvCOxTD7hzFI3VC7S4tJbs+UWNIzJ6PtCDnIT4cA0eITGBN2H/j2NRbBqEwK
         8Td/qe81autWmowuumXLg9sAKkrxXQyoktldjtSBXDoEQlO3eg2XLW5chRptwEuFuiRk
         lHcw==
X-Gm-Message-State: ABuFfojoRGYRIq9Ufv7dOgy26CTqrXwOOZk366vCsEFNLZEGjfi9UBYA
        LFjXokT71qpm470nNBlqmpsocA==
X-Google-Smtp-Source: ACcGV61PlikZUj7Qbw+Lc/0wkLSwO/nJIyd8fEDd9dpzZWi3QLt9RKDFst4+6CBC5bnhigN2ytGl3w==
X-Received: by 2002:adf:ecc9:: with SMTP id s9-v6mr36018146wro.142.1540043439647;
        Sat, 20 Oct 2018 06:50:39 -0700 (PDT)
Received: from viisi.sifive.com ([37.152.39.96])
        by smtp.gmail.com with ESMTPSA id o4-v6sm16906615wrj.45.2018.10.20.06.50.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 06:50:39 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Megan Wachs <megan@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 2/3] dt-bindings: clk: add documentation for the SiFive PRCI driver
Date:   Sat, 20 Oct 2018 06:50:23 -0700
Message-Id: <20181020135024.28573-3-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181020135024.28573-1-paul.walmsley@sifive.com>
References: <20181020135024.28573-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding documentation for the Linux driver for the SiFive
PRCI clock & reset control IP block, as found on the SiFive
FU540 chip.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Megan Wachs <megan@sifive.com>
Cc: linux-clk@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
v2: remove out-of-date example, add documentation for the compatible
    string and for the required PCB clock nodes

.../bindings/clock/sifive/fu540-prci.txt      | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sifive/fu540-prci.txt

diff --git a/Documentation/devicetree/bindings/clock/sifive/fu540-prci.txt b/Documentation/devicetree/bindings/clock/sifive/fu540-prci.txt
new file mode 100644
index 000000000000..d7c1e83fa5ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sifive/fu540-prci.txt
@@ -0,0 +1,43 @@
+SiFive FU540 PRCI bindings
+
+On the FU540 family of SoCs, most system-wide clock and reset integration
+is via the PRCI IP block.
+
+Required properties:
+- compatible: Should be "sifive,<chip>-prci<version>".  As of the time this
+              file was written, only one value is supported:
+	      "sifive,fu540-c000-prci0"
+- reg: Should describe the PRCI's register target physical address region
+- clocks: Should point to the hfclk device tree node and the rtcclk
+          device tree node.  The RTC clock here is not a time-of-day clock,
+	  but is instead a high-stability clock source for system timers
+	  and cycle counters.
+- #clock-cells: Should be <1>
+
+The clock consumer should specify the desired clock via the clock ID
+macros defined in include/linux/clk/sifive-fu540-prci.h.  These macros
+begin with PRCI_CLK_.
+
+The hfclk and rtcclk nodes are required, and represent physical
+crystals or resonators located on the PCB.
+
+Examples:
+
+hfclk: hfclk {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <33333333>;
+	clock-output-names = "hfclk";
+};
+rtcclk: rtcclk {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <1000000>;
+	clock-output-names = "rtcclk";
+};
+prci0: prci@10000000 {
+	compatible = "sifive,fu540-c000-prci0";
+	reg = <0x0 0x10000000 0x0 0x1000>;
+	clocks = <&hfclk>, <&rtcclk>;
+	#clock-cells = <1>;
+};
-- 
2.19.1

