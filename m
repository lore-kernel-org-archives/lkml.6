Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD83C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B425320651
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864049;
	bh=hiiPDHYAWattjPWQW07dh2SvPsTRqE6Clsqdbf0aK0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zqvQSizoGZfTAFhHmy2GFYKovFa/przKYzV+tHCGktL5Hi4tk9NsQbKmp7YEXNkIy
	 npKdNC0wCt2IEHr3l8/FmsmyNrCjgWsE1pyYFUl3Jb/2KtZr83XIDO01F9vU8PpaPm
	 IoYH6+7PYKFNAdnmRCPH1sz5VkosV8VU9GFRUInM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbeLZWks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:40:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:40978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729178AbeLZWkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:40:42 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6258C2054F;
        Wed, 26 Dec 2018 22:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864042;
        bh=hiiPDHYAWattjPWQW07dh2SvPsTRqE6Clsqdbf0aK0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N+LDQk0eOiBB7Qn8TGsEuNCjoPUe6qwQhYmnBM6yvbpGB2hGt0cTwXzhO1TdZ0o8P
         4E1j9/XaUMCMqdKK94bBIT5v1/JJ8AFd7e2TrSbRZUmLnCaHZ4YZLOeLILmBaDZnAi
         evF1hpnqS1GzWyfoILa0rfFmG/zcpkNnYMtnSyK8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Varun Prakash <varun@chelsio.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 28/59] scsi: target: iscsi: cxgbit: add missing spin_lock_init()
Date:   Wed, 26 Dec 2018 17:38:08 -0500
Message-Id: <20181226223839.150262-28-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223839.150262-1-sashal@kernel.org>
References: <20181226223839.150262-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Varun Prakash <varun@chelsio.com>

[ Upstream commit 9e6371d3c6913ff1707fb2c0274c9925f7aaef80 ]

Add missing spin_lock_init() for cdev->np_lock.

Signed-off-by: Varun Prakash <varun@chelsio.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/iscsi/cxgbit/cxgbit_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/target/iscsi/cxgbit/cxgbit_main.c b/drivers/target/iscsi/cxgbit/cxgbit_main.c
index 4fd775ace541..6340e2e7ffbe 100644
--- a/drivers/target/iscsi/cxgbit/cxgbit_main.c
+++ b/drivers/target/iscsi/cxgbit/cxgbit_main.c
@@ -58,6 +58,7 @@ static void *cxgbit_uld_add(const struct cxgb4_lld_info *lldi)
 		return ERR_PTR(-ENOMEM);
 
 	kref_init(&cdev->kref);
+	spin_lock_init(&cdev->np_lock);
 
 	cdev->lldi = *lldi;
 
-- 
2.19.1

