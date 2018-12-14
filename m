Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2FAC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134CB20892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544790870;
	bh=PKXt4YZ3RVQ6krAXwrmN3WK1ps/Fk9PxaXRWG/UTtn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GIh8InbxtpkJHLIr4hTyCD1MuOUy8kk4EV/727k2U1VBX5x/5hHVUFtA8SGvM1Ehw
	 xld9pb519ZhFvrWQAOsiDm+kVfGEcz76uZey+IHMECf/yyAkkKcF/nxa8Lq4oT/2wX
	 GfN0QCwcUiGLzzq0+asBFK57JlaJIXibvms/Z01I=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 134CB20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbeLNMe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:34:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:53320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730637AbeLNMH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:07:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80E02214C4;
        Fri, 14 Dec 2018 12:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789276;
        bh=PKXt4YZ3RVQ6krAXwrmN3WK1ps/Fk9PxaXRWG/UTtn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H/08UGXKzxI/HPzwe7WxJd6xsHrEGsKFk5AYH+MaasaxAPZrhkaO7oK7scfsy8SML
         zSaz2al0DOiLgO1jsxvauvSGlh0LvvnK/8r2EHwvuCPhU53ubGcv8P1WjHyZvF/mQ5
         too1vIgvXecslW2ZPuNYbeHWEiISkc0wfqNMgFcc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eran Ben Elisha <eranbe@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 07/89] net/mlx4_en: Change min MTU size to ETH_MIN_MTU
Date:   Fri, 14 Dec 2018 12:59:20 +0100
Message-Id: <20181214115730.027966839@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eran Ben Elisha <eranbe@mellanox.com>

[ Upstream commit 24be19e47779d604d1492c114459dca9a92acf78 ]

NIC driver minimal MTU size shall be set to ETH_MIN_MTU, as defined in
the RFC791 and in the network stack. Remove old mlx4_en only define for
it, which was set to wrong value.

Fixes: b80f71f5816f ("ethernet/mellanox: use core min/max MTU checking")
Signed-off-by: Eran Ben Elisha <eranbe@mellanox.com>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c |    4 ++--
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h   |    1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -3505,8 +3505,8 @@ int mlx4_en_init_netdev(struct mlx4_en_d
 		dev->gso_partial_features = NETIF_F_GSO_UDP_TUNNEL_CSUM;
 	}
 
-	/* MTU range: 46 - hw-specific max */
-	dev->min_mtu = MLX4_EN_MIN_MTU;
+	/* MTU range: 68 - hw-specific max */
+	dev->min_mtu = ETH_MIN_MTU;
 	dev->max_mtu = priv->max_mtu;
 
 	mdev->pndev[port] = dev;
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
@@ -157,7 +157,6 @@
 #define HEADER_COPY_SIZE       (128 - NET_IP_ALIGN)
 #define MLX4_LOOPBACK_TEST_PAYLOAD (HEADER_COPY_SIZE - ETH_HLEN)
 
-#define MLX4_EN_MIN_MTU		46
 /* VLAN_HLEN is added twice,to support skb vlan tagged with multiple
  * headers. (For example: ETH_P_8021Q and ETH_P_8021AD).
  */


