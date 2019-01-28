Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F31C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A0220880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690456;
	bh=8hSr7uKIGw7BsUzmOtpeDeOWGfuUUBzgz9AkBBaa1GA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MQpuVmPpkRcWD2cKiClzsUTu1ydvWRn4g9w2z7LfJCv/OOULKoslZ754xJNPhplNf
	 gCDJiWWdOzVz7iRaH83VHiF+RbTn/DeZNje7YKHSCHfiBUv7SNwWcMUgTtlc96jHGE
	 7caBhpEkeev5tjD5ym8LO+t+pcqfcaxMDr+unh3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbfA1Prf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:47:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:32916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728334AbfA1Prd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:47:33 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3644E2177E;
        Mon, 28 Jan 2019 15:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690452;
        bh=8hSr7uKIGw7BsUzmOtpeDeOWGfuUUBzgz9AkBBaa1GA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k3lbKVgm6/3gzI0xf5Ckx8ohZ8f2NKbZn9xi9/CmeTJ8jzRZXl7duBZgsZC+IhEdt
         NyPDgjYoewdJLG8Ac36LpXQc4uCCiDvQmrq3iJqZuvV4d0NNVLVlsbR/yJYRIXeKk3
         +Yc++VKu3VwjlGaVdG3N/Ham78EnF8V6govHl0nY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 092/304] net: aquantia: return 'err' if set MPI_DEINIT state fails
Date:   Mon, 28 Jan 2019 10:40:09 -0500
Message-Id: <20190128154341.47195-92-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 4e3c7c00bba0636b97eb23d582c20b0f5d95ce20 ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c:260:7:
 warning: variable 'err' set but not used [-Wunused-but-set-variable]

'err' should be returned while set MPI_DEINIT state fails
in hw_atl_utils_soft_reset.

Fixes: cce96d1883da ("net: aquantia: Regression on reset with 1.x firmware")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c
index 7def1cb8ab9d..22cbf8dc6fa9 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c
@@ -263,6 +263,8 @@ int hw_atl_utils_soft_reset(struct aq_hw_s *self)
 		AQ_HW_WAIT_FOR((aq_hw_read_reg(self, HW_ATL_MPI_STATE_ADR) &
 				HW_ATL_MPI_STATE_MSK) == MPI_DEINIT,
 			       10, 1000U);
+		if (err)
+			return err;
 	}
 
 	if (self->rbl_enabled)
-- 
2.19.1

