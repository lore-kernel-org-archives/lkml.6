Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802F3C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C2342168B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="bY5wxFVy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C2342168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934760AbeFZK3M (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:29:12 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41588 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934666AbeFZKXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:23:17 -0400
Received: by mail-wr0-f196.google.com with SMTP id h10-v6so16649566wrq.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 03:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SmGXMywFtJmXgDto4kP5pCXWN6wLcgjDNSMmo19B6+U=;
        b=bY5wxFVyqwHaOjbXPlhOk1H0UiWc3tfSm2OWnzGLb+UFSLAUh0FV5E/Woj68o7DIM5
         nezpXaKVXEqQPUL0SD8mDoEkt3OKGzdw2azcvySel0WFThzn6748B4JNRunIMWiQxysu
         nnEc1e106YjcujFL3cqdClwzT7IqRQfAtjgWLF8/9UgiNiAH4so47Td7vhcqXNtnS9/r
         EwP0yhe6D9WogE2Q68ApENihtnBv8zDgJDXZCg+bP3QI9T1GR/8rtz984ReFgdf4VvwF
         S52w7+lJTzmfukeTT07GbSt24tltWkip4OjylvIxLIPMUWYJdHtrX/JxhJaSGUdJ2UGK
         g9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SmGXMywFtJmXgDto4kP5pCXWN6wLcgjDNSMmo19B6+U=;
        b=n9syx3xl4kMVNp6AlkkGRydEyIvSWvU6rOUB1EEnqFySNqMMo7KB1HRoR8j1IK+16Q
         7QWOM2AWB1WwmKOWp6NIZuC6EjCOE+BDUftzg6cxjTbubAX5zC3Ap3nu7klElLjpmQRD
         GUh2FMcmAARbYWA37GxFDYn3dYfoZ9D/APfdH/6ZnppxSmpytnOJHZk4I3oK100SFKp8
         8djY/DBgulWZzKPVj5upXa+kImhhziHrqtxQTYRbAq/1thtSmsTA1x6IfOjK4jnibiMK
         ZtSoza7cNpoYzfiKiO3oNqLzFb40nYJ6yODoFvkyUAah4enplLQQMsTG3N/fbucEqx8X
         IraQ==
X-Gm-Message-State: APt69E2MEhKcPywXdhV8cVRkzMkGsl0g7Xhate8ED6aVuBZSFRIlnwld
        iCWCfidUQ8FrzS0k+k2B/Qm1kA==
X-Google-Smtp-Source: AAOMgpfhH8bJjirJCvX49I+t3EDUbx4GXq7IyeUCo5rzHwVa2ba2GgvL1jep2yzBMyfCa3zwEyqSqw==
X-Received: by 2002:adf:8747:: with SMTP id 7-v6mr876432wrz.117.1530008596305;
        Tue, 26 Jun 2018 03:23:16 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id 203-v6sm2573852wmp.23.2018.06.26.03.23.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 03:23:15 -0700 (PDT)
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
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 02/15] ARM: davinci: dm365-evm: use nvmem lookup for mac address
Date:   Tue, 26 Jun 2018 12:22:32 +0200
Message-Id: <20180626102245.30711-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626102245.30711-1-brgl@bgdev.pl>
References: <20180626102245.30711-1-brgl@bgdev.pl>
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

