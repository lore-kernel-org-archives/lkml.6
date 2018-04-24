Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932846AbeDXDCj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 23:02:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:21474 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932753AbeDXDCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 23:02:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,320,1520924400";
   d="scan'208";a="34126504"
From: "Ooi, Joyce" <joyce.ooi@intel.com>
To: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ooi Joyce <joyce.ooi@intel.com>,
        See Chin Liang <chin.liang.see@intel.com>,
        Yves Vandervennet <yves.vandervennet@intel.com>,
        Ong Hean Loong <hean.loong.ong@intel.com>
Subject: [PATCH] arm64: dts: stratix10: Change pad skew values for EMAC0 PHY driver
Date: Tue, 24 Apr 2018 11:01:58 +0800
Message-Id: <1524538918-21141-1-git-send-email-joyce.ooi@intel.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HPS EMAC0 drive strength is changed to 4mA because the initial 8mA
drive strength has caused CE test to fail. This requires changes on the
pad skew for EMAC0 PHY driver. Based on several measurements done, Tx
clock does not require the extra 0.96ns delay.

Signed-off-by: Ooi, Joyce <joyce.ooi@intel.com>
---
 .../boot/dts/altera/socfpga_stratix10_socdk.dts    |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index 0007564..8785f78 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -79,7 +79,7 @@
 			rxd2-skew-ps = <420>; /* 0ps */
 			rxd3-skew-ps = <420>; /* 0ps */
 			txen-skew-ps = <0>; /* -420ps */
-			txc-skew-ps = <1860>; /* 960ps */
+			txc-skew-ps = <900>; /* 0ps */
 			rxdv-skew-ps = <420>; /* 0ps */
 			rxc-skew-ps = <1680>; /* 780ps */
 		};
-- 
1.7.1
