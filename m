Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6896C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5549222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="yD0DRYzs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392430AbfBMPJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:09:46 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43730 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392409AbfBMPJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:09:44 -0500
Received: by mail-ed1-f67.google.com with SMTP id f9so2196317eds.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 07:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RXmtNLTc175lxeTH4WR0FnsamrIEb1qNdvropbMnYQY=;
        b=yD0DRYzsVX92dlSIf/PztkWelRkLDlZHneO9ZtSuNOLLwtVOwihBQ/W9zsPLM+j7nN
         Cyv+6IIMNc0F+q4CuHWcviDrfZu3nOweZSpQou71w/SJ1PfbyevjcipIZeiTXcKEm+E5
         FUd86h5EeMHPgu1nlQTSQLJu+vrxLvis/6qepUk8Z8c7K1A/OYj+GrXCXUMbAr0c6xFL
         uorDlZUadR8X3Uw5qr+o9hCPeW5VRARVj5Hl36ROoQyrAxasp5qveLwV0hKQjIPRQn4g
         QH3VPSx4AI08iZ2hBHp5cxpFlAObQ3jl983HsK8nzNmLr/PXjdKFZ42o06TbypBc5DUd
         CSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RXmtNLTc175lxeTH4WR0FnsamrIEb1qNdvropbMnYQY=;
        b=rMeQpxkZaLmePMrNb58CfkJLC3u49PpDRNv3hTYr+UC56LICLFOrvtb1SwOQV6OxoT
         7mp6kaTyFjjgAicw4x4reHZgJvte9zDa29mKLS4LOrIY16QDA7bSw49XH1UXFQs+wXCY
         Y4P+PrPGFr1mNW2uTKvy5g4uw+Bzngux8ge9xWABxo9+0VtO0GAZVV31z8E1REPP5/j1
         EQQzhThvS7qNfbiQaFNyMriMMdU57z399yt9WaXlk4ZnGSoaJYL31u4md8WAoTdt/KGX
         QmvLDGv7rzCW1zBF7jzNdLZfeAHVEcVkdCinJ2Y5TUd5G6tIw+MrvMeCFwF3dm/JP7ND
         tkIw==
X-Gm-Message-State: AHQUAuYW2IQzJXl0pSeia9PPvzMn5SJn7HLuiyZQoFFNEBpEWzuzBH52
        1nMTbFUClm5kaDcPUQSJRWFUEA==
X-Google-Smtp-Source: AHgI3IYm6lK0YlhtSzkgX6CYrK6Mz5b5BmHD0nzdKeKE8+Irkx/R5nZ608RzcZTgog2SWuH7Cq9n+Q==
X-Received: by 2002:a50:b902:: with SMTP id m2mr769570ede.108.1550070582788;
        Wed, 13 Feb 2019 07:09:42 -0800 (PST)
Received: from loys-ubuntu-BY1835A49200471.thefacebook.com ([2620:10d:c092:180::1:4505])
        by smtp.googlemail.com with ESMTPSA id k26sm1903941ejv.63.2019.02.13.07.09.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Feb 2019 07:09:42 -0800 (PST)
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
Subject: [PATCH v4 2/4] dt-bindings: gnss: add mediatek binding
Date:   Wed, 13 Feb 2019 16:09:27 +0100
Message-Id: <1550070569-18588-3-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550070569-18588-1-git-send-email-lollivier@baylibre.com>
References: <1550070569-18588-1-git-send-email-lollivier@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for Mediatek-based GNSS receivers.

Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
---
v4:
Use standard names for reset-gpios and gnss-fix-gpios
s/an/a UART

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
index 000000000000..12283d429baa
--- /dev/null
+++ b/Documentation/devicetree/bindings/gnss/mediatek.txt
@@ -0,0 +1,37 @@
+Mediatek-based GNSS Receiver DT binding
+
+Mediatek chipsets are used in GNSS-receiver modules produced by several
+vendors and can use a UART interface.
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
+- current-speed		: Default UART baud rate
+- gnss-fix-gpios	: GPIO used to determine device position fix state
+			  (pin name: FIX, 3D_FIX)
+- reset-gpios		: GPIO used to reset the device
+  		  	  (pin name: RESET, NRESET)
+- timepulse-gpios	: Time pulse GPIO (pin name: PPS1, 1PPS)
+- v-bckp-supply		: Backup voltage regulator
+  			  (pin name: VBAT, VBACKUP)
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

