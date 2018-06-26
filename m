Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDF4C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3A725592
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="wlUZKtMD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB3A725592
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934820AbeFZKXb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:23:31 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:54460 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934749AbeFZKXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:23:23 -0400
Received: by mail-wm0-f47.google.com with SMTP id i139-v6so1247922wmf.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 03:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hdmPjDSvWgFzi/ui3xXp3ufbDxi9LLAFx2+8+VRHKfA=;
        b=wlUZKtMDGsHfkupc1APfL2G0dnOb00u/nK4Tx67TO8lYIPQlJw8FW0URchiUlgDNM7
         e5OtZ7C41nOhB8JZu5+t55IaGW6hlh/L1YNjeTZRS81IZrroe8IorAzc5S4IIELidhym
         OVCxfTl93G7ArWEgrLIuXZj4JwSTdCz+30c8QsrkMqokC/vlwvbxY8KH38dU1QgasbUJ
         VuKyTLEVofNhh0vj4oITPUt2SCEpVbwGtwU9z9IW61qb7x+Jx4zxCAeBtprhsxdCU4aS
         xns0ph4NpdhdzUaD+C7cq/YO2UmnC0leUOob0cRjG2csDAt4X+8KODAzqrN7UPSeu6QP
         5gUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hdmPjDSvWgFzi/ui3xXp3ufbDxi9LLAFx2+8+VRHKfA=;
        b=TqNmXoBgQzK8THVRMdHZ3b46eFGmzCvyG48ppXlw39uG1HPm/RCXSPyTkSahj8FWYQ
         jdXbb9qHCs6TOvhF3ixgheO6pYP78nSVNS+Kyo1PvskmlFloLflUrGDTDQIaADGQ5GVv
         lVNXDHnGPMqNsCv/ueIbQClyOqPeSQ+zYgoWgV8qD7aRhV+PJW1TJhKG54F6ZmYJz6eM
         RDK3x2cy1yQjeYKZDYh/TE82onBbHKPWMzCB7XA2LRotQSfFGcg+LaseBNKy/lZ+LlH9
         Uy2t+OsPT2EK3/JRCNS7qN7P8I4YPa2vA0qoGIgHiQI9AhVgB6G1ilfzJ66/NbJnESdK
         LxrA==
X-Gm-Message-State: APt69E1HrvOLtQbE+RqcnmY79mrsaXeOL3LNAeVDoDeJ6ayTl4vYApzD
        Yr5y9wDxz/PvNDNlCbj4m720nQ==
X-Google-Smtp-Source: AAOMgpeyzz3Q5XFfHsPANFtUwp7wACT4QVoZ8WsynwlwelV0Sw7JlEG88z7sQ+uoK1bZAtjf1HAxdA==
X-Received: by 2002:a1c:694e:: with SMTP id e75-v6mr740355wmc.44.1530008602071;
        Tue, 26 Jun 2018 03:23:22 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id 203-v6sm2573852wmp.23.2018.06.26.03.23.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 03:23:21 -0700 (PDT)
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
Subject: [PATCH v2 06/15] ARM: davinci: mityomapl138: add nvmem cells lookup entries
Date:   Tue, 26 Jun 2018 12:22:36 +0200
Message-Id: <20180626102245.30711-7-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-mityomapl138.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index 37b3e48a21d1..2ec31ff61dbd 100644
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
 
+	nvmem_register_lookup(mityomapl138_nvmem_cells,
+			      ARRAY_SIZE(mityomapl138_nvmem_cells));
 	mityomapl138_config_emac();
 
 	ret = da8xx_register_rtc();
-- 
2.17.1

