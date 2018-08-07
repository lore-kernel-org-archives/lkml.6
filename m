Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8FDC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A292157F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxW4Mdd7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A292157F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389041AbeHGPXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 11:23:53 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38217 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388540AbeHGPXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 11:23:52 -0400
Received: by mail-pl0-f65.google.com with SMTP id u11-v6so7116145plq.5;
        Tue, 07 Aug 2018 06:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YyMJ2d0R6Lf3v4hLqW7T4yKhfoNobcq/IuYXkVtYiy4=;
        b=KxW4Mdd7/ZFaqrspXCkvqE1kAxrdAgUeShbNMkaWKzHJ0Vx1Qxkw2Oh/SpB6nKzHiB
         6KFqij9Nys2xSIV4HYc35RBauIC3/e27Ym7DFk9Opt3meSI8cAmqGGMY1h8pjJquigja
         AISjcEm3V6Yr4sSjTBqMwyBIvfUqG4dU3Vsvv8dRFf4WIGtzzs9TTTeH07jp8rNfVCBO
         ovyqSt7FDO1eBYKqut6h+qM9ORMvy3F1HiPozCk7OURyrxlMYSkJwM8jMvwKkpUjRtW2
         vndkROt0yvRNT8PNRJ84f9cPlRH3HJHTXZzdyu5eXFd//jUwMsZ7rfIHk069ANsJp8S+
         o84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YyMJ2d0R6Lf3v4hLqW7T4yKhfoNobcq/IuYXkVtYiy4=;
        b=ljzj+8DHTdByMxhrUkOtJu6DQsxW/7Gi8n7W94+QcBzFRBmYg5zoq+8J5FX/1flOhf
         PwLs+NpTZcPS9vh6Ct9yqjxF+O7CKgYcnAxUEOcTWaasouzFq/EL7pZxmNdf0uCH19/N
         DqO6fTCX3GTjVfT1FwkMuhJjUPnQxQP+3vtlNeyA2DjvErs8dSE8js7avGWnX86J78xg
         INjWY6odyXHXP+S0sYlyj4P1+Z18TXcRNFsqH2/F34HVn971NR+HBoaKmRH6e+n6O54c
         QcJgt6VhwrCkSdbNRRzrZ+mCbOoVqCvovcc3EdZdTgvqK/QPxQeFCEzHW8pMkZ3eZCtg
         ZeNw==
X-Gm-Message-State: AOUpUlHC2ygp4c2hBTUipe4nqGxlMkjibI4pbQGYPonmlWIgc+7aqIk2
        v8YtRr9x5EpzpsFBqdaW248=
X-Google-Smtp-Source: AAOMgpdchsX8aTAPu4Cd6HOb7Ec7G4knB5u0gOrnFPI6FCdm/RDNs6G35FHqgt0qB6S6tGZ7u5DcVg==
X-Received: by 2002:a17:902:d68d:: with SMTP id v13-v6mr5898768ply.278.1533647376305;
        Tue, 07 Aug 2018 06:09:36 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id 73-v6sm5339229pfu.20.2018.08.07.06.09.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 06:09:35 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] gpu: host1x: Don't complete a completed job
Date:   Tue,  7 Aug 2018 16:07:12 +0300
Message-Id: <20180807130713.1016-3-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807130713.1016-1-digetx@gmail.com>
References: <20180807130713.1016-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a chance that the last job has been completed at the time of
CDMA timeout handler invocation. In this case there is no need to complete
the completed job.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/host1x/cdma.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/host1x/cdma.c b/drivers/gpu/host1x/cdma.c
index 75f339f5df6f..6aa6fa1498e8 100644
--- a/drivers/gpu/host1x/cdma.c
+++ b/drivers/gpu/host1x/cdma.c
@@ -323,7 +323,7 @@ void host1x_cdma_update_sync_queue(struct host1x_cdma *cdma,
 {
 	struct host1x *host1x = cdma_to_host1x(cdma);
 	u32 restart_addr, syncpt_incrs, syncpt_val;
-	struct host1x_job *job = NULL;
+	struct host1x_job *job;
 
 	syncpt_val = host1x_syncpt_load(cdma->timeout.syncpt);
 
@@ -342,11 +342,16 @@ void host1x_cdma_update_sync_queue(struct host1x_cdma *cdma,
 
 	list_for_each_entry(job, &cdma->sync_queue, list) {
 		if (syncpt_val < job->syncpt_end)
-			break;
+			goto syncpt_incr;
 
 		host1x_job_dump(dev, job);
 	}
 
+	/* all jobs have been completed */
+	job = NULL;
+
+syncpt_incr:
+
 	/*
 	 * Increment with CPU the remaining syncpts of a partially executed job.
 	 *
@@ -359,16 +364,16 @@ void host1x_cdma_update_sync_queue(struct host1x_cdma *cdma,
 	 * modified NOP-ed PB slots). This lets things appear to have completed
 	 * properly for this buffer and resources are freed.
 	 */
-
-	dev_dbg(dev, "%s: perform CPU incr on pending buffers\n", __func__);
-
-	if (!list_empty(&cdma->sync_queue))
+	if (job)
 		restart_addr = job->first_get;
 	else
 		restart_addr = cdma->last_pos;
 
 	/* do CPU increments for the remaining syncpts */
 	if (job) {
+		dev_dbg(dev, "%s: perform CPU incr on pending buffers\n",
+			__func__);
+
 		/* won't need a timeout when replayed */
 		job->timeout = 0;
 
@@ -381,9 +386,10 @@ void host1x_cdma_update_sync_queue(struct host1x_cdma *cdma,
 		host1x_hw_cdma_timeout_cpu_incr(host1x, cdma, job->first_get,
 						syncpt_incrs, job->syncpt_end,
 						job->num_slots);
-	}
 
-	dev_dbg(dev, "%s: finished sync_queue modification\n", __func__);
+		dev_dbg(dev, "%s: finished sync_queue modification\n",
+			__func__);
+	}
 
 	/* roll back DMAGET and start up channel again */
 	host1x_hw_cdma_resume(host1x, cdma, restart_addr);
-- 
2.18.0

