Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBC0C43612
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3EC20874
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sz6MESQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbeLRDnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 22:43:03 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38930 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbeLRDnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 22:43:02 -0500
Received: by mail-pf1-f196.google.com with SMTP id r136so372285pfc.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 19:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p8+PRll/69hpVBI8tPhWaAoQEyS3IrjnhvvEZdMVHBc=;
        b=Sz6MESQFeLz7vdepva0/s+KBta4BzPpTYsMOoTThD/2hAW5V+IzXPsDeB2T9gKRRGM
         4EBP8RY/wXHE8/mtugnpRpxaSUrNb2hzhxlnlNnRLKuAuPTOgapfOwurVDS7pF0z7w+K
         cYl4lvL/iSj+JotZctezEu14AoQyaD/d/FEWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p8+PRll/69hpVBI8tPhWaAoQEyS3IrjnhvvEZdMVHBc=;
        b=m3czWbeQttFx8VbAwmrxghDk7x8paaiJKCiCrRzDJUT0tqapySqR4yk7Q96x++LT0q
         coL5xqYHUA3dtKSCa0tNqNwWooGINBu3l8V9SdnXQDqMCSoUuQAxhYz21WK6SgzNvF46
         VajTNTidhTIS7BAtcyt4/aX3e66vfw8fLXCF5chxl8aO9+Qlcg/Kd5tbz5CXcnacF1n1
         FyTE8l7/IyFKeGHIOPjiwXbQYCA//sUDEBESFm5RuMgwFhyW5KZAsbAzku+fWbAu/vwp
         bjTM1fUPY/llv+L2arvOfXr5zd6U2x8lR8tngA2c8Fg3oxSb1x1Au72vFbjhRK8ytECo
         jHCw==
X-Gm-Message-State: AA+aEWYxn+Op5soSd/2bhI2QpvU+FGeOr0D0E0sbO4izLcoJIyCR5ezR
        hQhz0M0MbKkyjM8906nom0xL
X-Google-Smtp-Source: AFSGD/XSCShiBqWsD6aQOj+TE8YBK0+4tdEzHuDa630UDB+/aaLMMUNc6EVPbkJwdub5tT+XwkK/ig==
X-Received: by 2002:a62:1043:: with SMTP id y64mr15467075pfi.78.1545104581361;
        Mon, 17 Dec 2018 19:43:01 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
        by smtp.gmail.com with ESMTPSA id b202sm25255422pfb.88.2018.12.17.19.42.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 19:43:00 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        zhao_steven@263.net,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 08/11] dt-bindings: serial: Document RDA Micro UART
Date:   Tue, 18 Dec 2018 09:11:29 +0530
Message-Id: <20181218034132.5070-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218034132.5070-1-manivannan.sadhasivam@linaro.org>
References: <20181218034132.5070-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Färber <afaerber@suse.de>

Add an initial binding for the UART in RDA Micro RDA8810PL SoC.

Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../bindings/serial/rda,8810pl-uart.txt         | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt b/Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt
new file mode 100644
index 000000000000..a08df97a69e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt
@@ -0,0 +1,17 @@
+RDA Micro UART
+
+Required properties:
+- compatible :  "rda,8810pl-uart" for RDA8810PL SoCs.
+- reg        :  Offset and length of the register set for the device.
+- interrupts :  Should contain UART interrupt.
+- clocks     :  Phandle to the input clock.
+
+
+Example:
+
+		uart2: serial@20a90000 {
+			compatible = "rda,8810pl-uart";
+			reg = <0x20a90000 0x1000>;
+			interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&uart_clk>;
+		};
-- 
2.17.1

