Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3625C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6871B27512
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="wsI0y/YN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6871B27512
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966886AbeF1OjO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 10:39:14 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54470 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966616AbeF1OdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 10:33:14 -0400
Received: by mail-wm0-f66.google.com with SMTP id i139-v6so9917511wmf.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 07:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NOzx46Z/qbsyhPpgprf9QNULjx54ex463sUBqP8VjUc=;
        b=wsI0y/YNPc6u9Foy+xNxXwkpLLaQA/ucKUwOI7LJLnkVq9bIEirI/2bshzxxpOfjYq
         DL1wGAKh2ovqYWyYA1OOHSkCzKGqqkqahd8gIb+1KrjUxer2xFK3/3Ywq7TIg4z8sfCw
         IJjMH8Z4JwoiMl8AdDs1q8ZEdNJPG5RM8n0yIUiqDIWuWhlaZNmA/VqmTenH4Weibrzw
         NXyuDZaKgX1oj9YqwnYREn4d+rW+WsrdtVHgJbyl3p52Rjd0FRazo6aUVH8yViRFPEDh
         x+yMb3G0nxA379RVbf0bFcGezM2tj8X9seaDUPLRioDMdGJr8fFKIcCyJcM0J/Co83vR
         hZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NOzx46Z/qbsyhPpgprf9QNULjx54ex463sUBqP8VjUc=;
        b=EKzFM2ha+kJTnqpBgBnqm8tmvlrmFVma+xgjwR+LXwTcLYClRHV5+jDKHwMBl8lAEd
         cVgeaZk7YlBvDezubyFDTbeEC065nULx4rqP2Xs5NU/06+LUaM4PpClQ/1OcgnLNSuwP
         j87NEbdNH3O5tQ9zX/CXaXQlamUaD65NyWv4lPnOowT1MoDHzBcAWg9X7DDjDWlc0mkw
         fhWV80FNGWIWt+LbDUcaC5ZqtTfoEc03VfwO4nagycC0ba9QI7Fi4GY2VfxRtMN5gOw8
         oe0H2vN2JPPnWOfPkK1cgx4PGnnNwopRYLjefFPkyLtFG12I/luh1ERI5Mm0EpUt4fM+
         Co1Q==
X-Gm-Message-State: APt69E3zJICA0K1IbyabgC6nkvCrmLVBkXclj7vIVTTQ0hLT+/ZBj1ao
        MOBHoxo6yd4XF05glpoXPQFMbg==
X-Google-Smtp-Source: AAOMgpd8Q19NzVXDAMtNxGqmz1HnDK8QH4lQW1HR1vo5/prXrAncar4y5Mkrx76T4aMLHdZ8bmuqYQ==
X-Received: by 2002:a1c:9253:: with SMTP id u80-v6mr8889728wmd.52.1530196392615;
        Thu, 28 Jun 2018 07:33:12 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-87-41.w90-86.abo.wanadoo.fr. [90.86.29.41])
        by smtp.gmail.com with ESMTPSA id 4-v6sm8037499wmh.14.2018.06.28.07.33.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 07:33:12 -0700 (PDT)
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
Subject: [PATCH v3 03/18] ARM: davinci: dm365-evm: use nvmem lookup for mac address
Date:   Thu, 28 Jun 2018 16:32:29 +0200
Message-Id: <20180628143244.4561-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628143244.4561-1-brgl@bgdev.pl>
References: <20180628143244.4561-1-brgl@bgdev.pl>
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

