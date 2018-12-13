Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D89C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 23:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37BCD2080F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 23:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAWvJD5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37BCD2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbeLMXDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 18:03:19 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37512 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbeLMXDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 18:03:16 -0500
Received: by mail-pf1-f196.google.com with SMTP id y126so1830911pfb.4;
        Thu, 13 Dec 2018 15:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GByOckciWJtppANEkFcCtKekhE0L3H28KuDOIQ817Og=;
        b=WAWvJD5BNWEbIKeaIo8RomMrwGHygTuIkyD/MsKJexKnxciOZDP9SdlMtWL9IK9XHF
         TL8R9xbRPno6VU+JQtNeP84QRsacWhGmQY55kLrZlneiS8BO+SJARpa075jMksZdUx3p
         p4pxpZOSmMXbWP9onfVe1+sqtxxIL4AxR7nq4uQt2azHzydfvaFXkZkFonEybFHDUfHf
         EVyz+DJb64aU5zX+GLwmSsBX0oAYoV1FOMOAuMP0uOPj9nOVqNT2dYPjs9E+t9xb6+2D
         Z8o0vL/202ZviV7w65JHM4wXTzpRVjR4H1a6kjb5hgVJ3xaWjatJ4cdT8LAivk/NdqUq
         ZJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GByOckciWJtppANEkFcCtKekhE0L3H28KuDOIQ817Og=;
        b=okOEM9buq5dQBKDDvAKoZCyqA58p7QKEANmWpLTQn8vMfxJ0CdY3jC8+5VC+UmaoXu
         t+7XLv2dyzumkni/J6iN9JwXwEqlgj5Mhk6zQEL7pafjQY+4WY5/fJtL/KwyGmoPJHLS
         Ib3E6GFO0Zh7I4fx2hRzDsFSv+iZH5vDC0VRl6JiNlPjCjyUczysHK35ciYCIcrOi47n
         ybpsRL8UNaHibD/AVuM+gqr3lDpoFyrHmPAig+p5N2CjyPCegSbSoa+z39ivlQcgbceE
         txxYWmYbUvcNEZN6ZSyzp07YzW8XzLzQF2B9ch3jV1aU+uIga41KJXGmyDzeQ7oE9UCG
         CxVA==
X-Gm-Message-State: AA+aEWaHB3O1LosaRiqSEfioJV+7Ny3sR847/RDc2f82Ie3KL0uTZ4Ue
        xhyl7UHRySlhsa63VbZcKLj/R2tQkOdkAQ==
X-Google-Smtp-Source: AFSGD/WF8XZ4hvNj2GSmAprXB3LnbwSebSi3qII9GDVgVKV4IAOv4Qonfp8Lxe+G5YF2+bOLxiXBpw==
X-Received: by 2002:a63:ee0e:: with SMTP id e14mr615499pgi.8.1544742195654;
        Thu, 13 Dec 2018 15:03:15 -0800 (PST)
Received: from dwesterg-mobl.amr.corp.intel.com (jfdmzpr05-ext.jf.intel.com. [134.134.139.74])
        by smtp.gmail.com with ESMTPSA id e86sm3922097pfb.6.2018.12.13.15.03.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 15:03:15 -0800 (PST)
From:   dwesterg@gmail.com
X-Google-Original-From: dalon.westergreen@linux.intel.com
To:     dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thor.thayer@intel.com
Cc:     Dalon Westergreen <dalon.westergreen@linux.intel.com>
Subject: [PATCH 3/3] ARM64: dts: stratix10: Add stmmac ptp_ref clock
Date:   Thu, 13 Dec 2018 15:03:02 -0800
Message-Id: <20181213230302.11034-3-dalon.westergreen@linux.intel.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181213230302.11034-1-dalon.westergreen@linux.intel.com>
References: <20181213230302.11034-1-dalon.westergreen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dalon Westergreen <dalon.westergreen@linux.intel.com>

Add the default stmmac ptp_ref clock for stratix10.  The stmmac
driver defaults the ptp_ref clock to the main stmmac clock
if the ptp_ref clock is not set in the devicetree.  This is
inappropriate for the stratix10.  The default ptp_ref clock is
STRATIX10_PERI_EMAC_PTP_CLK in the clock manager.

Signed-off-by: Dalon Westergreen <dalon.westergreen@linux.intel.com>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index adedd563125a..f464e7ba3402 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -160,8 +160,8 @@
 			mac-address = [00 00 00 00 00 00];
 			resets = <&rst EMAC0_RESET>, <&rst EMAC0_OCP_RESET>;
 			reset-names = "stmmaceth", "stmmaceth-ocp";
-			clocks = <&clkmgr STRATIX10_EMAC0_CLK>;
-			clock-names = "stmmaceth";
+			clocks = <&clkmgr STRATIX10_EMAC0_CLK>, <&clkmgr STRATIX10_PERI_EMAC_PTP_CLK>;
+			clock-names = "stmmaceth", "ptp_ref";
 			tx-fifo-depth = <16384>;
 			rx-fifo-depth = <16384>;
 			snps,multicast-filter-bins = <256>;
@@ -176,8 +176,8 @@
 			mac-address = [00 00 00 00 00 00];
 			resets = <&rst EMAC1_RESET>, <&rst EMAC1_OCP_RESET>;
 			reset-names = "stmmaceth", "stmmaceth-ocp";
-			clocks = <&clkmgr STRATIX10_EMAC1_CLK>;
-			clock-names = "stmmaceth";
+			clocks = <&clkmgr STRATIX10_EMAC1_CLK>, <&clkmgr STRATIX10_PERI_EMAC_PTP_CLK>;
+			clock-names = "stmmaceth", "ptp_ref";
 			tx-fifo-depth = <16384>;
 			rx-fifo-depth = <16384>;
 			snps,multicast-filter-bins = <256>;
@@ -192,8 +192,8 @@
 			mac-address = [00 00 00 00 00 00];
 			resets = <&rst EMAC2_RESET>, <&rst EMAC2_OCP_RESET>;
 			reset-names = "stmmaceth", "stmmaceth-ocp";
-			clocks = <&clkmgr STRATIX10_EMAC2_CLK>;
-			clock-names = "stmmaceth";
+			clocks = <&clkmgr STRATIX10_EMAC2_CLK>, <&clkmgr STRATIX10_PERI_EMAC_PTP_CLK>;
+			clock-names = "stmmaceth", "ptp_ref";
 			tx-fifo-depth = <16384>;
 			rx-fifo-depth = <16384>;
 			snps,multicast-filter-bins = <256>;
-- 
2.19.2

