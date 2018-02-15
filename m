Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1167182AbeBOUyl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 15:54:41 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40047 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755855AbeBOUyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 15:54:38 -0500
X-Google-Smtp-Source: AH8x225F3h1ElJ+BmVBJvU4jfcDxZjuFp0s8VJvIuwlbIVuJYPpmlAQmGKzfculJcPADKN01/27qBg==
From: Moritz Fischer <moritz.fischer@ettus.com>
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, sre@kernel.org,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 1/2] dt-bindings: power: reset: gpio-poweroff: Add 'timeout' property
Date: Thu, 15 Feb 2018 12:49:25 -0800
Message-Id: <20180215204926.23347-1-moritz.fischer@ettus.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moritz Fischer <mdf@kernel.org>

Add 'timeout' property to support boards where the 3s timeout that the
current driver defaults to is too short.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt b/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt
index e62d53d844cc..c2459c7d45d5 100644
--- a/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt
+++ b/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt
@@ -27,6 +27,8 @@ Optional properties:
   it to an output when the power-off handler is called. If this optional
   property is not specified, the GPIO is initialized as an output in its
   inactive state.
+- timeout: Time to wait before asserting a WARN_ON(1). If nothing is
+           specified, 3000 ms is used.
 
 Examples:
 
@@ -34,3 +36,9 @@ gpio-poweroff {
 	compatible = "gpio-poweroff";
 	gpios = <&gpio 4 0>;
 };
+
+gpio-poweroff {
+	compatible = "gpio-poweroff";
+	gpios = <&gpio 4 0>;
+	timeout = <3000>;
+};
-- 
2.16.1
