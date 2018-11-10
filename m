Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACD7C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 03:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107262081C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 03:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2l/FMIA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 107262081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbeKJNXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 08:23:14 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36890 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728228AbeKJNXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 08:23:14 -0500
Received: by mail-pl1-f195.google.com with SMTP id p6-v6so1799111pll.4;
        Fri, 09 Nov 2018 19:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wv6fd964pW9dxicq1yuADx/MUx25lUSe35PJfYc6suA=;
        b=h2l/FMIA6g5DrHx2mpI7QHi03dOzZ9eDQXepMi609VDVYehhWG58tj2QkUh/apHmCu
         3jhk3pW5pmqXktTHwYDZrG602P8RB+3H6t3lf2bCaTn5SEn9IoXDcabaYYuT0GSMLqf+
         CnSFvAAcIP66SMtBKKSB1x8DjO+gK6HAv4MUc4iboGcHVLd1gU7F8c9llny4e4EOugsE
         7Veyy3KXByDZCHbeaM+FJCoJOt5HfSyY0XsX/OWo7KtOVC9PTqQUpa+qy7GVXVPhSnaK
         5nFXU1n50Wlc9a4jMQqgvISBWU/eHxNalvwv3L4Oalwd9ZuHdTMBR66URiTkELieaxEd
         Jlrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wv6fd964pW9dxicq1yuADx/MUx25lUSe35PJfYc6suA=;
        b=pf9XI2gFAfcwKMJH/sLiBUQ+upZ0DhCZoVzuAmy7JECRISCbxmt0opkGzljNAaNiyd
         t2mFh9wvI/DjiismbVmDQQh2lHKKInT55CvRUVBc8v2mqHTqVrkAptxQiUMiR9x9eGkn
         TAU3jKlvc2S55JglgI+humMoRWQxqi1lhphfM/Ft/AzPE+2gUfHlgkK2njpbV60MdVR/
         sSgeywTpPYmVtOhJGDrk7eNOr/jm3Y83yRs3GWJ8vXqnH7TPRHWTIeMkhILhhMwtAGTL
         4CQoOtC857kbtW8N1Tty3cBwe/dVXG4v/cYabL53xmnvj4CMYyMeX/CNwSTT7w/cFlHB
         qshA==
X-Gm-Message-State: AGRZ1gIrGsp2mCe3GfE5DC7IerU8ciOiPgn18AFyTPFl7klv7JLTxbTh
        qxy6m+B1FuNgBHmHkUDcnGU=
X-Google-Smtp-Source: AJdET5dsMq9oV0wFSupTYpL0OYVl24KjN3XMZrWXkZCrYc+RNxv5l/kWJuMG3+ALkyAuhwF8igJY+A==
X-Received: by 2002:a17:902:6185:: with SMTP id u5-v6mr11328973plj.41.1541821183190;
        Fri, 09 Nov 2018 19:39:43 -0800 (PST)
Received: from localhost.localdomain ([45.76.192.69])
        by smtp.gmail.com with ESMTPSA id w2-v6sm10191359pfn.89.2018.11.09.19.39.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 19:39:42 -0800 (PST)
From:   He Yangxuan <yangxuan8282@gmail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, carlo@caione.org, khilman@baylibre.com,
        narmstrong@baylibre.com, He Yangxuan <yangxuan8282@gmail.com>
Subject: [PATCH v5 1/3] arm64: dts: meson-gxl: add support for phicomm n1
Date:   Sat, 10 Nov 2018 11:39:02 +0800
Message-Id: <20181110033904.4207-2-yangxuan8282@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181110033904.4207-1-yangxuan8282@gmail.com>
References: <20181110033904.4207-1-yangxuan8282@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the Phicomm N1. This device based on P230 reference design.
And this box doesn't have cvbs, so disable related section in device tree.

Signed-off-by: He Yangxuan <yangxuan8282@gmail.com>
---
 arch/arm64/boot/dts/amlogic/Makefile                |  1 +
 .../boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index c31f29d66..49f3ac5d8 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -18,6 +18,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-nexbox-a95x.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-p212.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p230.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p231.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-phicomm-n1.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s805x-p241.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-p281.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-tx3-mini.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts
new file mode 100644
index 000000000..9a8a8a7e4
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2018 He Yangxuan
+ */
+
+/dts-v1/;
+
+#include "meson-gxl-s905d-p230.dts"
+
+/ {
+	compatible = "phicomm,n1", "amlogic,s905d", "amlogic,meson-gxl";
+	model = "Phicomm N1";
+
+	cvbs-connector {
+		status = "disabled";
+	};
+};
+
+&cvbs_vdac_port {
+	status = "disabled";
+};
-- 
2.11.0

