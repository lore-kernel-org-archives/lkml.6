Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC73C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 17:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA29121888
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 17:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0CI1Ujn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA29121888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbeHETHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 15:07:08 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41066 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbeHETHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 15:07:08 -0400
Received: by mail-lj1-f194.google.com with SMTP id y17-v6so8674073ljy.8;
        Sun, 05 Aug 2018 10:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ldr0yoQdF1fCKHSkU/tHvNfIAixV328NcFTPZDoFZ4w=;
        b=U0CI1Ujnpd1mIRLTtfytGCJYEvyfYapDCOaCcHB95pDv5wj0OcPF+1d4ZYGOQT3cbM
         DOwrQb23FNgO+wc2AY0VWae2TAbSpbTX+ZdzwO29Jck1TYjq18v+QBVKY83dWSlLZN1B
         V6F98JpYLZYYDKCcysrOYz+NzGEMOiiRkxNy2yuSHA6SPRssHLhP4wf2yyP1Aohcxjf3
         TwqqqpdMqeIXqic6cWgJDiVyqzs3majswi9YyZh8HTKWyHKh/b69XaaLCYTGRQpg7MwW
         VeoPnznlWUqYaI7k96SB610CN0aYjdZP740Zg9j5H171KphS86GXi8TEACJopEmdrxgQ
         Og8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ldr0yoQdF1fCKHSkU/tHvNfIAixV328NcFTPZDoFZ4w=;
        b=Me3DIcVQGxHcxYP14ZZTkCt2ZiIqO05f4R+3pYIVgyGrHl4GkqfSA4w4srvdDDHwCR
         PG0koWow50Rn+bnZNH8q/ypjJwGWCNMvDLCn+rrsPKYl06GsB/W2Uqrt2fjSj0z5WDUB
         FulPXnve6FbIRXxR6oG0XLslzHSvCtXzueeTzcnj9tJZQ5AIGFzAvW0Rj3DyjFFCCu8f
         rL+m7ancyXVL46/bQvucFzG2a6n2MO/k52ze97uEdloZ4vtcIEY3oYnlDNO4gQZgJDx8
         eVapFcDsc2pq/eqyjn7mry4dmmwBSIeUHplwbrmv8P6j9wFypAOB24ZHMWTRi3Z2NVoL
         OAxg==
X-Gm-Message-State: AOUpUlFE1tePLjAB8SOFxJVOkZBqNjgbYBr0+blHQUClb159ZEqRbPDe
        44FE+HozJQaMtqWXnxLBeIs=
X-Google-Smtp-Source: AAOMgpfQs4k12becx0W4EUuOB/y2/G4rPiBcX/nk8GYf+zolfthgxpGqEekx2nEXbKSB6pjrQXEiyg==
X-Received: by 2002:a2e:2bd7:: with SMTP id r84-v6mr10978430ljr.40.1533488513888;
        Sun, 05 Aug 2018 10:01:53 -0700 (PDT)
Received: from localhost.localdomain ([109.252.90.13])
        by smtp.gmail.com with ESMTPSA id g11-v6sm1844609ljk.45.2018.08.05.10.01.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 10:01:53 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] gpu: host1x: Cancel only job that actually got stuck
Date:   Sun,  5 Aug 2018 20:01:31 +0300
Message-Id: <20180805170131.29263-1-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Host1x doesn't have information about jobs inter-dependency, that is
something that will become available once host1x will get a proper
jobs scheduler implementation. Currently a hang job causes other unrelated
jobs to be canceled, that is a relic from downstream driver which is
irrelevant to upstream. Let's cancel only the hanging job and not to touch
other jobs in queue.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/host1x/cdma.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/host1x/cdma.c b/drivers/gpu/host1x/cdma.c
index 91df51e631b2..4d94af4a315f 100644
--- a/drivers/gpu/host1x/cdma.c
+++ b/drivers/gpu/host1x/cdma.c
@@ -348,13 +348,11 @@ void host1x_cdma_update_sync_queue(struct host1x_cdma *cdma,
 	}
 
 	/*
-	 * Walk the sync_queue, first incrementing with the CPU syncpts that
-	 * are partially executed (the first buffer) or fully skipped while
-	 * still in the current context (slots are also NOP-ed).
+	 * Increment with CPU the remaining syncpts of a partially executed job.
 	 *
-	 * At the point contexts are interleaved, syncpt increments must be
-	 * done inline with the pushbuffer from a GATHER buffer to maintain
-	 * the order (slots are modified to be a GATHER of syncpt incrs).
+	 * Syncpt increments must be done inline with the pushbuffer from a
+	 * GATHER buffer to maintain the order (slots are modified to be a
+	 * GATHER of syncpt incrs).
 	 *
 	 * Note: save in restart_addr the location where the timed out buffer
 	 * started in the PB, so we can start the refetch from there (with the
@@ -370,12 +368,8 @@ void host1x_cdma_update_sync_queue(struct host1x_cdma *cdma,
 	else
 		restart_addr = cdma->last_pos;
 
-	/* do CPU increments as long as this context continues */
-	list_for_each_entry_from(job, &cdma->sync_queue, list) {
-		/* different context, gets us out of this loop */
-		if (job->client != cdma->timeout.client)
-			break;
-
+	/* do CPU increments for the remaining syncpts */
+	if (job) {
 		/* won't need a timeout when replayed */
 		job->timeout = 0;
 
@@ -388,20 +382,8 @@ void host1x_cdma_update_sync_queue(struct host1x_cdma *cdma,
 		host1x_hw_cdma_timeout_cpu_incr(host1x, cdma, job->first_get,
 						syncpt_incrs, job->syncpt_end,
 						job->num_slots);
-
-		syncpt_val += syncpt_incrs;
 	}
 
-	/*
-	 * The following sumbits from the same client may be dependent on the
-	 * failed submit and therefore they may fail. Force a small timeout
-	 * to make the queue cleanup faster.
-	 */
-
-	list_for_each_entry_from(job, &cdma->sync_queue, list)
-		if (job->client == cdma->timeout.client)
-			job->timeout = min_t(unsigned int, job->timeout, 500);
-
 	dev_dbg(dev, "%s: finished sync_queue modification\n", __func__);
 
 	/* roll back DMAGET and start up channel again */
-- 
2.18.0

