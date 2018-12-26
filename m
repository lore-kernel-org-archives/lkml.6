Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E13C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A8021741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545865041;
	bh=2hKzkZjyS2vnsSGOUTr1mFrNsaRD5FTTqtycEWRY9zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tuMghScnwVvVpLcv7+TKT0omeRHaM3QNuAD8E+SPnadZGelUSS6vKt76S0eRXwOVO
	 SjGuWp6tDZqpe+hIxViR5p1ecOxuwnFfg+1xoNRIlbSonR2QgQXyADqtW79UDklSw6
	 IhNyf0K5iCDYopP9I1gFEYUl1JlYb/JIzmD4akXM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbeLZW5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:57:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:58192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730412AbeLZW5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:57:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 929FC2070B;
        Wed, 26 Dec 2018 22:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545865034;
        bh=2hKzkZjyS2vnsSGOUTr1mFrNsaRD5FTTqtycEWRY9zs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o/pzf1hKdGR0CB6N3bt/4KiLZegQ0eceVptaJZcZ9qgBTY/w0JR25tCReBi/ARdC/
         9J5Msp8zx/h95t3WgIT6r4kQ1rabZXtgY4P1CaT1xK4SLzfKQmaI2xTxTe9azarJCD
         2PObSpX1D8g+3MlqN3QjwVcyE7LxDQFgM3hxJsBs=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 10/21] w90p910_ether: remove incorrect __init annotation
Date:   Wed, 26 Dec 2018 17:54:48 -0500
Message-Id: <20181226225501.151365-10-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226225501.151365-1-sashal@kernel.org>
References: <20181226225501.151365-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 51367e423c6501a26e67d91a655d2bc892303462 ]

The get_mac_address() function is normally inline, but when it is
not, we get a warning that this configuration is broken:

WARNING: vmlinux.o(.text+0x4aff00): Section mismatch in reference from the function w90p910_ether_setup() to the function .init.text:get_mac_address()
The function w90p910_ether_setup() references
the function __init get_mac_address().
This is often because w90p910_ether_setup lacks a __init

Remove the __init to make it always do the right thing.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/nuvoton/w90p910_ether.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/nuvoton/w90p910_ether.c b/drivers/net/ethernet/nuvoton/w90p910_ether.c
index afa445842f3e..9064db78cf39 100644
--- a/drivers/net/ethernet/nuvoton/w90p910_ether.c
+++ b/drivers/net/ethernet/nuvoton/w90p910_ether.c
@@ -918,7 +918,7 @@ static const struct net_device_ops w90p910_ether_netdev_ops = {
 	.ndo_change_mtu		= eth_change_mtu,
 };
 
-static void __init get_mac_address(struct net_device *dev)
+static void get_mac_address(struct net_device *dev)
 {
 	struct w90p910_ether *ether = netdev_priv(dev);
 	struct platform_device *pdev;
-- 
2.19.1

