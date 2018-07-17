Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4437ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B65E2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B65E2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731745AbeGQOX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:23:29 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:37001 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731589AbeGQOX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:23:28 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue102 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MeSdD-1fP7dL3nRf-00QBDs; Tue, 17 Jul 2018 15:50:13 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        Boris Pismenny <borisp@mellanox.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net/mlx5: fix an unused-function warning
Date:   Tue, 17 Jul 2018 15:49:48 +0200
Message-Id: <20180717135009.3584984-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:W0d303wHWGbg6M0LxWuFWd1c5CVmE2s3K55qR8byY4s72AhOmKS
 f3Q4VXWfXU3++6EvKlb4C8MPqqwl90lvjZW7+J8B1GXFzK5rBInwiuefx044MnMU6RfbXdZ
 e/oesSA/t4szNmf3noGUz6w6EdFmzRaZzvWNEcx2dTycR4t+y+K9FHVbAPZx0K5uBevR1EE
 xnJWIK8SQ6plFuP5IPn8w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zERpCpoHdPM=:iOUkUFc701e7EAUn1zVa6a
 j9A3Dt1m5PMQuXWXob7xoTDKtKlzJzL7ogufIRPKdk62btnCbUQ710qELw8ZiKobv2T4qIMQ3
 Ja5qkq2icBIfFwO895jMosXjK9uoXYQbPWu1MFUbGJ2XFhlXrUiaDhR2Rd7m+LaTDaYUS1hQZ
 a258PTiOBLvmGEa8dVcQ34B6swPEiUTJRa3Up4nMoL/3JU0scyQIyHTmqnn/tWEwKjxXczgSr
 MUH2fftkDNdjr8oUn2V5fyiAedrYpH493TUdQQ6gWdh2may82dUq7VnoZs3holucDRHclh/yX
 FZPD1M5zhLW9qIraDBKVqSKcaNyo3kbG4WgynM3QPtOwarjA8hWoyY4CKyPoz5NnxE11/1Ra1
 pkuE+ifsJdyL29mboOScn7brFHtdNzWwwgI5/0KpMW/ZMVBMMpXUyOhjKjXF5hK/7jWjqJF8x
 OjiSJApLjw++OeHshZt053Ljt3FQI4uEtc2jKcNV0N+oyd0asDTkWaNMQcIEx/u6hvTvBlWiN
 7drPzxL2+k3LG5SH16cXfAv/Uqnts2KK9euHwoCAaMSOQdCV+lniEH7sfiCwafsTUij9PrQoI
 SR1M7q6b8m4AJNQKH6OEenWHxZKfT0+ycC7+oWZbrRzBbJMxxEBs3Th5aq7PSnVL/1SJ2UxDu
 ipqrRFw2tJwlWwysilr3xXFFOaCePSrtXTcDp/tRQhNoGkuzEE1IlZkYv5M3FYfZX7LQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These dummy helpers are all intended to be inline functions,
but one of them by accident came without the 'inline' keyword,
causing a harmless warning:

In file included from drivers/net/ethernet/mellanox/mlx5/core/main.c:63:
drivers/net/ethernet/mellanox/mlx5/core/accel/tls.h:79:1: error: 'mlx5_accel_tls_add_flow' defined but not used [-Werror=unused-function]
 mlx5_accel_tls_add_flow(struct mlx5_core_dev *mdev, void *flow,

Fixes: ab412e1dd7db ("net/mlx5: Accel, add TLS rx offload routines")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/mellanox/mlx5/core/accel/tls.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/accel/tls.h b/drivers/net/ethernet/mellanox/mlx5/core/accel/tls.h
index 2228c1083528..def4093ebfae 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/accel/tls.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/accel/tls.h
@@ -75,7 +75,7 @@ void mlx5_accel_tls_cleanup(struct mlx5_core_dev *mdev);
 
 #else
 
-static int
+static inline int
 mlx5_accel_tls_add_flow(struct mlx5_core_dev *mdev, void *flow,
 			struct tls_crypto_info *crypto_info,
 			u32 start_offload_tcp_sn, u32 *p_swid,
-- 
2.9.0

