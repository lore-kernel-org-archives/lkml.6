Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5F9C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44B3E214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OV25Liv/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44B3E214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbeJIShz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:37:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41091 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbeJIShK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:37:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id x12-v6so1375158wru.8;
        Tue, 09 Oct 2018 04:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oal2Sxh3eKSVbX8dI6XStpPyPYZTzwiOSIntq3DfXv0=;
        b=OV25Liv/lFyD4j10PxxjRuG6XarLWdZxD67jZ3dqAlxBFX1YlaFyTNEZVBOVSNQq1i
         lVaZU7STZZpRXA2EXDipRQqvxV2LZpJk7V67a4EOgnVB5y7pklamkS2zySPrUxj07DbK
         Yg2zK52/UmdqOi6yNolScWxVYpf7OsXEyVX9TAhfxctwSR/ecTf7gc78Ulwjogms51Xq
         +7iaNVo/9E7VTXQYJ+rSo0UyVytQ1XfNTPmNmoG7Xjsztty7uI0Mt4pe/NgAjst4WnNZ
         TG+rWWBY8DEBmjP2nNhnnV1kWqjaAOVMGZVmEJLjjyWw948V48dxgQMb9mx/nnPfGK4R
         LkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oal2Sxh3eKSVbX8dI6XStpPyPYZTzwiOSIntq3DfXv0=;
        b=VvUr5CACVLnIQpAgtSomUIcaILdUtDH2zGg4dfRPcdl7rfTGWzGeCVxdr3fSrNLYht
         0PO540UsGXMGlyiPDO4U83WzP3w+xQT0F72JQymUw0BPYxKirCjnH1IGP8Hxdnpe3P9D
         JfIW0omO2H8m8TgcbkIp86kqJ1pcnt+jLD3HypyJhny0dp3HalkiFD8dTHXbpoGkYG/y
         WPH1DbpqCmXvCYaemKGYxRVzx8SF+AZzb3anTVBtF6cgTsSe1J7xUblx871OnG5X3HYN
         +WzC17RKGdq8dHK66PHX3rMe71H/KakiWq7ecEeNEMEeMnIPyqMrJarMK4wOv6rbRLar
         MJTw==
X-Gm-Message-State: ABuFfoiGy2ZYcrqFD+S/w6oXy/5LQFGCNOAsfhafkoaSNWGNPszWnium
        0omBjKdSrkzJsOcZchxyA5yRlbpUHPQ=
X-Google-Smtp-Source: ACcGV607mkdQzbJBucRpiE9PV5ggxWQZsdT/km9U4sklqiGZj2wcIo3BktO2YAbo5Tk8g8uevSG4mA==
X-Received: by 2002:a5d:5342:: with SMTP id t2-v6mr19214195wrv.257.1539084040733;
        Tue, 09 Oct 2018 04:20:40 -0700 (PDT)
Received: from cperon-Latitude-7490.lan (static-css-csd-151233.business.bouyguestelecom.com. [176.162.151.233])
        by smtp.gmail.com with ESMTPSA id v129-v6sm9361330wme.45.2018.10.09.04.20.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:20:40 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 1/3] ARM: socfpga: Clean unused functions
Date:   Tue,  9 Oct 2018 13:20:19 +0200
Message-Id: <20181009112021.756-1-peron.clem@gmail.com>
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

