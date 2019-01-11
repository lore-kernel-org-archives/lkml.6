Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D368BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32352133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217428;
	bh=nzi/7HJghO4Zo1n7urxSs+0LR2Sm8s61a8oLmS7AlJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZAhJjOwY1j/YSRudIJd32q8Z/4cydqjd7Lvub41xcWdWHSyHNp6iu8Ek2rvTst6NH
	 sk+Jc16p8M1VHYtSOoe4eHFyIq95SHop3IpfoLgB0m6bn1MNhCaqEYDJJCB9X+pFsK
	 V3OeM+X5NcftsuK7qBRXo56tEi0l9ht/7M8DA7vs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390557AbfAKOhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:37:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:57464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390541AbfAKOhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:37:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3E422063F;
        Fri, 11 Jan 2019 14:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217422;
        bh=nzi/7HJghO4Zo1n7urxSs+0LR2Sm8s61a8oLmS7AlJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nDm2JX1Ce4V/rtbd/6qf0wQDpqGji2yUDWoh2MYEsJ5AES7KrdLWNhbzJyuNWq8bS
         GlyECSHtf4Rh0DY40UkScCxiczPnDxOLPK2x6tqUh+c8TVaLZMClWcN024jS89JMje
         WRVPIUWgvD0XKwKoeQSU0yjZZXSTyrs48xrykJ80=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 053/148] net: hns: Fix ntuple-filters status error.
Date:   Fri, 11 Jan 2019 15:13:51 +0100
Message-Id: <20190111131116.392678786@linuxfoundation.org>
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

[ Upstream commit 7e74a19ca522aec7c2be201a7ae1d1d57ded409b ]

The ntuple-filters features is forced on by chip.
But it shows "ntuple-filters: off [fixed]" when use ethtool.
This patch make it correct with "ntuple-filters: on [fixed]".

Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns/hns_enet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index 8a53c82c72b4..6242249c9f4c 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -2374,7 +2374,7 @@ static int hns_nic_dev_probe(struct platform_device *pdev)
 	ndev->min_mtu = MAC_MIN_MTU;
 	switch (priv->enet_ver) {
 	case AE_VERSION_2:
-		ndev->features |= NETIF_F_TSO | NETIF_F_TSO6;
+		ndev->features |= NETIF_F_TSO | NETIF_F_TSO6 | NETIF_F_NTUPLE;
 		ndev->hw_features |= NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
 			NETIF_F_RXCSUM | NETIF_F_SG | NETIF_F_GSO |
 			NETIF_F_GRO | NETIF_F_TSO | NETIF_F_TSO6;
-- 
2.19.1



