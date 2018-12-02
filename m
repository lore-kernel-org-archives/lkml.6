Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D3CC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 07:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675722080A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 07:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+yUKNZ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 675722080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725770AbeLBH11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 02:27:27 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45190 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbeLBH10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 02:27:26 -0500
Received: by mail-pl1-f195.google.com with SMTP id a14so4853049plm.12;
        Sat, 01 Dec 2018 23:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ae8sSpM0vQ0WX6UMuR6yY2DIJEC73vMziqohwF/+LoM=;
        b=W+yUKNZ9LqhUIEUskgWP6VF6MQNE6zr46oaLqOLnj0FfuCgChxTiAcJJtiWkeTnsuY
         QxlXMO7qfXMVwIslaWuWeSvx0fRIS8wmlkaNIQQ5mUyKD/vWSCiACq8GY4nBfiirujAn
         yLtmhtwiMouBFHqhYFNQuKzOapNMKFpy98ROtkIC6I2H5HkXsvdKklbCNjxgCWos/30S
         dz3pkilUHcEKONGeLe0vhWsFShjyysT7AUBlwITTjgWBT0ZgfAc+ANug6KeCOocNm2v2
         jvfFpfYzHv7UL01XlrwyTYGJjjX5/B6BzPz3bgY12Ood9HKQKvLXmnVeK5AE+n9P+niH
         ScxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ae8sSpM0vQ0WX6UMuR6yY2DIJEC73vMziqohwF/+LoM=;
        b=MlFs55v9vR9TFwHRKpuUCi4+5sFVDGDWVciCip+mnURUarZxYjE4L3dK7ZtnknTsGQ
         SVvgI1W23ws39ITE6R4brWJ+4I8GA6cB0lHgIa5838rTktWUbwOixv/BHa8e+CmL77ZV
         IxQJ/ib8vh1Hi+kGM3yyMJbEM5uWRZd3YqvviAgepLVtMwRzt/ruJYgpjsTSqzsaoDHy
         XvPYoG7nQI+Sbf3majh2yRbxP4q0uj4/C1bde9E9bOVvHMzpoYBkPF+3ujXaplnev/QS
         V5SbwP2eGXKrjluppn5WGbmZdBWlVDYdAwr3h7KV1X6wj4SMFLGpJ/Krrnbw6Yg+rODM
         Tlvw==
X-Gm-Message-State: AA+aEWZvzv9Yx2L3TTG8XEFatTiQkeVsUtN0o8RQKjSLW+vZb4DBUn+Y
        SYhQ7asTfzR18Rm/hXzQkNvsiXGb
X-Google-Smtp-Source: AFSGD/XcI6s5Pm9d6IT+KPj8XbSuKurz899xcgp6cfXfzbB8kgAI3BhPKZ7I4VnqF78GScd/6QlMgA==
X-Received: by 2002:a17:902:5a5:: with SMTP id f34mr11705220plf.161.1543735639886;
        Sat, 01 Dec 2018 23:27:19 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.99.148])
        by smtp.gmail.com with ESMTPSA id x3sm17097300pgk.18.2018.12.01.23.27.17
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 01 Dec 2018 23:27:18 -0800 (PST)
Date:   Sun, 2 Dec 2018 13:01:02 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        sabyasachi.linux@gmail.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi/pmcraid.c: Use dma_pool_zalloc
Message-ID: <20181202073102.GA12031@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced dma_pool_alloc + memset with dma_pool_zalloc.

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/scsi/pmcraid.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index 4e86994..84a2734 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -4681,7 +4681,7 @@ static int pmcraid_allocate_control_blocks(struct pmcraid_instance *pinstance)
 
 	for (i = 0; i < PMCRAID_MAX_CMD; i++) {
 		pinstance->cmd_list[i]->ioa_cb =
-			dma_pool_alloc(
+			dma_pool_zalloc(
 				pinstance->control_pool,
 				GFP_KERNEL,
 				&(pinstance->cmd_list[i]->ioa_cb_bus_addr));
@@ -4690,8 +4690,6 @@ static int pmcraid_allocate_control_blocks(struct pmcraid_instance *pinstance)
 			pmcraid_release_control_blocks(pinstance, i);
 			return -ENOMEM;
 		}
-		memset(pinstance->cmd_list[i]->ioa_cb, 0,
-			sizeof(struct pmcraid_control_block));
 	}
 	return 0;
 }
-- 
1.9.1

