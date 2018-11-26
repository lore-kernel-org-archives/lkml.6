Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FC2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6EE20663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B6EE20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbeK0EaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:30:04 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41302 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbeK0EaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:30:04 -0500
Received: by mail-qk1-f193.google.com with SMTP id 189so12771525qkj.8;
        Mon, 26 Nov 2018 09:35:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :organization:content-transfer-encoding;
        bh=X24ZaQXfQMFLhqJ/vqtCFvzAhGzHk095zxeis0Hu6EU=;
        b=hYuBm+xOwRUIgJYz0VRk459Urye3VbpNYiuUvBUauDqBnqvCkDUWZL3dLoKmx4iJWY
         QeEhsEaW9ui+u8wS9nitJjXQEAdnzVS4vzMz3l9h0cvKRpfHkLQiZC1fUywaN4GoMnD6
         LjktLM2eI12nQSyNTLquAnQKFIjtJMI27Jrya/BtmEf5MlncuqfUTKrw45UZPRuYJFoj
         2Nw2YvhGzBgJssYb0B304H6/VQopgN8m3EUT7F8qU6vIPOz6n6vViG4aEkVypx6ttdqe
         OA8evVwwnyqEp7noMekyXofLiqfgXiOnAq9qbEcPhc+pJvR+jqV3/LsjEwvRT7HMOPZJ
         G6Hw==
X-Gm-Message-State: AA+aEWZR/iCU7i4z7nJX2OA0YdMjktDFYdSHEdBq/XKFVUwcXvRJviy+
        Vx+PdTU0syrvNLlVTiUwLoxlxw+7
X-Google-Smtp-Source: AFSGD/X7KZPI6SHQw4pPWVJfabNohoenRKIfFVdxmd6e47jdHj7Wxr2Adqt/2AdCUJ2zjxtEZU7k+w==
X-Received: by 2002:a37:8e81:: with SMTP id q123mr25352662qkd.34.1543253714983;
        Mon, 26 Nov 2018 09:35:14 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id 205sm431499qkf.22.2018.11.26.09.35.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 09:35:14 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Mon, 26 Nov 2018 15:35:07 -0200
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Otavio Salvador <otavio@ossystems.com.br>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 1/4] ARM: dts: rockchip: Fix the PMU interrupt number for rv1108
Date:   Mon, 26 Nov 2018 15:35:03 -0200
Message-Id: <20181126173506.24068-1-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the Rockchip vendor tree the PMU interrupt number is
76, so fix it accordingly.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
Tested-by: Fabio Berton <fabio.berton@ossystems.com.br>
---

Changes in v2:
- fixup commit signed-off-by
- fixup commit log

 arch/arm/boot/dts/rv1108.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 11ab86d6c4a5..611f2fe8e56c 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -67,7 +67,7 @@
 
 	arm-pmu {
 		compatible = "arm,cortex-a7-pmu";
-		interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
 	timer {
-- 
2.19.2

