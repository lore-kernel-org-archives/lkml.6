Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2B5ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 19:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892662083A
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 19:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hncF8j3Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 892662083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbeIPAxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 20:53:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33536 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbeIPAxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 20:53:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id d4-v6so5791282pfn.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 12:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=UmJIyeGt/F7ce8hsaaw2SmgvXTgXUPrhz5rFO4BHE1c=;
        b=hncF8j3ZXpC6scM4cMnjbY209uGbL5PYnS/imNqyw8vlbPw/n6QuRXp884oDFPYYSY
         EeeTPq2kXKyHDQwgE2Tombd+Kc4cw0lw37NcAReflyYZh/tYlXDVr/Nu1kf1pjTUM58Q
         1HOltR5olf0Yx2YNaDZe6P8iucjMoo4cFVBbLGd98xTtCxz72SQP8/DDafH4dwEut4KQ
         29sG6UuCVR8HwpdP/+HsKCX5vA5MQKWgmfvzRsb8Fvw+Mvopoz8Ac5iPi5zJ3jClfdWt
         3BXVvyJtZUx18eSCcEqxoWT2/Foydi5PzhZdI1b6dik7bcLy+G/9NS2xZPpWqEzF0GT1
         yOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=UmJIyeGt/F7ce8hsaaw2SmgvXTgXUPrhz5rFO4BHE1c=;
        b=F1f1KGJSZ2wHhhx0GhiRxULdUAmyI0aqrVksdUYZJQk8cNQttnZe2ziyfil+n/pvJM
         qIUv7ViiR8tsT0z7z+RCF9YjiAooSM0yQEXpg9TLR6MUhUbMxKAYnhRNHLxF+67/RB+q
         99sKv5FMWyqxRUC3AZo90vZwP+0GeuWt65/SLdNCi54+hVHp4CQwHPF4pp/nV1VAyZxx
         1k29xsYuEmCAqNfvdFEhIkbWeMOWAgewHYh0TtcXoUkdXoxVKsTM5MEYppd83MmuChCR
         m42A+G3lQ5ohAXg1r01fCdaRGdvoxKA7VzmXkEyF8K4Q53tFwlE0zwvPLmFDqx+puk9N
         hlTw==
X-Gm-Message-State: APzg51DcnqgydrCA1WkwfRR+egBgwiYwY4cJstOcKRdAa87DKPq90rmi
        OgeQRz5wukfFV9GFoId+gbQ=
X-Google-Smtp-Source: ANB0VdY8QNDiKilC4q/qjSkP8tjgzmpElPIKH5e9TPCmqFXK77urMtCaNLMj1CdE+FRBd/LuZCvtEg==
X-Received: by 2002:a63:77ce:: with SMTP id s197-v6mr17343217pgc.172.1537040022681;
        Sat, 15 Sep 2018 12:33:42 -0700 (PDT)
Received: from ip-172-31-20-60.us-west-2.compute.internal (ec2-35-163-67-21.us-west-2.compute.amazonaws.com. [35.163.67.21])
        by smtp.gmail.com with ESMTPSA id h190-v6sm18945820pge.18.2018.09.15.12.33.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 12:33:42 -0700 (PDT)
From:   yupeng <yupeng0921@gmail.com>
To:     keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] trace nvme submit queue status
Date:   Sat, 15 Sep 2018 19:33:41 +0000
Message-Id: <20180915193341.1221-1-yupeng0921@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

export nvme disk name, queue id, sq_head, sq_tail to trace event
usage example:
go to the event directory:
cd /sys/kernel/debug/tracing/events/nvme/nvme_sq
filter by disk name:
echo 'disk=="nvme1n1"' > filter
enable the event:
echo 1 > enable
check results from trace_pipe:
cat /sys/kernel/debug/tracing/trace_pipe
In practice, this patch help me debug hardware related
performant issue.

Signed-off-by: yupeng <yupeng0921@gmail.com>
---
 drivers/nvme/host/pci.c   |  5 +++++
 drivers/nvme/host/trace.h | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d668682f91df..11743c65a83f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -31,6 +31,7 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/sed-opal.h>
 
+#include "trace.h"
 #include "nvme.h"
 
 #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
@@ -894,6 +895,10 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 	}
 
 	req = blk_mq_tag_to_rq(*nvmeq->tags, cqe->command_id);
+	trace_nvme_sq(req->rq_disk,
+		      nvmeq->qid,
+		      le16_to_cpu(cqe->sq_head),
+		      nvmeq->sq_tail);
 	nvme_end_request(req, cqe->status, cqe->result);
 }
 
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index a490790d6691..13e33184cf93 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -156,6 +156,24 @@ TRACE_EVENT(nvme_complete_rq,
 
 );
 
+TRACE_EVENT(nvme_sq,
+	    TP_PROTO(void *rq_disk, int qid, int sq_head, int sq_tail),
+	    TP_ARGS(rq_disk, qid, sq_head, sq_tail),
+	    TP_STRUCT__entry(
+		 __array(char, disk, DISK_NAME_LEN)
+		 __field(int, qid)
+		 __field(int, sq_head)
+		 __field(int, sq_tail)),
+	    TP_fast_assign(
+		__entry->qid = qid;
+		__entry->sq_head = sq_head;
+		__entry->sq_tail = sq_tail;
+		__assign_disk_name(__entry->disk, rq_disk);
+	    ),
+	    TP_printk("nvme: %s qid=%d head=%d tail=%d",
+		      __print_disk_name(__entry->disk),
+		      __entry->qid, __entry->sq_head, __entry->sq_tail)
+);
 #endif /* _TRACE_NVME_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.17.1

