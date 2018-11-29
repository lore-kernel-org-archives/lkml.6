Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A08DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C280721104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lov0+5bR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C280721104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbeK2RC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:02:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:36800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727758AbeK2RCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:02:55 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC495208E7;
        Thu, 29 Nov 2018 05:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471124;
        bh=+XO14ihzRVM/XboJX+OFIqFhXyUqziYTBPbMXH0OJfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lov0+5bRf8Y9pswkAgJbI61VGvqKPH82vP7LeLP1h271WjWhTuUO5U36ylO0DI50B
         wTJQemJtD4P4pSiT9ijFJsNeLga/TnYhXWhun8Dlm2kj4FcqeRGwL/EWo1Rs7JTj1a
         HI4VwoMzdM/FVM9vDOxc24yjP51U1od5Ew/8i0rE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Kalderon <michal.kalderon@cavium.com>,
        Denis Bolotin <denis.bolotin@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 32/68]  drivers/net/ethernet/qlogic/qed/qed_rdma.h: fix typo
Date:   Thu, 29 Nov 2018 00:55:23 -0500
Message-Id: <20181129055559.159228-32-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129055559.159228-1-sashal@kernel.org>
References: <20181129055559.159228-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@linux-foundation.org>

[ Upstream commit a97b9565338350d70d8d971c4ee6f0d4fa967418 ]

Add missing semicolon.

Fixes: 291d57f67d244973 ("qed: Fix rdma_info structure allocation")
Cc: Michal Kalderon <michal.kalderon@cavium.com>
Cc: Denis Bolotin <denis.bolotin@cavium.com>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_rdma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_rdma.h b/drivers/net/ethernet/qlogic/qed/qed_rdma.h
index 50d609c0e108..3689fe3e5935 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_rdma.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_rdma.h
@@ -183,7 +183,7 @@ void qed_rdma_info_free(struct qed_hwfn *p_hwfn);
 static inline void qed_rdma_dpm_conf(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt) {}
 static inline void qed_rdma_dpm_bar(struct qed_hwfn *p_hwfn,
 				    struct qed_ptt *p_ptt) {}
-static inline int qed_rdma_info_alloc(struct qed_hwfn *p_hwfn) {return -EINVAL}
+static inline int qed_rdma_info_alloc(struct qed_hwfn *p_hwfn) {return -EINVAL;}
 static inline void qed_rdma_info_free(struct qed_hwfn *p_hwfn) {}
 #endif
 
-- 
2.17.1

