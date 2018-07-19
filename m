Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AFFC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3892084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="DER6VvK1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3892084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732043AbeGSQQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:16:39 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36495 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731680AbeGSQQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:16:38 -0400
Received: by mail-wm0-f66.google.com with SMTP id s14-v6so6895033wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 08:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NGCfKMPNiphpkZq3ixyFo1n5Jq09hNfE9390fzLN6Wk=;
        b=DER6VvK11nXQ+52alJZkPHCLuF/+CR/GSCeAxBiONaDF38xKTd7NPb0aLms3MjWmxG
         qLyM8l8IEcyBdHcIG3CE7KjP/iPIp2rtrA8orGxfNSsGon6yBwhXehbIljeEGObG3zL8
         R8R4oqBM50tkmQkl4jhoYjJNAr5bnUqf4X7FdxfK618xW+YwN2yEfELbDtc1ob1/jlwM
         Z+DGQkPVs0ZbGBB7zvgjZ7+lYKUQ0Bs9P0/NtYi66kv3xMmnhFXX0+8ee8YtNzFjLvi8
         7X5EqQZ2X2rBu9q6b+Oo49Drq2ctrPPV+4RNEPWPHsgP072tLcQ0wUL0sQuYJDaDEsB+
         2cGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NGCfKMPNiphpkZq3ixyFo1n5Jq09hNfE9390fzLN6Wk=;
        b=TNpWOxfIAu9PsitWcYIiMKNAwZ30eRP5aJ1aMVqviws0K0Vzs+bOa00x6hmPUziV2C
         YbTBvjVagpEHkQTfh2zMmtGZ7ZzHhjpm58YHqJBSStCOhJJ1BaIbXQyW5NeQwErOV9/p
         Ol6uJDO+kOHgGctkkqeLrVhZULHc1oh5qwQTg/FQXyO1ma2P414CI1foz27YiGekDLO/
         j7Q3D0RsDsqd3HAfe0RwBzC1OkLNKhD8pmRGmt/k0OxgwW+f6UJ/uKgvo05yTUBKp5sY
         15KJuPv0PJBSEAbdX/Cb1UN4ZLDJoeQjDIxa98y1m/f6sPr73Wh0pFQ9y0H9Q7hkuTtW
         3wxA==
X-Gm-Message-State: AOUpUlFvf1GYjR6usrH6xToOzQDqZaIpFQ7/KV10H8y1yopeLJNYr7cq
        BU03W87d2IX7uIPDiVFnaag6ZQ==
X-Google-Smtp-Source: AAOMgpcyw5TKoN9PrZtzMZJspIArdfBp0K9dVmNhexMfhj2iFOSx2yOPOu42J6dY2+Jp/WT9M6RLkg==
X-Received: by 2002:a1c:8010:: with SMTP id b16-v6mr4824280wmd.9.1532014374692;
        Thu, 19 Jul 2018 08:32:54 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-40-185.w90-86.abo.wanadoo.fr. [90.86.159.185])
        by smtp.gmail.com with ESMTPSA id w9-v6sm8914090wrr.77.2018.07.19.08.32.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 08:32:54 -0700 (PDT)
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
Subject: [PATCH v3 3/3] net: add MTD support to eth_platform_get_mac_address()
Date:   Thu, 19 Jul 2018 17:32:43 +0200
Message-Id: <20180719153243.20944-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180719153243.20944-1-brgl@bgdev.pl>
References: <20180719153243.20944-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

MTD doesn't support nvmem yet. Some platforms use MTD to read the MAC
address from SPI flash. If we want this function to generalize reading
the MAC address, we need to separately try to use MTD.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 net/ethernet/eth.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index 98bc280b8a62..a0d5e4477afc 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -55,6 +55,7 @@
 #include <linux/of_net.h>
 #include <linux/pci.h>
 #include <linux/nvmem-consumer.h>
+#include <linux/mtd/mtd.h>
 #include <net/dst.h>
 #include <net/arp.h>
 #include <net/sock.h>
@@ -593,6 +594,36 @@ static int mac_address_from_nvmem(struct device *dev, u8 *mac_addr)
 	return rv;
 }
 
+#ifdef CONFIG_MTD
+static int mac_address_from_mtd(u8 *mac_addr)
+{
+	struct mtd_info *mtd;
+	size_t alen;
+	int rv = 0;
+
+	mtd = get_mtd_device_nm("MAC-Address");
+	if (IS_ERR(mtd))
+		return PTR_ERR(mtd);
+
+	rv = mtd_read(mtd, 0, ETH_ALEN, &alen, mac_addr);
+	if (rv)
+		goto put_mtd;
+
+	if (alen != ETH_ALEN || !is_valid_ether_addr(mac_addr))
+		rv = -ENODEV;
+
+put_mtd:
+	put_mtd_device(mtd);
+
+	return rv;
+}
+#else /* CONFIG_MTD */
+static int mac_address_from_mtd(u8 *mac_addr)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_MTD */
+
 int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
 {
 	int rv;
@@ -609,6 +640,6 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
 	if (!rv)
 		return 0;
 
-	return -ENODEV;
+	return mac_address_from_mtd(mac_addr);
 }
 EXPORT_SYMBOL(eth_platform_get_mac_address);
-- 
2.17.1

