Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01C3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723F420652
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="pguzGXez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 723F420652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731625AbeGRQtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:49:25 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53398 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731577AbeGRQtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:49:24 -0400
Received: by mail-wm0-f66.google.com with SMTP id s9-v6so3349612wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 09:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UI9KTymoEQZqQnq+XDW6aBlMZfkVrCAcmaUDPOUsmDI=;
        b=pguzGXezdMo+nCfj61cb9cSQDJqpYDOA2Gm52xVOTudW90q76PH+oziuivmWzBxLZE
         wtA1jQ6Bk6uQRqzgzsCvt6VJc+tYlIgj2iihBaSg+0+LI9R/DlcymyHnghikJdhwETRw
         xR7fsF4k8WOglmZibZCTOzoTfu2sV9GGzcFqznTMhcngd2LKH248xBwGdMx6i5qEa3EV
         jcCVbwn7C5iOzkxffP2dGUHTzarnYExs7HWv8xVL221UYVL53bQDeTcC0RLOHgbrdrcd
         acAYPAWGHFQv5Dg0u4CNkmnHaHE9PiL8OdGnxH/JT8/LKlPPsyN30iMUG4uANiumViy3
         Ub9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UI9KTymoEQZqQnq+XDW6aBlMZfkVrCAcmaUDPOUsmDI=;
        b=E07EUBKtXvGlvO+FnTMRgQz4oyqnjIQKLUChgknkJ6H0cgs7bGQr53y5axRpsoQUDW
         t1nFDkD6ZBG6n+I5EwWygaZpmO/7nvznDLIdasLE8KIP2zlxq3mIrAguPw3tEY77w9aR
         mGAS6qLFfhVaKH8tdZ+KVEUmU34pmnp3tVi/i5nBoF/NPild+/CA+6upPPf/WfDTzz+H
         qYFfs/Dvbvje2QNlKidSLsWD5KvOjXApPhVBl1C2o1t+S62GVPoeTIFhwQ4U2vxxCCMC
         WO++vWsbPt3gepGBMjy14UAZsjUiR8ZMklo17u2JyEGVMcrdxvif9IO4f00RmvAkmNjP
         lP4A==
X-Gm-Message-State: AOUpUlGPJd1X9I0DglWLe+zqWbxE9Vs44V5syaNlBLLCYa1jrFEdj9M3
        RWaAgfp8hko2AZS6knqgS2HUYA==
X-Google-Smtp-Source: AAOMgpcwQPB1DFnur4NqIP4uqwTLePGwa5l7iBSUGa11B1GdVBq0tO/YH/N5apraJ12RGysmcl6whw==
X-Received: by 2002:a1c:838a:: with SMTP id f132-v6mr2074786wmd.127.1531930247866;
        Wed, 18 Jul 2018 09:10:47 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id v185-v6sm2847803wme.30.2018.07.18.09.10.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 09:10:47 -0700 (PDT)
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
Subject: [PATCH 4/5] net: add support for nvmem to eth_platform_get_mac_address()
Date:   Wed, 18 Jul 2018 18:10:34 +0200
Message-Id: <20180718161035.7005-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718161035.7005-1-brgl@bgdev.pl>
References: <20180718161035.7005-1-brgl@bgdev.pl>
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
 net/ethernet/eth.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index 6b64586fd2af..adf5bd03851f 100644
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
@@ -530,7 +531,10 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
 	struct device_node *dp = dev_is_pci(dev) ?
 			pci_device_to_OF_node(to_pci_dev(dev)) : dev->of_node;
 	const unsigned char *addr = NULL;
+	unsigned char addrbuf[ETH_ALEN];
+	struct nvmem_cell *nvmem;
 	const char *from = NULL;
+	size_t alen;
 
 	if (dp) {
 		addr = of_get_mac_address(dp);
@@ -544,6 +548,31 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
 			from = "arch callback";
 	}
 
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
+				from = "nvmem";
+				/* Don't use ether_addr_copy() in case we
+				 * didn't get the right size.
+				 */
+				memcpy(addrbuf, addr, alen);
+				kfree(addr);
+				addr = addrbuf;
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

