Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F9EC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298B120659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNYRgvCp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 298B120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbeIFBTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 21:19:25 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41781 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbeIFBTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 21:19:25 -0400
Received: by mail-lf1-f68.google.com with SMTP id l26-v6so7159390lfc.8;
        Wed, 05 Sep 2018 13:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=D+xYC5Sko/yQRwd8YhDHzcuQLJgQw1NUi54D0OxmERM=;
        b=UNYRgvCpM2bQW/zAoGCutPcxdYr86H8QdtIjc0YTM3g9IYtgKVaNg+O89zkKlqQ68g
         16K9lNGgFOhSwy45bhIbTSGpOvui8nwzVLn2PFofalYKpybyFgDQnBhMprwIQdQ7oaVT
         gMYdxNLqjO7ed2OrhGwV+MlAEFjy8NvyzT8HfIcCuLKpJwLwo2PucJCWhrGnm5YKBIW8
         ptCH2MuSSSl5WTg6jYSZzcDk8C5guUM9Lo4TYGDW57xkG+bO9LnrvNk0vSkz+Ewjc4NM
         0yT4JFSgBXHH4+1bmHXTJdPyiAe6D7VFesaaXc3eFpSlY8O9S3gLjvQD4P1GuVn/OYKr
         g0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D+xYC5Sko/yQRwd8YhDHzcuQLJgQw1NUi54D0OxmERM=;
        b=q/MFi8QPdixKq99LP+R3AWTVz4+eXw/R+Xuo+NAgxrc9rKT96EmhjP9O+d7y5psu3S
         fIOj3iOFg53EYd2iomYiO6gvrUxqN/pmTuJRQahD8jV2scIzl64elgCTASWl++oHWa3Z
         BiIvY4ke4RMmDzlTTL3JaT0vD1C68eDB4PapFGjfQJvn5BCJ0M9B7buQicnohr5E1KVN
         gI/AisVpav1KclIXwfIo774o8HM0VS7E+ZEv/2uoxCTwaEiGEjs8tj4ibe5a9Ug4/Gw7
         zc9Jwv/Go0nyaMef9YmrEh3/sD4z+Y2l6HaPbq2xq0Fyx5S8RytD325bwfks73c0Zn2x
         m/QA==
X-Gm-Message-State: APzg51BLxZGclHTLUGg+2wL7b+J4URCfFmeUIZipSyhDdBedEC8EpuKu
        K6qWlsfFGPdJ5pq0S2gNgriVvjS8EAU=
X-Google-Smtp-Source: ANB0VdbEd59Wr0+L8oWXmN9kIlMKEXv2DX4554zmwqBv6TbWmE04wYMKW3+uNzEhMcoxZR/t0cOCmg==
X-Received: by 2002:a19:115b:: with SMTP id g88-v6mr24738430lfi.57.1536180449894;
        Wed, 05 Sep 2018 13:47:29 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-159-62-202.elisa-laajakaista.fi. [91.159.62.202])
        by smtp.gmail.com with ESMTPSA id 103-v6sm477468lfs.28.2018.09.05.13.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 13:47:29 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: remove unnecessary unlikely()
Date:   Wed,  5 Sep 2018 23:47:20 +0300
Message-Id: <20180905204720.992-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BUG_ON() already contains an unlikely(), there is no need for another one.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
Cc: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 drivers/scsi/scsi_lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 0adfb3bce0fd..aaa1819b0a69 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1207,8 +1207,8 @@ int scsi_init_io(struct scsi_cmnd *cmd)
 
 		count = blk_rq_map_integrity_sg(rq->q, rq->bio,
 						prot_sdb->table.sgl);
-		BUG_ON(unlikely(count > ivecs));
-		BUG_ON(unlikely(count > queue_max_integrity_segments(rq->q)));
+		BUG_ON(count > ivecs);
+		BUG_ON(count > queue_max_integrity_segments(rq->q));
 
 		cmd->prot_sdb = prot_sdb;
 		cmd->prot_sdb->table.nents = count;
-- 
2.17.1

