Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966174AbeCAFsi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 00:48:38 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35801 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966141AbeCAFs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 00:48:29 -0500
X-Google-Smtp-Source: AG47ELu3b6WB3PXZJb8Jb3SeK6VGFetXX3N4kEnwdAEiQNoZN2KU/mLQWX8bv8G+GbRnL3FX4pvc1Q==
From: Derek Basehore <dbasehore@chromium.org>
To: linux-kernel@vger.kernel.org
Cc: Soby.Mathew@arm.com, sudeep.holla@arm.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        rafael.j.wysocki@intel.com, tglx@linutronix.de,
        briannorris@chromium.org, marc.zyngier@arm.com,
        Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH v7 2/3] DT/arm,gic-v3-its: add reset-on-suspend property
Date: Wed, 28 Feb 2018 21:48:19 -0800
Message-Id: <20180301054820.42847-3-dbasehore@chromium.org>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd-goog
In-Reply-To: <20180301054820.42847-1-dbasehore@chromium.org>
References: <20180301054820.42847-1-dbasehore@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds documentation for the new reset-on-suspend property. This
property enables saving and restoring the ITS for when it loses state
in system suspend.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 .../devicetree/bindings/interrupt-controller/arm,gic-v3.txt  | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
index 0a57f2f4167d..dfd1b9b838cd 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
@@ -78,6 +78,11 @@ These nodes must have the following properties:
 Optional:
 - socionext,synquacer-pre-its: (u32, u32) tuple describing the untranslated
   address and size of the pre-ITS window.
+- reset-on-suspend: Boolean property. Indicates that the ITS loses power
+  on suspend to memory (via PSCI_SYSTEM_SUSPEND). Registers and data within
+  the ITS will be the same as before probe (PSCI FW does not restore state).
+  Any state stored in external memory is maintained (such as collection
+  tables stored in external memory).
 
 The main GIC node must contain the appropriate #address-cells,
 #size-cells and ranges properties for the reg property of all ITS
-- 
2.16.2.395.g2e18187dfd-goog
