Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CA6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B826A2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395058AbfBNUmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 15:42:55 -0500
Received: from mga06.intel.com ([134.134.136.31]:37550 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440026AbfBNUmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 15:42:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2019 12:42:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,370,1544515200"; 
   d="scan'208";a="143557699"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by fmsmga002.fm.intel.com with ESMTP; 14 Feb 2019 12:42:02 -0800
From:   thor.thayer@linux.intel.com
To:     lee.jones@linaro.org, arnd@arndb.de, dinguyen@kernel.org,
        linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, peppe.cavallaro@st.com,
        alexandre.torgue@st.com, joabreu@synopsys.com, olof@lixom.net
Cc:     davem@davemloft.net, mcoquelin.stm32@gmail.com,
        mchehab+samsung@kernel.org, mark.rutland@arm.com,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCHv4 2/6] Documentation: dt: socfpga: Add S10 System Manager binding
Date:   Thu, 14 Feb 2019 14:44:14 -0600
Message-Id: <1550177058-1860-3-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550177058-1860-1-git-send-email-thor.thayer@linux.intel.com>
References: <1550177058-1860-1-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add the device tree bindings for the Stratix10 System Manager.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v2  New compatible string and usage for Stratix10
v3  No change
v4  Add Reviewed-by from v2.
---
 .../devicetree/bindings/arm/altera/socfpga-system.txt        | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-system.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-system.txt
index f4d04a067282..82edbaaa3f85 100644
--- a/Documentation/devicetree/bindings/arm/altera/socfpga-system.txt
+++ b/Documentation/devicetree/bindings/arm/altera/socfpga-system.txt
@@ -11,3 +11,15 @@ Example:
 		reg = <0xffd08000 0x1000>;
 		cpu1-start-addr = <0xffd080c4>;
 	};
+
+ARM64 - Stratix10
+Required properties:
+- compatible : "altr,sys-mgr-s10"
+- reg : Should contain 1 register range(address and length)
+        for system manager register.
+
+Example:
+	 sysmgr@ffd12000 {
+		compatible = "altr,sys-mgr-s10";
+		reg = <0xffd12000 0x228>;
+	};
-- 
2.7.4

