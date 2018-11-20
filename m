Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B93EC41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C6420685
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePl5YJim"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C6420685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbeKUD2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:28:03 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40847 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729299AbeKUD2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:28:03 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so2737705wrt.7;
        Tue, 20 Nov 2018 08:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PQtXbiUxnj9lxKfzPmiU/8R4P/UiXSZCFvt2FxxOm9c=;
        b=ePl5YJimxYINQ5HZhB1NeC9td+O0luVkwJDmMomGR/glwWMFXYm/yMOGBiUvSTSsYJ
         3byjzEjjfPOzg3lLqPDhvEn4aj3pM61rfrTtoTIe4pHDLY31T+nf9DVt+59AZTdn0MVC
         b0T+XxgSmfpLLZAJMaKIq/qtyqZpGnoqBTz3VeZY/VPMSGMxnlOUwkQvme/mZRBytH4O
         +1KUdl7e5Ka/IbW/m27FskmiNPej3aA32DQhcL6eqtS4WKlXeqbwEi7VP410w/5eURDX
         KlNay3a10Zilfze/VpPyiJmDxNzVT04fo4mWGo5hRhv9HMy/NvIcSw5NGzU7SKuOGyNf
         rb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PQtXbiUxnj9lxKfzPmiU/8R4P/UiXSZCFvt2FxxOm9c=;
        b=nHiuPvIzlR+0OBZQbCW0cLU/mlkkfo0d5sW3Tgl/K2rOU4DCApmU/mkAQ60QhnIMM6
         Uzj+ms+e202rmOpUsJ1MBYaJKwYq0i44J8JXj4zmlvC1hkInblvcJgLSE4WrwrFPOhqH
         oW2dRJFujjYMJGVxsvwJCSJUIc3rwKuT6Z2/Srj2I1BkHGutGwvjTzt2SakAcgITDTfq
         CZovzV98OX5hTZX9+aigOwpdMKa4XINKb19ZEjjfzP3u4YfvksipEwO2vsexl4eTccMB
         NR6nbxZbAo0+h9n6tuSwp4QXsZdNtJZVOUl6oat0gLxR3o6ORI2cWk7uKOkM3ph/Gnw/
         +7hg==
X-Gm-Message-State: AA+aEWYPqOxM+6eCRHawKRm4GkZUljMFWOlwmn6wo01obiM4K/XoBeQX
        K4OuYrQ3oJFucMhvnExnLNk=
X-Google-Smtp-Source: AFSGD/X/RMRMcPcHCk4XFXuf0r+8ALKrsPBPyx2nePEhqtXor1REyIU+z08BAse/IUaLgIW77TfMuA==
X-Received: by 2002:adf:ba8b:: with SMTP id p11-v6mr2834369wrg.203.1542733075333;
        Tue, 20 Nov 2018 08:57:55 -0800 (PST)
Received: from localhost.localdomain (static-css-cqn-143221.business.bouyguestelecom.com. [176.149.143.221])
        by smtp.gmail.com with ESMTPSA id 6-v6sm35287504wmg.19.2018.11.20.08.57.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 08:57:54 -0800 (PST)
From:   Romain Izard <romain.izard.pro@gmail.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH] ARM: dts: at91: sama5d2: use the divided clock for SMC
Date:   Tue, 20 Nov 2018 17:57:37 +0100
Message-Id: <20181120165737.4998-1-romain.izard.pro@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SAMA5D2 is different from SAMA5D3 and SAMA5D4, as there are two
different clocks for the peripherals in the SoC. The Static Memory
controller is connected to the divided master clock.

Unfortunately, the device tree does not correctly show this and uses the
master clock directly. This clock is then used by the code for the NAND
controller to calculate the timings for the controller, and we end up with
slow NAND Flash access.

Fix the device tree, and the performance of Flash access is improved.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 61f68e5c48e9..b405992eb601 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -308,7 +308,7 @@
 				  0x1 0x0 0x60000000 0x10000000
 				  0x2 0x0 0x70000000 0x10000000
 				  0x3 0x0 0x80000000 0x10000000>;
-			clocks = <&mck>;
+			clocks = <&h32ck>;
 			status = "disabled";
 
 			nand_controller: nand-controller {
-- 
2.17.1

