Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2F4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76232218CD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RzXsMT5X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbeLRPDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:03:09 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34530 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbeLRPDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:03:09 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so8275022pfg.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 07:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FesXI/CntZT7O17A7JC22Pf8CkQ9Of1LoOQsFlXVEvc=;
        b=RzXsMT5XP3gcdCACg6PIl6rRkWuwpdgeN/6/qhaN2JKZLuDSJC7hsGYxXeyaocea2f
         /XNEuMiwUi7p9xlnh+OUjwkqV67DSvdZllbieXmS1zJAB00jxE8Izmqjh5OSSTdZCtu5
         Ltq6pt81IUkWwCoUelEzq80A3NKL8bZQcBIWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FesXI/CntZT7O17A7JC22Pf8CkQ9Of1LoOQsFlXVEvc=;
        b=OOX5c6Q3DLldvrG9uBygePhJrsRsqXhDnC73vh12y91r5X3SIBxhMMp4CNXHROA45K
         4g4nJ1hcgYLlAYSo32Y+5Dnh46dHxnyVPhPtDBPPURoBwZCzTtic6YenHUjXS8NvQmZd
         ZKRzEUqEgaQaT1XtgnWacwk/J7CurWlMg3xWYjak8suEriOo/O0tml6WfBXoIyDifKjD
         BJ2Ec8akn7sHLgIskxmNVAdWJb1+XXMfT+erI+A36zrmu2+FeZm6424y3DdZQ3LWYrqL
         Y7N0lgeXy3PWdvg9dOK7xYlyFmi3Q0q4gmvQjz45qeaYil+o0WdL6YwkWFNo1Ppk122J
         ybSA==
X-Gm-Message-State: AA+aEWZdvENvoj54aUQYX15qEIPxPr5qAGjhzIBNbwGG/ph8lNd321y2
        Pc7WIrtc0zpkchCwhuKt9Tiv
X-Google-Smtp-Source: AFSGD/Uk4HJ/aqLuiL5P7IxWeSMH7ytf82p/PHE7W47Ya8n2IeAjHsvZ1VnD8K6dipIN6ixf9HRD8g==
X-Received: by 2002:a63:7c13:: with SMTP id x19mr15069040pgc.336.1545145388131;
        Tue, 18 Dec 2018 07:03:08 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
        by smtp.gmail.com with ESMTPSA id m198sm28798688pga.10.2018.12.18.07.03.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 07:03:07 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v7 02/11] dt-bindings: arm: Document RDA8810PL and reference boards
Date:   Tue, 18 Dec 2018 20:32:29 +0530
Message-Id: <20181218150238.23010-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
References: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Färber <afaerber@suse.de>

Add bindings for RDA Micro RDA8810PL SoC and below reference boards:

1. Orange Pi 2G-IoT - http://www.orangepi.org/OrangePi2GIOT/
2. Orange Pi i96 - https://www.96boards.org/product/orangepi-i96/

Cc: zhao_steven@263.net
Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/devicetree/bindings/arm/rda.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/rda.txt

diff --git a/Documentation/devicetree/bindings/arm/rda.txt b/Documentation/devicetree/bindings/arm/rda.txt
new file mode 100644
index 000000000000..43c80762c428
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/rda.txt
@@ -0,0 +1,17 @@
+RDA Micro platforms device tree bindings
+----------------------------------------
+
+RDA8810PL SoC
+=============
+
+Required root node properties:
+
+ - compatible :  must contain "rda,8810pl"
+
+
+Boards:
+
+Root node property compatible must contain, depending on board:
+
+ - Orange Pi 2G-IoT: "xunlong,orangepi-2g-iot"
+ - Orange Pi i96: "xunlong,orangepi-i96"
-- 
2.17.1

