Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12DDECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF6F2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="MhBHL33e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF6F2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731611AbeGSJCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:02:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46840 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731551AbeGSJCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:02:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id s11-v6so7098329wra.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 01:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d0qNtBWtv5HWQy/kUDtOXthITMbaUfiwfKESg2lHVYM=;
        b=MhBHL33ej5mDKwzEXxwoDFsibzfJFpBjmbuCV/y07Gn9cB4ozGvTNyQ3IaDME1Xp6D
         ZaCAZbmp/6fo/pDsaytNP1isueLeqLU1XVmHNm9I/r8W88K7kRufOi+szuEEuLfS74U/
         yL56vm6U7Nqv7GKcfqODdCHgNVOfsyLTvKxKf0rQRJ9g1y3NhpG2uFZAPF3DDQnFVZo3
         f4HeGX4E/h65wS9HWkvmzhfVdqMg22BjUVhPEBoEbwiAxTDxruIOdNo2NPueq623Pw6m
         FyeTIdvUbeQkImacUS+KHtwkV+UT2lAmt/sILlcL62OK8TLxipZINFgk3f9UcBMFtlpC
         IsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d0qNtBWtv5HWQy/kUDtOXthITMbaUfiwfKESg2lHVYM=;
        b=qSY745uzmoLSpa1sLXeAZwlRIcmFEZcLJTXXqv/yvnbMNdpk7Gm38FC935BZcnadzy
         OZh30sdwBxQJc/Tl1HdGKsxtkL+InrqqWGfmYLv7XPEao9phcDUS3jQAweYUO1Gdi2/I
         JzIuzC5rVqjwm/T6ovqSdFqsXOBs1pCeSrOIqQg/rGPBIL+9g1/LNq1pbife7+eA43Ea
         b9gMtOHO3SbWumRMYfO5YJgdDsO20xRrKqJpxPZ27NwJo3X0r1VJmwF38HkxfMJZYM7r
         leABlNivAVmvkP7EwkmlFkPemJ+K2S8Qqi/RLW2DdvdXeCYWCot+RLQjlgmBQ7mQZhps
         MLmw==
X-Gm-Message-State: AOUpUlGw/iKXRysWOaQ7TX4VTgzSdpapyQ6IzR26rf94cbRkdQg5PH9W
        fktfBtvXcqfAoPqzHNQOCbK13g==
X-Google-Smtp-Source: AAOMgpfL5hCLOazHVWXmiLHh1BuE/Hn7YNAOS8tJYFSHc94pnLsCxxaJGT79aI9qK2h36JJ2GbVqwA==
X-Received: by 2002:adf:9f13:: with SMTP id l19-v6mr6723087wrf.206.1531988435884;
        Thu, 19 Jul 2018 01:20:35 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-40-185.w90-86.abo.wanadoo.fr. [90.86.159.185])
        by smtp.gmail.com with ESMTPSA id h43-v6sm1716338wrh.1.2018.07.19.01.20.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 01:20:35 -0700 (PDT)
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
Subject: [PATCH v2 3/3] net: add MTD support to eth_platform_get_mac_address()
Date:   Thu, 19 Jul 2018 10:20:28 +0200
Message-Id: <20180719082028.26116-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180719082028.26116-1-brgl@bgdev.pl>
References: <20180719082028.26116-1-brgl@bgdev.pl>
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
 net/ethernet/eth.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index af3b4b1b77eb..addbb3375e3b 100644
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
@@ -568,6 +569,23 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
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
+			if (rv == 0)
+				addr = addrbuf;
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

