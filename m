Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CC1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13BBF2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYlDyi3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13BBF2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733284AbeKTDFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:05:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:39058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731409AbeKTDFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:05:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84F3121104;
        Mon, 19 Nov 2018 16:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645687;
        bh=LHvHd+LGcecAdf1vn+xkfBxw6QbLOvUirVwZh+QK+xk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JYlDyi3yFbpNbu66DST9bXGN6vrih/zINhnpuema2T4BDyScgQVGFis0RSPr3gXXg
         vzL06UTzwv3mqXy/r0myrSGJe1Lpz2GVDlicCoF9AudZDc3os09ZocxeN4emIM4uxd
         DAkQgStpbx69Z/5Pb0RjemNWCAUIRbWHeEGmFlZI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thor Thayer <thor.thayer@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 052/171] arm64: dts: stratix10: Support Ethernet Jumbo frame
Date:   Mon, 19 Nov 2018 17:27:28 +0100
Message-Id: <20181119162628.335803715@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

commit a27460c9768ee19949c5b91f3d959ccd88c2a64a upstream

Properly specify the RX and TX FIFO size which is important
for Jumbo frames.
Update the max-frame-size to support Jumbo frames.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi      | 6 ++++++
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 3989876ab699..22f88188b0f5 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -131,6 +131,8 @@
 			reset-names = "stmmaceth";
 			clocks = <&clkmgr STRATIX10_EMAC0_CLK>;
 			clock-names = "stmmaceth";
+			tx-fifo-depth = <16384>;
+			rx-fifo-depth = <16384>;
 			status = "disabled";
 		};
 
@@ -144,6 +146,8 @@
 			reset-names = "stmmaceth";
 			clocks = <&clkmgr STRATIX10_EMAC1_CLK>;
 			clock-names = "stmmaceth";
+			tx-fifo-depth = <16384>;
+			rx-fifo-depth = <16384>;
 			status = "disabled";
 		};
 
@@ -157,6 +161,8 @@
 			reset-names = "stmmaceth";
 			clocks = <&clkmgr STRATIX10_EMAC2_CLK>;
 			clock-names = "stmmaceth";
+			tx-fifo-depth = <16384>;
+			rx-fifo-depth = <16384>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index f9b1ef12db48..fb1b9ddd9f51 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -76,7 +76,7 @@
 	phy-mode = "rgmii";
 	phy-handle = <&phy0>;
 
-	max-frame-size = <3800>;
+	max-frame-size = <9000>;
 
 	mdio0 {
 		#address-cells = <1>;
-- 
2.17.1



