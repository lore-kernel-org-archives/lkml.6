Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA1AC43612
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 05:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D1F20656
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 05:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DcTyiDjq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbeLOFWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 00:22:41 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39441 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730086AbeLOFWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 00:22:37 -0500
Received: by mail-pf1-f194.google.com with SMTP id c72so3802396pfc.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 21:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/liDBIpQXNSCjmDraeSlsWQ6WORYpTFOBdDULIY1SWU=;
        b=DcTyiDjqBzYIaA513uHWLRLPoYRoX5rk9vElhcz0rY+QpmqVnrH4Ih+cVjTwFP9cpB
         P7SjeKKmjWSeZObpJLVNDZTi2mz8KDve72UK/T7rLNNml4QLpXwgcFLo8IxuMIA6CYRg
         I3U2S4tCWFDLFpD1Nq9KwDtFE49uOmmmfb+DVuxsETyiV9/AAg2/TsPOiTF9hFQPPOT0
         3eHXk2Uko/CUs7kMHEHSwADlrWpvOVYCaw/RHBhl/0ijL62pCCqxrO0qyP+zF0kkYB/S
         GNzM9ckJ2wug9vqH+e98YAAgJQsW9Tv0P0c04H+YlpXZsquoUirBZYED1RRrGXfjBYGF
         WGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/liDBIpQXNSCjmDraeSlsWQ6WORYpTFOBdDULIY1SWU=;
        b=Nv5AsJSy1YO009CVbgTE+d2B8XdP6WhFGlMPkDd6OslldiSlJrAhW64FI8EYtebcj+
         sR6OcAAJF6MQrqUC/e6B8Q+1WpjopGdF17hKkEeH+Ki42uEzIGzzFvK/loVs2/eUqYDd
         5oH8nXFie8zqY+eGZeW7Mk9L0TR09hmk4CVcUsizY3h1Zzg+TP5oS+dJzUW3snP8wOsp
         ZuiwfKXD6wcfMETUszSDZm/DBjhSeNvYdJE5ULYHrveBVlNy5Tyy+waRJM1OMRNyovWb
         ZoqThqMgOBuo/G8kanzfqBWbdPi+nCvO9H/DAZB1lPUf5rsj1vXG4pTRoze/qzDGKQX5
         8kEA==
X-Gm-Message-State: AA+aEWa0k6QXLBflQ+HcWDhocQwGm1yhzeo0AcsRK+Z7nUdnBvQAROG1
        Zo7pxLf5f0Qy2loSxkgj8paN4pyyKEQ=
X-Google-Smtp-Source: AFSGD/UpV6Y5WhGohaLi/Mw4QzdLhEDnYwu8aaLd3eP/aEzvL3y2Sx7CYNM3JAxBafNxujZcs0Ltvg==
X-Received: by 2002:a63:801:: with SMTP id 1mr5044606pgi.275.1544851356054;
        Fri, 14 Dec 2018 21:22:36 -0800 (PST)
Received: from viisi.sifive.com ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id z127sm11351282pfb.80.2018.12.14.21.22.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 21:22:35 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 7/7] riscv: dts: add initial board data for the SiFive HiFive Unleashed
Date:   Fri, 14 Dec 2018 21:21:54 -0800
Message-Id: <20181215052154.24347-8-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181215052154.24347-1-paul.walmsley@sifive.com>
References: <20181215052154.24347-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial board data for the SiFive HiFive Unleashed A00.

Currently the data populated in this DT file describes the board
DRAM configuration and the external clock sources that supply the
PRCI.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: devicetree@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/riscv/boot/dts/Makefile                  |  2 +
 arch/riscv/boot/dts/sifive/Makefile           |  4 ++
 .../dts/sifive/hifive-unleashed-a00-fu540.dts | 39 +++++++++++++++++++
 3 files changed, 45 insertions(+)
 create mode 100644 arch/riscv/boot/dts/Makefile
 create mode 100644 arch/riscv/boot/dts/sifive/Makefile
 create mode 100644 arch/riscv/boot/dts/sifive/hifive-unleashed-a00-fu540.dts

diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
new file mode 100644
index 000000000000..dcc3ada78455
--- /dev/null
+++ b/arch/riscv/boot/dts/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+subdir-y += sifive
diff --git a/arch/riscv/boot/dts/sifive/Makefile b/arch/riscv/boot/dts/sifive/Makefile
new file mode 100644
index 000000000000..e120ccf5649c
--- /dev/null
+++ b/arch/riscv/boot/dts/sifive/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_SIFIVE) += hifive-unleashed-a00-fu540.dtb
+
+
diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00-fu540.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00-fu540.dts
new file mode 100644
index 000000000000..0c6afabe69e3
--- /dev/null
+++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00-fu540.dts
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: Apache-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) 2018 SiFive, Inc */
+/* See the file LICENSE for further information */
+
+/dts-v1/;
+
+#include "fu540-c000.dtsi"
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	model = "SiFive HiFive Unleashed A00 (FU540-C000)"
+	compatible = "sifive,hifive-unleashed-a00-fu540",
+		"sifive,hifive-unleashed-fu540";
+
+	chosen {
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x1f 0x80000000>;
+	};
+
+	soc {
+		hfclk: hfclk {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <33333333>;
+			clock-output-names = "hfclk";
+		};
+		rtcclk: rtcclk {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <1000000>;
+			clock-output-names = "rtcclk";
+		};
+	};
+};
-- 
2.20.0

