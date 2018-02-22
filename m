Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751805AbeBVXWO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 18:22:14 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37967 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751522AbeBVXWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 18:22:12 -0500
X-Google-Smtp-Source: AH8x2240LVzyLuBkBg/MRNmBhM9m5iH/aWtJg20UuFKu1yWz9Q98olhlQhM5ZIK+5G2j26wVudOW3Q==
From: Moritz Fischer <mdf@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, sre@kernel.org,
        robh+dt@kernel.org, andy.shevchenko@gmail.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: power: reset: gpio-poweroff: Add 'timeout-ms' property
Date: Thu, 22 Feb 2018 15:17:13 -0800
Message-Id: <20180222231714.11843-1-mdf@kernel.org>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'timeout-ms' property to support boards where the 3s timeout that the
current driver defaults to is too short.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---

Changes from v2:
- Addressed Rob's feedback (timeout_ms -> timeout-ms)

Changes from v1:
- Addressed Rob's feedback (timeout -> timeout_ms)
- Added to old example rather than creating separate one

---

 Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt b/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt
index e62d53d844cc..6d8980c18c34 100644
--- a/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt
+++ b/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt
@@ -27,10 +27,13 @@ Optional properties:
   it to an output when the power-off handler is called. If this optional
   property is not specified, the GPIO is initialized as an output in its
   inactive state.
+- timeout-ms: Time to wait before asserting a WARN_ON(1). If nothing is
+              specified, 3000 ms is used.
 
 Examples:
 
 gpio-poweroff {
 	compatible = "gpio-poweroff";
 	gpios = <&gpio 4 0>;
+	timeout-ms = <3000>;
 };
-- 
2.16.1
