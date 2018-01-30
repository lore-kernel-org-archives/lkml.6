Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752519AbeA3BA0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 29 Jan 2018 20:00:26 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43612 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752405AbeA3BAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jan 2018 20:00:23 -0500
X-Google-Smtp-Source: AH8x224K3JTDsVhe3ArE3r3nuHxyG1JvfkycueUU2J4RADcPNYhG8+GkvOrBlO4OJRawIpsOvTz0nA==
From: Derek Basehore <dbasehore@chromium.org>
To: linux-kernel@vger.kernel.org
Cc: Soby.Mathew@arm.com, sudeep.holla@arm.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        rafael.j.wysocki@intel.com, tglx@linutronix.de,
        briannorris@chromium.org, marc.zyngier@arm.com,
        Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH v3 5/5] DT/arm,gic-v3: add collections-reset-on-suspend property
Date: Mon, 29 Jan 2018 17:00:07 -0800
Message-Id: <20180130010007.256564-6-dbasehore@chromium.org>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
In-Reply-To: <20180130010007.256564-1-dbasehore@chromium.org>
References: <20180130010007.256564-1-dbasehore@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This boolean property for the GIC-V3-ITS enables resending the MAP
COLLECTIONS commands when resuming for when the state is reset on
suspend.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
index a470147d4f14..adb958e046d2 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
@@ -81,6 +81,10 @@ Optional:
 - reset-on-suspend: Boolean property. Indicates that the ITS state is
   reset on suspend. The state is then saved on suspend and restored on
   resume.
+- collections-reset-on-suspend : Boolean property. If the collections for the
+  ITS are stored internally instead of externally, the state will be lost if the
+  GIC loses power. Setting this enables the kernel to reset the collections
+  state on resume for this ITS node.
 
 The main GIC node must contain the appropriate #address-cells,
 #size-cells and ranges properties for the reg property of all ITS
-- 
2.16.0.rc1.238.g530d649a79-goog
