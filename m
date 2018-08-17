Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023B7C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 05:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C23213A2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 05:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="z5YxADVp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C23213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbeHQIKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 04:10:00 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41949 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeHQIJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 04:09:59 -0400
Received: by mail-pl0-f66.google.com with SMTP id w19-v6so3154525ply.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 22:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=53BARU/ZAFEXDbwsVCESlUSUuP/kzAjudPhdYPJzkt8=;
        b=z5YxADVp8098DY6vCFE15eANxI6JopaU9Xm500yT7daa+e3hNzp5VgGhFwwp1ju++I
         0XvVrjAxPJ+2FBCA3ZXQF472s+6NEwE3AsZpK1C8M/VCAvrdUS5p5NttwzyBAXbGP1Ne
         pL2EVUkzm7DUwqiwUmSRBeVT8er3opaxZNJys5GwPBV19spd5a8wrHNrQCFt+X1VOuBs
         YUUDMeshHwcD4sy8apbcBHe4DR5Gbipsph0O6tnEy1/bGNlKfsBGVBwKtKWy6v9rWhmf
         g7dObduXI5Z7Me0kBF09tYM3fdXgCsauOip3R7jN0pCJnswBMOQb9PCZef8fGuBqSks5
         Qxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=53BARU/ZAFEXDbwsVCESlUSUuP/kzAjudPhdYPJzkt8=;
        b=oaWZe0GJ2cB1GVxzJd+I9jpOM6ND5NqAEvcjV2LanqRiFfDuyp39YQ/5EjWBxQD/Bd
         OrejZWqij/foxkCQWO+mKSk+MaPi2KK6XqftCe/Gnsv4T2hMS10DjWYdpEwxwQWh5idz
         8Ng6+zFqdSwTxgph6Oh8pIAbYbh25V9rFjQnFucU3Ey1EMrunYlJFEs4LvE8h1Nu1H9Y
         NflXs3PprYWs3hcjQKI3dpRCirEcM5ph/BTbSsmtM8Wu6z02C8EmsFBFvbpD00RZYbqu
         thpSWeXc/KkU99tZGzpvIfk9k2rnhQIqAVqzbYX1DjbfGjGoy2XhExW7GcmBiQqSYfrV
         i9Aw==
X-Gm-Message-State: AOUpUlHZgQ5tss79MJ/I/GetPa3TXpKqFF4btB7YAVgRX7sxuN57FwbF
        sBvum9+tf3AyXWAsFjRKaExZsA==
X-Google-Smtp-Source: AA+uWPwBC+5smPxpoh0fCA74RYUUciJxofitLZnzk5O6bi2Iq6wigy0WtnV7jpE2My6NZxtZDO7Ybg==
X-Received: by 2002:a17:902:5617:: with SMTP id h23-v6mr31668679pli.324.1534482483487;
        Thu, 16 Aug 2018 22:08:03 -0700 (PDT)
Received: from localhost.localdomain (125-227-158-176.HINET-IP.hinet.net. [125.227.158.176])
        by smtp.gmail.com with ESMTPSA id j5-v6sm895980pgp.6.2018.08.16.22.07.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 22:08:02 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        David Miller <davem@davemloft.net>, nic_swsd@realtek.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com
Cc:     Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH v2 net] r8169: don't use MSI-X on RTL8106e
Date:   Fri, 17 Aug 2018 13:07:35 +0800
Message-Id: <20180817050735.3367-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180815062110.16155-1-jian-hong@endlessm.com>
References: <20180815062110.16155-1-jian-hong@endlessm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Found the ethernet network on ASUS X441UAR doesn't come back on resume
from suspend when using MSI-X.  The chip is RTL8106e - version 39.

[   21.848357] libphy: r8169: probed
[   21.848473] r8169 0000:02:00.0 eth0: RTL8106e, 0c:9d:92:32:67:b4, XID
44900000, IRQ 127
[   22.518860] r8169 0000:02:00.0 enp2s0: renamed from eth0
[   29.458041] Generic PHY r8169-200:00: attached PHY driver [Generic
PHY] (mii_bus:phy_addr=r8169-200:00, irq=IGNORE)
[   63.227398] r8169 0000:02:00.0 enp2s0: Link is Up - 100Mbps/Full -
flow control off
[  124.514648] Generic PHY r8169-200:00: attached PHY driver [Generic
PHY] (mii_bus:phy_addr=r8169-200:00, irq=IGNORE)

Here is the ethernet controller in detail:

02:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
RTL8101/2/6E PCI Express Fast/Gigabit Ethernet controller [10ec:8136]
(rev 07)
	Subsystem: ASUSTeK Computer Inc. RTL810xE PCI Express Fast
Ethernet controller [1043:200f]
	Flags: bus master, fast devsel, latency 0, IRQ 16
	I/O ports at e000 [size=256]
	Memory at ef100000 (64-bit, non-prefetchable) [size=4K]
	Memory at e0000000 (64-bit, prefetchable) [size=16K]
	Capabilities: <access denied>
	Kernel driver in use: r8169
	Kernel modules: r8169

Falling back to MSI fixes the issue.

Fixes: 6c6aa15fdea5 ("r8169: improve interrupt handling")
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
Changes in v2:
  - Make the commit message shorter
  - Add "Fixes" tag in the commit message

 drivers/net/ethernet/realtek/r8169.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index 0d9c3831838f..0efa977c422d 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -7071,17 +7071,20 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
 {
 	unsigned int flags;
 
-	if (tp->mac_version <= RTL_GIGA_MAC_VER_06) {
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_01 ... RTL_GIGA_MAC_VER_06:
 		RTL_W8(tp, Cfg9346, Cfg9346_Unlock);
 		RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~MSIEnable);
 		RTL_W8(tp, Cfg9346, Cfg9346_Lock);
 		flags = PCI_IRQ_LEGACY;
-	} else if (tp->mac_version == RTL_GIGA_MAC_VER_40) {
+		break;
+	case RTL_GIGA_MAC_VER_39 ... RTL_GIGA_MAC_VER_40:
 		/* This version was reported to have issues with resume
 		 * from suspend when using MSI-X
 		 */
 		flags = PCI_IRQ_LEGACY | PCI_IRQ_MSI;
-	} else {
+		break;
+	default:
 		flags = PCI_IRQ_ALL_TYPES;
 	}
 
-- 
2.11.0

