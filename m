Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECF1C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE7E223DC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="bhFAgZ5h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE7E223DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeHJKhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 06:37:01 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:39104 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728206AbeHJKep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 06:34:45 -0400
Received: by mail-wr1-f51.google.com with SMTP id h10-v6so7462194wre.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 01:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HVcV+D9oE5OwLHTLo/qKvbgd6WX5oO3G+bmGYBBY+LM=;
        b=bhFAgZ5hHjjTrwrl1iOBbafXfBDZiTPhqPFI3NNgnioBKDQ9cc/2d9WiTpA060hA31
         dvp9PdgR/uW2GaC/OfRLieKDN2frM/haHRGaGTfW61Gb9dqlssGutnim8Wr0rUiK2KWH
         xHoM/SWqCl0FxIazn4IPWAC1uvLuPN/QbBUwVgXVuI6CbZvMWJRcAqYn2UJMZ+Jrg41p
         ZIuLV4F6xKtofc6znzidBFHaUZ458NXJnukAgkkbkI82sWb5xlYEMW2o0b58czd1clnl
         j+Drc3J+KuvjnViTb2VpM2V0LP2JjL+1wK7CiLodtIYRrBzFwebqEbHStVGZF/kmONeF
         POlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HVcV+D9oE5OwLHTLo/qKvbgd6WX5oO3G+bmGYBBY+LM=;
        b=BdTarQvsQlqearf32HiQH+CX5+YniBPAYLyw8ku9I4neZrHFLzn21QnrLVN3oaMKqN
         N8T0wEG4o85d4tgsepQmEzCPjym26zbF8vNbtH+RxXTyYRQeu0+AXltic6A4Lz75Oa8G
         1TRsdsl1FoI2JJEhpBy87e9kcDrNNXYxbKneA+DcK70JH6mMurKDwp/jFVQzJIEm6ErM
         GBPEpca6JuIipnpF9YUWWkXdJQvgcnawP0i+aGQiHjHJqZIf3SA5hjj65pWvnVNlGsRc
         o2uJYcm+3OAVot8GpiXYM9d1YULlTLm0avoxb48hT7vFxYwFOgvN3nB9mkkycuxze+mX
         9gEg==
X-Gm-Message-State: AOUpUlEYsCAwQZx6Q+txXkMOmyDKz9khHMC/R44XM8teep/orlDH+vfv
        saUU0oMSUuwoK+dNMP+UI2ux5Q==
X-Google-Smtp-Source: AA+uWPyBdjVAqNR/3A8sojlKFsQmP5DkUM6AEbLZ9dYbBKm/fehxDFZKubc2KMb2IL1kO7W4wKMBJA==
X-Received: by 2002:a5d:458b:: with SMTP id p11-v6mr3508671wrq.122.1533888359309;
        Fri, 10 Aug 2018 01:05:59 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id h7-v6sm9546405wrs.8.2018.08.10.01.05.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 01:05:58 -0700 (PDT)
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
Subject: [PATCH v2 14/29] net: simplify eth_platform_get_mac_address()
Date:   Fri, 10 Aug 2018 10:05:11 +0200
Message-Id: <20180810080526.27207-15-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810080526.27207-1-brgl@bgdev.pl>
References: <20180810080526.27207-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We don't need to use pci_device_to_OF_node() - we can retrieve
dev->of_node directly even for pci devices.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 net/ethernet/eth.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index ee28440f57c5..7f08105402c8 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -530,11 +530,7 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
 	const unsigned char *addr;
 	struct device_node *dp;
 
-	if (dev_is_pci(dev))
-		dp = pci_device_to_OF_node(to_pci_dev(dev));
-	else
-		dp = dev->of_node;
-
+	dp = dev->of_node;
 	addr = NULL;
 	if (dp)
 		addr = of_get_mac_address(dp);
-- 
2.18.0

