Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB1FECDE44
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0632081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="sAQt6Arm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E0632081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbeJaD1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 23:27:45 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:51599 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbeJaD1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 23:27:43 -0400
Received: by mail-it1-f194.google.com with SMTP id h13so2108200itl.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 11:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FDKGBdEnPJqmZMVEkJWhACz2yqqeabrzsupMLOYAhO4=;
        b=sAQt6ArmCG29q2FC2N3AEPWxQsxpU9ESDqTKtgWldkMW2zejie424VUyRdwDv7/jyk
         GyqYFEYz4ONd0OYnjasEn/TFB6hImfM5yLp0uRFa9aLHzTAnwfAloAjbv9XSQuHSEtpi
         Ao3wpVsOXf+CPjgybmvDgJUbd6fUHHKIWo/qqzzt0lK/C5TAEf693/Jnutc5CUDF3TtE
         oM2KFZpex+B94D1hHl+W/JBGdFdn7V9ZLHp3gW8ElWLMBn3kR57HI+LSyIaYqEtIZqAr
         GuZr6MvIyKcjcS2MFzlVIeh+kiOBxOFZvDMyvgkKuv62C4Y3FaavZy8s5pjh7iMzVqIL
         bhvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FDKGBdEnPJqmZMVEkJWhACz2yqqeabrzsupMLOYAhO4=;
        b=jI4IVBDg6YugXSi+EqyyAwZ2xvCogK5yBj7UlC9dLZOD27zl7Xk1MN6+ItLAsD9b93
         nDv00LZCZ/tZE1CFQjOqS+TXVyY59OUONcIiQnroIQ9+FPq1QrCYhAW7n2VLR3KxX1ep
         5MMlxoOOyvPfsFYuFwps97F2rGrYy6sQkz5Y/GwNHFCZXfzZ5BZGkUBDZgZ7zxeUsEdt
         CWZMbX4qiTWnzcW6FNjj1YDhPQqBA8sNSV8FUtJ8t/xNnypHFSJaD9oGDDMm6DNT9goz
         BHsSCYQXeNxnJpIrBBoR+46jGi/Cf4FvIsx4Dqyy0Bw8/TxyNnk7nxbKqxKtYrl6EMy+
         AQsA==
X-Gm-Message-State: AGRZ1gJ5WFKNyUZBV3cWivQTUTxO8bVpGag5G1YR9ck+W1A9CoQjkn6k
        2U0nr+FOavxF40pTD88CKA/pZQ==
X-Google-Smtp-Source: AJdET5di1MfVvmB6Hq618QWR7jsFmPGD/4Vc9jDMrIk7h9M2KWLd68t9oDSc56+f1ChmvsHRFM89Ag==
X-Received: by 2002:a24:4f51:: with SMTP id c78-v6mr22872itb.56.1540924388040;
        Tue, 30 Oct 2018 11:33:08 -0700 (PDT)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o20-v6sm4895739itc.34.2018.10.30.11.33.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 11:33:06 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/16] blk-mq: add 'type' attribute to the sysfs hctx directory
Date:   Tue, 30 Oct 2018 12:32:42 -0600
Message-Id: <20181030183252.17857-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030183252.17857-1-axboe@kernel.dk>
References: <20181030183252.17857-1-axboe@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can be useful for a user to verify what type a given hardware
queue is, expose this information in sysfs.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq-sysfs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index aafb44224c89..2d737f9e7ba7 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -161,6 +161,11 @@ static ssize_t blk_mq_hw_sysfs_cpus_show(struct blk_mq_hw_ctx *hctx, char *page)
 	return ret;
 }
 
+static ssize_t blk_mq_hw_sysfs_type_show(struct blk_mq_hw_ctx *hctx, char *page)
+{
+	return sprintf(page, "%u\n", hctx->type);
+}
+
 static struct attribute *default_ctx_attrs[] = {
 	NULL,
 };
@@ -177,11 +182,16 @@ static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_cpus = {
 	.attr = {.name = "cpu_list", .mode = 0444 },
 	.show = blk_mq_hw_sysfs_cpus_show,
 };
+static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_type = {
+	.attr = {.name = "type", .mode = 0444 },
+	.show = blk_mq_hw_sysfs_type_show,
+};
 
 static struct attribute *default_hw_ctx_attrs[] = {
 	&blk_mq_hw_sysfs_nr_tags.attr,
 	&blk_mq_hw_sysfs_nr_reserved_tags.attr,
 	&blk_mq_hw_sysfs_cpus.attr,
+	&blk_mq_hw_sysfs_type.attr,
 	NULL,
 };
 
-- 
2.17.1

