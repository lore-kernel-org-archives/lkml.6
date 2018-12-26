Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393DBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F093D214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864685;
	bh=xDPbD/0Jy3U0Od03vJvtLKSv35WQitxtk5JxKZ78r4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WKnuS5zSH/lqp12Nmt6Mda6in7QpBD+zOgea+dWQgis1qGL5TM4hB6L1hZboJWWri
	 vqq+/NMg/TNlDIExKnmkreNttLK6U2GkurzyJEAHyD64tjyiVOfFxWn/FbLwtsWq1H
	 mOVsOM0nIQGDzTAkKh0vx9yn12rNIBue57zcdkIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbeLZWvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:51:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:37332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbeLZWhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:37:13 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B23C821901;
        Wed, 26 Dec 2018 22:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863832;
        bh=xDPbD/0Jy3U0Od03vJvtLKSv35WQitxtk5JxKZ78r4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jNhSE5y4jAFRMBHcwXtLlVlYUdEqgfS5n+0qMGnHf/nK6QrvBy2cwGnGfibxj2Sd8
         IfFFnJMSPQ9OE6g8o5OhqfweAC+Yht1aabpg37+whilMwUeIg4PwGesM949ox3Wc0D
         OcmEXY8yEDJwTmzEN7QGmOqCpmoALWTD8VSC/I7M=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>,
        Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 47/97] qed: Fix command number mismatch between driver and the mfw
Date:   Wed, 26 Dec 2018 17:35:07 -0500
Message-Id: <20181226223557.149329-47-sashal@kernel.org>
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

From: Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>

[ Upstream commit c3db8d531045774aeee6e0f731ab15b0c450de45 ]

The value for OEM_CFG_UPDATE command differs between driver and the
Management firmware (mfw). Fix this gap with adding a reserved field.

Fixes: cac6f691546b ("qed: Add support for Unified Fabric Port.")
Signed-off-by: Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>
Signed-off-by: Ariel Elior <ariel.elior@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_hsi.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_hsi.h b/drivers/net/ethernet/qlogic/qed/qed_hsi.h
index a71382687ef2..bed8f48e029a 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_hsi.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_hsi.h
@@ -12669,8 +12669,9 @@ enum MFW_DRV_MSG_TYPE {
 	MFW_DRV_MSG_BW_UPDATE10,
 	MFW_DRV_MSG_TRANSCEIVER_STATE_CHANGE,
 	MFW_DRV_MSG_BW_UPDATE11,
-	MFW_DRV_MSG_OEM_CFG_UPDATE,
+	MFW_DRV_MSG_RESERVED,
 	MFW_DRV_MSG_GET_TLV_REQ,
+	MFW_DRV_MSG_OEM_CFG_UPDATE,
 	MFW_DRV_MSG_MAX
 };
 
-- 
2.19.1

