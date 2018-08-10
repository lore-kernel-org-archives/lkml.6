Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF123C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61B3223F6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ZoSD+iUv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A61B3223F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbeHJKeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 06:34:50 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36557 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728303AbeHJKes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 06:34:48 -0400
Received: by mail-wm0-f66.google.com with SMTP id w24-v6so937812wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 01:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xBCyNbNCPITfm/FYEaMd+IK4mUMo7ZN7E7Ko6Q08LvM=;
        b=ZoSD+iUvQYCrkYLzuxLovIKe7P6g1SzIAaKg1KbZIqH8t+2kAOF4XKmk+NS1KXP6vF
         cPNFZ3Sc5sxKFR7uxTY7nwe7P4/pvzM2LPPB/0tX4nDr18PB5QsFaLhTOfVd4kwty3rk
         p6PtvVnld4i7zINBC1jaxatDY0l7Tyrk9U8neYeEVBxVpX5T3YlzC6n/X2/c0uUYyviZ
         LRNQz26ewZJW/BuDz2Fxfkmy/IeqdITTUyn9x3U4Ul+cME/zYMWcgBuo+2+ksEKtrYfo
         k/nn30kdsam5V6Gte4JXQF60uB1EMrbabLMexof3N8qTZ4NWJxA//9s1o5oordEMLuwd
         Ar+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xBCyNbNCPITfm/FYEaMd+IK4mUMo7ZN7E7Ko6Q08LvM=;
        b=cHltGCKq1OHSTe4sZD+uCmUhrFjp+dXe91sj8w9kHRs9Z93d9LfCnhrgoQQfydy7gP
         W4z3+1elhcl83nKarKsNlChzu6js5Zr9TMWMl1VIx+ltQpjjMPA4w3xi6IbrlYrEeJSk
         2NGxBOWJjINSmBXTZBK8afrpkgKWN1KREFu4idct0AFn0zqjopU6ejN3I6yynd9VZlym
         HWCRPJxgRHDUH73jT+IAau+dTPxBttCRDEDSYdgcBPXYUhTgUIkOIs7tQXMXIeqKdiAQ
         9qa6OoOykAR6HZ69OA16363DgB08GYoO8isM1EQLZ7C+BKGBRlOZ3UXnnKDcFXAcj+5k
         25+g==
X-Gm-Message-State: AOUpUlEiWno8PXrwqx2/YVLP3WLi/hd7odx1dn34T4KTxysmQjywgUy8
        qHmBArNsse2n9QhMH170jvLDDQ==
X-Google-Smtp-Source: AA+uWPwkRZbXh5LSdlohK1hTKspc6zrxfOZHz6Dm0nnhPL1EtFPJittRNfRlO54QLRBPf0Hyd4OjWQ==
X-Received: by 2002:a1c:5bc7:: with SMTP id p190-v6mr775080wmb.101.1533888363093;
        Fri, 10 Aug 2018 01:06:03 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id h7-v6sm9546405wrs.8.2018.08.10.01.06.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 01:06:02 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Naren <naren.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Sven Van Asbroeck <svendev@arcx.com>,
        Paolo Abeni <pabeni@redhat.com>, Alban Bedel <albeu@free.fr>,
        Rob Herring <robh@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 16/29] net: add support for nvmem to eth_platform_get_mac_address()
Date:   Fri, 10 Aug 2018 10:05:13 +0200
Message-Id: <20180810080526.27207-17-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810080526.27207-1-brgl@bgdev.pl>
References: <20180810080526.27207-1-brgl@bgdev.pl>
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
 net/ethernet/eth.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index d01dd55de037..f6f6af05fb58 100644
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
@@ -557,6 +558,39 @@ static int mac_address_from_arch(u8 *mac_addr)
 	return 0;
 }
 
+static int mac_address_from_nvmem(struct device *dev, u8 *mac_addr)
+{
+	const unsigned char *addr;
+	struct nvmem_cell *cell;
+	size_t alen;
+	int rv = 0;
+
+	cell = nvmem_cell_get(dev, "mac-address");
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	addr = nvmem_cell_read(cell, &alen);
+	if (IS_ERR(addr)) {
+		rv = PTR_ERR(addr);
+		goto put_nvmem;
+	}
+
+	if (alen != ETH_ALEN || !is_valid_ether_addr(addr)) {
+		rv = -ENODEV;
+		goto free_addr;
+	}
+
+	ether_addr_copy(mac_addr, addr);
+
+free_addr:
+	kfree(addr);
+
+put_nvmem:
+	nvmem_cell_put(cell);
+
+	return rv;
+}
+
 int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
 {
 	int rv;
@@ -569,6 +603,10 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
 	if (!rv)
 		return 0;
 
+	rv = mac_address_from_nvmem(dev, mac_addr);
+	if (!rv)
+		return 0;
+
 	return -ENODEV;
 }
 EXPORT_SYMBOL(eth_platform_get_mac_address);
-- 
2.18.0

