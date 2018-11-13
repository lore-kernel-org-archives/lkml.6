Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189A0C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6FE322419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Y1Ikk8Ng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6FE322419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387921AbeKNAAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:00:32 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38253 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387851AbeKNAAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:00:30 -0500
Received: by mail-wr1-f66.google.com with SMTP id e3-v6so13458978wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 06:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ccuz9dZlPq5ZTOzECk8TCynM67LjW14hECdEnE8yAoo=;
        b=Y1Ikk8NgQXMqwpoVUP121s+8HRZcWcJ2uhzlSaFno9Jt35RotfDNIizNFi2pJSERdE
         JY3i7MHMmIdMxBfGAOZXFfscqNPbJorgU6YlbYEPchiKNNSmauwS+CqByewU7L5P2Pb2
         Ty+35fPZUl9PamqqCj1kh83hinbakmM/par85eA1i9xi7NSmU7BaXT5njEonCBrre3bp
         ZjjKoYd0lZFz9AkNwYz30Cpt/TT+zvrwVg9+76xjFlrdXY9Ie8Ata8EZ1rlmlC/9A9XG
         hZENno7gq9eKRmpVgJ7OziWoK2RubCX81HdDrJ74k73B+qpIt9XZzAfY/RQpLZ5lsH+B
         ZPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ccuz9dZlPq5ZTOzECk8TCynM67LjW14hECdEnE8yAoo=;
        b=TA+e/0Kc2AqPtxBRP40bHglseP9/OPjpcpKmi848RAqlTvIxqi+jY6TZNVg/ZsVoVK
         nxIu4E+hOHrDkIombIIa7t55EUNOZ60WeJmY4HTNilveFCY8+N78IsE2L+4k18xZ+bZ4
         fD89MYC5iDP2Fv4Ny6XfCx02LoH1vcKE7ShXW18ZMjObCtZbztoP8+oyiOIBU/E6IsIv
         ptWYmtSaZAOWVibZ/lzrQ0+vR9kreIxPOeBd2THdipGAGcxfXQ3PQy0MiQCSRwMJVycE
         oy109McV+2Uqb9c+6mOcxl9f1dyUsWe0jX+TB1UTlATyUZaj7LbWGguwm1O4KoPOu/ec
         5u9w==
X-Gm-Message-State: AGRZ1gLkCkcfBIzz6nm3lT+Qy4bPF52FfAPXBKZMMrHhbE2J55mVPaiH
        3SNVMH/cw+hHyOnoN8hY10FdpA==
X-Google-Smtp-Source: AJdET5eG9CTFTnCYCng22fl6MqKtw+y6SlVDe065gFz+CvwaX0lJzR27KK+1HT0w6VQ4Oij2wpEgHA==
X-Received: by 2002:a5d:4b05:: with SMTP id v5-v6mr4999594wrq.5.1542117731700;
        Tue, 13 Nov 2018 06:02:11 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id m69-v6sm16604122wmb.8.2018.11.13.06.02.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 06:02:11 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org,
        netdev@vger.kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 10/25] net: ethernet: provide nvmem_get_mac_address()
Date:   Tue, 13 Nov 2018 15:01:18 +0100
Message-Id: <20181113140133.17385-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181113140133.17385-1-brgl@bgdev.pl>
References: <20181113140133.17385-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We already have of_get_nvmem_mac_address() but some non-DT systems want
to read the MAC address from NVMEM too. Implement a generalized routine
that takes struct device as argument.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/etherdevice.h |  1 +
 net/ethernet/eth.c          | 38 +++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index 572e11bb8696..2c0af7b00715 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -32,6 +32,7 @@
 struct device;
 int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr);
 unsigned char *arch_get_platform_mac_address(void);
+int nvmem_get_mac_address(struct device *dev, void *addrbuf);
 u32 eth_get_headlen(void *data, unsigned int max_len);
 __be16 eth_type_trans(struct sk_buff *skb, struct net_device *dev);
 extern const struct header_ops eth_header_ops;
diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index fd8faa0dfa61..df38593d1bb4 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -47,6 +47,7 @@
 #include <linux/inet.h>
 #include <linux/ip.h>
 #include <linux/netdevice.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 #include <linux/errno.h>
@@ -548,3 +549,40 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
 	return 0;
 }
 EXPORT_SYMBOL(eth_platform_get_mac_address);
+
+/**
+ * Obtain the MAC address from an nvmem cell named 'mac-address' associated
+ * with given device.
+ *
+ * @dev:	Device with which the mac-address cell is associated.
+ * @addrbuf:	Buffer to which the MAC address will be copied on success.
+ *
+ * Returns 0 on success or a negative error number on failure.
+ */
+int nvmem_get_mac_address(struct device *dev, void *addrbuf)
+{
+	struct nvmem_cell *cell;
+	const void *mac;
+	size_t len;
+
+	cell = nvmem_cell_get(dev, "mac-address");
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	mac = nvmem_cell_read(cell, &len);
+	nvmem_cell_put(cell);
+
+	if (IS_ERR(mac))
+		return PTR_ERR(mac);
+
+	if (len != ETH_ALEN || !is_valid_ether_addr(mac)) {
+		kfree(mac);
+		return -EINVAL;
+	}
+
+	ether_addr_copy(addrbuf, mac);
+	kfree(mac);
+
+	return 0;
+}
+EXPORT_SYMBOL(nvmem_get_mac_address);
-- 
2.19.1

