Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FD6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D0F21841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217399;
	bh=i4Res1OO8pE4i6ysdh/PonuALFU/BSgfj+mNi+2qTRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u+MSrFvhoRGNTSj2IEfbdrfrAwDoyaAYgyA9a5lHrMb9uElubTb0MgTeeP63uMWzR
	 T1n5qy6oZvVYcKPl3IKDICb4Kadjubqtg2y9zmNKm6Nrb56Hg7GsqeCt+0Nd+aANwu
	 OZm8isbyxiQyWILS4NLfn6o1ENjMf1PJPiyDY92c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390445AbfAKOgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:36:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:56954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390425AbfAKOgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:36:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1F5B204EC;
        Fri, 11 Jan 2019 14:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217395;
        bh=i4Res1OO8pE4i6ysdh/PonuALFU/BSgfj+mNi+2qTRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gL5Xsn21Y5hydpjBDlMyQh4M2lZWbRW/gsoqzgBeEr3zFuifaWs/Atibgq3pzZDto
         xvI/6oyClkuv/zON0JYhkS5xgKSTyZnF9dgNt9RjMytZLgQqWoz09vk7XYRKBGAQj4
         bw0PsT1Qb59uLviZmaKLUqHBYBovSD3prxkA31kY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 045/148] w90p910_ether: remove incorrect __init annotation
Date:   Fri, 11 Jan 2019 15:13:43 +0100
Message-Id: <20190111131116.082394007@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



