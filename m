Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C53EC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568B720831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 568B720831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbeKCETi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:19:38 -0400
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:60904 "EHLO
        emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeKCETi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:19:38 -0400
Received: from localhost.localdomain (85-76-96-200-nat.elisa-mobile.fi [85.76.96.200])
        by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 89912300D2;
        Fri,  2 Nov 2018 21:11:15 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH v3] arm64: dts: stratix10: fix multicast filtering
Date:   Fri,  2 Nov 2018 21:10:48 +0200
Message-Id: <20181102191048.22657-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@nokia.com>

On Stratix 10, the EMAC has 256 hash buckets for multicast filtering. This
needs to be specified in DTS, otherwise the stmmac driver defaults to 64
buckets and initializes the filter incorrectly. As a result, e.g. valid
IPv6 multicast traffic ends up being dropped.

Fixes: 78cd6a9d8e15 ("arm64: dts: Add base stratix 10 dtsi")
Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 3 +++
 1 file changed, 3 insertions(+)

	v3: Send the patch using sane SMTP server to preserve the correct
	    formatting.

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 8253a1a9e985..fef7351e9f67 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -139,6 +139,7 @@
 			clock-names = "stmmaceth";
 			tx-fifo-depth = <16384>;
 			rx-fifo-depth = <16384>;
+			snps,multicast-filter-bins = <256>;
 			status = "disabled";
 		};
 
@@ -154,6 +155,7 @@
 			clock-names = "stmmaceth";
 			tx-fifo-depth = <16384>;
 			rx-fifo-depth = <16384>;
+			snps,multicast-filter-bins = <256>;
 			status = "disabled";
 		};
 
@@ -169,6 +171,7 @@
 			clock-names = "stmmaceth";
 			tx-fifo-depth = <16384>;
 			rx-fifo-depth = <16384>;
+			snps,multicast-filter-bins = <256>;
 			status = "disabled";
 		};
 
-- 
2.17.0

