Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69CCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A62E1217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfBZPDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 10:03:49 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:40009 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfBZPDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 10:03:49 -0500
X-Originating-IP: 91.192.165.7
Received: from pc.localdomain (unknown [91.192.165.7])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 3ABFE240003;
        Tue, 26 Feb 2019 15:03:45 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v2 1/2] dt-bindings: power: supply: gpio-charger: Add status-gpios property
Date:   Tue, 26 Feb 2019 16:04:36 +0100
Message-Id: <20190226150437.3704-1-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the "status-gpios" property.
Update the "gpios" property with a valid example.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
---

Changes:

v2: - add a better description for the "status-gpios" property,
    - add valid examples for the "gpios" and "status-gpios" properties

 .../devicetree/bindings/power/supply/gpio-charger.txt       | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/gpio-charger.txt b/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
index adbb5dc5b6e9..999cc245543c 100644
--- a/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
+++ b/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
@@ -14,12 +14,16 @@ Required properties :
      usb-cdp (USB charging downstream port)
      usb-aca (USB accessory charger adapter)
 
+Optional properties:
+ - status-gpios: GPIO indicating whether a battery is charging.
+
 Example:
 
 	usb_charger: charger {
 		compatible = "gpio-charger";
 		charger-type = "usb-sdp";
-		gpios = <&gpf0 2 0 0 0>;
+		gpios = <&gpd 28 GPIO_ACTIVE_LOW>;
+		status-gpios = <&gpc 27 GPIO_ACTIVE_LOW>;
 	}
 
 	battery {
-- 
2.21.0

