Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7BFC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D1C5214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548696160;
	bh=JYZ9wKN3GG7XpQUG9Se5rWp0h1ZFhe21NVzsX2cQnbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ReLZ6S2pp74cVRYMgTX/MnRWi6AHi7Vb8t4bRsRWqWvaLXxmOwLvD1XBKYyYYmv8O
	 CQbK5eMy92I7pfMQM0vdh+gLuyDgpRLJ4oWY2dsLpKunlJnmAbx/JKrkYGnaMPTP0N
	 LTeMeOqGNkX9DEsDvtmKHKKs2VIfLu6ZBQMcnUEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731355AbfA1QDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:03:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:48536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727969AbfA1QDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:03:13 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0411021852;
        Mon, 28 Jan 2019 16:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691393;
        bh=JYZ9wKN3GG7XpQUG9Se5rWp0h1ZFhe21NVzsX2cQnbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jXm24CgvQP9wwU/8xDd+RrPFGd/qCW8bZDmgpJxL1zvyMiAltm8JmAmIKQkJ3K8s6
         trFTZZeWeL8nZ5jo4tZkNm8prDtNLymytZTDWqfbjnF2ag3/l2BBpWltdVJhtYM6cR
         Ty/wHrDXPzpfqjocj59MzLfS+U97ciuDLz4jvl4c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 078/258] net: aquantia: return 'err' if set MPI_DEINIT state fails
Date:   Mon, 28 Jan 2019 10:56:24 -0500
Message-Id: <20190128155924.51521-78-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
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
index c965e65d07db..9939ccaeb125 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c
@@ -262,6 +262,8 @@ int hw_atl_utils_soft_reset(struct aq_hw_s *self)
 		AQ_HW_WAIT_FOR((aq_hw_read_reg(self, HW_ATL_MPI_STATE_ADR) &
 			       HW_ATL_MPI_STATE_MSK) == MPI_DEINIT,
 			       10, 1000U);
+		if (err)
+			return err;
 	}
 
 	if (self->rbl_enabled)
-- 
2.19.1

