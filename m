Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD526C00319
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 01:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B05C2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 01:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbfBYBuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 20:50:16 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4723 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726511AbfBYBuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 20:50:15 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 33468D51ED11DF8778F2;
        Mon, 25 Feb 2019 09:50:13 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.408.0; Mon, 25 Feb 2019 09:50:03 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Jiri Pirko <jiri@mellanox.com>, Ido Schimmel <idosch@mellanox.com>,
        <davem@davemloft.net>
CC:     YueHaibing <yuehaibing@huawei.com>, <netdev@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] mlxsw: spectrum: remove set but not used variable 'autoneg_status'
Date:   Mon, 25 Feb 2019 02:03:28 +0000
Message-ID: <20190225020328.42510-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/net/ethernet/mellanox/mlxsw/spectrum.c: In function 'mlxsw_sp_port_get_link_ksettings':
drivers/net/ethernet/mellanox/mlxsw/spectrum.c:3062:5: warning:
 variable 'autoneg_status' set but not used [-Wunused-but-set-variable]

It's not used since commit 475b33cb66c9 ("mlxsw: spectrum: Remove unsupported
eth_proto_lp_advertise field in PTYS")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 40177b9834c4..b00f6f74f91a 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -3059,7 +3059,6 @@ static int mlxsw_sp_port_get_link_ksettings(struct net_device *dev,
 	const struct mlxsw_sp_port_type_speed_ops *ops;
 	char ptys_pl[MLXSW_REG_PTYS_LEN];
 	u8 connector_type;
-	u8 autoneg_status;
 	bool autoneg;
 	int err;
 
@@ -3079,8 +3078,6 @@ static int mlxsw_sp_port_get_link_ksettings(struct net_device *dev,
 	mlxsw_sp_port_get_link_advertise(mlxsw_sp, eth_proto_admin, autoneg,
 					 cmd);
 
-	autoneg_status = mlxsw_reg_ptys_an_status_get(ptys_pl);
-
 	cmd->base.autoneg = autoneg ? AUTONEG_ENABLE : AUTONEG_DISABLE;
 	connector_type = mlxsw_reg_ptys_connector_type_get(ptys_pl);
 	cmd->base.port = mlxsw_sp_port_connector_port(connector_type);



