Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E0CC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E731245BC
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Z+0LzQO0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E731245BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754269AbeFYPv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:51:29 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38494 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752602AbeFYPvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:51:21 -0400
Received: by mail-wm0-f67.google.com with SMTP id 69-v6so10569963wmf.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SmGXMywFtJmXgDto4kP5pCXWN6wLcgjDNSMmo19B6+U=;
        b=Z+0LzQO08mSbq3zTMEDSBOE+54XLck3CBprHdNd2n+mdpaqymjDQ4J5bcsExopUWaA
         kcWniHrTS64F9FdvB+DLpTi0ZCZp1VkJuY6MyQ0b6SxYKoniYZJ8goai04burxVGpcMp
         WWEKzTuicCVSBFsJ5zShKaXqXWHmd33J8mu2Y7rGlb1UB/sJdK6kPhIVIjNp5BMKc3cd
         IU+JP42FyEHWPnnK/JVOzp1ERA+8nZ3Fc0XrQMet5rqKr65Drtfmo6rNt3bEfZadNesz
         xJBz1udU2qpUEUmYbkiyitTgvZMavz7GUVx7tP7jC8/VDVE2vspyebGRw/lnxPERXooR
         0+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SmGXMywFtJmXgDto4kP5pCXWN6wLcgjDNSMmo19B6+U=;
        b=rMLPA7DW0eD7ERiB/gU0ijiPZVC7Zay9dIrmHNxCOVJ+0fIJLplb8rviBxKIXGVMrv
         eOzjAjP8R8/KuhfQLEa13OZOhgoxyFO8hGsX5ONwIJl3BYepZKyKoa1rDYsaYrk198S/
         JxSZ6gndj6VMF4qt1/0nep517+3j+N6xwZe5A8/uNnfZY6+HYpXyKDNeeXpAwlEUaLQd
         sOvzmNexb5iqnqvMozr4i65wS5Lr8KHI1VNpdlvCDSu4R0lCgSRY3IrFHwiv6yYL4eZk
         JVgt2dBdCNDiutc8Al1EBvGo5mvIMCwQkZwk6gJ8n9IfzCY+AfViqDUkkiM4lFY8Cg2+
         XX2g==
X-Gm-Message-State: APt69E3JNj3Z3iqBo9OBziphfjG2h4nhgGEYGJqCL0Hq2czRcFTcKY7W
        uMxE3NK9LNQYthOI7eg1CtUeQQ==
X-Google-Smtp-Source: AAOMgpfEzMR+YTwvMarOkcDLn0fCADCwj+ZkjJmKpRC8YeBo0K5Ue52y/fCndFYOeQCRejSXv2uEFA==
X-Received: by 2002:a1c:20ca:: with SMTP id g193-v6mr1387630wmg.4.1529941880681;
        Mon, 25 Jun 2018 08:51:20 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id x16-v6sm3523737wro.13.2018.06.25.08.51.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 08:51:20 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 02/14] ARM: davinci: dm365-evm: use nvmem lookup for mac address
Date:   Mon, 25 Jun 2018 17:50:13 +0200
Message-Id: <20180625155025.12567-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625155025.12567-1-brgl@bgdev.pl>
References: <20180625155025.12567-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now support nvmem lookups for machine code. Add a lookup for
mac-address.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-dm365-evm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 435f7ec7d9af..df640d977bfa 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -28,6 +28,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/eeprom.h>
 #include <linux/v4l2-dv-timings.h>
+#include <linux/nvmem-provider.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -169,6 +170,15 @@ static struct platform_device davinci_nand_device = {
 	},
 };
 
+static struct nvmem_cell_lookup dm365evm_mac_address_cell = {
+	.info = {
+		.name = "mac-address",
+		.offset = 0x7f00,
+		.bytes = ETH_ALEN,
+	},
+	.nvmem_name = "1-00500",
+};
+
 static struct at24_platform_data eeprom_info = {
 	.byte_len       = (256*1024) / 8,
 	.page_size      = 64,
@@ -769,6 +779,8 @@ static __init void dm365_evm_init(void)
 
 	dm365_init_spi0(BIT(0), dm365_evm_spi_info,
 			ARRAY_SIZE(dm365_evm_spi_info));
+
+	nvmem_register_lookup(&dm365evm_mac_address_cell, 1);
 }
 
 MACHINE_START(DAVINCI_DM365_EVM, "DaVinci DM365 EVM")
-- 
2.17.1

