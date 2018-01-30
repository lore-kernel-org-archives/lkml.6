Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752495AbeA3BAZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 29 Jan 2018 20:00:25 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35569 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752290AbeA3BAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jan 2018 20:00:20 -0500
X-Google-Smtp-Source: AH8x225KGFcaydAPj474BgcjNYqJVkifGWs07Z6KHpLiUUKtZ6w09nBaS42JWdKUYu8yTvYe6pNwwg==
From: Derek Basehore <dbasehore@chromium.org>
To: linux-kernel@vger.kernel.org
Cc: Soby.Mathew@arm.com, sudeep.holla@arm.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        rafael.j.wysocki@intel.com, tglx@linutronix.de,
        briannorris@chromium.org, marc.zyngier@arm.com,
        Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH v3 3/5] DT/arm,gic-v3-its: add reset-on-suspend property
Date: Mon, 29 Jan 2018 17:00:05 -0800
Message-Id: <20180130010007.256564-4-dbasehore@chromium.org>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
In-Reply-To: <20180130010007.256564-1-dbasehore@chromium.org>
References: <20180130010007.256564-1-dbasehore@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds documentation for the new reset-on-suspend property. This
property enables saving and restoring the ITS for when it loses state
in system suspend.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
index 0a57f2f4167d..a470147d4f14 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
@@ -78,6 +78,9 @@ These nodes must have the following properties:
 Optional:
 - socionext,synquacer-pre-its: (u32, u32) tuple describing the untranslated
   address and size of the pre-ITS window.
+- reset-on-suspend: Boolean property. Indicates that the ITS state is
+  reset on suspend. The state is then saved on suspend and restored on
+  resume.
 
 The main GIC node must contain the appropriate #address-cells,
 #size-cells and ranges properties for the reg property of all ITS
-- 
2.16.0.rc1.238.g530d649a79-goog
