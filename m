Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9315C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE702133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TUA8CghS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbeLRIFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:05:52 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36208 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeLRIFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:05:51 -0500
Received: by mail-pf1-f195.google.com with SMTP id b85so7761654pfc.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 00:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OZbNRq4vPh2tMrFA0qvMX9547LZd+ov7go0ZcVd3YcY=;
        b=TUA8CghSP+7HrGdLnbar8fZ477bOwyppf+zSVdT/+D8IlxEaCfCoRdSota1f+qYDlm
         L+RCg4ozkswYFCh184d2BWOW8zFn38ZMD3yN3yq0Rsk5FJcP2S3xllk3ixUZQdojZZvV
         ky9vRpnL1oTApb+yDYAyca0VgWUjhPoaWMMiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OZbNRq4vPh2tMrFA0qvMX9547LZd+ov7go0ZcVd3YcY=;
        b=BdzBi6On7GmXb0xv8voirRlP1uKqrvbH4ZP8a63DQFWu39i1BavlJXj1yMQXb0/E5r
         dMhj9m8nFxOML7dCwaGZ9+rY9u3v1o2Ub/X/JF9xTmwCfJT5M0m0mnlQ/3l05bOwiPmW
         FfUCYDDxYqSxbqUHFnG6enKPmBnwty9IrXASHYB/rWtrIbakn5ynPrjvyFEpYG132Qk7
         kXY8F/PSUjrkQVVfv21tfbqwZGp57Kg2nVthFQ8+iceU8AfY8yGphoYEDTJOu4y1j/7S
         LkwWrCO87KOGiWdUlBk3YbqjKkfRkK4rdzL1GHUhFsUNvLxWiq94Dj489SLjckX8VGJJ
         CpBg==
X-Gm-Message-State: AA+aEWZiAbLrkmSvsbC3a4EEUwMq6v7zbKjcV9Z/iC11B4jP0cS5s2O1
        SXCiZaAX5v8lmQhs+VOx+yKm
X-Google-Smtp-Source: AFSGD/Xj+yIt+l4wPKbQ1v6bgulp2QO9ETSS+/s9mDaHVU6SqQoCHhX/JUn1Bg61nEwvULSthzJyTQ==
X-Received: by 2002:a62:8096:: with SMTP id j144mr16046934pfd.140.1545120350918;
        Tue, 18 Dec 2018 00:05:50 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
        by smtp.gmail.com with ESMTPSA id 7sm45596888pfm.8.2018.12.18.00.05.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 00:05:50 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        zhao_steven@263.net,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 01/11] dt-bindings: Add RDA Micro vendor prefix
Date:   Tue, 18 Dec 2018 13:35:17 +0530
Message-Id: <20181218080527.10801-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218080527.10801-1-manivannan.sadhasivam@linaro.org>
References: <20181218080527.10801-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Färber <afaerber@suse.de>

Add vendor prefix for RDA Micro which now merged into Unisoc
Communications Inc.

Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 4b1a2a8fcc16..37826fac7684 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -320,6 +320,7 @@ ralink	Mediatek/Ralink Technology Corp.
 ramtron	Ramtron International
 raspberrypi	Raspberry Pi Foundation
 raydium	Raydium Semiconductor Corp.
+rda	Unisoc Communications, Inc.
 realtek Realtek Semiconductor Corp.
 renesas	Renesas Electronics Corporation
 richtek	Richtek Technology Corporation
-- 
2.17.1

