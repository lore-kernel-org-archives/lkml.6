Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836E4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A76F214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864666;
	bh=tqnXBLGGESMm9WvLDATNKyT7sGo1rbilrdcDJjY2hks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Nj6GwvK/lB0J4ddvaZdql2nMwlnDPGz2tq2VSuCIU0+x+uMyApkNqb3PP5zuUT90j
	 CwvGhhCBEbCFHqZP9sYgVR63Toang/IFDFCXb41LvbJlVWIfezO/qGG67/u8CTuF8F
	 wVdJocK6V5tCghSWan9JfbJH9nhOGw/TE7sRG6mo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbeLZWvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:51:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:37404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728154AbeLZWhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:37:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3DEC2054F;
        Wed, 26 Dec 2018 22:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863835;
        bh=tqnXBLGGESMm9WvLDATNKyT7sGo1rbilrdcDJjY2hks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NQcYzc4DOZNjdRAryRnYvTSJB/KtdJI5ydYtEXPv0Cpya+L1oF54D5C0MIj1xKOan
         dVzcNIB6ruwhOGCsZQ8KhDBMgXezFAwZ6B/gaUbV+rS7Qzi0lFLaeUOZRu8fkAhimP
         L5FeL4gOWfRC+9oSyeFanR3yKsk4zpzAOG9UtUzI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 50/97] w90p910_ether: remove incorrect __init annotation
Date:   Wed, 26 Dec 2018 17:35:10 -0500
Message-Id: <20181226223557.149329-50-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
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
index 052b3d2c07a1..c662c6f5bee3 100644
--- a/drivers/net/ethernet/nuvoton/w90p910_ether.c
+++ b/drivers/net/ethernet/nuvoton/w90p910_ether.c
@@ -912,7 +912,7 @@ static const struct net_device_ops w90p910_ether_netdev_ops = {
 	.ndo_validate_addr	= eth_validate_addr,
 };
 
-static void __init get_mac_address(struct net_device *dev)
+static void get_mac_address(struct net_device *dev)
 {
 	struct w90p910_ether *ether = netdev_priv(dev);
 	struct platform_device *pdev;
-- 
2.19.1

