Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245BFECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA5720854
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAA5720854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388139AbeGTNRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:17:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37148 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbeGTNRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:17:10 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 68B60BD1;
        Fri, 20 Jul 2018 12:28:56 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shay Agroskin <shayag@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.9 22/66] net/mlx5: Fix wrong size allocation for QoS ETC TC regitster
Date:   Fri, 20 Jul 2018 14:13:39 +0200
Message-Id: <20180720121408.545904237@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121407.228772286@linuxfoundation.org>
References: <20180720121407.228772286@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shay Agroskin <shayag@mellanox.com>

[ Upstream commit d14fcb8d877caf1b8d6bd65d444bf62b21f2070c ]

The driver allocates wrong size (due to wrong struct name) when issuing
a query/set request to NIC's register.

Fixes: d8880795dabf ("net/mlx5e: Implement DCBNL IEEE max rate")
Signed-off-by: Shay Agroskin <shayag@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/port.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/port.c
@@ -575,7 +575,7 @@ EXPORT_SYMBOL_GPL(mlx5_set_port_prio_tc)
 static int mlx5_set_port_qetcr_reg(struct mlx5_core_dev *mdev, u32 *in,
 				   int inlen)
 {
-	u32 out[MLX5_ST_SZ_DW(qtct_reg)];
+	u32 out[MLX5_ST_SZ_DW(qetc_reg)];
 
 	if (!MLX5_CAP_GEN(mdev, ets))
 		return -ENOTSUPP;
@@ -587,7 +587,7 @@ static int mlx5_set_port_qetcr_reg(struc
 static int mlx5_query_port_qetcr_reg(struct mlx5_core_dev *mdev, u32 *out,
 				     int outlen)
 {
-	u32 in[MLX5_ST_SZ_DW(qtct_reg)];
+	u32 in[MLX5_ST_SZ_DW(qetc_reg)];
 
 	if (!MLX5_CAP_GEN(mdev, ets))
 		return -ENOTSUPP;


