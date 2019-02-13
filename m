Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F82C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 328F921934
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026347;
	bh=efNcnhC12B286zXMLF9MqdlABJf9oIlVPJgAulgdcCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hAAzA3F/TZaIVT3oNLgu7cVPcwUmtxK9ttyy5oJAhiQ5n3nr+Mx3gIUXcHG1fPTAY
	 ky07cPUEXxHMjoa4Vijrx/9I3d54+iiRS/PUJnN4evX9HblmQKi8xlLz3z3RsUB3+7
	 MdD2ESQm97Ah/oyCOD9A4wuUyFaXlbkTYmXt4mjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389883AbfBMCw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:52:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:42092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388551AbfBMCib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:38:31 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BED5C206B6;
        Wed, 13 Feb 2019 02:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025511;
        bh=efNcnhC12B286zXMLF9MqdlABJf9oIlVPJgAulgdcCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MR2S2go6NBgcbPi+qAi6Tk+0rILrL/zujmwj5Xdbk2cm87RDbXBMM75dGTT3RdS/o
         RoBCNjnKtJlMSssI6SobbqRXN/LZw5jMMjEIm+kG690ztvbNnzCgj37vIJvoGvZr0I
         NT64g5BhboyJQWGq1GuMjZnf85sUtZlNl2SfUmDY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Avri Altman <avri.altman@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 54/83] scsi: ufs: Fix geometry descriptor size
Date:   Tue, 12 Feb 2019 21:36:32 -0500
Message-Id: <20190213023701.20286-54-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Avri Altman <avri.altman@wdc.com>

[ Upstream commit 9be9db9f78f52ef03ee90063730cb9d730e7032b ]

Albeit we no longer rely on those hard-coded descriptor sizes, we still use
them as our defaults, so better get it right. While adding its sysfs
entries, we forgot to update the geometry descriptor size. It is 0x48
according to UFS2.1, and wasn't changed in UFS3.0.

[mkp: typo]

Fixes: c720c091222e (scsi: ufs: sysfs: geometry descriptor)
Signed-off-by: Avri Altman <avri.altman@wdc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ufs/ufs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
index 14e5bf7af0bb..c3bcaaec0fc5 100644
--- a/drivers/scsi/ufs/ufs.h
+++ b/drivers/scsi/ufs/ufs.h
@@ -195,7 +195,7 @@ enum ufs_desc_def_size {
 	QUERY_DESC_CONFIGURATION_DEF_SIZE	= 0x90,
 	QUERY_DESC_UNIT_DEF_SIZE		= 0x23,
 	QUERY_DESC_INTERCONNECT_DEF_SIZE	= 0x06,
-	QUERY_DESC_GEOMETRY_DEF_SIZE		= 0x44,
+	QUERY_DESC_GEOMETRY_DEF_SIZE		= 0x48,
 	QUERY_DESC_POWER_DEF_SIZE		= 0x62,
 	QUERY_DESC_HEALTH_DEF_SIZE		= 0x25,
 };
-- 
2.19.1

