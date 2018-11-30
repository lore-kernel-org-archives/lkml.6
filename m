Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46EFC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8899B20868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="SdRkiTze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8899B20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeK3T3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:29:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53491 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbeK3T3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:29:48 -0500
Received: by mail-wm1-f68.google.com with SMTP id y1so4813437wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 00:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g6fDyXr3adFpuTH9G+ruIeWWkLZ3iM8ERWmFGu4Kdi0=;
        b=SdRkiTze7FJcu/orY1Ounsq77owwcLmuT/VjBp5Xzn4YvcUjmXkbDLuzC3w9DpQuTA
         U7ySkhDJ8CbtrS4xM81Yn7eA1cg1MAp4Varxt1pX5lSqVjJ8Uivr1cb69VkhXKk1KwC0
         x0D6ghRLC4afx3WMKnxqrWz8f9tGlS+5yAU7JzIWGchjbKmJULEd5PCOVktC8Yib9f0X
         d6mipJrTo3li7yKK5WH0CwvSUu6bP0U2Fy5zdb6uMYI3Iar4NSs95SvJjTAufOL5yrUb
         1/ptL8WHSPCaaIXoerioO1uo25SQOWJ1kibnpLx/P2peezhvfBvbR7BorAB0UM4JEqFo
         wL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g6fDyXr3adFpuTH9G+ruIeWWkLZ3iM8ERWmFGu4Kdi0=;
        b=r6ULRzLKMpX7QIBlkO/fArKfZPLtN4MEbvt7rmvDFwX3nvYqvp8TwI9VkZEbsahzrx
         UUiokJRCOAGdDx9p/SgvrZ5jTxPHT/lHqaV0CnwJ+GC6Z3A/dw4ss0kOnURFCHJil5xu
         yesQtj+dTvRNR4pvKwVhwB2Eewq981ShGNJcshPg4yS60whMKahdd2Xs7c6f+oejz6CH
         V150sXl/LBYTNfFW0kRJgallxd/srxRNcO8tgUiCxI9djTuoY8pL55cf6YEBzjXUI+Co
         wTn0XOajXLLgIie9mAQCRtonxgZzJS7nPMzRQ1MNYDNhI8u4mY1ak+eoOHFn0t6nSSSw
         sUrQ==
X-Gm-Message-State: AA+aEWZa+BklwUXwFRNjCdJyj8Cj34AMt90w4AOFml3MgfaQ14bXugXt
        CT/aTErTUlulTYH87yIs7yhYsQ==
X-Google-Smtp-Source: AFSGD/VDOHrh3e+21hseD3mbZwxVT4ZVuFEbMdCpQ8KJw0BmOokvgh2RjLvJujGP94dUUCrL2PhcTQ==
X-Received: by 2002:a1c:5f8a:: with SMTP id t132mr4749920wmb.40.1543566077010;
        Fri, 30 Nov 2018 00:21:17 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id x197sm6473374wmd.2.2018.11.30.00.21.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 00:21:16 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [net-next][PATCH 0/4] davinci_emac: read the MAC address from nvmem
Date:   Fri, 30 Nov 2018 09:20:56 +0100
Message-Id: <20181130082100.6241-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series is part of a bigger series that aims at removing the platform
data structure from the at24 EEPROM driver[1].

We provide a generalized version of of_get_nvmem_mac_address(), switch the
only user of the of_ variant to using it, remove the previous
implementation and use the new routine in the davinci_emac driver.

[1] https://lkml.org/lkml/2018/11/13/884

Bartosz Golaszewski (4):
  net: ethernet: provide nvmem_get_mac_address()
  net: cadence: switch to using nvmem_get_mac_address()
  of: net: kill of_get_nvmem_mac_address()
  net: davinci_emac: use nvmem_get_mac_address()

 drivers/net/ethernet/cadence/macb_main.c |  2 +-
 drivers/net/ethernet/ti/davinci_emac.c   | 14 ++++++---
 drivers/of/of_net.c                      | 39 ------------------------
 include/linux/etherdevice.h              |  1 +
 include/linux/of_net.h                   |  6 ----
 net/ethernet/eth.c                       | 38 +++++++++++++++++++++++
 6 files changed, 49 insertions(+), 51 deletions(-)

-- 
2.19.1

