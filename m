Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F54C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 23:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594C220879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 23:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K45mWQvL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594C220879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbeLMXDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 18:03:14 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46787 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbeLMXDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 18:03:13 -0500
Received: by mail-pf1-f193.google.com with SMTP id c73so1813699pfe.13;
        Thu, 13 Dec 2018 15:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XtAh37RnD+Lc9ohh4f6ICSdrBqVFkxgp0y6TXjLUoas=;
        b=K45mWQvLdwYZabxvyN2AmVWX1T/VPsOwCXXpJ3oHospKfNN9V/y6nvh2SiOSYY5tk+
         RtLRMNKpUevq6Ls/45CYrWPKLCXUVoNDWqh5HmQW5PXXmBb5d4QWPWA74ATpbYM87CUB
         +nOhZDfIajrqy2HyWWUUNUvwmdQmJetZzhZLFuCTIwKy5FNfUJo8rzjUmqP3urtAHly8
         DQwgUn0rSs9XGnauAYvjSppgxt2drSJSd6ztpZg6PzyClvvj1yXEUrk4kOMpFnts/j5l
         ckXIr5QE+7PpH4iF9Xl+MA/X5EA1aIBtUwnI9tHbtxbDj0sb94FL0ZuYJENOnYB5Us/L
         inDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XtAh37RnD+Lc9ohh4f6ICSdrBqVFkxgp0y6TXjLUoas=;
        b=Vv2trvvz0N6WFNcw5gQVP897aP+LCepV3uq6X35MlKNP/gSJTv3sudwJbsf8+8rH7k
         X7BNtaCE2KmP4W67gcD5BACpwxcLBSxqjTsamZ6YEACnagx20uln1O3j1emKV/F+FDR0
         lOtMqtW3ErPu9u+BMYm67yrRD95Og5PkoFsPgreAAJfMg0VyoxEGcmOajIZvASLgPPJE
         VCfTLDVsKPoCMZqhQAextQUfj8nVS6zJSRUPPct0j7xQOsLegY7zE/l22/HBbXPcciJ3
         K7/tb0v7AdHakxhqaXIzHvYeYRirXOIZOC2sv4OrK77bhXz1IAlg5hM+a7QnuQ3yeRO1
         Ph2Q==
X-Gm-Message-State: AA+aEWa8ZB7cbaP764YvUBtVJ3IeXTdeMD4TQzu7C3Och4gteUDiwdN6
        R4cZqIl1tyq3850nGlXEkmcxHRpGDDiFOQ==
X-Google-Smtp-Source: AFSGD/X2Au6W8q9iDoZd7gXjCnmBGoNIfkbEbsrxynZet49ktnWf0GU9Npqk0/cIQ26FRZ81h/E1LQ==
X-Received: by 2002:a62:8dd9:: with SMTP id p86mr572691pfk.143.1544742192689;
        Thu, 13 Dec 2018 15:03:12 -0800 (PST)
Received: from dwesterg-mobl.amr.corp.intel.com (jfdmzpr05-ext.jf.intel.com. [134.134.139.74])
        by smtp.gmail.com with ESMTPSA id e86sm3922097pfb.6.2018.12.13.15.03.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 15:03:11 -0800 (PST)
From:   dwesterg@gmail.com
X-Google-Original-From: dalon.westergreen@linux.intel.com
To:     dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thor.thayer@intel.com
Cc:     Dalon Westergreen <dalon.westergreen@linux.intel.com>
Subject: [PATCH 1/3] ARM: dts: cyclone5: Add stmmac ptp_ref clock
Date:   Thu, 13 Dec 2018 15:03:00 -0800
Message-Id: <20181213230302.11034-1-dalon.westergreen@linux.intel.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dalon Westergreen <dalon.westergreen@linux.intel.com>

Add the ptp_ref clock to gmac0 / gmac1 specifying the default clk
of osc1.  The stmmac driver defaults the ptp_ref clock to the main
stmmac clock if ptp_ref is not provided.  This is inappropriate for
the Cyclone5 or Arria5 devices.

Signed-off-by: Dalon Westergreen <dalon.westergreen@linux.intel.com>
---
 arch/arm/boot/dts/socfpga.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 28ecb4bdf5aa..c1c9d6a2bb91 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -557,8 +557,8 @@
 			interrupts = <0 115 4>;
 			interrupt-names = "macirq";
 			mac-address = [00 00 00 00 00 00];/* Filled in by U-Boot */
-			clocks = <&emac_0_clk>;
-			clock-names = "stmmaceth";
+			clocks = <&emac_0_clk>, <&osc1>;
+			clock-names = "stmmaceth", "ptp_ref";
 			resets = <&rst EMAC0_RESET>;
 			reset-names = "stmmaceth";
 			snps,multicast-filter-bins = <256>;
@@ -575,8 +575,8 @@
 			interrupts = <0 120 4>;
 			interrupt-names = "macirq";
 			mac-address = [00 00 00 00 00 00];/* Filled in by U-Boot */
-			clocks = <&emac_1_clk>;
-			clock-names = "stmmaceth";
+			clocks = <&emac_1_clk>, <&osc1>;
+			clock-names = "stmmaceth", "ptp_ref";
 			resets = <&rst EMAC1_RESET>;
 			reset-names = "stmmaceth";
 			snps,multicast-filter-bins = <256>;
-- 
2.19.2

