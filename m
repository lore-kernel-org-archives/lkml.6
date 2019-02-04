Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5BBC282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB4C2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5DH5lPZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbfBDQmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:42:22 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37699 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbfBDQmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 11:42:19 -0500
Received: by mail-wm1-f67.google.com with SMTP id g67so606239wmd.2;
        Mon, 04 Feb 2019 08:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=klfMY5bcujzvlO0MLobful1nWbbcATcqEYRjC6qrSNg=;
        b=C5DH5lPZ1D/zKYXMuB6IfKWgSZxavMuvgzcXCQjhmYGO54EQAe0QT6b5b29e61KtV5
         ctxUQHuTa45PKgTpdFnkDkez1/6/NMsLRaQ/6WJMU6T54V/R3fZITJMsKnI3Di1Dx7yx
         KiYhD8HIp0CIWDm4FYiymQCiPWSSEOdszhfS4ffMHSO5Fg/UEx7/ZICD1ZjotoX5HxWd
         8aJNTEGurRT/R4Gzm3btim/kv5lR+dpW107G0XCLfMAO+1AlM/YvYjcaaAxs56oiLFWt
         8jRrHlc9hw4bVIgZ2xFElfqATHTdr0ntUjOdVXGo3rRS1vRGC7w0v+ZnQuUm5K2EjRPK
         PqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=klfMY5bcujzvlO0MLobful1nWbbcATcqEYRjC6qrSNg=;
        b=LwNeBJn9mwLacGidQamlw7PFxaCZbJfSnOuvNUbzerwdaKZXbQnb9NWSq1mJHBCTjl
         qB4a0cshRjqxTPDqYwCVtQ3DEVLE04Wuy5EF84xkLrB5xxaxm4nOVIlRvuXNsvyGvQM2
         +PDfTd2DEn4+xXauBv9/8sU5Dhk+ohpEi1qfJ6JcHCj10QMFuUCtsrhAZeDGsogSbdm8
         C2xoU1nZYoKkgIpf04RaH4i0hL0UOv4DT/BlldhX0cHEjSdWGr+QLCBfpVaTBVywtiEk
         BVtCRPn7rJZ34H/4cunGBrOrdIm7GPKtB73h27UIk76NxwvZ59HRCYX0bOu3nVo/GpCb
         Y8cQ==
X-Gm-Message-State: AHQUAuZYQVdkn8MGnWZ5mYlDddvA6ug9pMQ4Dl0F+ec54hdtEEDp2fAP
        5tlLmm5/79lvriFDfOQkkVs=
X-Google-Smtp-Source: AHgI3IY3ScUnpETUQOLa1MOgKyre9CELJTViPjjG3ZP2Hr5A37SpJX96aGgDQCgZlS7YZt7awDAEqw==
X-Received: by 2002:a1c:a185:: with SMTP id k127mr212286wme.134.1549298537184;
        Mon, 04 Feb 2019 08:42:17 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id f8sm2374772wrv.41.2019.02.04.08.42.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 08:42:16 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] r8169: Avoid pointer aliasing
Date:   Mon,  4 Feb 2019 17:42:13 +0100
Message-Id: <20190204164213.30727-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190204164213.30727-1-thierry.reding@gmail.com>
References: <20190204164213.30727-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Read MAC address 32-bit at a time and manually extract the individual
bytes. This avoids pointer aliasing and gives the compiler a better
chance of optimizing the operation.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Applies to net-next.

I tested this on a Jetson TX2 with an add-in Realtek ethernet card that
has a properly programmed OTP to verify that I got the endianess right.
Seems like everything works and the device behaves the same with or
without this patch.

 drivers/net/ethernet/realtek/r8169.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index 501891be7c56..192fbb36bc9f 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -7113,12 +7113,21 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
 static void rtl_read_mac_address(struct rtl8169_private *tp,
 				 u8 mac_addr[ETH_ALEN])
 {
+	u32 value;
+
 	/* Get MAC address */
 	switch (tp->mac_version) {
 	case RTL_GIGA_MAC_VER_35 ... RTL_GIGA_MAC_VER_38:
 	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_51:
-		*(u32 *)&mac_addr[0] = rtl_eri_read(tp, 0xe0, ERIAR_EXGMAC);
-		*(u16 *)&mac_addr[4] = rtl_eri_read(tp, 0xe4, ERIAR_EXGMAC);
+		value = rtl_eri_read(tp, 0xe0, ERIAR_EXGMAC);
+		mac_addr[0] = (value >>  0) & 0xff;
+		mac_addr[1] = (value >>  8) & 0xff;
+		mac_addr[2] = (value >> 16) & 0xff;
+		mac_addr[3] = (value >> 24) & 0xff;
+
+		value = rtl_eri_read(tp, 0xe4, ERIAR_EXGMAC);
+		mac_addr[4] = (value >>  0) & 0xff;
+		mac_addr[5] = (value >>  8) & 0xff;
 		break;
 	default:
 		break;
@@ -7316,7 +7325,7 @@ static int rtl_get_ether_clk(struct rtl8169_private *tp)
 static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	const struct rtl_cfg_info *cfg = rtl_cfg_infos + ent->driver_data;
-	u8 mac_addr[ETH_ALEN] __aligned(4) = {};
+	u8 mac_addr[ETH_ALEN] = {};
 	struct rtl8169_private *tp;
 	struct net_device *dev;
 	int chipset, region, i;
-- 
2.19.1

