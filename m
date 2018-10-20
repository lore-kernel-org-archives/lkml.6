Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C43CECDE45
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 13:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8602152D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 13:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OBiHFoRW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A8602152D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbeJTVtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 17:49:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45956 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbeJTVtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 17:49:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id f17-v6so8438555wrs.12
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 06:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZvxOUP5Fom85HZYW6S3mncAl5RrZvlD+akPdxng1h0A=;
        b=OBiHFoRWGSmBv7ST/JPrISARyB8LRjBOUYLcjAKz8XWUZyA2L3FCOttjWFJeXVvyqr
         8pmxNj86PAIkXrw187mSpr/qK6pFofaNLRlMy6UGs4YGUurpYeF4CRgVj5TZtu044yTQ
         tnOkMWY3yO1d8QsgpkyEFSagnyoQ8V63WzoAvGHfsjKXe+vs1xlbNiXXYReSUfNJbz05
         cVKM0NTvF/EzQw68ymE6YMT9gk12+lnfDvvUKOA3lTxUKR6rsStWSsCM2yZIux+HCi+u
         Nz2A+UKrw+pukQTAYkmMJulGQL2XogQTiR8Vvh9myI7W17+0yhw4cKvD99XGBcPZTevm
         ScCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZvxOUP5Fom85HZYW6S3mncAl5RrZvlD+akPdxng1h0A=;
        b=LT9g+lCDW2qrPAIL7dDiKRVPaErytEbWiOSBk0KjzYkR4ioqG2Pmk0b8xG1Mfd6Eld
         nXGZNFiTFN+xXD6Zt5d6bezdDci6yFFydkjUiOQl+2X4GUilwMTMu2F8Z3XmZXQ+n/RS
         qNnJzQ0qJMc2HpDG95MbAWJ89eO9PiUhO89mKbXBFBh2Xlz+YvhenEwEDnYFq+Wvrhkk
         HvDfJwsQPfaBpOsLaA9Z92QZvwn/LIOrKUF02JBCpehNJ6oohKyCBtnwp0bVbtrgYKdx
         6yHLKgSmZ5H6yNMkqgi6xKBu1F6LlbUGqJCvwND/ZeWXf60kUK4L+j3UIebs3Gb1KffY
         1PLg==
X-Gm-Message-State: AGRZ1gLH85bobrxxen0gqw9uOJGZc6gnKzGfcvikRGdMc1IHtGJg3NvP
        z+Q6DPDTBBC5Pvethylp7WoCFg==
X-Google-Smtp-Source: AJdET5fwa2wuI67FoW/kdcoyeYefbSZ/8qcn2kZ0BY8xUuW5D54vtMt75emXeALF9/wR6n/a2pEKTg==
X-Received: by 2002:adf:9246:: with SMTP id 64-v6mr6403097wrj.130.1540042721693;
        Sat, 20 Oct 2018 06:38:41 -0700 (PDT)
Received: from viisi.sifive.com ([37.152.39.96])
        by smtp.gmail.com with ESMTPSA id f1-v6sm5227207wme.23.2018.10.20.06.38.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 06:38:41 -0700 (PDT)
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
Subject: [PATCH 2/3] dt-bindings: clk: add documentation for the SiFive PRCI driver
Date:   Sat, 20 Oct 2018 06:38:23 -0700
Message-Id: <20181020133823.27103-3-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181020133823.27103-1-paul.walmsley@sifive.com>
References: <20181020133823.27103-1-paul.walmsley@sifive.com>
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
Cc: Megan Wachs <megan@sifive.com>                                                                                                                    Cc: linux-clk@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 .../bindings/clock/sifive/fu540-prci.txt      | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sifive/fu540-prci.txt

diff --git a/Documentation/devicetree/bindings/clock/sifive/fu540-prci.txt b/Documentation/devicetree/bindings/clock/sifive/fu540-prci.txt
new file mode 100644
index 000000000000..27d8fdd4f3a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sifive/fu540-prci.txt
@@ -0,0 +1,40 @@
+SiFive FU540 PRCI bindings
+
+On the FU540 family of SoCs, most system-wide clock and reset integration
+is via the PRCI IP block.
+
+Required properties:
+- compatible: Should be "sifive,fu540-c000-prci0"
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
+
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
+	compatible = "sifive,fu540-c000-prci0", "sifive,prci0";
+	reg = <0x0 0x10000000 0x0 0x1000>;
+	clocks = <&hfclk>, <&rtcclk>;
+	#clock-cells = <1>;
+};
-- 
2.19.1

