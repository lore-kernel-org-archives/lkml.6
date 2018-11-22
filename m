Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EB3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BB020864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="s93VUvVG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95BB020864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406985AbeKWGfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 01:35:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:34780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733189AbeKWGfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 01:35:52 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55D5420864;
        Thu, 22 Nov 2018 19:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542916500;
        bh=pf2oHXSh6C7WxyK3jC6/zz0sdIOCJ97YWAfpVhSUsZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s93VUvVGmI/oEHk2NSrbUXj0+iU4SovkFk7ZtiNQE47Fn4HmXS0RED8LfJUHbvewy
         spC0vpGnfRdJS04VOWlEht+5BIUSatmFlG58LFFxPrPC4GCuRNkl8CiY+EAdT3X4nW
         DA3YisGQsW08veKiZp8QtmNXA3jfEYYU9MU99t5c=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Finn Thain <fthain@telegraphics.com.au>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 02/21] scsi: NCR5380: Return false instead of NULL
Date:   Thu, 22 Nov 2018 14:54:33 -0500
Message-Id: <20181122195452.13520-2-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181122195452.13520-1-sashal@kernel.org>
References: <20181122195452.13520-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Finn Thain <fthain@telegraphics.com.au>

[ Upstream commit 96edebd6bb995f2acb7694bed6e01bf6f5a7b634 ]

I overlooked this statement when I recently converted the function result
type from struct scsi_cmnd * to bool. No change to object code.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/NCR5380.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
index 777b0222d021..f2783441b830 100644
--- a/drivers/scsi/NCR5380.c
+++ b/drivers/scsi/NCR5380.c
@@ -1190,7 +1190,7 @@ static struct scsi_cmnd *NCR5380_select(struct Scsi_Host *instance,
 
 out:
 	if (!hostdata->selecting)
-		return NULL;
+		return false;
 	hostdata->selecting = NULL;
 	return cmd;
 }
-- 
2.17.1

