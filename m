Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915EEC00319
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 20:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6055220663
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 20:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5E238wT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbfBXUdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 15:33:45 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38186 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfBXUdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 15:33:44 -0500
Received: by mail-pl1-f196.google.com with SMTP id g37so661404plb.5;
        Sun, 24 Feb 2019 12:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KnnxHwkDJFIYf3W9dWpRpBGaF42LRM0p/MCcNDxRd+E=;
        b=G5E238wTz3ko9ARX0FzIuZ6Dsv++poSBZhwhSAmots9FzBMCadcMTkXg/EECFdy/GO
         ME3ukX40PkccPuhu2wV8+ywJCboaCmP9aedkIKMcvI7G7rN/MuHun/6XJyHwuzoDSrS/
         sWyGkHG87ezV8C1eYwyd9q3jnhJZu7sCy1H1M7s4jpzdfx1JPoLJeDjBkj9U9Wrr3dYy
         yHzgSJyx1H3a4WTRDtVgp+L2NrI09Y1w/zSIg1dSaWYGNTYCJAjdNOiAgIQBCxPFsb2/
         nV01+WXuwdmNNEvSN9hCw41iMKq09vdVKOavYX/nZZVu8a3qgpoEki/9Z5wm4Un0NV3q
         7cYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KnnxHwkDJFIYf3W9dWpRpBGaF42LRM0p/MCcNDxRd+E=;
        b=THyGsN4ABEX3/23ixAEvC2dhnVKvfJR3+Ci3TveV2voOthTykcZmeWx13/m2/Y+n01
         Moxu6wQWqGcPyZkrUlSCjM6yomxZWDQVj2mgweI8qEuwlyPufwOerB3RIRQVNHBFZYoY
         ooWydM0r7tpVtQ7fTDPt1ZSBtTePJ4aohrD3qpfvoAO8cQPO9BzH1S+vQ0Q0tCMFT6t+
         gXmJbjiXWKQ0zMxFqP+DJWpdZVV7/MjcRMRNhJqEugLk7qFG6bti/+WjkOfci6dz63ih
         sBokKMLeOMIZH9CE3tyG0vQw+JNEIsKDSK+bLgZPdgN5nfTflvS0F37nuIEy2SK6ijsv
         NwKg==
X-Gm-Message-State: AHQUAuYQf22gkO+PRJ7GKD652zEv8f0pCGHgezn8+lWM39nEEwCDIhVB
        C7DDqs+g0zIgP0SHXhWJtiY=
X-Google-Smtp-Source: AHgI3IYSkoMu8iFfOkRNLemNOJK67HMqduXj7Rfo35bEb2b0RKjUosTyhviihirW38li95+BENJx2Q==
X-Received: by 2002:a17:902:7688:: with SMTP id m8mr15054553pll.248.1551040423865;
        Sun, 24 Feb 2019 12:33:43 -0800 (PST)
Received: from bobby.hsd1.or.comcast.net ([2601:1c0:5501:37e2::e774])
        by smtp.googlemail.com with ESMTPSA id 70sm24105423pfr.43.2019.02.24.12.33.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 12:33:43 -0800 (PST)
From:   Robert Eshleman <bobbyeshleman@gmail.com>
To:     bobbyeshleman@gmail.com
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] dt-bindings: iio: light: Add ap3216c
Date:   Sun, 24 Feb 2019 12:33:51 -0800
Message-Id: <b1689e99c868d19aa33932b0a96944852e91db45.1551037168.git.bobbyeshleman@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <42dbbd7568e4216a320c6fd617bd91c1ee045af0.1551037168.git.bobbyeshleman@gmail.com>
References: <42dbbd7568e4216a320c6fd617bd91c1ee045af0.1551037168.git.bobbyeshleman@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds device tree bindings for the ap3216c ambient light and proximity
sensor.

Signed-off-by: Robert Eshleman <bobbyeshleman@gmail.com>
---
 .../devicetree/bindings/iio/light/ap3216c.txt | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/ap3216c.txt

diff --git a/Documentation/devicetree/bindings/iio/light/ap3216c.txt b/Documentation/devicetree/bindings/iio/light/ap3216c.txt
new file mode 100644
index 000000000000..c5ae80c79dd8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/ap3216c.txt
@@ -0,0 +1,22 @@
+* AP3216C Ambient Light and Proximity Sensor
+
+Required properties:
+  - compatible: should be "liteon,ap3216c"
+  - reg: the I2C address of the sensor (default is <0x1e>)
+
+Optional properties:
+  - interrupts: interrupt mapping for GPIO IRQ. Should be configured with
+    IRQ_TYPE_EDGE_FALLING.
+
+Refer to interrupt-controller/interrupts.txt for generic interrupt client
+node bindings.
+
+Example:
+
+light-sensor@1e {
+	compatible = "liteon,ap3216c";
+	reg = <0x1e>;
+
+	interrupt-parent = <&gpio1>;
+	interrupts = <17 IRQ_TYPE_EDGE_FALLING>;
+};
-- 
2.20.1

