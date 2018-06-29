Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E6AC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E5A427CBB
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Jb1VdHdd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E5A427CBB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753249AbeF2JpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 05:45:22 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:34102 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754811AbeF2Jky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 05:40:54 -0400
Received: by mail-wm0-f44.google.com with SMTP id l15-v6so1508238wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 02:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uc9DsLvuo9YkRZ27l37cWzXamU3JMdrZofUpXwWBSEI=;
        b=Jb1VdHddxa2cEaIYOj+354E/9cRqqwGGzz1zmS8ndA3iU1XHbliWlMd5Ew96AoHjwI
         PRgenGAuhMMTupbBxxpSMRa4BLXvYFF1dMuL1Zvd45JIEL2/qkzbvWTr4yp63vIZbeZY
         k5kxmP098Jo0QfYeWmram+1QR5FVZAsv31K5/BHaDm1HE+dMdG0gt4BiIHpfk/n+J3Pj
         33WbBUoE4KmPFMfW6LwRQsKkQrwQvkFkhurZ1Bs/0qS2fw8bSd0rYuXn8JMa3oWPdAMF
         mPjH9euUXR3GV+Di15FsuOfkIiuEOySohGmxqzl8yrvMoF8QRjnfsBfQob9ZhgYLPeiU
         5Isw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uc9DsLvuo9YkRZ27l37cWzXamU3JMdrZofUpXwWBSEI=;
        b=RnYWttzpXYJtF3vZe2JCl0gdDM6e0Da7MT3xqIhbAT19MwwUDsXDeVss7JM8N6lNjb
         uzzafqTMz8vfg+yc5RwdGvdy6ttIRtM8w3vjLGRYxCK8o4WHl7zVNp6cfwNCPyFHfs/6
         VfzRkP3KOxBNORInxKvYs2luTxQQACEjMvUlplgrUCxR0AnQsR9xHEm/VVxVluh/r+3L
         NPhQH8lAiz8vK64eKvWgLf20Wiys4umqDsiO2Is4hhj+x3eItuFfBjVcy0513bndE2DY
         ICGXtjb54r0XS0pOkEsxiT4W+b275Oh1ZwH/3o9YD3bjrE2JJ0J2txSrDTzvbMMdtP3u
         Et9w==
X-Gm-Message-State: APt69E2bDYFgtXyxxXeWKaZtuYOLlaZf+LzN+g/BkfePMssDweKofby7
        WPXvjpBC3pQXH7WuhYURorCkbw==
X-Google-Smtp-Source: AAOMgpfW2hmhcGYENZ8B4489qIEu0SEMYxQgn55Jm7Dej495LeRm+ZCN/scIfvtqvCwqYrs0yWrFbQ==
X-Received: by 2002:a1c:8893:: with SMTP id k141-v6mr1221248wmd.133.1530265253213;
        Fri, 29 Jun 2018 02:40:53 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id d102-v6sm1386394wma.10.2018.06.29.02.40.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 02:40:52 -0700 (PDT)
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
Subject: [PATCH v4 07/18] ARM: davinci: mityomapl138: add nvmem cells lookup entries
Date:   Fri, 29 Jun 2018 11:40:28 +0200
Message-Id: <20180629094039.7543-8-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-mityomapl138.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index 37b3e48a21d1..b5be51c0451e 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -21,6 +21,7 @@
 #include <linux/etherdevice.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/flash.h>
+#include <linux/nvmem-provider.h>
 
 #include <asm/io.h>
 #include <asm/mach-types.h>
@@ -160,6 +161,25 @@ static void read_factory_config(struct nvmem_device *nvmem, void *context)
 	mityomapl138_cpufreq_init(partnum);
 }
 
+static struct nvmem_cell_lookup mityomapl138_nvmem_cells[] = {
+	{
+		.info = {
+			.name = "factory-config",
+			.offset = 0x0,
+			.bytes = sizeof(struct factory_config),
+		},
+		.nvmem_name = "1-00500",
+	},
+	{
+		.info = {
+			.name = "mac-address",
+			.offset = 0x64,
+			.bytes = ETH_ALEN,
+		},
+		.nvmem_name = "1-00500",
+	}
+};
+
 static struct at24_platform_data mityomapl138_fd_chip = {
 	.byte_len	= 256,
 	.page_size	= 8,
@@ -534,6 +554,8 @@ static void __init mityomapl138_init(void)
 	if (ret)
 		pr_warn("spi 1 registration failed: %d\n", ret);
 
+	nvmem_add_lookup_table(mityomapl138_nvmem_cells,
+			       ARRAY_SIZE(mityomapl138_nvmem_cells));
 	mityomapl138_config_emac();
 
 	ret = da8xx_register_rtc();
-- 
2.17.1

