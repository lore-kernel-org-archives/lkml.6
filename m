Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051D5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF1892177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216994;
	bh=KmpPXNnlpaqreyCfJoQJ/BXN6/yMSEELXrnGRXtYHmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WJ6dZK8DUu9IWC0JChrG6BHly0pEsHNE8TwvUBt4E78/z9/COgp0lEjNUjttvqzTK
	 7+NU8gswcvfnoa86LMAMlR5aNtiAxnPnDV4r4gy+/w15on1AYA/92yLkC3F0K+Xz0I
	 KWh1X63ePsJgjzRz6k54yB+HIIxptMI2ip3qWeEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388828AbfAKO3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:29:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:49006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388800AbfAKO3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:29:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE8A42063F;
        Fri, 11 Jan 2019 14:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216990;
        bh=KmpPXNnlpaqreyCfJoQJ/BXN6/yMSEELXrnGRXtYHmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cfNsQR/En6PSgklZYtXL3PrVrnFF2JxlhUmgKM/sCYTtyPEdJY+0SBfzLi/M/wiTv
         YvX/zJzqmJqzKmbNPl1s0XVwJNWaFyw5BeOhRObcI4O+0DLl+1c7bcen61ZNSEo9so
         52NDKVW/KpX6Gd1qGlGzMwY+IZzgOaxhI3tI2o/E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 26/63] net: hns: Fix ntuple-filters status error.
Date:   Fri, 11 Jan 2019 15:14:29 +0100
Message-Id: <20190111131049.851346606@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131046.387528003@linuxfoundation.org>
References: <20190111131046.387528003@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
index 7ffbd70824d9..a2f7d0834071 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -2036,7 +2036,7 @@ static int hns_nic_dev_probe(struct platform_device *pdev)
 
 	switch (priv->enet_ver) {
 	case AE_VERSION_2:
-		ndev->features |= NETIF_F_TSO | NETIF_F_TSO6;
+		ndev->features |= NETIF_F_TSO | NETIF_F_TSO6 | NETIF_F_NTUPLE;
 		ndev->hw_features |= NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
 			NETIF_F_RXCSUM | NETIF_F_SG | NETIF_F_GSO |
 			NETIF_F_GRO | NETIF_F_TSO | NETIF_F_TSO6;
-- 
2.19.1



