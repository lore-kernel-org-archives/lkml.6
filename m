Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CAAC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE9620821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE9620821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbeLJUph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:45:37 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:53871 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbeLJUph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:45:37 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MVvGt-1gw0AT32MX-00RuFi; Mon, 10 Dec 2018 21:45:16 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Wan ZongShun <mcuos.com@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] w90p910_ether: remove incorrect __init annotation
Date:   Mon, 10 Dec 2018 21:45:07 +0100
Message-Id: <20181210204514.2362328-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:o1rMw2aYXfEUlBRV5qxG3z9Xz3NqFDkHTfll+jYdgTzCqly/PpC
 4kkeLiXInDEm59fTvKLxmY7BsZJ7cCZgts+pvPoJ71M5aif0gEgAoacdjohegJ5Tfm3xVfJ
 2qO5G+ZkLU9ScmK+JYQxlJyJHWZLUZlVuhxpXPDYb4HZPEKtBKgXtjgYL3WELTAaqH/H0NS
 Oq2tuxv192OC2rOPHfNYg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sdrTkwtKAzY=:tKINHUTVVsm0WFaUykQcBK
 HbVbbTJV9JyhmvHLuvH5TKLvcksbehb++5bGJvD0tKDjohphSiDS9t2b3UrnMQ2bU38Neht6H
 UVyVFd71pOvsqvFrE4u70KTeBSQi2BTbg3FvJHmUXBEjHXLP1KKtQhymJlUS3ic+zsKA3g77x
 ivFs5d5CLCVvRseIkkNk9BhEXEdSLjaCb6fsEPC98b2PHWH7IDT9iqqy8qLv4qmDmM+Co/2d4
 vlcuuFzrPArKd+iEMlhZHo/lOlKv3YZrN7ysjDFqA4v/SUa5bi9+kE4DmKZPhZAgEiAr7DIsZ
 ayln/I4my15yQzLWN/MJg5FDNSgBsGkIXymUcIIJWp8qDszDt08a00tlzXuUOOmHRUoXdlbs3
 YeWMBCBapIc+d54jfWFPDhl2Te4KFbJCgauj2qJ1VSBr1Xc9G1E1hP8rFE4jakpD/pmDKXTW7
 tppn2rfg7WtJYLSCZ6KfTC5MnSmSdra+UkZLKd0vADBBNZy/QVZL9xlqF+ReSEqGErhkddYhd
 JMXsSbdjVTq+8tMgK3kc80wMYSbtdoFelHBulx9BcUmeEuYUID6gO25VXav7RMx/zNKgFCqvo
 K+iJOFH9Z4TBHAyo2wk+i8Qre9CTA385XnPXM3h7oZb8X4Sa5R4sMxHE++INpnzf0ePtSBy8T
 q4WRe7azIGmfNRYSwQ7ac1pOa9+/GEGddgoxYQ6UC73nmp72q/ZbskkXPoyJGBKqQLjMD8Fcs
 Nzs5zYGVovwtpGu4gHoPc7WvXH+HngFLqDP3eQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The get_mac_address() function is normally inline, but when it is
not, we get a warning that this configuration is broken:

WARNING: vmlinux.o(.text+0x4aff00): Section mismatch in reference from the function w90p910_ether_setup() to the function .init.text:get_mac_address()
The function w90p910_ether_setup() references
the function __init get_mac_address().
This is often because w90p910_ether_setup lacks a __init

Remove the __init to make it always do the right thing.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
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
2.20.0

