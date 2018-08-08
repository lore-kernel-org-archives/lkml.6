Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C34AC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D5D5208DA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ZqPg9nBe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D5D5208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbeHHRyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:54:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46511 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729221AbeHHRyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:54:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id h14-v6so2377603wrw.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 08:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GhxBsIfK86giZ9cjSjQgHpsWxFiMvzhSUErcIymDujg=;
        b=ZqPg9nBeYD7Jj4LbD/qxHP8mdIaP9ehKNQ4AiXOn4oOR+a5ZAukUE+JSxk5Awm7see
         4zC84eGwAAGMLSh2/XuOWxIK/te5rwrHxpT/bW0eu4kwE+HgrDCmjcnYhBbK1Qg0g0iK
         olWgZ0mraa0LMdGszgAYyHjeeetJwyAyZbU1zQSSiUKih9toBsrwLiDr1y6F05nH50pt
         xTGMmDnYdUzQv6qqFh2GzahD1ZQ82M0164l1drphkhkbh33+AxbLUcfoQCOitNqO3oOr
         Us8whYMDibcOLJ0MkFa3pnVGRkdt1rdTb+bEsP68ccMWss+wLl39D21hrtsygCAddcBi
         HsLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GhxBsIfK86giZ9cjSjQgHpsWxFiMvzhSUErcIymDujg=;
        b=T3tbX6aFVTLfOzwrVbRu/3DDXAlkqvVEFSFafl1qhtLrB5uHb1yMYrObTMgM9vlKKj
         wvQhVEsX4HIsfuxrx7gQzMyaF84GyON3zCMTCThvVuX+7icqaBqZoj7ExDvyI1HWIsWZ
         M1f4P7Ls8dRJOs/4dRhBaWquUez7Crvys1JgoS+CMpPC4lfTxpQyPB/2YV8sIyrmERvj
         Z5yvQzpSyuWizVDo6+JK1Utpb4CRS1DKei43Hc0kcs21Okuj7bth1i6fgW//uxTBn5qs
         Jkd2BZegv1JZ3eduGxGaHd0fs43VayEnCTvmupCnCjeUN9Qj0bIbmCHrYR26P9AUTrqy
         Lcjw==
X-Gm-Message-State: AOUpUlE+L2xSOcZsuqm+P4PY2yHIv9RPfP6qAV4Zoira8RCD+zD3XnZH
        SxQljbmSuv9mJCMiHuzqATuKQA==
X-Google-Smtp-Source: AA+uWPytVmDjddx7tRYYs/vrCyUbG7+F7GSlQDH5jICevieM/gzTCUd/yRKlDppGuaWlecpoKEfSTg==
X-Received: by 2002:adf:fcc3:: with SMTP id f3-v6mr2213453wrs.216.1533742434493;
        Wed, 08 Aug 2018 08:33:54 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id s2-v6sm5240915wrw.52.2018.08.08.08.33.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:33:53 -0700 (PDT)
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
Subject: [PATCH 14/28] net: split eth_platform_get_mac_address() into subroutines
Date:   Wed,  8 Aug 2018 17:31:36 +0200
Message-Id: <20180808153150.23444-15-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808153150.23444-1-brgl@bgdev.pl>
References: <20180808153150.23444-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We want do add more sources from which to read the MAC address. In
order to avoid bloating this function too much, start by splitting it
into subroutines, each of which takes care of reading the MAC from
one source.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 net/ethernet/eth.c | 48 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index ee28440f57c5..cf54cdf042b7 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -525,26 +525,52 @@ unsigned char * __weak arch_get_platform_mac_address(void)
 	return NULL;
 }
 
-int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
+static int mac_address_from_of(struct device *dev, u8 *mac_addr)
 {
 	const unsigned char *addr;
-	struct device_node *dp;
+	struct device_node *np;
 
-	if (dev_is_pci(dev))
-		dp = pci_device_to_OF_node(to_pci_dev(dev));
-	else
-		dp = dev->of_node;
+	np = dev_is_pci(dev) ? pci_device_to_OF_node(to_pci_dev(dev))
+			     : dev->of_node;
 
-	addr = NULL;
-	if (dp)
-		addr = of_get_mac_address(dp);
-	if (!addr)
-		addr = arch_get_platform_mac_address();
+	if (!np)
+		return -ENODEV;
 
+	addr = of_get_mac_address(np);
 	if (!addr)
 		return -ENODEV;
 
+	if (!addr || !is_valid_ether_addr(addr))
+		return -ENODEV;
+
+	ether_addr_copy(mac_addr, addr);
+	return 0;
+}
+
+static int mac_address_from_arch(u8 *mac_addr)
+{
+	const unsigned char *addr;
+
+	addr = arch_get_platform_mac_address();
+	if (!addr || !is_valid_ether_addr(addr))
+		return -ENODEV;
+
 	ether_addr_copy(mac_addr, addr);
 	return 0;
 }
+
+int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
+{
+	int rv;
+
+	rv = mac_address_from_of(dev, mac_addr);
+	if (!rv)
+		return 0;
+
+	rv = mac_address_from_arch(mac_addr);
+	if (!rv)
+		return 0;
+
+	return -ENODEV;
+}
 EXPORT_SYMBOL(eth_platform_get_mac_address);
-- 
2.18.0

