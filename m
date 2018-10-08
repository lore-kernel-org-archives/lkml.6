Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB21FC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751BC214FA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaqWR4lm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 751BC214FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbeJHWh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:37:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbeJHWh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:37:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6B5E2089D;
        Mon,  8 Oct 2018 15:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012342;
        bh=SzNmvlm1uxVggVxNYxMvBY1CZ3MPDkNR2WJhVKOaS7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UaqWR4lmsbkUmT6ZP7eQ2f2Ojffc4PWRfA9Dd5NIHuIk7S3H7lpBr5/G0m0KRveYX
         C4x8oKFHR4/YVB0f0s6xgHthMeBFtmEpjy83iaO/QbcauhcoSaP1i4ECG5LwZRRhzJ
         rzgFzyY6ZEivrt6CvDm2CwU96O8yoTJPoWMMciQ8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Steve Wise <swise@opengridcomputing.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 16/58] cxgb4: fix abort_req_rss6 struct
Date:   Mon,  8 Oct 2018 11:24:41 -0400
Message-Id: <20181008152523.70705-16-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152523.70705-1-sashal@kernel.org>
References: <20181008152523.70705-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve Wise <swise@opengridcomputing.com>

[ Upstream commit 9f34519a82356f6cf0ccb8480ee0ed99b3d0af75 ]

Remove the incorrect WR_HDR field which can cause a misinterpretation
of ABORT CPL by ULDs, such as iw_cxgb4.

Fixes: a3cdaa69e4ae ("cxgb4: Adds CPL support for Shared Receive Queues")
Signed-off-by: Steve Wise <swise@opengridcomputing.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/chelsio/cxgb4/t4_msg.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_msg.h b/drivers/net/ethernet/chelsio/cxgb4/t4_msg.h
index 09e38f0733bd..10b9cb2185b1 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_msg.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_msg.h
@@ -753,7 +753,6 @@ struct cpl_abort_req_rss {
 };
 
 struct cpl_abort_req_rss6 {
-	WR_HDR;
 	union opcode_tid ot;
 	__u32 srqidx_status;
 };
-- 
2.17.1

