Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC44C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8FE620834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lW9XK8YP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8FE620834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbeHaCk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:40:29 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37961 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbeHaCk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:40:28 -0400
Received: by mail-lf1-f65.google.com with SMTP id i7-v6so8480086lfh.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 15:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eBRbuymwF9MVHxtnZ+TXUvKdoBKuqYdJwQwOYSyNFQ4=;
        b=lW9XK8YPaXpf+M5mJS4xcZWbX61BTMKmjgvs8m4JNNjW/GOZLiFR8fRfLCVp8ptMEk
         KlMu9eIBT/YqNTbVvhlbuNF1cuJBdbBymag8PUU3poxW1pqLmfxmnIsF069JgCRqp43D
         PJ72yl/0tgPMj3vbi+MBhkPhi5bFeV2CGpSoSddWzREP3RlgJhVdxRd2vtTSfdb3Dpzl
         6OiFNCy1H84ROR7feyUhiPo8dOBtLrmy6p139WfdCu9EnrMMywgB0AbpvyHFsiuwWVRI
         mmBNNH7ajRygWC7klpSFvoK9sWhP6UBHdVEc1BtcxtF1mQG54RM7eDT4WJIK7gxauCBV
         ofDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eBRbuymwF9MVHxtnZ+TXUvKdoBKuqYdJwQwOYSyNFQ4=;
        b=DKwp5cN1UOINdDL5Ay73F+Pqu6Y3uCRbR9cVyRTCeKQd4gzBF/wZ6vQ/23e06hBGtC
         JUvNacMaFdFYjP/dmuln9CS+M2fEQ9EAphKfKwsWcCA7cPmuTlOGrtD9TrujVhANVfBz
         CoPfhlhCbyoNOsbyEQo3fF/QsVPQvP49jwr1qwJzYTPfBRPDD0IvDH5iG7vphCbFwJTI
         iIi4u9wcu6b9wpy0QNrOYgeyykdYMi4hoxtbje5OTC19VtL1wo6yKASqDmdCd3MoQoqV
         D46zRJ1eJcJtYlCQQbcCan9EuMdlBofdMI/VBOpH3fZxo/xWJhPRtj5d7aDyZ7ByVhdf
         LwsQ==
X-Gm-Message-State: APzg51AHFG0Bq44jQlOiQZmjLd9/yc0QB+CcHJgs7LdqWl3Ree/8yNcw
        UICOQk/14SQBJGAbPytOW+j6dvMe+nc=
X-Google-Smtp-Source: ANB0Vdbmli3WVAs+mF1Tvqh4GZTvw9VV9m8EYyN9jue51QO/4EyL6a009KGVZnM/EfH5pm0vT2jhBQ==
X-Received: by 2002:a19:1591:: with SMTP id 17-v6mr8336474lfv.141.1535668562377;
        Thu, 30 Aug 2018 15:36:02 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-159-62-202.elisa-laajakaista.fi. [91.159.62.202])
        by smtp.gmail.com with ESMTPSA id u28-v6sm1455376ljd.61.2018.08.30.15.36.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 15:36:01 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     linux-kernel@vger.kernel.org
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
Subject: [PATCH 23/23] scsi: remove unnecessary unlikely()
Date:   Fri, 31 Aug 2018 01:34:29 +0300
Message-Id: <20180830223429.30051-24-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830223429.30051-1-igor.stoppa@huawei.com>
References: <20180830223429.30051-1-igor.stoppa@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BUG_ON() already contains an unlikely(), there is no need for another one.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
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

