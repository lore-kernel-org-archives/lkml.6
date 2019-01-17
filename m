Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0B7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781A520855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="H0Of10pf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbfAQQzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:55:03 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53778 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbfAQQyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:54:44 -0500
Received: by mail-wm1-f66.google.com with SMTP id d15so1806311wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b8QgOE/tP8Qxz0RDuzfPpPYFYowoEBOjoA8eqPauTxo=;
        b=H0Of10pfwb0GAxVCtSdHEMcUdQGVnzowP83zcS2ctxKASi53pk7mJaigAIOY0eQhkg
         NmZX/E1bwDrCf/n6l1XP1LFfL8WNDNmm4LFWiWaulVt9/6IWcQvvQHe3CnXA9qhp3NCj
         7/olVS/pMbpbUTzsNsEvwKwftD4W0IU3R9r+YBtT7jK5A9BQ5lCZUxNtpFNEBXQTm9G6
         u6d1txDihVH8TLJ+ERFZhXOVUQ5PCn26s31KrC28xgpJfjtxvV8SsgFwgfdAv4NMNzXC
         aCiKOeTT2jmVSh8cMkzugkzzgWQ1fCSDS7J9fUWMel44gdh/f0UERKITvwRXCxbWly4V
         JrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b8QgOE/tP8Qxz0RDuzfPpPYFYowoEBOjoA8eqPauTxo=;
        b=iMmW1OK5ZJ9J0dGMVFgYW7zUiGPYeIGBTgWsfKmsUuTC3RYXMbVsQmzBLxliiypdfq
         wuVYILrqfjVC/n/FoMaMJgth0WnKinaAwQVb//+aS1uhx4NAsnaIbHbVc6K4QD4A9FEE
         5Smv4Xl0lobiyqXMHGYqI5eLpMC3aku1+bHUrk04x26HObsRFRovi0rKtECQt8pS9kYT
         K+DmYeMFbbksEk0Fn5RS3L/MivrttRxl8FmBV1Z6ehNj2hrdbSKNIsUWRq/NKaeU311A
         LjWmZPcCdbKBex2k8S5oPZfBMnfE5deH69logVDAq014QMT/e0IFHM4kV7KnpvPfIDV6
         mS7A==
X-Gm-Message-State: AJcUukdXQivb7yxHPfz4Rl10bLWPLzG/LNH7QdcIbOasmlCoarxYZcqp
        tKzAhgmPJ7B7csqrt87RslMk0g==
X-Google-Smtp-Source: ALg8bN4SF57si1/YPd/9aUuvRaLoUikPxer9tLyuwYYMwjAf+wqgeEhhNOmtost06mEEjob9LtIuyw==
X-Received: by 2002:a1c:96ce:: with SMTP id y197mr12976064wmd.36.1547744082833;
        Thu, 17 Jan 2019 08:54:42 -0800 (PST)
Received: from loys-ubuntu-BY1835A49200471.thefacebook.com (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id b12sm65309630wrt.17.2019.01.17.08.54.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Jan 2019 08:54:42 -0800 (PST)
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
Subject: [PATCH v2 2/4] dt-bindings: gnss: add mediatek binding
Date:   Thu, 17 Jan 2019 17:54:32 +0100
Message-Id: <1547744074-28308-3-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
References: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for Mediatek-based GNSS receivers.

Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
---

v2:
Renamed bindings from Globaltop/gtop to Mediatek/mtk.
Moved current-speed as an optional propertie.
Removed the status line in the example.
Added "mediatek,mt3339" compatible.

 .../devicetree/bindings/gnss/mediatek.txt          | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gnss/mediatek.txt

diff --git a/Documentation/devicetree/bindings/gnss/mediatek.txt b/Documentation/devicetree/bindings/gnss/mediatek.txt
new file mode 100644
index 000000000000..fd984b4a9a6d
--- /dev/null
+++ b/Documentation/devicetree/bindings/gnss/mediatek.txt
@@ -0,0 +1,39 @@
+Mediatek-based GNSS Receiver DT binding
+
+Mediatek chipsets are used in GNSS-receiver modules produced by several
+vendors and can use UART, SPI or I2C interfaces.
+
+Please see Documentation/devicetree/bindings/gnss/gnss.txt for generic
+properties.
+
+Required properties:
+
+- compatible	: Must be one of
+
+			"globaltop,pa6h"
+			"mediatek,mt3339"
+
+- vcc-supply	: Main voltage regulator (pin name: 3V3_IN, VCC, VDD)
+
+Required properties (I2C):
+- reg		: I2C slave address
+
+Required properties (SPI):
+- reg		: SPI chip select address
+
+Optional properties:
+
+- timepulse-gpios	: Time pulse GPIO
+- v-bckp-supply		: Backup voltage regulator
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

