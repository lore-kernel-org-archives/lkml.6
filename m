Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18021C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 23:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC9E2080F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 23:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+LA+mci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEC9E2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbeLMXDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 18:03:21 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38431 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbeLMXDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 18:03:15 -0500
Received: by mail-pl1-f194.google.com with SMTP id e5so1766279plb.5;
        Thu, 13 Dec 2018 15:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e5VQ3DItQus1AWQK+joJlD7fKu2CP6WPbBj/REv1nfA=;
        b=p+LA+mcideL3ksknh1RarVjkEU97TWLMmSZm4P7EoCZ7Qv5IBqydAPTPfBbZzqWIxs
         7/be3ojRb9vIX5Mrg5n8BiHZngFVdVvVtplOMrt763hcOXQj6knBVfeS/+KV3uS1+0bC
         PKFfOE66Q0AjYIQrn6vYIkGYtTXj9tTk0Rm5uO/Roch+kY3qkiuqGKg83lUOhdPcPJax
         fsTb+/CBGI9e2zVXKiQ/mEY1bXOw059LqQfpk35DWcrPcWt4DrouDzNmge2uExz5inlx
         2dvGxQkTm7Do7XYr/wtZ2YN5JJ0K3JgwtmSwsdIN0R22dXoXo3NZmUTKY99W3sMXSFgO
         K0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e5VQ3DItQus1AWQK+joJlD7fKu2CP6WPbBj/REv1nfA=;
        b=YcdXwRE78eHApWPiPO9hsi2NYxWL3ov/EAz9iS+wHgtWO0gOWFzwPEh2PE3bslMFlG
         6qtaqx7QwepuioEHeQ4dLqANc8L+hPtPXn6zsKoCmSxQP9wFakQ/rl3fZYOZCtsNmVbS
         HIBY3X1iSo50HHHuzGWAbY0xWP//SajGX8A+3W0VqpYzwnz86FkWtTkDSRGdMUru3ThF
         1eyFEQTc42Rgo+4O7yAz31w53/UsHUucJ6Ex71FMYuvyaZ9SNHQWqpZJmHvV75ll7DKE
         Y2FyUJSKdmQAqc1LGb9QuPPB+FxeJN6d7S5xGsGQxEerk0wke4nSjm6e2lX+hvPiTzZQ
         cD8Q==
X-Gm-Message-State: AA+aEWac8ak5k9RC/GVC756OpQy7O1MmtYZRdnAOlEcwXCuxXkdzwOQp
        bqXURCHTRSgiCQy5wQu5E10=
X-Google-Smtp-Source: AFSGD/V5C2QTkzL0uY+KJCDb/B0Kb1ZcwYc6TPLuK9+nEcXuhJgi1HSukqn3d5Wx/fkSNJRTXUMQ2w==
X-Received: by 2002:a17:902:64c1:: with SMTP id y1mr664072pli.64.1544742194114;
        Thu, 13 Dec 2018 15:03:14 -0800 (PST)
Received: from dwesterg-mobl.amr.corp.intel.com (jfdmzpr05-ext.jf.intel.com. [134.134.139.74])
        by smtp.gmail.com with ESMTPSA id e86sm3922097pfb.6.2018.12.13.15.03.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 15:03:13 -0800 (PST)
From:   dwesterg@gmail.com
X-Google-Original-From: dalon.westergreen@linux.intel.com
To:     dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thor.thayer@intel.com
Cc:     Dalon Westergreen <dalon.westergreen@linux.intel.com>
Subject: [PATCH 2/3] ARM: dts: arria10: Add stmmac ptp_ref clock
Date:   Thu, 13 Dec 2018 15:03:01 -0800
Message-Id: <20181213230302.11034-2-dalon.westergreen@linux.intel.com>
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

Add the default stmmac ptp_ref clock for arria10.  The stmmac
driver defaults the ptp_ref clock to the main stmmac clock
if the ptp_ref clock is not set in the devicetree.  This is inappropriate
for the arria10 device.  The default ptp_ref clock is peri_emac_ptp_clk.

Signed-off-by: Dalon Westergreen <dalon.westergreen@linux.intel.com>
---
 arch/arm/boot/dts/socfpga_arria10.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index 0017bac7f96c..6591def7b225 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -426,8 +426,8 @@
 			snps,perfect-filter-entries = <128>;
 			tx-fifo-depth = <4096>;
 			rx-fifo-depth = <16384>;
-			clocks = <&l4_mp_clk>;
-			clock-names = "stmmaceth";
+			clocks = <&l4_mp_clk>, <&peri_emac_ptp_clk>;
+			clock-names = "stmmaceth", "ptp_ref";
 			resets = <&rst EMAC0_RESET>;
 			reset-names = "stmmaceth";
 			snps,axi-config = <&socfpga_axi_setup>;
@@ -446,8 +446,8 @@
 			snps,perfect-filter-entries = <128>;
 			tx-fifo-depth = <4096>;
 			rx-fifo-depth = <16384>;
-			clocks = <&l4_mp_clk>;
-			clock-names = "stmmaceth";
+			clocks = <&l4_mp_clk>, <&peri_emac_ptp_clk>;
+			clock-names = "stmmaceth", "ptp_ref";
 			resets = <&rst EMAC1_RESET>;
 			reset-names = "stmmaceth";
 			snps,axi-config = <&socfpga_axi_setup>;
@@ -466,8 +466,8 @@
 			snps,perfect-filter-entries = <128>;
 			tx-fifo-depth = <4096>;
 			rx-fifo-depth = <16384>;
-			clocks = <&l4_mp_clk>;
-			clock-names = "stmmaceth";
+			clocks = <&l4_mp_clk>, <&peri_emac_ptp_clk>;
+			clock-names = "stmmaceth", "ptp_ref";
 			snps,axi-config = <&socfpga_axi_setup>;
 			status = "disabled";
 		};
-- 
2.19.2

