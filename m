Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5397C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B66920651
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545863912;
	bh=ChbwwDdG8Lx4zreboeDn83DxBhoezsdsMxBqvHn9xsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vj+L9YGe6YqOGzFY4hAb5tlAKOsEqPLx1/eJH+mChjLhjgEGsSSBQm263wSoqa0dN
	 kI7AiEzRxll5wBzyGRbtABhynKsmz9rR3PWN3EIOC2t9RxHhvXIWwchgGZgwNEKXvq
	 2kEAGiOkS5pTE/YsH0GZOr5siHJxDfTIYcJ4m85c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbeLZWib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:38:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:38616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728627AbeLZWiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:38:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F50C218E2;
        Wed, 26 Dec 2018 22:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863900;
        bh=ChbwwDdG8Lx4zreboeDn83DxBhoezsdsMxBqvHn9xsA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WkCAx4GBFnloX0LWvhVdyuOaQpYBwyCrm5Uf6T0RCZ7naaO9qiXCaoHKGuMGRTgyY
         SvIKRv51MnvAOj2gJAiyeiq+eWcvA4/4J9TwH53JXtsUgnn7l1DpmrH2IRbUPFhdJC
         OigNJy5zPchwrfhZkuXczG4oXz1Cr4FnmfSlKTvU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yuval Avnery <yuvalav@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 85/97] net/mlx5: Typo fix in del_sw_hw_rule
Date:   Wed, 26 Dec 2018 17:35:45 -0500
Message-Id: <20181226223557.149329-85-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuval Avnery <yuvalav@mellanox.com>

[ Upstream commit f0337889147c956721696553ffcc97212b0948fe ]

Expression terminated with "," instead of ";", resulted in
set_fte getting bad value for modify_enable_mask field.

Fixes: bd5251dbf156 ("net/mlx5_core: Introduce flow steering destination of type counter")
Signed-off-by: Yuval Avnery <yuvalav@mellanox.com>
Reviewed-by: Daniel Jurgens <danielj@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 37d114c668b7..d181645fd968 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -432,7 +432,7 @@ static void del_sw_hw_rule(struct fs_node *node)
 
 	if ((fte->action.action & MLX5_FLOW_CONTEXT_ACTION_FWD_DEST) &&
 	    --fte->dests_size) {
-		modify_mask = BIT(MLX5_SET_FTE_MODIFY_ENABLE_MASK_DESTINATION_LIST),
+		modify_mask = BIT(MLX5_SET_FTE_MODIFY_ENABLE_MASK_DESTINATION_LIST);
 		update_fte = true;
 	}
 out:
-- 
2.19.1

