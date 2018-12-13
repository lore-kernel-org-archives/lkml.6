Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D9BC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81FA020849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544676073;
	bh=GOlZfrGOXJvQfR+Uh9Tr0ORZk0bNMmNmIWOjF1SBbxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bTVQnhp/8rr+eixIkNgp/hNsy1Kc+HVcwwfpg7xDDgHJYiiJWvbMtAwldSjTfZgbU
	 tH5ANKj7/RAl0QBaxda4isyC86fafZZVhcSCGgSQFeO6Lt4fwBQpOKFhMXz0Eq3H22
	 KmivErCvJTUrqzLD7cyTMeLis7UvAIkU3QSKH6ic=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81FA020849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbeLMEcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:32:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:44920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728940AbeLMEcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:32:00 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E33F20873;
        Thu, 13 Dec 2018 04:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675519;
        bh=GOlZfrGOXJvQfR+Uh9Tr0ORZk0bNMmNmIWOjF1SBbxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y9YlahKqFcdHD0Ex2pbAMNojfLG+xBtG1Xihk15h/IeasmbR/OjHvfH4wUEwHl2g0
         NZkjt2e3aoZcYSGVLFJP78yleDbENlvH0CAOOqTShO+01n/Ifu7TjWkXTogM+jPYiQ
         el/585meEIye6fCBnm/SxqPIAJrl2idnNtlyitXg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tarick Bedeir <tarick@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 41/41] net/mlx4_core: Correctly set PFC param if global pause is turned off.
Date:   Wed, 12 Dec 2018 23:30:54 -0500
Message-Id: <20181213043054.75891-41-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043054.75891-1-sashal@kernel.org>
References: <20181213043054.75891-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tarick Bedeir <tarick@google.com>

[ Upstream commit bd5122cd1e0644d8bd8dd84517c932773e999766 ]

rx_ppp and tx_ppp can be set between 0 and 255, so don't clamp to 1.

Fixes: 6e8814ceb7e8 ("net/mlx4_en: Fix mixed PFC and Global pause user control requests")
Signed-off-by: Tarick Bedeir <tarick@google.com>
Reviewed-by: Eran Ben Elisha <eranbe@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
index 5fe56dc4cfae..5363cee88a0a 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -1070,8 +1070,8 @@ static int mlx4_en_set_pauseparam(struct net_device *dev,
 
 	tx_pause = !!(pause->tx_pause);
 	rx_pause = !!(pause->rx_pause);
-	rx_ppp = priv->prof->rx_ppp && !(tx_pause || rx_pause);
-	tx_ppp = priv->prof->tx_ppp && !(tx_pause || rx_pause);
+	rx_ppp = (tx_pause || rx_pause) ? 0 : priv->prof->rx_ppp;
+	tx_ppp = (tx_pause || rx_pause) ? 0 : priv->prof->tx_ppp;
 
 	err = mlx4_SET_PORT_general(mdev->dev, priv->port,
 				    priv->rx_skb_size + ETH_FCS_LEN,
-- 
2.19.1

