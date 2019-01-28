Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A954C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C1821738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbfA1WMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 17:12:13 -0500
Received: from mga17.intel.com ([192.55.52.151]:37525 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728491AbfA1WMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 17:12:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2019 14:12:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,534,1539673200"; 
   d="scan'208";a="111810533"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by orsmga006.jf.intel.com with ESMTP; 28 Jan 2019 14:12:08 -0800
From:   thor.thayer@linux.intel.com
To:     lee.jones@linaro.org, arnd@arndb.de, dinguyen@kernel.org,
        linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, peppe.cavallaro@st.com,
        alexandre.torgue@st.com, joabreu@synopsys.com
Cc:     davem@davemloft.net, mcoquelin.stm32@gmail.com,
        mchehab+samsung@kernel.org, mark.rutland@arm.com,
        bjorn.andersson@linaro.org, olof@lixom.net,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCHv3 6/6] arm64: dts: stratix10: New System Manager compatible
Date:   Mon, 28 Jan 2019 16:14:15 -0600
Message-Id: <1548713655-25940-7-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548713655-25940-1-git-send-email-thor.thayer@linux.intel.com>
References: <1548713655-25940-1-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Use the new compatible string defined for the Stratix10
System Manager. Remove syscon since it is not correct
on this platform. Use "altr,sys-mgr" as the non-specific
fallback compatible.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
v2  New. Use new Stratix10 System Manager compatible
v3  Use "altr,sys-mgr" as the non-specific compatible.
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index b2c9bb664595..18e4e54db0bb 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -363,7 +363,7 @@
 		};
 
 		sysmgr: sysmgr@ffd12000 {
-			compatible = "altr,sys-mgr", "syscon";
+			compatible = "altr,sys-mgr-s10","altr,sys-mgr";
 			reg = <0xffd12000 0x228>;
 		};
 
-- 
2.7.4

