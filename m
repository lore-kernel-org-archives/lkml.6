Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62570C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA54218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545866543;
	bh=rHMk2wZPrsgOm9SWpwXEqM8q/rtsNLJoiLR6Wpl7v0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K0gu1IzzPXoB/pdd/rmJp3xOXdzi0x2PflkHJhNTlLexnJS+BROHzYvZ554BMVgt8
	 4nn7rKNx/PmvaheFqF2ZVEpd9R28wi+ZixZQjzMUalcqjUAEqm5MD7m2D5JaOUInoR
	 kpbGhy7pvUZHmny519Wm8iUkigypRwVylEl4ZRIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbeLZXWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 18:22:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:43928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728306AbeLZXWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 18:22:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91326218A5;
        Wed, 26 Dec 2018 23:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545866535;
        bh=rHMk2wZPrsgOm9SWpwXEqM8q/rtsNLJoiLR6Wpl7v0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=luk4WrYqOpJ6PvBCGlIhSpCImbcf9wo0X0fuhKlWltFY3BC6djEN3BGr0FU4KUj4b
         wKFNC8zfLA+5OvkbtyYqTGz+50+ivzgEFnKqWKViyqp3EXZW4jv+8Ef/XzFabh53vf
         PeBZZ57EeW10+2ibonngJd5UOhvQEPCpVWjFs3j0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 07/12] w90p910_ether: remove incorrect __init annotation
Date:   Wed, 26 Dec 2018 17:57:35 -0500
Message-Id: <20181226225741.151608-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226225741.151608-1-sashal@kernel.org>
References: <20181226225741.151608-1-sashal@kernel.org>
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
index 379b7fbded78..f15c97343c9b 100644
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

