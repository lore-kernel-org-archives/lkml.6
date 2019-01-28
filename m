Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7E0C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A47F20811
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="RDmU414o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390297AbfA1Qib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:38:31 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38620 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389969AbfA1QiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:38:10 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so18767728wrw.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 08:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9TWS3RWKZyY10HyUQ8/8Pkd3n2zCGA7KyKif2utYLQk=;
        b=RDmU414oN71nkBAYiPqn/5DnY9a/u9LMT3qHlV2ydHCc9+jtKa3TZNdEJgRBEKLjco
         NI+Lb1XZrxNIUcye9zYNtrllkeaj2GBJoJI7Z/i1XARKPFGR9kWhG+lXT2jrRFEJnFXG
         fb0nNllUVAVqtLBaoWLKoW9l+FHgd0sKaMl5VY5QMFASIbkKM3vKMmKsLdNCuDCWoG46
         0AMutNJrNG1RtjHGwSWyW5Q7n5J90mjXDurK03szScyb9cpynPLrpT31fd8bU0tOTEb2
         EzYmx8T2acxvSwN8Brv/qxA6tYytvzdG1jBUYjMrnKEiND2F1CQCHlEcU9+/R2aYozSO
         qW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9TWS3RWKZyY10HyUQ8/8Pkd3n2zCGA7KyKif2utYLQk=;
        b=tX1sSRTCD5/gec7LLd/X7iciXbfuNrg2VtlYikSNRrmd2MeiujAaRKdJTTtiAT423e
         0ZSLXnSaA4UBjfbh9R8v3vTRk3Z16j3QUerFFjy8P+/LoofleCfI5MESI5Yj8ViOBiKp
         mODuehO0yGoqNfvs+XJ80afCwRbzSvdgtMHBNLuMgpV9FFc5k7I/18VORW5RI/BPtjjg
         Ej97MmtnyaH2xtbqIzRNMbK2tD40qxQfsbqJm70J0te8XTczFLcOduD4A0U9amUzYsZ1
         DzT70v0TBPd/t0m9TrRwRW6phAhIuGIIOB5U+tHLhVEDKEy9TGCRKRlB3WH1Fgv+ZSDQ
         hvqQ==
X-Gm-Message-State: AJcUukdFYwGdZGCI66gnl9JQMUut//uBYV/u/uCju4suuBZxhlSEX6kk
        8ZemQfkExFMvDFqzHk9ULaxBJQ==
X-Google-Smtp-Source: ALg8bN4eVHINugfE+Wj5WD3XT4PnxZy5JY6koo/ABOSVBWhpinarToJm9cMVU9wRXD/OYiuX3Zt80A==
X-Received: by 2002:a5d:5182:: with SMTP id k2mr22490514wrv.121.1548693488056;
        Mon, 28 Jan 2019 08:38:08 -0800 (PST)
Received: from loys-ubuntu-BY1835A49200471.thefacebook.com ([2620:10d:c092:180::1:d40b])
        by smtp.googlemail.com with ESMTPSA id s3sm52388982wmj.23.2019.01.28.08.38.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jan 2019 08:38:07 -0800 (PST)
From:   Loys Ollivier <lollivier@baylibre.com>
To:     devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>
Cc:     Loys Ollivier <lollivier@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 2/4] dt-bindings: gnss: add mediatek binding
Date:   Mon, 28 Jan 2019 17:37:59 +0100
Message-Id: <1548693481-1162-3-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548693481-1162-1-git-send-email-lollivier@baylibre.com>
References: <1548693481-1162-1-git-send-email-lollivier@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for Mediatek-based GNSS receivers.

Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
---

v3:
Removed the I2C and SPI interfaces references.
Removed the "mediatek,mt3339" compatible line.
Added the optional propertied (reset, fix)
Added the pin names for the optional properties.

v2:
Renamed bindings from Globaltop/gtop to Mediatek/mtk.
Moved current-speed as an optional propertie.
Removed the status line in the example.
Added "mediatek,mt3339" compatible.

 .../devicetree/bindings/gnss/mediatek.txt          | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gnss/mediatek.txt

diff --git a/Documentation/devicetree/bindings/gnss/mediatek.txt b/Documentation/devicetree/bindings/gnss/mediatek.txt
new file mode 100644
index 000000000000..00650d81c5c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/gnss/mediatek.txt
@@ -0,0 +1,37 @@
+Mediatek-based GNSS Receiver DT binding
+
+Mediatek chipsets are used in GNSS-receiver modules produced by several
+vendors and can use an UART interface.
+
+Please see Documentation/devicetree/bindings/gnss/gnss.txt for generic
+properties.
+
+Required properties:
+
+- compatible	: Must be
+
+			"globaltop,pa6h"
+
+- vcc-supply	: Main voltage regulator (pin name: VCC)
+
+Optional properties:
+
+- gtop,reset-gpios	: GPIO used to reset the device
+  			  (pin name: RESET, NRESET)
+- gtop,fix-gpios	: GPIO used to determine device position fix state
+			  (pin name: FIX, 3D_FIX)
+- timepulse-gpios	: Time pulse GPIO (pin name: PPS1, 1PPS)
+- v-bckp-supply		: Backup voltage regulator
+  			  (pin name: VBAT, VBACKUP)
+- current-speed		: Default UART baud rate
+
+Example:
+
+serial@1234 {
+	compatible = "ns16550a";
+
+	gnss {
+		compatible = "globaltop,pa6h";
+		vcc-supply = <&vcc_3v3>;
+	};
+};
-- 
2.7.4

