Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18C0C282C3
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 04:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718F3218CD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 04:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G7oDI9X0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbfAZELH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 23:11:07 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37442 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729613AbfAZELH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 23:11:07 -0500
Received: by mail-pg1-f195.google.com with SMTP id c25so5012685pgb.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 20:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zwq/fMdcgA58BB2frt4nPrnsexnAJmLHano6hGtPJbI=;
        b=G7oDI9X02JXb5jWSWxHginc5z5PpTZe/xrxwjBKLhB78MYbePD8X7Bu+Z+tK1tTj2l
         lysZ3mIJrhkuxary1Sa7nAfEonzfZAHrZe92lsxyx3APOyZ55xBZfLAzKalDv2/IvBBg
         eEspoYqd7XF6MWuAHV6rJjGVCnHaVvVQ2U5k0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zwq/fMdcgA58BB2frt4nPrnsexnAJmLHano6hGtPJbI=;
        b=tYNVWicR1hva3bmbr6vN045gduvYle7d7rnYhZxARyvgE7oh6aBgFYsn9qJw8XIxU3
         VucZyJupRolbeatv3xrMqekuSKet7TWBvCb4IkKljcAYubxx1aHpm1GX9x0cWx8R6PO3
         iY8G+Hz+K4ZeDEnwyMcM6ymLJKVByF24jVp4kznO4BtTNpwLZmYjIcVmQWVW4qaB38IH
         E7Op7vW74hjy38bQBAGYB6izvh+Gay7z0RXNLyF6xwG607wqJPwxCCfqzR5kLSOz22Fg
         dIOnN4TyzP9HtfWv+YPLFN8PUSaMyV9aYJvfa3PKS70BLb/3tdWRo59YbMAhxinCaFlY
         sLZg==
X-Gm-Message-State: AJcUukfBolH5hjfO1XL1W7czvi+5PxTTZjyAkTDDghLe7GmTWeRGrny/
        y1/ZIIKVkrNW4xv1KBelJbpr
X-Google-Smtp-Source: ALg8bN7UGiTX9YWgAr5DhxHGCDm6EWH4q0Wf/Hgsw8kXDcT/m3LeTfkX0A2It+loKCaNLT9iSGko3Q==
X-Received: by 2002:a63:ec13:: with SMTP id j19mr12323766pgh.6.1548475866371;
        Fri, 25 Jan 2019 20:11:06 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:905:e69d:b1bd:9891:c622:302d])
        by smtp.gmail.com with ESMTPSA id h129sm75099676pfb.110.2019.01.25.20.11.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 20:11:05 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     robh+dt@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        amit.kucheria@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/5] dt-bindings: arm: Document Bitmain BM1880 SoC
Date:   Sat, 26 Jan 2019 09:40:37 +0530
Message-Id: <20190126041041.13173-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190126041041.13173-1-manivannan.sadhasivam@linaro.org>
References: <20190126041041.13173-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Bitmain BM1880 SoC from Bitmain Technologies Ltd along with the
Sophon Edge board.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/arm/bitmain.yaml       | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bitmain.yaml

diff --git a/Documentation/devicetree/bindings/arm/bitmain.yaml b/Documentation/devicetree/bindings/arm/bitmain.yaml
new file mode 100644
index 000000000000..0efdb4ac028e
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bitmain.yaml
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/bitmain.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bitmain platform device tree bindings
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+properties:
+  compatible:
+    items:
+      - enum:
+        - bitmain,sophon-edge
+      - const: bitmain,bm1880
+...
-- 
2.17.1

