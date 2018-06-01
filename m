Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbeFACBR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 22:01:17 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42052 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbeFACBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 22:01:14 -0400
X-Google-Smtp-Source: ADUXVKIXAb4sig9UxzaKySQkjHw4VWgqUEwH2P2qgpDONRaFdLPPRi+lHNRIaxuu8RE0gQD0RM4OUg==
From: Varsha Rao <rvarsha016@gmail.com>
To: Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Nicholas Mc Guire <der.herr@hofr.at>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Varsha Rao <rvarsha016@gmail.com>
Subject: [PATCH] net: ethernet: mlx4: Remove unnecessary parentheses
Date: Fri,  1 Jun 2018 07:30:49 +0530
Message-Id: <20180601020049.3704-1-rvarsha016@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the clang warning of extraneous parentheses, with the
following coccinelle script.

@@
identifier i;
expression e;
statement s;
@@
if (
-(i == e)
+i == e
 )
s

Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Varsha Rao <rvarsha016@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx4/port.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/port.c b/drivers/net/ethernet/mellanox/mlx4/port.c
index 3ef3406ff4cb..10fcc22f4590 100644
--- a/drivers/net/ethernet/mellanox/mlx4/port.c
+++ b/drivers/net/ethernet/mellanox/mlx4/port.c
@@ -614,9 +614,9 @@ int __mlx4_register_vlan(struct mlx4_dev *dev, u8 port, u16 vlan,
 		int index_at_dup_port = -1;
 
 		for (i = MLX4_VLAN_REGULAR; i < MLX4_MAX_VLAN_NUM; i++) {
-			if ((vlan == (MLX4_VLAN_MASK & be32_to_cpu(table->entries[i]))))
+			if (vlan == (MLX4_VLAN_MASK & be32_to_cpu(table->entries[i])))
 				index_at_port = i;
-			if ((vlan == (MLX4_VLAN_MASK & be32_to_cpu(dup_table->entries[i]))))
+			if (vlan == (MLX4_VLAN_MASK & be32_to_cpu(dup_table->entries[i])))
 				index_at_dup_port = i;
 		}
 		/* check that same vlan is not in the tables at different indices */
-- 
2.17.0
