Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FD8C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D21213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dT5sgIyv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1D21213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbeJDPqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:46:53 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56210 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbeJDPqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:46:53 -0400
Received: by mail-wm1-f66.google.com with SMTP id 206-v6so8241648wmb.5;
        Thu, 04 Oct 2018 01:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oal2Sxh3eKSVbX8dI6XStpPyPYZTzwiOSIntq3DfXv0=;
        b=dT5sgIyvnwhdXHQNv4Rc5C8G6LVXjSGFrF/ZnRKwlC0SX0iRP6iS5Tbo1bE3gj/A5V
         EdB/wxWmQdEcfh+jCNIB7tvyiGOJcXOgSw39pJTqoNbY7+TS2ZbZaCf+OZFQC3CHUTiU
         27fHFh8IUC20VLaYm1B/hLhdQVH9gaew1XRtlRJJXAif4Mp4xvDPMJHj5azHuVv0WmbA
         qNkUEGQzDVoah0zPYnIgYeK/oDQfYBlySF3Cp5YEMVFZkkXP4v0sxVHYGZqkwJPgYfqs
         WN/D1/YhvgieTMDfMMQS2lmGB4zctbe0/B8BzgbZvARI3nwW+F/kvcH2WzOLqcOsC1hZ
         coWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oal2Sxh3eKSVbX8dI6XStpPyPYZTzwiOSIntq3DfXv0=;
        b=PwnYfIp2OG/RnKdQnyFlqyKHNL7JYYm9Kwqfo6SK9mZFqG2lHCzX4J+ckoa37ZtL/5
         EIov+ItL148sSeG/smsmsCNi0umpoN6+KrGgNaT8rUjFndJvcWP4b/9NS7XOshkI5YY1
         9+gRh9FQIs8ioxTf+ZnjrChPxbmslPieKXwTc42lsnT2CXwdzS/qnwp1S6rv65f49xC6
         2iAE0sSiSIiQ2e2gxPxFGs8B0f6WHDodUSLWOhggt95XH+yf7b4tK7U2NLeQ6K+CKlTx
         pbjEbBvY/1CXvidRcrm/D+QX/zdO8Huypq/a9qB8wvK4ykKdJvJeeD+7YG15UvtrkuFo
         rAlg==
X-Gm-Message-State: ABuFfohN1W3eVEIOMJAXKbeCVYL4i9KTIcgd0iZe/44H0fereF7NJ7mu
        P5YCTLBMgbf0Jt7boqlFGWE=
X-Google-Smtp-Source: ACcGV63CRi4UXM8mkEXCOVPqg17EE1pywkCH4HbqumAq958mbNu+iW5GiJHFu0dx9cXUtII0l3Jxig==
X-Received: by 2002:a1c:a683:: with SMTP id p125-v6mr4134869wme.24.1538643277075;
        Thu, 04 Oct 2018 01:54:37 -0700 (PDT)
Received: from cperon-Latitude-7490.devialet.com (static-css-csd-151233.business.bouyguestelecom.com. [176.162.151.233])
        by smtp.gmail.com with ESMTPSA id b139-v6sm8715013wmd.36.2018.10.04.01.54.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 01:54:36 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 1/3] ARM: socfpga: Clean unused functions
Date:   Thu,  4 Oct 2018 10:54:13 +0200
Message-Id: <20181004085415.12925-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions are unused externally, removed them and declare
the one used locally as static.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm/mach-socfpga/core.h    | 2 --
 arch/arm/mach-socfpga/socfpga.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
index 65e1817d8afe..92cae0a9213f 100644
--- a/arch/arm/mach-socfpga/core.h
+++ b/arch/arm/mach-socfpga/core.h
@@ -34,8 +34,6 @@
 
 #define RSTMGR_MPUMODRST_CPU1		0x2     /* CPU1 Reset */
 
-extern void socfpga_init_clocks(void);
-extern void socfpga_sysmgr_init(void);
 void socfpga_init_l2_ecc(void);
 void socfpga_init_ocram_ecc(void);
 void socfpga_init_arria10_l2_ecc(void);
diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index dde14f7bf2c3..5fb6f79059a8 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -32,7 +32,7 @@ void __iomem *rst_manager_base_addr;
 void __iomem *sdr_ctl_base_addr;
 unsigned long socfpga_cpu1start_addr;
 
-void __init socfpga_sysmgr_init(void)
+static void __init socfpga_sysmgr_init(void)
 {
 	struct device_node *np;
 
-- 
2.17.1

