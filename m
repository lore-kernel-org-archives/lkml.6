Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751654AbeELRJT (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 13:09:19 -0400
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:53654 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeELRJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 13:09:18 -0400
X-ME-Helo: ubuntu-CJ.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 12 May 2018 19:09:16 +0200
X-ME-IP: 86.244.116.1
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: saeedm@mellanox.com, matanb@mellanox.com, leon@kernel.org,
        davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] net/mlx5: Use 'kvfree()' for memory allocated by 'kvzalloc()'
Date: Sat, 12 May 2018 19:09:25 +0200
Message-Id: <20180512170925.23690-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'out' is allocated with 'kvzalloc()'. 'kvfree()' must be used to free it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/mellanox/mlx5/core/vport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/vport.c b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
index 177e076b8d17..49968a4db758 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
@@ -511,7 +511,7 @@ int mlx5_query_nic_vport_system_image_guid(struct mlx5_core_dev *mdev,
 	*system_image_guid = MLX5_GET64(query_nic_vport_context_out, out,
 					nic_vport_context.system_image_guid);
 
-	kfree(out);
+	kvfree(out);
 
 	return 0;
 }
-- 
2.17.0
