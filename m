Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56196C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 10:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0452082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 10:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="SNVHuh+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E0452082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nic.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbeKBTml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 15:42:41 -0400
Received: from mail.nic.cz ([217.31.204.67]:57825 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbeKBTml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 15:42:41 -0400
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 3022162D10;
        Fri,  2 Nov 2018 11:35:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1541154958; bh=nwA1NaAwS6HsPOgl7bMUe80Vqyfl+PhUYtiBZfcGnTE=;
        h=From:To:Date;
        b=SNVHuh+UKmmDJIFgZGAkKGfUAPK+XuZ1+H3NQesWYlFgM5Ka9XwYCWTsAjf3YWAX4
         zeBD+whe+u2Tq8GtZLknLgwkukG9eWL12EI9SU4+/BYD6ZZ7cdx/t49ck4A58m+ysJ
         5WUPf5bGLRO54rKd1cIhoon/pbvtPlrE6ox5XzAw=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Tony Lindgren <tony@atomide.com>, Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 bus+gpio 4/4] dt-bindings: gpio: Document GPIOs via Moxtet bus
Date:   Fri,  2 Nov 2018 11:35:39 +0100
Message-Id: <20181102103539.6077-4-marek.behun@nic.cz>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181102103539.6077-1-marek.behun@nic.cz>
References: <20181102103539.6077-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds documentation of the device tree bindings for GPIOs
on the devices connected via Moxtet bus.

Signed-off-by: Marek Behún <marek.behun@nic.cz>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
---
 .../devicetree/bindings/gpio/gpio-moxtet.txt   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-moxtet.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-moxtet.txt b/Documentation/devicetree/bindings/gpio/gpio-moxtet.txt
new file mode 100644
index 000000000000..7e9b5770585d
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-moxtet.txt
@@ -0,0 +1,18 @@
+Turris Mox Moxtet GPIO expander via Moxtet bus
+
+Required properties:
+ - compatible		: Should be "cznic,moxtet-gpio".
+ - gpio-controller	: Marks the device node as a GPIO controller.
+ - #gpio-cells		: Should be two. For consumer use see gpio.txt.
+
+Other properties are required for a Moxtet bus device, please refer to
+Documentation/devicetree/bindings/bus/moxtet.txt.
+
+Example:
+
+	moxtet_sfp: moxtet-sfp@0 {
+		compatible = "cznic,moxtet-gpio";
+		gpio-controller;
+		#gpio-cells = <2>;
+		reg = <0>;
+	}
-- 
2.18.1

