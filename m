Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556B5C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 096532691F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="bCfsQ43O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 096532691F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964927AbeFZK15 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:27:57 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36616 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934735AbeFZKXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:23:22 -0400
Received: by mail-wm0-f65.google.com with SMTP id u18-v6so1222297wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 03:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qDcomHocfb0UTWNpKg09I19AVkb09J7DVriHdyGCECI=;
        b=bCfsQ43OdsHikmK7mN3/Hb3JDPblleIhaKkOug7e/0TT1N+u3DrJtlUMnnRTbmqNZD
         evj6bqmKfYogmHdbVelivQvS8gW4wC/1dkTjSX8wqKUHJKKXQP2u40kxobfke0NTQvC2
         BpnX9ydto3aWvLnLtQfde87/Zo18SnzaCFaDlDHpI4QpXljPX614WZ+encg/i+AxvxXi
         qBMsO1EGJHnWtv8a2MpxJjlIIiaeMn35GhW6X2hinip9GhnxYFCMCR08MVU0lLhL1EAC
         qC+fGG3hFk8j6+ESQW5sjQAauvt91h+Dz8qdqObxiCOVjo4I0cPr8c50s1xzE9abgO1w
         QH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qDcomHocfb0UTWNpKg09I19AVkb09J7DVriHdyGCECI=;
        b=jCh55xQYuQBKDFK1bCf6On9UdQe2E8s0+f+TLWhqBiHkDVJKPtF5x9xosXS8gigU2P
         Vto6V9+gHxljZDKLTg18idlLwhjJZv3o3DU3zivwqWDM206M7+PqQLDVBA5Q0g0LirRg
         ilYWWL1q8XaklYtwNypqr7zzDOi4ZJHc5Ce7n/yAJtf0tpzrpaAYz2KRXVxIe9eFC1/y
         xCvtZG4ULlBm+Y8Q4xJ+jOTjjM0Uo0V7RDF2NyzCy1VQ/x6iLS5oztFHRDiO2OOOkn3w
         iD8zlNPi2/TX7AkVvsAuCSTA9voendT8rQ0oqRcIcC0GWFL0IA1ESK0DnDcGV8WVsG5P
         syDQ==
X-Gm-Message-State: APt69E0vIwmdpQdBtI8/Y+7rPe1CW897s6RJzF9h90aAe18+ylIJDNa2
        NczDEiqr4NyvRqon0hZdwjO7nQ==
X-Google-Smtp-Source: AAOMgpcC+3TY2kHfkk06zefIvcGD3PUwe3P+koUGFRwnHcakBjlRDrF3iuExqyS3Kz6lcX9HAP7KHQ==
X-Received: by 2002:a1c:2686:: with SMTP id m128-v6mr1197661wmm.65.1530008600773;
        Tue, 26 Jun 2018 03:23:20 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id 203-v6sm2573852wmp.23.2018.06.26.03.23.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 03:23:20 -0700 (PDT)
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
Subject: [PATCH v2 05/15] ARM: davinci: da830-evm: use nvmem lookup for mac address
Date:   Tue, 26 Jun 2018 12:22:35 +0200
Message-Id: <20180626102245.30711-6-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-da830-evm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 14a6fc061744..3be3e93f2f18 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -29,6 +29,7 @@
 #include <linux/platform_data/spi-davinci.h>
 #include <linux/platform_data/usb-davinci.h>
 #include <linux/regulator/machine.h>
+#include <linux/nvmem-provider.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -409,6 +410,15 @@ static inline void da830_evm_init_lcdc(int mux_mode)
 static inline void da830_evm_init_lcdc(int mux_mode) { }
 #endif
 
+static struct nvmem_cell_lookup da830_evm_mac_address_cell = {
+	.info = {
+		.name = "mac-address",
+		.offset = 0x7f00,
+		.bytes = ETH_ALEN,
+	},
+	.nvmem_name = "1-00500",
+};
+
 static struct at24_platform_data da830_evm_i2c_eeprom_info = {
 	.byte_len	= SZ_256K / 8,
 	.page_size	= 64,
@@ -618,6 +628,8 @@ static __init void da830_evm_init(void)
 		pr_warn("%s: spi 0 registration failed: %d\n", __func__, ret);
 
 	regulator_has_full_constraints();
+
+	nvmem_register_lookup(&da830_evm_mac_address_cell, 1);
 }
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
-- 
2.17.1

