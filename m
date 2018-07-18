Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAFBECDFBC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D512720652
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="SlTGuzpT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D512720652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731650AbeGRQt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:49:27 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37106 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731600AbeGRQtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:49:25 -0400
Received: by mail-wm0-f67.google.com with SMTP id a19-v6so3454059wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 09:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KzIGmhGopa8qvGvH3FjuzEqo3RmKWtro3PgtBoK8plw=;
        b=SlTGuzpTdzpzWjjDNnruv80utH7LQIgJWTow35OdlEo5crkazi0WTjyeQPO6taUGm/
         +uZSzWvlBsChyjRZY3+oI9eHsyxZqOKh2ayal0bw4Ka7E4hXmYD/VSzyZAlCkb/nqQOX
         x3MdS8u0jeXgrgTLUsQbh/lCBoVr/7uF6ASc5Sk6SMLjXOp17XbByM3DSXdGsu/z9wfO
         Fkv5f5n3D9uYflV7Hi64MMpk9OgJ0CxfXO5exT5xB/gQp+Z1rofsngmRLiFiaLLarXeX
         DmWzogrSXdKtIkLjfmvCTomM0zwH95FRTRwAGvhW9EVVz2fx9LJ5+EEIoE1w4D56dNwh
         vw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KzIGmhGopa8qvGvH3FjuzEqo3RmKWtro3PgtBoK8plw=;
        b=DVnRjxmLc5B8RCYOWZZDrgu7cLA84/qfNpqR1m5Y90E638LqL7tnw58zM/HR6jDWMb
         ke0EQWh1R/7AkgKtfdw0eLx+drD+Zcyp0I/eevuldbqyhraKO3jEnCX6nSSkdQwCtMv2
         kX5OW1+qvn9BykyfDqTpFpoLHypTONw3PVidu57K/OlQIAzPat0F6z0Jg1qK9q7h4jOS
         kkjbFRDDrddHHyWoLcyFehsfxi9I4NzAVmnQmxVy4mERRByLcviVXxc2FGbYhY4QJnat
         i3c9SFhKZIq2Bxsmu6YpWLCZKTNHDNmNP7rmd9uqYkhzfsSbHA9FVzXW7gL+Wk8a/uGL
         GyNA==
X-Gm-Message-State: AOUpUlGi6YkEisiGEFmyexXTYUV/36SyQ+gJhl9uBhM45/5a7xhbyP/Q
        8ldjnsGWT7r2Yai4nWjjpfWFPg==
X-Google-Smtp-Source: AAOMgpcTDIBrjTh7f1WdPZSu3h22o8LwJaSr7vKg/uFwwHL1KoYbEvLWo3K/svVKRKNIVRGOV+wTfQ==
X-Received: by 2002:a1c:ec9d:: with SMTP id h29-v6mr2062379wmi.94.1531930249254;
        Wed, 18 Jul 2018 09:10:49 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id v185-v6sm2847803wme.30.2018.07.18.09.10.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 09:10:48 -0700 (PDT)
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
Subject: [PATCH 5/5] net: add MTD support to eth_platform_get_mac_address()
Date:   Wed, 18 Jul 2018 18:10:35 +0200
Message-Id: <20180718161035.7005-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718161035.7005-1-brgl@bgdev.pl>
References: <20180718161035.7005-1-brgl@bgdev.pl>
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
 net/ethernet/eth.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index adf5bd03851f..f7dbd2cff7f9 100644
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
@@ -573,6 +574,25 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
 		}
 	}
 
+#ifdef CONFIG_MTD
+	/* NOTE: this should go away as soon as MTD gets nvmem support. */
+	if (!addr) {
+		struct mtd_info *mtd;
+		int rv;
+
+		mtd = get_mtd_device_nm("MAC-Address");
+		if (!IS_ERR(mtd)) {
+			rv = mtd_read(mtd, 0, ETH_ALEN, &alen, addrbuf);
+			if (rv == 0) {
+				from = "MTD";
+				addr = addrbuf;
+			}
+
+			put_mtd_device(mtd);
+		}
+	}
+#endif /* CONFIG_MTD */
+
 	if (!addr || !is_valid_ether_addr(addr))
 		return -ENODEV;
 
-- 
2.17.1

