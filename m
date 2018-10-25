Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAC7C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B04A2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1lsDS15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B04A2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbeJYXED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:04:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729506AbeJYWvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:51:38 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C497E2086D;
        Thu, 25 Oct 2018 14:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477121;
        bh=Zjsc9pHnES/Sv9ixrO1xYocxyoCcFvIBR6C27l4TvsI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I1lsDS15q4dxOS1UD7hKcba1DK9gBfKD0/elPHmm93issqQdyd32cozy6exzTUiJi
         IbtNUhsBIRqRyIBFQa/T+Bxlpp571SsLBQnN/RCFoPjDyJ0WKH8nTX79yPtOM3A1n/
         9Y13OMDEml+VxgNG6GpicOGrt9Ww/z4EVFpHuGa4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 62/65] scsi: aacraid: Fix typo in blink status
Date:   Thu, 25 Oct 2018 10:17:02 -0400
Message-Id: <20181025141705.213937-62-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141705.213937-1-sashal@kernel.org>
References: <20181025141705.213937-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.com>

[ Upstream commit 934767c56b0d9dbb95a40e9e6e4d9dcdc3a165ad ]

The return status of the adapter check on KERNEL_PANIC is supposed to be
the upper 16 bits of the OMR status register.

Fixes: c421530bf848604e (scsi: aacraid: Reorder Adpater status check)
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.com>
Reviewed-by: Dave Carroll <david.carroll@microsemi.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/aacraid/src.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/aacraid/src.c b/drivers/scsi/aacraid/src.c
index e415e1c58eb5..cf3ac0654a3a 100644
--- a/drivers/scsi/aacraid/src.c
+++ b/drivers/scsi/aacraid/src.c
@@ -444,7 +444,7 @@ static int aac_src_check_health(struct aac_dev *dev)
 	return -1;
 
 err_blink:
-	return (status > 16) & 0xFF;
+	return (status >> 16) & 0xFF;
 }
 
 /**
-- 
2.17.1

