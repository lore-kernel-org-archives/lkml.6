Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30881C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDEC0206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="acXBfGRW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDEC0206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731546AbeGSJCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:02:34 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:44547 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731186AbeGSJCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:02:33 -0400
Received: by mail-wr1-f43.google.com with SMTP id r16-v6so7108894wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 01:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GD31JLCNt8L1SLxIII8ZY0h+x0qTpgVuq1EzBxuSJSA=;
        b=acXBfGRWXA+I7bgMj+okioJKnjvjKMxDAjJCYaxQ5hKnn/ipAd1NRzrxqxLV592499
         1OrX01twt4O2CD/Y1Cim4696UHEG2VQPJodmSR/x1xSPbxQGRsXyTw1JwoKG81rC7PA+
         HKHeezw90jdaxQ3lOg96we+jMUKeG/NvUmgcIdMR1u+vBBG7knHNEuMoAgx7REj3NuYX
         USu5QLc+6zKbdtAdyQu9dVWDN5NXC7BI26IpV6gwVMZ1qlG5PymO2QhUijbhsP7eZ7BL
         6TqyLvytu7P5+nuc/julJ589qTcrRENnTCVzxUSqZaA5kKNIEOMlCvwOhymBbHgmWJOi
         1vfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GD31JLCNt8L1SLxIII8ZY0h+x0qTpgVuq1EzBxuSJSA=;
        b=fCKDOjGNgWOpQfKX7Q90IXpPFY1apps2oqH3B2nzsIHZ9LdrKIJL+We8bMAeG3lHqd
         7N220yOq4JUSWc2ZxSRIgI2JMVG+H/Yw37ajACxLcy/GgMZiggoMtb48Tfj68sd/sYqI
         x13ddGv9U0V9gKGSvGAk2U4KzTNkljh9brqUKj7JpJ39a1axQSiSr7FBvl1P08CH7X3k
         WnGYdeT8ujdbN4RML9TGY7i4nlqmxt+BNrB5fNpNFBbOkW0w9wIqa5zepmlrGpHIVlyU
         X1B+slPmgXOgNhPBrqLcUqfqHHRxkh8C228tlyfgp/kDvCpFSs86PbGR4ZmeSwON57+M
         +rRg==
X-Gm-Message-State: AOUpUlG8TZ1VOClw5qpxQUVAogCjWIANUB9gb31fnT0afq+0inDKCF+T
        C0exyRXHfKDth4NIJH/B6BtMpA==
X-Google-Smtp-Source: AAOMgpcEMk0FaEio3Fxu4SiPcEyScKHLARXxtXCIc2tdO5179xaxVdRsVG4LfiY1bp3vsF2Ej5zhyQ==
X-Received: by 2002:adf:a0f3:: with SMTP id n48-v6mr6946521wrn.23.1531988433260;
        Thu, 19 Jul 2018 01:20:33 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-40-185.w90-86.abo.wanadoo.fr. [90.86.159.185])
        by smtp.gmail.com with ESMTPSA id h43-v6sm1716338wrh.1.2018.07.19.01.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 01:20:32 -0700 (PDT)
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
Subject: [PATCH v2 1/3] net: fortify eth_platform_get_mac_address()
Date:   Thu, 19 Jul 2018 10:20:26 +0200
Message-Id: <20180719082028.26116-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180719082028.26116-1-brgl@bgdev.pl>
References: <20180719082028.26116-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We'll soon have more sources from which to read the MAC address in this
routine. Make sure the address is correct before returning it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 net/ethernet/eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index ee28440f57c5..39af03894598 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -541,7 +541,7 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
 	if (!addr)
 		addr = arch_get_platform_mac_address();
 
-	if (!addr)
+	if (!addr || !is_valid_ether_addr(addr))
 		return -ENODEV;
 
 	ether_addr_copy(mac_addr, addr);
-- 
2.17.1

