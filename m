Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40F8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C03A2080D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="amZHdIrn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C03A2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387877AbeKNAA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:00:29 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35421 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387822AbeKNAA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:00:28 -0500
Received: by mail-wm1-f66.google.com with SMTP id t15-v6so11576346wmt.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 06:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2eIRMJcdB28q8gd3gkQor3tkK+DGn7qHJn7Cj+8GDeU=;
        b=amZHdIrnSs7c8jZW92v9Kikt9NDZvSE6hQEPbCPyn2jDxbBwywkhabdh36IBU1q31I
         o6pm2Jczv5JXrWUl1K6fffJWSjND3io0wOOjtrrItgj0If9D69u/xKrIZ25/2lITShgd
         Dny/nLUQJnoKUvKCJlxVTnRy6FnlDomyFFy3tp/bVeVjVDPRGVgcDndIQiZ06fPpztU/
         fww7ux7TxKoOvD0fTJIWQFDm2FArtwBTw4VL7xqfYIVlenWeRRCSBjvEkihfOAD081ix
         zZ/lY675M6RTp+UAvj+yhod3/e4INrDAygE5LGpdh2JWXoVGrAE49on7RWLPp9uaHVYN
         g7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2eIRMJcdB28q8gd3gkQor3tkK+DGn7qHJn7Cj+8GDeU=;
        b=rp/NNzxkGIH8vXX885VGPZ+ggUXDc032j3DP9gKycisj6egI1V1l4HKroYx/o68Ar7
         Heq1b1nRbwhDVJ66K1Loo4BU4+5lT/XI6XgMM2En1NoXn1npv2p/lURg77qOLFu4QFky
         TEbe91dvzMqJLBz/jv/F4ONOy9/1z2DgYGp/Yl3t1D7EKDc1MlvFfjBMe/bmSBSo71xZ
         LIa4L43rOYih1Jk4o/sWmDoyNVjinxNXrQ2yocE1n16eN9346d5Dixft9ihE+8VZbIta
         QPFbbUTiwLZnl7xfeJutSmsTQijRWP/Ihgh/2E3tnrilVwbfWXIURDMM08EO9wNhxOXq
         LCBg==
X-Gm-Message-State: AGRZ1gLubQD7nv19s0OUsEudcKDyHTx1PN8rCDbgOTabaqG4gxaPp9Zk
        hSEvLd8pkZWtwYXZqPTtbqRSr3ydoMA=
X-Google-Smtp-Source: AJdET5eoE64XWNNiFm19EqpK/Nc3Y8dt7f/33XUO4NGqA04C77zBLDLjisFr8ov6/0MZ+gkc3J/b9A==
X-Received: by 2002:a1c:38c5:: with SMTP id f188-v6mr3268849wma.19.1542117729980;
        Tue, 13 Nov 2018 06:02:09 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id m69-v6sm16604122wmb.8.2018.11.13.06.02.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 06:02:09 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org,
        netdev@vger.kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 09/25] ARM: davinci: da850-evm: remove unnecessary include
Date:   Tue, 13 Nov 2018 15:01:17 +0100
Message-Id: <20181113140133.17385-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181113140133.17385-1-brgl@bgdev.pl>
References: <20181113140133.17385-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The include file for at24_platform_data is not needed in this file.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da850-evm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index bac2162e2153..6a29baf0a289 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -20,7 +20,6 @@
 #include <linux/kernel.h>
 #include <linux/leds.h>
 #include <linux/i2c.h>
-#include <linux/platform_data/at24.h>
 #include <linux/platform_data/pca953x.h>
 #include <linux/input.h>
 #include <linux/input/tps6507x-ts.h>
-- 
2.19.1

