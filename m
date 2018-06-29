Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2214C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B57B27CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="AUQcx8MS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B57B27CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754221AbeF2Jq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 05:46:56 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42485 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754637AbeF2Jks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 05:40:48 -0400
Received: by mail-wr0-f195.google.com with SMTP id p1-v6so8209754wrs.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 02:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NOzx46Z/qbsyhPpgprf9QNULjx54ex463sUBqP8VjUc=;
        b=AUQcx8MSzvEVx8ntynYLAJtPX8iUcOhCeWYtwDHS3SSx4CYQShmQrZWhnqLS6xvc4P
         pjYsadgXaEe6c8KhwSIH/csBXbYLxRi5BmoiM8BTIX+B/g6uuEEAeYZSIIiDhhyYDiVJ
         NWr4hWwsu1BHI7qap/QjZmGwdy4G9t/cr7Kj0zPwoBRHMShlcQV0m+qy1z0QNFUvvNjl
         HivVRB0fO4HCCp/hTKKKBT0Ho7Yf07KhoMb0sxw9Ug+fG5CDwNOH28MXTdJOEdFapTa2
         sNOxsbC999XRVJnB90/GmpSvRBrFM+BzPEhJ//wrc6wztUDVkvhnGxhtcPG2Di0a5mTi
         xeUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NOzx46Z/qbsyhPpgprf9QNULjx54ex463sUBqP8VjUc=;
        b=k8fKbn0GxsNXxk+yPqt47hDNVOTcK/ZKDgZJv3uwDZnJQW0Qsxl5N8D6kguFh3YukI
         biQB6vNvW17b6xogVzfKRQqExaJkk/EeWJnbGsEZ7IE4MAKTPmR1JStyU/Awg+dE0i6x
         HLsrb7Qmb++ml+1UvdaiWce8pWY4OUfj6A3qqrh1UV7E4WQslB5YDWlQCGwogqFM8D3k
         BKLJinVfAY7T6+Pxby+za5k2pFpgnHAqcDI9VuSW6RSAhebwD8M783LrgFVR9WhBP6xS
         Sa4kkhpW9STEDAWUkNCqJCX5cza9FOsEa3UXYqxGrohG/imumqpz3x2fTCnsqgTdsPUh
         xumw==
X-Gm-Message-State: APt69E3cOKSsOzdD6trONsjJZf6udayXwQMxbSs6hqjOaOy1C26imZah
        RFdAlh54btUCdcjNV8cW53iy/A==
X-Google-Smtp-Source: AAOMgpdVKHR98lL4fAH29/Ozh9Cai9N+wq9O51qgZ/4JKXUocxrnWp6lz7T65Wu94PbQMVH6cqkMSA==
X-Received: by 2002:adf:a963:: with SMTP id u90-v6mr11131948wrc.248.1530265247510;
        Fri, 29 Jun 2018 02:40:47 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id d102-v6sm1386394wma.10.2018.06.29.02.40.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 02:40:46 -0700 (PDT)
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 03/18] ARM: davinci: dm365-evm: use nvmem lookup for mac address
Date:   Fri, 29 Jun 2018 11:40:24 +0200
Message-Id: <20180629094039.7543-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180629094039.7543-1-brgl@bgdev.pl>
References: <20180629094039.7543-1-brgl@bgdev.pl>
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
index 435f7ec7d9af..cb0ac92a278e 100644
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
+	nvmem_add_lookup_table(&dm365evm_mac_address_cell, 1);
 }
 
 MACHINE_START(DAVINCI_DM365_EVM, "DaVinci DM365 EVM")
-- 
2.17.1

