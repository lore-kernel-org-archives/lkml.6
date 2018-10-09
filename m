Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09352C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C486E214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PngYlG5J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C486E214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbeJIShZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:37:25 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52230 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbeJIShO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:37:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id 189-v6so1458276wmw.2;
        Tue, 09 Oct 2018 04:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WQN/j+wqjpzSRE7VzyTzeBWTsLQApqGBHWd7dWouz2E=;
        b=PngYlG5JjZRP+IDoecrVlGxZAv6lQroBbnzmu/coCuqlRyyMIjayMQNI7Ixud82hXJ
         v5gGed9dQfeyHM8hg1P4yseG1Qy8TRgtZ4ota3J8iZxY+bC6tZ0mYT5EXhbC9dVmoC1S
         uPB2m5A37ue66UbA4+QsgBkezaEO206+3Fa+d+vNiMv9miTkIEuXiXQ4tXGi6W0mKce8
         0i2qPYp3Z60WF3dZ6qdWhFSC01DJsnd+srSXS+OWDRjt+i4p5QtUgqKIYoZJHYS4WznM
         5lEy02PTot7rLiH9BDA0zPfJm6mWOWkuWPiwxYN/2VUDXt0uN2u+CTEBvbyRE5jZw6m1
         HzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WQN/j+wqjpzSRE7VzyTzeBWTsLQApqGBHWd7dWouz2E=;
        b=I+RvleLCeiBBml8moSP0Y3BdgSvekAFVT6UuZu4RpfTSiBmdL/3AlBe3HOAcWpSdU/
         pO13zakPsIkzQl+o3iuBx/D1AuXSQfmpLFelqp9Sbq+H0MpPRFpoEEpfaWcISYDee5s3
         Olv6J534zwx5lmYMjT+2ELi/oXk082dWD2iAwNIpmkMv5ReR4LUvCTSuMKgeI58yys4T
         6XhkQ8J8fU9ZNPBI1i88E3FlRiAZfKr/mqBEj2gv7ZKeAz0wei85HO/ruiL0GEmC8V5T
         D+0uBg+l0Bt8Gb6qFhWbSDRLeZr72ZIq97F4DbvPNdWFa8Mi1ryXRZl42KWAbPfaj9LH
         yHbA==
X-Gm-Message-State: ABuFfojpCsbSOdmJHTFRaq/SpGEOQ59eECA2LPLyOohb58jYhk6C1i5d
        XNn/kFGHSlGNJ3rZBr8h39w=
X-Google-Smtp-Source: ACcGV63dMoZemJYoJqnJdDlk1rIOdtIDORsYXmJca9pcs9QwsgFfwBfjRCDUOxNetoSOTYCri0rgvQ==
X-Received: by 2002:a1c:1984:: with SMTP id 126-v6mr1562036wmz.7.1539084043343;
        Tue, 09 Oct 2018 04:20:43 -0700 (PDT)
Received: from cperon-Latitude-7490.lan (static-css-csd-151233.business.bouyguestelecom.com. [176.162.151.233])
        by smtp.gmail.com with ESMTPSA id v129-v6sm9361330wme.45.2018.10.09.04.20.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:20:42 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Dinh Nguyen <dinguyen@altera.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 2/3] ARM: socfpga: Turn on all peripheral clocks for a system reboot
Date:   Tue,  9 Oct 2018 13:20:20 +0200
Message-Id: <20181009112021.756-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181009112021.756-1-peron.clem@gmail.com>
References: <20181009112021.756-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinh Nguyen <dinguyen@altera.com>

When doing a software reboot, all peripheral clocks must get turned on for the
L3 interconnect to work.

This code is needed when doing a "reboot" from user-space and a peripheral
clock as been gated off. Why would a peripheral clock get gated? An example
use case would be a .ko that gets insmod and rmmod during runtime. The insmod
would turn on the IP's clock, and the rmmod would turn off the IP's clock.
Doing a "reboot" would cause the system to hang.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---

 v2:
	- Remove fixes tag in commit log

 arch/arm/mach-socfpga/core.h    | 3 +++
 arch/arm/mach-socfpga/socfpga.c | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
index 92cae0a9213f..17c8a97c04d9 100644
--- a/arch/arm/mach-socfpga/core.h
+++ b/arch/arm/mach-socfpga/core.h
@@ -52,4 +52,7 @@ extern unsigned long socfpga_cpu1start_addr;
 
 #define SOCFPGA_SCU_VIRT_BASE   0xfee00000
 
+/* Clock manager defines */
+#define SOCFPGA_ENABLE_PLL_REG	0xA0
+
 #endif
diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index 5fb6f79059a8..c9c881f7c67c 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -31,6 +31,7 @@ void __iomem *sys_manager_base_addr;
 void __iomem *rst_manager_base_addr;
 void __iomem *sdr_ctl_base_addr;
 unsigned long socfpga_cpu1start_addr;
+void __iomem *clkmgr_base_addr;
 
 static void __init socfpga_sysmgr_init(void)
 {
@@ -51,6 +52,10 @@ static void __init socfpga_sysmgr_init(void)
 	np = of_find_compatible_node(NULL, NULL, "altr,rst-mgr");
 	rst_manager_base_addr = of_iomap(np, 0);
 
+	np = of_find_compatible_node(NULL, NULL, "altr,clk-mgr");
+	clkmgr_base_addr = of_iomap(np, 0);
+	WARN_ON(!clkmgr_base_addr);
+
 	np = of_find_compatible_node(NULL, NULL, "altr,sdr-ctl");
 	sdr_ctl_base_addr = of_iomap(np, 0);
 }
@@ -80,6 +85,9 @@ static void socfpga_cyclone5_restart(enum reboot_mode mode, const char *cmd)
 {
 	u32 temp;
 
+	/* Turn on all periph PLL clocks */
+	writel(0xffff, clkmgr_base_addr + SOCFPGA_ENABLE_PLL_REG);
+
 	temp = readl(rst_manager_base_addr + SOCFPGA_RSTMGR_CTRL);
 
 	if (mode == REBOOT_HARD)
-- 
2.17.1

