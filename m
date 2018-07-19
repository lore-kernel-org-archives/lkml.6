Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6160C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C81820673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="wpD1zpgj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C81820673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732010AbeGSQQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:16:36 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38075 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731680AbeGSQQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:16:35 -0400
Received: by mail-wm0-f68.google.com with SMTP id 69-v6so6827420wmf.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 08:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ILOXH9pVEXmkUqoRI158DGfYu5yW/dY65Iz0Pm4CfIk=;
        b=wpD1zpgjNoJzc7gGJjnsRMVNmmArkWJDssEGA6Xxw6MvRaJpoUQgIfU+2Zf7Tv9ea+
         +hs20Hr3lNDgxMC4Pm5WTE3m0f9YBGg0JGJh6pU07ne4k827KjRJJ+XJhlb6s99Uo3Tx
         o/vIk/ZmWILR4XMzAuHQbK4XvIyWg2/zh7SbwHMhkyCWFnIG83EavP1lKQe5kJ+2K77j
         vyGa8aLI2mxaOPXJpM/pnWXyY7EG8lNTdcy27le7jKRVrnu4U7tsXAeI/uYJKS9kv3yq
         tC8lCz4hVLHCRwM34C9ecBjwTlBnuGJ/hQhWFZ7ixHBGFM21AfZvt7Bs0d5y9RPiUFUE
         So3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ILOXH9pVEXmkUqoRI158DGfYu5yW/dY65Iz0Pm4CfIk=;
        b=Br90dqQWQf3a38PKLVHCWK+Llioqwzdf+I8IBCJmTbB65DMHtCkRGPqBIFW7iNA2Vv
         KfRw0xJ3UaqTzGdXQUZ08jB+6+u03/e30GmLEfxlLDHJsOVJrfW4kbvMlO3Du4TBvkXd
         gm1T8O0ARJywL6Shg32W5C/MpYPTU0DusiaxbjLvMC7oJ8S0VY2xBQbEj5Gq2d4VgbmM
         cOzgVKwyxIPBACVTI1Yk0/WqPRAsZxDcoR/m6FZPXBlIqJBbZ+BgyXZQFTMBEvTx+d06
         NSNf5FaFH1YGyhvY46AvU5ipt95WchHyXY75+04jVsd6ntPyvmU1loJXAsrKeAxxOACo
         zehw==
X-Gm-Message-State: AOUpUlFRQmIiYduK9/vHJPZAN5rZbIsS+4lknwAQ9VCq8FQUoqa8iPU8
        WwLjQpCbZcrHR+pmz0Gf1NClzA==
X-Google-Smtp-Source: AAOMgpfr+hiJTPGwnqvPCPW7pxNq4Y5VWbASiEBQ88EY7/i47Sed8+2rfaZXjnoIwDTOc+d0lS7TgQ==
X-Received: by 2002:a1c:28c2:: with SMTP id o185-v6mr4577523wmo.40.1532014371999;
        Thu, 19 Jul 2018 08:32:51 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-40-185.w90-86.abo.wanadoo.fr. [90.86.159.185])
        by smtp.gmail.com with ESMTPSA id w9-v6sm8914090wrr.77.2018.07.19.08.32.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 08:32:51 -0700 (PDT)
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
Subject: [PATCH v3 1/3] net: split eth_platform_get_mac_address() into subroutines
Date:   Thu, 19 Jul 2018 17:32:41 +0200
Message-Id: <20180719153243.20944-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180719153243.20944-1-brgl@bgdev.pl>
References: <20180719153243.20944-1-brgl@bgdev.pl>
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
2.17.1

