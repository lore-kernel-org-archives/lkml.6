Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C65ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 06:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030C1214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 06:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 030C1214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbeIQLsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 07:48:53 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:48461 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727130AbeIQLsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 07:48:51 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42DGJR0GC0z9ttCC;
        Mon, 17 Sep 2018 08:22:47 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id sHN1mFclsFDv; Mon, 17 Sep 2018 08:22:46 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42DGJQ6vPnz9ttBw;
        Mon, 17 Sep 2018 08:22:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F20A38B787;
        Mon, 17 Sep 2018 08:22:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id hytKnrCm8bgw; Mon, 17 Sep 2018 08:22:55 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BF4F58B786;
        Mon, 17 Sep 2018 08:22:55 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id A0B1A7191E; Mon, 17 Sep 2018 06:22:53 +0000 (UTC)
Message-Id: <e3e0bcfd7b779b978d07e088a8bd667ea9ddf4aa.1537163780.git.christophe.leroy@c-s.fr>
In-Reply-To: <c09f541d459c29aca40d54fff152d5645e24b50d.1537163776.git.christophe.leroy@c-s.fr>
References: <c09f541d459c29aca40d54fff152d5645e24b50d.1537163776.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 3/3] dt-bindings: watchdog: add mpc8xxx-wdt support
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Radu Rendec <radu.rendec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Date:   Mon, 17 Sep 2018 06:22:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description of DT bindings for mpc8xxx-wdt driver which
handles the CPU watchdog timer on the mpc83xx, mpc86xx and mpc8xx.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 .../devicetree/bindings/watchdog/mpc8xxx-wdt.txt   | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/mpc8xxx-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/mpc8xxx-wdt.txt b/Documentation/devicetree/bindings/watchdog/mpc8xxx-wdt.txt
new file mode 100644
index 000000000000..e176face472a
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/mpc8xxx-wdt.txt
@@ -0,0 +1,25 @@
+* Freescale mpc8xxx watchdog driver (For 83xx, 86xx and 8xx)
+
+Required properties:
+- compatible: Shall contain one of the following:
+	"mpc83xx_wdt" for an mpc83xx
+	"fsl,mpc8610-wdt" for an mpc86xx
+	"fsl,mpc823-wdt" for an mpc8xx
+- reg: base physical address and length of the area hosting the
+       watchdog registers.
+		On the 83xx, "Watchdog Timer Registers" area:	<0x200 0x100>
+		On the 86xx, "Watchdog Timer Registers" area:	<0xe4000 0x100>
+		On the 8xx, "General System Interface Unit" area: <0x0 0x10>
+
+Optional properties:
+- reg: additional physical address and length (4) of location of the
+       Reset Status Register (called RSTRSCR on the mpc86xx)
+       		On the 83xx, it is located at offset 0x910
+       		On the 86xx, it is located at offset 0xe0094
+       		On the 8xx, it is located at offset 0x288
+
+Example:
+		WDT: watchdog@0 {
+		    compatible = "fsl,mpc823-wdt";
+		    reg = <0x0 0x10 0x288 0x4>;
+		};
-- 
2.13.3

