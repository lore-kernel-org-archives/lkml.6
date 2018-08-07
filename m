Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B66C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97FB2157F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pyz3sLPk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D97FB2157F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389074AbeHGPX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 11:23:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39896 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388540AbeHGPX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 11:23:57 -0400
Received: by mail-pf1-f194.google.com with SMTP id j8-v6so8580334pff.6;
        Tue, 07 Aug 2018 06:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UsaSOYgImjdVqa2SYo+qH8Qx5i9t0zoeiVANgfUOr2c=;
        b=pyz3sLPks9A6CPEU/abwG23Y7HN+Hk45EMMiVGpKNzshKB9sz2p76vzyVbKRHdq1tm
         vhX791aj1zj8tl8HBFNyJAbBAodX+1NmeAGB5vmi+LhgSELdPtsB+ZvLWX7Jykj8D7Ht
         lR7lCqoy/cfGh9IjYuKJwZc3KzAIXlf8QuG7p/r8eUUvyYyY/YFlENqe4LHl0xQxZzLS
         PVTtU9NY4edcJX2Y3DrKiHZqF2Mabj6AGUr5VlEiMWnI6yOXtZXS1Hoo7lvpwUlQN+6e
         mBQgNDL8VTjy4aH0SDHlsTQcnpBDCaV6pAgqvfepC9xIibh7KJUaf20JO7q8J3F93t/p
         pq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UsaSOYgImjdVqa2SYo+qH8Qx5i9t0zoeiVANgfUOr2c=;
        b=EokphflLRyV/kH3LkGaZ3UlxxBJfVxV6ivmoY3g1Yai438PRAf4JVX/cHRDVJEY4CB
         jgiF+9QVWm8VkDTu1hjN1PCfnJ4oaAO6mV9C0rU42guYB7A7mq5r4qyxkuGr38k8gfXO
         4aj2U4o3d2Kr8I7neciDeVz4jhN+sSPTg7NSHCYkf7ipBpskps2mBkgo8i6CkMk9x6qs
         7PxD1iCiKDrLgxQARwJ5QTsFLYTMyvW3ByfcNnZchADuT0h/i4J16BEInp6rHW2O9G86
         goaXgZ4GxWkhZcme7cxeM4xW73oYu8NkxTOAKEz5byd1pcxD7HsPqc5oe2CgoNnvMPh4
         Mr4A==
X-Gm-Message-State: AOUpUlFguC64gOUKUBl0tTQMuPZVGyZZGwOdNog1L2GyPIvpf/dmbuh7
        pvNccz42qn26k5VYH749le0=
X-Google-Smtp-Source: AAOMgpemEG2a2AMdCFBiCkUennj6fM0+lQSKUG4o8f2m+gM0ccyvY/MTkmRCXV4Qoq62w53CNm5kDQ==
X-Received: by 2002:a63:1126:: with SMTP id g38-v6mr18416792pgl.122.1533647381018;
        Tue, 07 Aug 2018 06:09:41 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id 73-v6sm5339229pfu.20.2018.08.07.06.09.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 06:09:40 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] gpu: host1x: Continue CDMA execution starting with a next job
Date:   Tue,  7 Aug 2018 16:07:13 +0300
Message-Id: <20180807130713.1016-4-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807130713.1016-1-digetx@gmail.com>
References: <20180807130713.1016-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently gathers of a hung job are getting NOP'ed and a restarted CDMA
executes the NOP'ed gathers. There shouldn't be a reason to not restart
CDMA execution starting with a next job, avoiding the unnecessary churning
with gathers NOP'ing.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/host1x/cdma.c       | 23 +++++++++++------------
 drivers/gpu/host1x/hw/cdma_hw.c | 13 -------------
 2 files changed, 11 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/host1x/cdma.c b/drivers/gpu/host1x/cdma.c
index 6aa6fa1498e8..9e4f01c7f663 100644
--- a/drivers/gpu/host1x/cdma.c
+++ b/drivers/gpu/host1x/cdma.c
@@ -323,7 +323,7 @@ void host1x_cdma_update_sync_queue(struct host1x_cdma *cdma,
 {
 	struct host1x *host1x = cdma_to_host1x(cdma);
 	u32 restart_addr, syncpt_incrs, syncpt_val;
-	struct host1x_job *job;
+	struct host1x_job *job, *next_job = NULL;
 
 	syncpt_val = host1x_syncpt_load(cdma->timeout.syncpt);
 
@@ -341,8 +341,13 @@ void host1x_cdma_update_sync_queue(struct host1x_cdma *cdma,
 		__func__);
 
 	list_for_each_entry(job, &cdma->sync_queue, list) {
-		if (syncpt_val < job->syncpt_end)
+		if (syncpt_val < job->syncpt_end) {
+
+			if (!list_is_last(&job->list, &cdma->sync_queue))
+				next_job = list_next_entry(job, list);
+
 			goto syncpt_incr;
+		}
 
 		host1x_job_dump(dev, job);
 	}
@@ -355,17 +360,11 @@ void host1x_cdma_update_sync_queue(struct host1x_cdma *cdma,
 	/*
 	 * Increment with CPU the remaining syncpts of a partially executed job.
 	 *
-	 * Syncpt increments must be done inline with the pushbuffer from a
-	 * GATHER buffer to maintain the order (slots are modified to be a
-	 * GATHER of syncpt incrs).
-	 *
-	 * Note: save in restart_addr the location where the timed out buffer
-	 * started in the PB, so we can start the refetch from there (with the
-	 * modified NOP-ed PB slots). This lets things appear to have completed
-	 * properly for this buffer and resources are freed.
+	 * CDMA will continue execution starting with the next job or will get
+	 * into idle state.
 	 */
-	if (job)
-		restart_addr = job->first_get;
+	if (next_job)
+		restart_addr = next_job->first_get;
 	else
 		restart_addr = cdma->last_pos;
 
diff --git a/drivers/gpu/host1x/hw/cdma_hw.c b/drivers/gpu/host1x/hw/cdma_hw.c
index ce320534cbed..bc203532ae6d 100644
--- a/drivers/gpu/host1x/hw/cdma_hw.c
+++ b/drivers/gpu/host1x/hw/cdma_hw.c
@@ -40,7 +40,6 @@ static void cdma_timeout_cpu_incr(struct host1x_cdma *cdma, u32 getptr,
 				u32 syncpt_incrs, u32 syncval, u32 nr_slots)
 {
 	struct host1x *host1x = cdma_to_host1x(cdma);
-	struct push_buffer *pb = &cdma->push_buffer;
 	unsigned int i;
 
 	for (i = 0; i < syncpt_incrs; i++)
@@ -48,18 +47,6 @@ static void cdma_timeout_cpu_incr(struct host1x_cdma *cdma, u32 getptr,
 
 	/* after CPU incr, ensure shadow is up to date */
 	host1x_syncpt_load(cdma->timeout.syncpt);
-
-	/* NOP all the PB slots */
-	while (nr_slots--) {
-		u32 *p = (u32 *)(pb->mapped + getptr);
-		*(p++) = HOST1X_OPCODE_NOP;
-		*(p++) = HOST1X_OPCODE_NOP;
-		dev_dbg(host1x->dev, "%s: NOP at %pad+%#x\n", __func__,
-			&pb->dma, getptr);
-		getptr = (getptr + 8) & (pb->size - 1);
-	}
-
-	wmb();
 }
 
 /*
-- 
2.18.0

