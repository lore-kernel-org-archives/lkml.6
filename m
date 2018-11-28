Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02708C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B282081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:31:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5B282081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbeK1Xd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 18:33:26 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15170 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727673AbeK1Xd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 18:33:26 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C834A9A118B70;
        Wed, 28 Nov 2018 20:31:51 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Wed, 28 Nov 2018
 20:31:46 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <subashab@codeaurora.org>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: qualcomm: rmnet: remove set but not used variables 'ip_family, fc_seq, qos_id'
Date:   Wed, 28 Nov 2018 20:31:42 +0800
Message-ID: <20181128123142.25348-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c:26:6:
 warning: variable 'ip_family' set but not used [-Wunused-but-set-variable]
drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c:27:6:
 warning: variable 'fc_seq' set but not used [-Wunused-but-set-variable]
drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c:28:6:
 warning: variable 'qos_id' set but not used [-Wunused-but-set-variable]

It never used since introduction in commit
ceed73a2cf4a ("drivers: net: ethernet: qualcomm: rmnet: Initial implementation")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c
index 3ee8ae9..8990307 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c
@@ -23,9 +23,6 @@ static u8 rmnet_map_do_flow_control(struct sk_buff *skb,
 	struct rmnet_map_control_command *cmd;
 	struct rmnet_endpoint *ep;
 	struct net_device *vnd;
-	u16 ip_family;
-	u16 fc_seq;
-	u32 qos_id;
 	u8 mux_id;
 	int r;
 
@@ -45,10 +42,6 @@ static u8 rmnet_map_do_flow_control(struct sk_buff *skb,
 
 	vnd = ep->egress_dev;
 
-	ip_family = cmd->flow_control.ip_family;
-	fc_seq = ntohs(cmd->flow_control.flow_control_seq_num);
-	qos_id = ntohl(cmd->flow_control.qos_id);
-
 	/* Ignore the ip family and pass the sequence number for both v4 and v6
 	 * sequence. User space does not support creating dedicated flows for
 	 * the 2 protocols
-- 
2.7.0


