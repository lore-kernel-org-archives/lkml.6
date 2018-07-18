Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6535ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A176220850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="kE9HkCU2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A176220850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731824AbeGRQvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:51:10 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54615 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731535AbeGRQtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:49:21 -0400
Received: by mail-wm0-f67.google.com with SMTP id c14-v6so3350375wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 09:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5nw1HQAmv4GwhqMuUaC5yDqQkngaK0CYak4ZYQ4kb7k=;
        b=kE9HkCU2i2Zo9sm8D1hIwFs780xiRBBKt598nH9OeB0bbn1rSrfPXgsJ0zJkH/dVt0
         pUsHG4sMy3Ye0vsLsKrhF6/z+kqqxIFhUpqIBkHqlEQQzJA6X7uilonoR2mQXqSBz4OO
         bdCbXliMU46bbir8A86dc/zMLupcV8EoCnmhXOQXKb4rGtC+2lml7B01mbwxMbQpyFTZ
         Gd+b3hu7Xht5SsmACFJHQ7kPkwTwrwSCAAev0SUNV357vD+faWt0c+TCzsjr38WlKqfP
         AdrBFOBxc2w/8q6PCT64q+tY/b/u3TLv34TFxLR75jXfeuEXPeXjNNA8koLu59Xn02oo
         bY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5nw1HQAmv4GwhqMuUaC5yDqQkngaK0CYak4ZYQ4kb7k=;
        b=HxCXOp0Jr/Rt1ln8iZRFBv/dE11k7VcvvEp0DkoqcyAYqR58Bh1K1V/74ryCG1tx3l
         WF5kOtcUppS/F+s7ZvNawilERO/bLX9VUFfZ2NJqbU36i3SWJoTJWoLRMiFUcJidgwQt
         L/1n1GfZ3Ut4EhPzi6jFFHiFYPJwZ5sePv/bLxXJLdJ49aO6yH4qIeAowXO4O7024L+Z
         jCe0UULrD6wzpjfdvCqlebwWRd3HsHAF8cFRAQgWvZOgng6AUJfFk/l9gbQjJUlD6Xzt
         DLw+/7XjHuOHZ5oG6I3ZuKQJSMpFgJzfIUjCVjDmWIr6xWuhHPbHtIOUraRQ9NK/B38+
         xHdQ==
X-Gm-Message-State: AOUpUlFkFO4HZ/vCjSbLtT6B2wqSFuuuRdOm1MtKUBxxKCbiFvQ5ca3M
        5DVguaiQZjn/osRt+BNmKjsdvQ==
X-Google-Smtp-Source: AAOMgpcqx/s4hF9Qf7YbLyIV28plr/vySEY4KZ3blOpbVwFRzDm/VgvAxsktM83/X59ApovtSEcXcQ==
X-Received: by 2002:a1c:1802:: with SMTP id 2-v6mr1928894wmy.81.1531930244957;
        Wed, 18 Jul 2018 09:10:44 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id v185-v6sm2847803wme.30.2018.07.18.09.10.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 09:10:44 -0700 (PDT)
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
Subject: [PATCH 2/5] net: add an info message to eth_platform_get_mac_address()
Date:   Wed, 18 Jul 2018 18:10:32 +0200
Message-Id: <20180718161035.7005-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718161035.7005-1-brgl@bgdev.pl>
References: <20180718161035.7005-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Many drivers that read the MAC address from EEPROM or MTD emit a log
message when they succeed. Since this function is meant to be reused
in those drivers instead of reimplementing the same operation
everywhere, add an info message when we successfully read the MAC
address.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 net/ethernet/eth.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index da8530879e1e..2a2173324d9e 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -530,15 +530,24 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
 	struct device_node *dp = dev_is_pci(dev) ?
 			pci_device_to_OF_node(to_pci_dev(dev)) : dev->of_node;
 	const unsigned char *addr = NULL;
+	const char *from = NULL;
 
-	if (dp)
+	if (dp) {
 		addr = of_get_mac_address(dp);
-	if (!addr)
+		if (addr)
+			from = "device tree";
+	}
+
+	if (!addr) {
 		addr = arch_get_platform_mac_address();
+		if (addr)
+			from = "arch callback";
+	}
 
 	if (!addr)
 		return -ENODEV;
 
+	dev_info(dev, "read MAC address from %s\n", from);
 	ether_addr_copy(mac_addr, addr);
 	return 0;
 }
-- 
2.17.1

