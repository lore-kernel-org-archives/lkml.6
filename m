Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753210AbeCFHvk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 02:51:40 -0500
Received: from regular1.263xmail.com ([211.150.99.131]:56467 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750801AbeCFHvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 02:51:38 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <ab67b1767c75f4142a541f771cbe5781>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org
Cc: briannorris@google.com, heiko@sntech.de, dtor@google.com,
        dianders@google.com, Jeffy Chen <jeffy.chen@rock-chips.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 2/3] Input: gpio-keys - allow setting wakeup event action in DT
Date: Tue,  6 Mar 2018 15:51:22 +0800
Message-Id: <20180306075123.20989-1-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180306074418.8879-2-jeffy.chen@rock-chips.com>
References: <20180306074418.8879-2-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow specifying event actions to trigger wakeup when using the
gpio-keys input device as a wakeup source.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2:
Specify wakeup event action instead of irq trigger type as Brian
suggested.

 Documentation/devicetree/bindings/input/gpio-keys.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b/Documentation/devicetree/bindings/input/gpio-keys.txt
index a94940481e55..996ce84352cb 100644
--- a/Documentation/devicetree/bindings/input/gpio-keys.txt
+++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
@@ -26,6 +26,14 @@ Optional subnode-properties:
 	  If not specified defaults to 5.
 	- wakeup-source: Boolean, button can wake-up the system.
 			 (Legacy property supported: "gpio-key,wakeup")
+	- wakeup-event-action: Specifies whether the key should wake the
+	  system when asserted, when deasserted, or both. This property is
+	  only valid for keys that wake up the system (e.g., when the
+	  "wakeup-source" property is also provided).
+	  Supported values are defined in linux-event-codes.h:
+		EV_ACT_ASSERTED		- asserted
+		EV_ACT_DEASSERTED	- deasserted
+		EV_ACT_ANY		- both asserted and deasserted
 	- linux,can-disable: Boolean, indicates that button is connected
 	  to dedicated (not shared) interrupt which can be disabled to
 	  suppress events from the button.
-- 
2.11.0
