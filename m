Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344D6ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B7720856
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Mf4LcwYt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B7720856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732054AbeGSQQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:16:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36976 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731979AbeGSQQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:16:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id q10-v6so8511778wrd.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 08:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1xdS95FRpW8FEMlxpDl9MSMdZJkHd3nUIrG//p44OVk=;
        b=Mf4LcwYtI7fqLwkE+HSaK4s0I8Bicptyee6tPc0IkelFmX/G1EW9HXwoYCJAzCrGCA
         S476KiOeVP8XyXQIgp8YvNRWP00u9YGw+c28alk2N43krVZ+jVUMbRXUiMmNIlWHgqjE
         sXWZ4TNMH2T6Diq5pGLD5HZePnKp5yVbnZbK/67ex+Pm9pl2HcafaAvhoh3eF4Q8mmj0
         yOTbgL8gNg4PTKYer+Jb+AsFuTIHHmZgaxgaq7xFNrzXO37J7LvX7Cf/3glbzZvYRqai
         BdA7uLY/8GqCjM11SMJ/ssn8U9WMqjrQafFIvgryHz+hSgw0TRV45jwE+2iZpjx+fxG1
         E+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1xdS95FRpW8FEMlxpDl9MSMdZJkHd3nUIrG//p44OVk=;
        b=q1QhQXbNFw6vx6Jh32eSGhm1tQ3MI0bnZgT8yyZ6asW6SuIhOcnAXUJYy/dahX8LFZ
         q37Uzf2Q3atD61ouHCtGprfPBVdjyTalKeV0hGUDRmek450j11uSiqT2LZUbT5C5hyxT
         fmd9onuRijkm0vgrVeBylc+imqRfUMWIg6UOzqm1d+HqcTzY54vWmYkfXWNypXR+k9e/
         rskPtPc2njX35eQlkYfuk2Jo79zmi4yGVN19y0hD0+5NBqaiDRJ2gaJ5MVCJ2rektoU8
         dtLhAyyZa54yNgHKD4zaBOPtYX9N7mW0fUX0OYhh6fmliYavredpc+wRM5ebZ/rp5+iT
         +GAA==
X-Gm-Message-State: AOUpUlH5Nbswd4xFcQgW0p3dQLIG3amYJkIg0yo57ZufINuL73ifzAGh
        znJflO5BiOV97VT8yKSvjsu3Bw==
X-Google-Smtp-Source: AAOMgpdexKV1aSpZwz4I7gGFEQ6AMCcnGg3sbhzR7U2/Etll8f7BWmLCTpXw1ZkXRck9FOGT8pq2Wg==
X-Received: by 2002:adf:8481:: with SMTP id 1-v6mr8175290wrg.34.1532014373323;
        Thu, 19 Jul 2018 08:32:53 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-40-185.w90-86.abo.wanadoo.fr. [90.86.159.185])
        by smtp.gmail.com with ESMTPSA id w9-v6sm8914090wrr.77.2018.07.19.08.32.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 08:32:52 -0700 (PDT)
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
Subject: [PATCH v3 2/3] net: add support for nvmem to eth_platform_get_mac_address()
Date:   Thu, 19 Jul 2018 17:32:42 +0200
Message-Id: <20180719153243.20944-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180719153243.20944-1-brgl@bgdev.pl>
References: <20180719153243.20944-1-brgl@bgdev.pl>
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
index cf54cdf042b7..98bc280b8a62 100644
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
@@ -559,6 +560,39 @@ static int mac_address_from_arch(u8 *mac_addr)
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
@@ -571,6 +605,10 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
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
2.17.1

