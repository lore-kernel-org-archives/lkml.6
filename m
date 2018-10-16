Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A94C070C3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4967F20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjHT3xXS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4967F20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbeJPMXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:23:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727813AbeJPMBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:01:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D96021477;
        Tue, 16 Oct 2018 04:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663165;
        bh=DIcvI1x1xhB226EQNNh5mu3KeEqb8PA2L/sKHvtQpzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tjHT3xXSOUjJWn2uR8b2ZhutLRyxSzPHpHjfqYS7Wh3xVUGRk22hpjVy4vF8hG3Dt
         Gxo+b4+EKItDypL8s0+L8ElYgyKI1ExD54Qajk7RTLSno1GYFSM/FItFn71kWoK9Sw
         9VwIhUBZcFu6rRyxI78RDhVA8qmGqGDeQCnPz1AM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zhao Qiang <qiang.zhao@nxp.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Li Yang <leoyang.li@nxp.com>, Olof Johansson <olof@lixom.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 023/100] soc: fsl: qe: Fix copy/paste bug in ucc_get_tdm_sync_shift()
Date:   Tue, 16 Oct 2018 00:11:04 -0400
Message-Id: <20181016041221.135528-23-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhao Qiang <qiang.zhao@nxp.com>

[ Upstream commit 96fc74333f84cfdf8d434c6c07254e215e2aad00 ]

There is a copy and paste bug so we accidentally use the RX_ shift when
we're in TX_ mode.

Fixes: bb8b2062aff3 ("fsl/qe: setup clock source for TDM mode")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
(cherry picked from commit 3cb31b634052ed458922e0c8e2b4b093d7fb60b9)
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/fsl/qe/ucc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/ucc.c b/drivers/soc/fsl/qe/ucc.c
index c646d8713861..681f7d4b7724 100644
--- a/drivers/soc/fsl/qe/ucc.c
+++ b/drivers/soc/fsl/qe/ucc.c
@@ -626,7 +626,7 @@ static u32 ucc_get_tdm_sync_shift(enum comm_dir mode, u32 tdm_num)
 {
 	u32 shift;
 
-	shift = (mode == COMM_DIR_RX) ? RX_SYNC_SHIFT_BASE : RX_SYNC_SHIFT_BASE;
+	shift = (mode == COMM_DIR_RX) ? RX_SYNC_SHIFT_BASE : TX_SYNC_SHIFT_BASE;
 	shift -= tdm_num * 2;
 
 	return shift;
-- 
2.17.1

