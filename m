Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1D3C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1089B20868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="uX7QS7g4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1089B20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbeK3T3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:29:51 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51475 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbeK3T3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:29:50 -0500
Received: by mail-wm1-f68.google.com with SMTP id s14so4848329wmh.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 00:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ccuz9dZlPq5ZTOzECk8TCynM67LjW14hECdEnE8yAoo=;
        b=uX7QS7g4JDsPrxezfmeCVmdxMKHX0QZ3kZ6AfJtpusnADX1lEV8tF79PS2JbrpqIY7
         Q5nYud/F2oFMyW8keHTPVAq4jk81aYEx4zW2HInP5+PJyVGehVT30JBtTr2h7PwgflIo
         XgjYte0RcD5NpvCC4gqrCaYL7y7eTeUADR887kVBvamV4s1+2ZMsBicHgwatcyZ9vovq
         wc88AOijPR7YcG8NRa4p7tbkb9yjOe/RhLKu8EbsUnCJly64cAVaNwiHhypwxYihLSpW
         eBnWt28r/oCyYoQftm/8nWtK/x2l7UCvBxiuHTaT6Av8E+/LbEDfnxEiyXqI7qONXYSC
         WwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ccuz9dZlPq5ZTOzECk8TCynM67LjW14hECdEnE8yAoo=;
        b=kKJ8jI8YrsNPyvfGotoaNtLfaCphUvz6NDZsYokZvH7yyFdOFEMM/MIHLSsZCibYHz
         yQyHdXWhS8Y6Tl0LE+foDgDM0GISCdsk9ye90NvuH2tdzRjpa298R5to2/Bsur2CH3Xz
         IwnnR//TQUFUzsJD5lMmOuh8BU/m8fvDVSQOoR0K2JhfMqSvkuLp/3XE3cWxZcrLuxdA
         9GmWUu/gYyQ+h1+TMXn2InomIhOIDYsvfwra6QSRZ6NktQN4YrrR4Fmw4dIxIDJgSy9P
         uZ4Rk3jXwevVbfbzKeEgDfn/hJlKPKRtIBh2qk9ESif5EqUW+tPWVQPwnUiDAkknoChG
         UOEA==
X-Gm-Message-State: AA+aEWbBAlNdht26KpKrGRp5q54aLZnF2o0o6ho0oDisjSDJLGrqPwqV
        ZrW9GsJ36yZF7eSRuTAiPZb0cQ==
X-Google-Smtp-Source: AFSGD/WSQb4UKxUJp/cZxMhoCDD6o9879iKyE70hXRqynkc8QHsrqcU9k/BhxMJDtgeuSzFpRHOBzQ==
X-Received: by 2002:a1c:9314:: with SMTP id v20mr4695071wmd.15.1543566078364;
        Fri, 30 Nov 2018 00:21:18 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id x197sm6473374wmd.2.2018.11.30.00.21.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 00:21:17 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [net-next][PATCH 1/4] net: ethernet: provide nvmem_get_mac_address()
Date:   Fri, 30 Nov 2018 09:20:57 +0100
Message-Id: <20181130082100.6241-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181130082100.6241-1-brgl@bgdev.pl>
References: <20181130082100.6241-1-brgl@bgdev.pl>
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

