Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9FDECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1DC206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="XZ4vKeDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1DC206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbeGSJCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:02:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33964 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731479AbeGSJCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:02:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id c13-v6so7141253wrt.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 01:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6aX5BtucoOQijr14hJLQWkiX22ZRMT0Pi0ieKWGm2A8=;
        b=XZ4vKeDVThbroNNkg12Q/lIkPtkRFVcqrvmiIPVLOt7+hb9dqDHmUpfmbsFiMQA2Vj
         aAlGaWvXNKSzzUrSmtVtpAWNrB3caagzy3HnnVFpLg3zO4R1clc2mcfVwACRgnhlVO42
         B2Os09Sp0xecdo0stMvYdT2WKdE5XRGTKteoT9W4nB/u9svAYqhFpa/R4YvppZybky1b
         QwSP9dYTeGkxuhIoGIS1S2NBIoewNtdkHX5gKNPXOIewfGhgvR+lm251Fwz4oJBU0NWX
         mnZFifn1SGVUmUtsxF4eSVr0XbDdGu61jUMzIO4wek4NZLFydFkYusOKRehpWnUsjjmy
         O4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6aX5BtucoOQijr14hJLQWkiX22ZRMT0Pi0ieKWGm2A8=;
        b=VlZ7yjgBsLo8GbRVJNBH9NxyyfMVt6EqaR+TYkyv2oS7MTTcJypP9/9Cx05HxbV2S8
         iitE/voQm4wHiTHN/hOFaseZSxH4ivovis9277nICzm/8OrLsEPiQHJK1Z+7pZyo8DSd
         By1n1HPpCN9KmSswCpIT9zxVVs0bQWvwe1UVlGStsjnRoZeNKHNhr4bWjz2vp0jhA39s
         DSq2tJCke/3+22+5+Wd9qqttOh+bGX3lFtYnA13JnmZ+Jkwu4JbhRRB9n+1wzQ4bEMWO
         UjGeFFZTXevtamAYg+stgjilLImo27yQF/8JPAnrJu2mk8VhzwDO2rtRsvgr7DC04uVu
         Bepw==
X-Gm-Message-State: AOUpUlEYvIad1PT3MHrB8emI6QM4xS0AgrLzxtl924NI7htJ/tuvdsWd
        9e19y8P5sMGZ1SJKzMcuaMFaUg==
X-Google-Smtp-Source: AAOMgpfRQlntvwTygkmWO3wjmGHEbxy7UlmbI+t6NYuopvlbk/rsIsyF6G9P9xOwMyWs66Sg+0Wbqg==
X-Received: by 2002:a5d:4cc5:: with SMTP id c5-v6mr6995087wrt.210.1531988434522;
        Thu, 19 Jul 2018 01:20:34 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-40-185.w90-86.abo.wanadoo.fr. [90.86.159.185])
        by smtp.gmail.com with ESMTPSA id h43-v6sm1716338wrh.1.2018.07.19.01.20.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 01:20:33 -0700 (PDT)
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
Subject: [PATCH v2 2/3] net: add support for nvmem to eth_platform_get_mac_address()
Date:   Thu, 19 Jul 2018 10:20:27 +0200
Message-Id: <20180719082028.26116-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180719082028.26116-1-brgl@bgdev.pl>
References: <20180719082028.26116-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Many non-DT platforms read the MAC address from EEPROM. Usually it's
either done with callbacks defined in board files or from SoC-specific
ethernet drivers.

In order to generalize this, try to read the MAC from nvmem in
eth_platform_get_mac_address() using a standard lookup name:
"mac-address".

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 net/ethernet/eth.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index 39af03894598..af3b4b1b77eb 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -54,6 +54,7 @@
 #include <linux/if_ether.h>
 #include <linux/of_net.h>
 #include <linux/pci.h>
+#include <linux/nvmem-consumer.h>
 #include <net/dst.h>
 #include <net/arp.h>
 #include <net/sock.h>
@@ -527,8 +528,11 @@ unsigned char * __weak arch_get_platform_mac_address(void)
 
 int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
 {
+	unsigned char addrbuf[ETH_ALEN];
 	const unsigned char *addr;
+	struct nvmem_cell *nvmem;
 	struct device_node *dp;
+	size_t alen;
 
 	if (dev_is_pci(dev))
 		dp = pci_device_to_OF_node(to_pci_dev(dev));
@@ -541,6 +545,29 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
 	if (!addr)
 		addr = arch_get_platform_mac_address();
 
+	if (!addr) {
+		nvmem = nvmem_cell_get(dev, "mac-address");
+		if (IS_ERR(nvmem) && PTR_ERR(nvmem) == -EPROBE_DEFER)
+			/* We may have a lookup registered for MAC address but
+			 * the corresponding nvmem provider hasn't been
+			 * registered yet.
+			 */
+			return -EPROBE_DEFER;
+
+		if (!IS_ERR(nvmem)) {
+			addr = nvmem_cell_read(nvmem, &alen);
+			if (!IS_ERR(addr)) {
+				if (alen == ETH_ALEN)
+					ether_addr_copy(addrbuf, addr);
+
+				kfree(addr);
+				addr = alen == ETH_ALEN ? addrbuf : NULL;
+			}
+
+			nvmem_cell_put(nvmem);
+		}
+	}
+
 	if (!addr || !is_valid_ether_addr(addr))
 		return -ENODEV;
 
-- 
2.17.1

