Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751846AbeELBr0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 21:47:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47218 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750805AbeELBq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 21:46:56 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C8AF5601EA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
From: David Collins <collinsd@codeaurora.org>
To: broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc: David Collins <collinsd@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rnayak@codeaurora.org, sboyd@kernel.org,
        dianders@chromium.org
Subject: [PATCH 1/2] regulator: of: add property for allowed modes specification
Date: Fri, 11 May 2018 18:46:46 -0700
Message-Id: <f3aa166ddd11c8f9813602be68aa5b10e5c90979.1526088289.git.collinsd@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1526088289.git.collinsd@codeaurora.org>
References: <cover.1526088289.git.collinsd@codeaurora.org>
In-Reply-To: <cover.1526088289.git.collinsd@codeaurora.org>
References: <cover.1526088289.git.collinsd@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a common device tree property for regulator nodes to support
the specification of allowed operating modes.

Signed-off-by: David Collins <collinsd@codeaurora.org>
---
 Documentation/devicetree/bindings/regulator/regulator.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt b/Documentation/devicetree/bindings/regulator/regulator.txt
index 2babe15b..c627aa0 100644
--- a/Documentation/devicetree/bindings/regulator/regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/regulator.txt
@@ -59,6 +59,11 @@ Optional properties:
 - regulator-initial-mode: initial operating mode. The set of possible operating
   modes depends on the capabilities of every hardware so each device binding
   documentation explains which values the regulator supports.
+- regulator-allowed-modes: list of operating modes that software is allowed to
+  configure for the regulator at run-time.  Elements may be specified in any
+  order.  The set of possible operating modes depends on the capabilities of
+  every hardware so each device binding document explains which values the
+  regulator supports.
 - regulator-system-load: Load in uA present on regulator that is not captured by
   any consumer request.
 - regulator-pull-down: Enable pull down resistor when the regulator is disabled.
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
