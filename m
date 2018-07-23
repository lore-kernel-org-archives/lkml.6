Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410BBECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 04:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D74B020846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 04:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="bqj6Xi0N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D74B020846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=castello.eng.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbeGWF4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 01:56:38 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.51]:43244 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726781AbeGWF4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 01:56:38 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 2E7A21088B
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 23:09:38 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id hSAEfqL2AkBj6hSAEfB9TP; Sun, 22 Jul 2018 23:09:38 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=References:In-Reply-To:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EnsQVUYtm0+DsogU7q/hOj4wINGmftqfl6hUQBV9EH0=; b=bqj6Xi0NOdTPSN7bfdLRzVLZq
        mNvH77TI9coUYuuksFUq31ND4dD4t+X8WELGDzQ4oHQXpt6NUbE9eA+N2AbfSOA/eQ1JO88uBfJfi
        MOW/WsYTkwpY9V84kY9R6HtKCKWtGXVSikCGM8euUSLE1SIpDVtiWS1367C6ghvdrIScZOBA21Ogp
        ORHthREa3ub+kMYJw3CV2dtk0GNOEQLFbO1oneUWGx4WzgPi2bRMJFLy8IdYyLpJr5lxoOgrfp8o/
        ZCU/Kytgk8+iglei+GSa1ox1B0qSV+gZaEX0tr5Q9xj6nlCrA1LDXpCUNeGRQOyWryKFnvdYJN7lx
        s4JdrK/Pg==;
Received: from [191.189.20.114] (port=7927 helo=localhost.localdomain)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <matheus@castello.eng.br>)
        id 1fhSAD-001oyu-7r; Mon, 23 Jul 2018 01:09:37 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     sre@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH 3/4] dt-bindings: power: supply: Max17040: Add low level SOC alert threshold
Date:   Mon, 23 Jul 2018 00:08:15 -0400
Message-Id: <20180723040816.19455-4-matheus@castello.eng.br>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20180723040816.19455-1-matheus@castello.eng.br>
References: <20180723040816.19455-1-matheus@castello.eng.br>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.189.20.114
X-Source-L: No
X-Exim-ID: 1fhSAD-001oyu-7r
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [191.189.20.114]:7927
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 22
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For configure low level state of charge threshold alert signaled from
max17040 we add "maxim,alert-soc-level" property.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 .../bindings/power/supply/max17040_battery.txt     | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/max17040_battery.txt

diff --git a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
new file mode 100644
index 000000000000..e6e4e46c03c4
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
@@ -0,0 +1,24 @@
+max17040_battery
+~~~~~~~~~~~~~~~~
+
+Required properties :
+ - compatible : "maxim,max17040"
+
+Optional threshold properties :
+ If skipped the power up default value will be used
+ - maxim,alert-soc-level :	The alert threshold that sets the state of
+ 				charge level where an interrupt is generated.
+                          	max17040 can be configured from 1 up to 32.
+
+Remembering that for the interrupt to be handled it must also be described the
+information of the interruption in the node.
+
+Example:
+
+	battery-charger@36 {
+		compatible = "maxim,max17040";
+		reg = <0x36>;
+		maxim,alert-soc-level = <10>;
+		interrupt-parent = <&gpio>;
+		interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
+	};
-- 
2.13.3

