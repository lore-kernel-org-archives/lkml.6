Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E9EC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8492081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="LwxpnXwV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B8492081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbeJaD1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 23:27:38 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38162 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbeJaD1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 23:27:37 -0400
Received: by mail-io1-f68.google.com with SMTP id q18-v6so7916450iod.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 11:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ncMlYjW4QMBcueE4XAAx0DvzuXJgAlxX/WdXaLvA1LQ=;
        b=LwxpnXwV9wkbg77rASowOSIiSpfJI7H8XloHlgoOkRB1S9yKN5q/ItcjYlpQQ7niel
         jatV8sShUu5KMmQpvox9AAcbNG5uRTj7ovh0HSsqSHYE6en7us/jrWt0/c3UHvs8iBDE
         PVUWeif1HJMoBCXwSpxoMKFFYq5+Z4ngXgDWhqyzy6YnN0QLJNhdbBDY36iWK7UzG9Ei
         5/33eRILNXIypxag4UQZLDTPqSYnmb/RE/DbaQaorCI622Yh4oGthv6AWkuUW6PxnYpF
         VrQydiunyYljd5T627LXqp9gVQ45i/weRybPoLeIhZK7+Y4O/YNsYRBV3dlpfmPMWK0B
         jVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ncMlYjW4QMBcueE4XAAx0DvzuXJgAlxX/WdXaLvA1LQ=;
        b=FcyVsKkGX6vCO0n5XxNTbku6DRUFoo9zEI6OSV8uf7ZTLPXl4pV15ylXIERhNiN0C4
         1x1riC4r++C67VpHzH4K4AJGkZ35RYfZ6pK5u3ZpRRUq2L4+/bJEwzOjiJtWWbYX45Ni
         IeHDZLF4o7DX4FJe1HZXxm1mtvSQ9zy5avbo9Ty+4inhis2s0HSrLTTF3GP6c0ZH8WyS
         PqPdwHFWoCnz4bABFbRCXQTha//9h7nDo8Z4InsQKPl6xg4PS8XrqOzXwPlgvcGKYqx9
         4e6njwzu3trcoDwHGTEhXTWtIF7loJ4UoqqSVU2EAyel5N5SyLJuM3JnJoHULfmfUbtR
         DD6A==
X-Gm-Message-State: AGRZ1gKjbdl5h7qouuEAsK1CWrXG3cI/LhN5e3GD2RB4BTWWAe6vu18G
        rTOgXkNpq44RnXvvxoZxfjwM9w==
X-Google-Smtp-Source: AJdET5cjDUXCBnY7PbTHECdvmrixYnr7k5OsSzpmnCpd9XSmPvCg4KpuZSBCIJoRausFAsnxAqJXng==
X-Received: by 2002:a6b:4618:: with SMTP id t24-v6mr8245ioa.284.1540924381841;
        Tue, 30 Oct 2018 11:33:01 -0700 (PDT)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o20-v6sm4895739itc.34.2018.10.30.11.33.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 11:33:00 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/16] blk-mq: provide dummy blk_mq_map_queue_type() helper
Date:   Tue, 30 Oct 2018 12:32:39 -0600
Message-Id: <20181030183252.17857-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030183252.17857-1-axboe@kernel.dk>
References: <20181030183252.17857-1-axboe@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doesn't do anything right now, but it's needed as a prep patch
to get the interfaces right.

While in there, correct the blk_mq_map_queue() CPU type to an unsigned
int.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.h b/block/blk-mq.h
index 889f0069dd80..d9facfb9ca51 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -73,13 +73,20 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 extern int blk_mq_hw_queue_to_node(struct blk_mq_queue_map *qmap, unsigned int);
 
 static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
-		int cpu)
+						     unsigned int cpu)
 {
 	struct blk_mq_tag_set *set = q->tag_set;
 
 	return q->queue_hw_ctx[set->map[0].mq_map[cpu]];
 }
 
+static inline struct blk_mq_hw_ctx *blk_mq_map_queue_type(struct request_queue *q,
+							  unsigned int hctx_type,
+							  unsigned int cpu)
+{
+	return blk_mq_map_queue(q, cpu);
+}
+
 /*
  * sysfs helpers
  */
-- 
2.17.1

