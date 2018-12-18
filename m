Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9BDC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B0321852
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iIf9pnXA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbeLRPEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:04:12 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37362 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbeLRPEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:04:10 -0500
Received: by mail-pg1-f193.google.com with SMTP id c25so6434143pgb.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 07:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/+Wot32dCYbFyz82umg0TGbI9UaJBZsDc3LGBl9ZFTY=;
        b=iIf9pnXABmhVxHctX913lu7LzINrROLekvfBds+7aNxZPg1xaIxxDiFFGd12jsoJ0T
         9DtMJlX+x9E9VOaeEOtxjeHU5q4+8y+5bAYh+a3tlRgYVfNaZ63c2iKqtQycTq4oPkwB
         3ROCT5y+WReR4f54VG00G9aS38STj2V2Ks/Rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/+Wot32dCYbFyz82umg0TGbI9UaJBZsDc3LGBl9ZFTY=;
        b=Ltml18CveJGLhxP1bFzO7jbvy7394IGJRlaYypwigQeG+uTYjQ+l0vgZ+5xGdbBtW7
         nyjOlsxU4NNUzO9mUEjSJeb7QSBD4tkRR8rxyTAW4HC9UNnJM5qeggsxkf6D43MnHscO
         HTXPaE22lVjmzwAg+h90eoFaNv5SfNPMkKCJ55fevQiFyoHycqzP8bAwtq5tyV5bUNPj
         QeTp21q4a8g3nd1T7uc4TTOTCTk9zHzeVaOmP0FWIgEjn/9HEpKqxhnKJhXV6wqXa5rF
         wWMWm2W76O1tYWPm4Z7qovoCYRtxc5Z3jG2cQqF/QaWozlIsqyqOEGwn5cH7zJRejkZg
         HbbQ==
X-Gm-Message-State: AA+aEWa7GkxOQIPmZqURSzMYgyZQwfZ3frgtcUGvUFvFL+VI7jvWli90
        8w10O0WHaGiaWHu7C2hwtIss
X-Google-Smtp-Source: AFSGD/W/175emCViIzzUGynsJ1OVpxVqOZ3euiM2JR3hBfSKptrbkxWFnjNyDXCGC2qLaLFI6QLEdA==
X-Received: by 2002:a65:6491:: with SMTP id e17mr15868402pgv.418.1545145449913;
        Tue, 18 Dec 2018 07:04:09 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
        by smtp.gmail.com with ESMTPSA id m198sm28798688pga.10.2018.12.18.07.04.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 07:04:09 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v7 09/11] ARM: dts: rda8810pl: Add interrupt support for UART
Date:   Tue, 18 Dec 2018 20:32:36 +0530
Message-Id: <20181218150238.23010-10-manivannan.sadhasivam@linaro.org>
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

Add interrupt support for UART in RDA Micro RDA8810PL SoC.

Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/dts/rda8810pl.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/rda8810pl.dtsi b/arch/arm/boot/dts/rda8810pl.dtsi
index 84baa4c0a14c..19cde895bf65 100644
--- a/arch/arm/boot/dts/rda8810pl.dtsi
+++ b/arch/arm/boot/dts/rda8810pl.dtsi
@@ -71,18 +71,21 @@
 		uart1: serial@0 {
 			compatible = "rda,8810pl-uart";
 			reg = <0x0 0x1000>;
+			interrupts = <9 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 
 		uart2: serial@10000 {
 			compatible = "rda,8810pl-uart";
 			reg = <0x10000 0x1000>;
+			interrupts = <10 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 
 		uart3: serial@90000 {
 			compatible = "rda,8810pl-uart";
 			reg = <0x90000 0x1000>;
+			interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 	};
-- 
2.17.1

