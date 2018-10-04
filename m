Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4A6C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A425213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMWvqcCp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A425213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbeJDPq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:46:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34139 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbeJDPq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:46:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id z4-v6so8988566wrb.1;
        Thu, 04 Oct 2018 01:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VgEeMcMlv6eq1LWwPB2RsqWLX+9E5hcAuRXmO2ns/Nw=;
        b=mMWvqcCpd72Wdd6pp5e6Wj+H5S6QfpLXVWU5HYDPvgREyCK05v3p+8iIDyZfLYx9F3
         ozBB1lSTlwpautLEzbnCShiU7BC7SVc5VtPTRR3DZVtLHITv3CVNh6LNvw4riMrxYmF5
         ASesBkhCK+GP6y0xRuWMkgJEmiLZh+5joaUWVBHBkO4lHo+3kNm9okxgp9RlYi62sStw
         zzkzypyH8hZmzGnSCJxmMlEu0uKOFiAZbeGLjwCwjSNykrDS0BlWLDB088sq4lDwJOOV
         6EwiLQ06frLHJwJbrqhO0KAnT4h4JtB90TjtW1Z1/AZ4yUq9AVPuymZ08oU6eSMsahRO
         8Akw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VgEeMcMlv6eq1LWwPB2RsqWLX+9E5hcAuRXmO2ns/Nw=;
        b=E1N+3XMFcKTcKXFTxV+k/AKTu2u2zDtnR6nyX5ByHOFS0PpXsalFbQ+zK3QJawh/1S
         un/y7Rd57ayO0blGepO6j5FI2Lgi5tayrxrkwLIPQ6LrOUz3wvFXVp6L4cScN98cDdOP
         MXyfOHV0/BW77XnK4LHYnKtPBuMaad8JdR9RZnAF0qV4FLQ5GqCbWNkzOZrH+mHPuvTs
         xnpvHRiyrSzLr4MWgChHpNyNeKWOvfW7kSHh/EpPrQ0bXhVbN+kIr2LvUi9isVxn8ST9
         RS/9bvJzdSk/GkYN4kaQjukpNqxqYHmp0B8X32kdufuUT0/ggJu08LFp0pI7TUU62OoU
         P09A==
X-Gm-Message-State: ABuFfog0DjmxYEx3DLTWt7KldI4iD1RCLgjpi+qLnnVnQlgC7hDj1Tav
        Pykh5kewOFbWxqASL7OQ9FE=
X-Google-Smtp-Source: ACcGV62jzhNs9W0bECQ8cK7hwB3fcYLhup0a0k/5Z8DDz/iwG+GxUEVhS2aBoepkSi362AlW/wA/MQ==
X-Received: by 2002:adf:9e09:: with SMTP id u9-v6mr3909303wre.51.1538643280605;
        Thu, 04 Oct 2018 01:54:40 -0700 (PDT)
Received: from cperon-Latitude-7490.devialet.com (static-css-csd-151233.business.bouyguestelecom.com. [176.162.151.233])
        by smtp.gmail.com with ESMTPSA id b139-v6sm8715013wmd.36.2018.10.04.01.54.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 01:54:39 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Dinh Nguyen <dinguyen@altera.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 2/3] ARM: socfpga: Turn on all peripheral clocks for a system reboot
Date:   Thu,  4 Oct 2018 10:54:14 +0200
Message-Id: <20181004085415.12925-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181004085415.12925-1-peron.clem@gmail.com>
References: <20181004085415.12925-1-peron.clem@gmail.com>
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

5c04b57fe33c ("ARM: socfpga: Enable soft reset")
Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
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

