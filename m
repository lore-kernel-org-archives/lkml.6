Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EFEC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C049217D4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866545;
	bh=KHkNQR7JfX4o9VhPkM4yFPyzG8zF5ud6rW5wgNQLmP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UU+OWgCecDqS7k7E24ASI2cmHWu+Mk46yiS5d2KWRlAZbL1GymG9J/QbU1aVPwIt+
	 ksRx7Lpy6Og8VqYCsC9NjDSiBzUV25cbsIML+rYpwdBU3YZZmJVM3XzXm/hD9u0Pxf
	 dW3ACCGy14kEU4+32MsONjOnRxxbrztAh/Usrf6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731766AbfAGNJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:09:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:56062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731146AbfAGNJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:09:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DC6A217D4;
        Mon,  7 Jan 2019 13:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866541;
        bh=KHkNQR7JfX4o9VhPkM4yFPyzG8zF5ud6rW5wgNQLmP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FdDtHQaIZ+w1cMwedh48q3mkqmCdyh542PxAFLs0A3AFYO1W9PNgJOv9Rcq8yw72r
         eRqMME36FRNHy0IGEn2C2a9/GB9acl5BM2NMiRsZwJ1QVRkHZwUlDTISkusWo6BoiI
         CgYgR8Ywq7E67Hua4Reygpd4vqzl0y3Njm7qvUh0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yuval Avnery <yuvalav@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.9 27/71] net/mlx5: Typo fix in del_sw_hw_rule
Date:   Mon,  7 Jan 2019 13:32:56 +0100
Message-Id: <20190107105334.325206885@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.280153213@linuxfoundation.org>
References: <20190107105330.280153213@linuxfoundation.org>
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

From: Yuval Avnery <yuvalav@mellanox.com>

[ Upstream commit f0337889147c956721696553ffcc97212b0948fe ]

Expression terminated with "," instead of ";", resulted in
set_fte getting bad value for modify_enable_mask field.

Fixes: bd5251dbf156 ("net/mlx5_core: Introduce flow steering destination of type counter")
Signed-off-by: Yuval Avnery <yuvalav@mellanox.com>
Reviewed-by: Daniel Jurgens <danielj@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -390,7 +390,7 @@ static void del_rule(struct fs_node *nod
 	}
 	if ((fte->action & MLX5_FLOW_CONTEXT_ACTION_FWD_DEST) &&
 	    --fte->dests_size) {
-		modify_mask = BIT(MLX5_SET_FTE_MODIFY_ENABLE_MASK_DESTINATION_LIST),
+		modify_mask = BIT(MLX5_SET_FTE_MODIFY_ENABLE_MASK_DESTINATION_LIST);
 		err = mlx5_cmd_update_fte(dev, ft,
 					  fg->id,
 					  modify_mask,


