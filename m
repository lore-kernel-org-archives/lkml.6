Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A0DECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDAB620854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="0YpQBTGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDAB620854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731567AbeGRQtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:49:21 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:40599 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731452AbeGRQtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:49:20 -0400
Received: by mail-wm0-f48.google.com with SMTP id z13-v6so3447667wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 09:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AZzCltgnNdPyeZzXiMFjWCg4GFVgDog5WHEdONSaQYA=;
        b=0YpQBTGjX84ndXw1Qum4CiP3P2WxZurvYZThnuNXWR08RnwbPI4e2GjvoVhUdyEBth
         GxlkSsth9vK6cOICNeN9DdEtvnvF74ZfP3/vuLuJArkElGJV1YNsYRqHCgERqCOVHQ34
         SXrgeL6dBhbLeWlU8Z4JNeI7RB6s/eLqa5j0O8lkGcKo1fiwwLM83cgkxhwz4wrhhNVD
         RnVS5Emrddpb289sl2cJYb1sfT2soXpIJtm9c/RgLXQ7nwb7a6BfGQBCBO4F2wXAPiuK
         MYGpqbtrLZDXIke2bNcTOC1WtgoXZsWF8a0yEQWSQyaY0AHTRjHGwPKg8wJzrA55WbPG
         FDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AZzCltgnNdPyeZzXiMFjWCg4GFVgDog5WHEdONSaQYA=;
        b=XtXPc6s/gh8zEQzk0HFXMX13pIqchJB5BOCi4owGW6Yf+EMH4y15YBEaPtBzU7U+uI
         xvzXyzOZgzcpFgLnlxch96sPi6Hw+2V97/S398wFRxK8wTaALZQvhu0YYS5z6jBflnBB
         fEgUsZaaPGzzxOBI+M1nxxBihx22TLdjcfNLXHvIRTvMAr4LgNHQWeur3c0R4L7LDU9x
         E5Eal/GRDX7DiHs3Ocx1Wuon5MXQVPmwbd6ILQFfqTGxn2W4fAoQQ2nDf+iwNHdqWHNN
         OjQhbt++fu6MJo/hJFzs9/jWwzWIU5JsZ7KbQBLVlTGcdOf6aRRRdMzGmWBzwkguJYmr
         RgPA==
X-Gm-Message-State: AOUpUlGVH53w8yNZGL2K181EBawoiGkpDT3zLdAQgWGvNZwtlyCy1+U1
        0xwTLTnepa8PCOT/+g+n3Jg5PQ==
X-Google-Smtp-Source: AAOMgpe57NW0DQDrONhZjG8SlJwhk7i/pp3Ii9AltAolWcQJMvLYWVi8kJi6JCEEY5x61NvhhAjheA==
X-Received: by 2002:a1c:888e:: with SMTP id k136-v6mr2069766wmd.6.1531930243447;
        Wed, 18 Jul 2018 09:10:43 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id v185-v6sm2847803wme.30.2018.07.18.09.10.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 09:10:42 -0700 (PDT)
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
Subject: [PATCH 1/5] net: visually shrink eth_platform_get_mac_address()
Date:   Wed, 18 Jul 2018 18:10:31 +0200
Message-Id: <20180718161035.7005-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718161035.7005-1-brgl@bgdev.pl>
References: <20180718161035.7005-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Initialize the variables with proper values so that we save a few
lines of code before we extend this function in the follow-up patches.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 net/ethernet/eth.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index ee28440f57c5..da8530879e1e 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -527,15 +527,10 @@ unsigned char * __weak arch_get_platform_mac_address(void)
 
 int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
 {
-	const unsigned char *addr;
-	struct device_node *dp;
+	struct device_node *dp = dev_is_pci(dev) ?
+			pci_device_to_OF_node(to_pci_dev(dev)) : dev->of_node;
+	const unsigned char *addr = NULL;
 
-	if (dev_is_pci(dev))
-		dp = pci_device_to_OF_node(to_pci_dev(dev));
-	else
-		dp = dev->of_node;
-
-	addr = NULL;
 	if (dp)
 		addr = of_get_mac_address(dp);
 	if (!addr)
-- 
2.17.1

