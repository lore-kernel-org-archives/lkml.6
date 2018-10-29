Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DC3C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DCB2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="aAiOocQM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1DCB2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbeJ3B1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:27:09 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50940 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbeJ3B1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:27:09 -0400
Received: by mail-it1-f194.google.com with SMTP id k206-v6so10318239ite.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 09:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7tpaRVSjhaK88jexqA/z4LLCkTo0WudeZhco39P0CL8=;
        b=aAiOocQM/qr+dkvhRoy7DTtw2TGJZ8QxlsS1xfpmfB+Y1LESvD+yGnFlQCdmTlmgpG
         zTaEJGBAvpy0+INyAHzCkDpFdw0Kr+ECbtU3feolq5l/akofreFA9e54SMCBZ5q0FYO8
         Eh1RrH/qV7RAJucf6gy4E+L0LF/Jo+AK2adjHQxM99CttRVTH+MCx31WgfQFeMpOqJrR
         /6lV6K5mno6EWFoK8SWDgtHx8vZQKeeUwdneUzcE9mWzqGu7qmTRsimK/fW15PBEpqM/
         HigkDuP1q5z7fj9kVM9XOduKJGnTZDu4hyU74ayOryozKpx3Gg9zDffpFyVvo5EIML5K
         +/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7tpaRVSjhaK88jexqA/z4LLCkTo0WudeZhco39P0CL8=;
        b=J3NyAtWOZxBVmy4lyTqfXc4xb7pMWarelEVyUXXwrZ7Iwpp6OMPddgfGqvbeBLrb1c
         6HlSUxNzUBNQjtVFiKDrqU97qE7H87gCDiRKTJFKJ3Cv7T5/OQ5yMGT16/knAXP6TWMF
         wfYYN7hJdIhCWoaKZhyHiEYmv/Ibm/rdhL4xHZNrnMpTo8I8RVUBInHXI/SuvwIRTeib
         AUHxfqbQA97qDgc1BJnA2FChEdstGkNRGllHgjF9wc+cJGwZmAhhFCH4/ZNKguDPrrjX
         EIhZz9SrxgC0z8gJ0I1e5qy/yRKcHYs77LUdfbquLJGO4oFOeZHnGttsdMCuipuJViaT
         Bm2A==
X-Gm-Message-State: AGRZ1gK2iHrSP5kN3sfZ2hDQ1nPOiIWA1Tuhg1lmzpBJxUg9gyPTXsmn
        ztPZZ58W+g381gScYvD+8Hul9w==
X-Google-Smtp-Source: AJdET5dRoGp+h4o2frTysI1QUlAJzxsn4/JpObChfmceUa8YbO8e4XAnZTHQrwNDzUBsDQ/H4+woxA==
X-Received: by 2002:a24:ce47:: with SMTP id v68-v6mr3818711itg.163.1540831067893;
        Mon, 29 Oct 2018 09:37:47 -0700 (PDT)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id q15-v6sm3367019itc.38.2018.10.29.09.37.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 09:37:46 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/14] blk-mq: provide dummy blk_mq_map_queue_type() helper
Date:   Mon, 29 Oct 2018 10:37:27 -0600
Message-Id: <20181029163738.10172-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181029163738.10172-1-axboe@kernel.dk>
References: <20181029163738.10172-1-axboe@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doesn't do anything right now, but it's needed as a prep patch
to get the interfaces right.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/blk-mq.h b/block/blk-mq.h
index 889f0069dd80..79c300faa7ce 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -80,6 +80,12 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
 	return q->queue_hw_ctx[set->map[0].mq_map[cpu]];
 }
 
+static inline struct blk_mq_hw_ctx *blk_mq_map_queue_type(struct request_queue *q,
+							  int type, int cpu)
+{
+	return blk_mq_map_queue(q, cpu);
+}
+
 /*
  * sysfs helpers
  */
-- 
2.17.1

