Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C986C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4750E213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="hZ2sDFzI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4750E213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeJDOSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:18:09 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40482 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbeJDOSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:18:09 -0400
Received: by mail-ed1-f68.google.com with SMTP id j62-v6so7606951edd.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 00:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bdIMu71RHkQyz0q/XQmi9bcwpKUTSOb4uv9ELshnrrg=;
        b=hZ2sDFzIAZEYZtvMxJRsqjm1A/Goj75dTEZVgJSeE2JG9jmt82KaMDSzAiZ5UWPL+6
         fKYoh5P4TwU7ZGuh03DhHQXlkDzDsQBxThNswbPQmKICnDEihA57qyNQWGnJPRlqjStg
         FB6FhJX6lK9T4DQf8ifav8HYaLjsf0v9ShoVonvqeDJ8DBjH/V1iL5F1XBaTDXPyHMNH
         qnPIeOfsDAy8r5Pb0k89EQ3VibDcs7zdKhKMlkPuqyT9y3Ij7JbG9VWBkQszaqzHwyVj
         /sYoQDSdEooEOBoXIyqddeAvPuQ+dQOvv7RH5HEBrwHCOPi9bs+8TL5xc2xdCzQIPR6k
         /XPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bdIMu71RHkQyz0q/XQmi9bcwpKUTSOb4uv9ELshnrrg=;
        b=egEz5IlDYxaCwM0gxE6QFQOpKfs0rW9hzw3y28xA6kIRO42fDQWdjOdYhoncXvqNfb
         VRi0boBwOETeJZHjS41qLcO3s7S2PG0FB7sgm0+ZDpA0AjkdMdPNSYZkW7EYw/eUsSh8
         twgv6ipj857M4Ne5azMwreqXAse3DfC/9/x6+TD3ISbwbVAHuAmESsXyG7AecR58rh3i
         Kn7E/6iqmGJtlC4Z2R/KQj8AiL+UZ43bYIYenIz3AkBwa2gPv4a9bohcR6kIN/a4kc/z
         RdEAkm2+QWP6Avcw0HFH8tYAkFA3VcenP0SCpELKHcotyQdGTuP8DskHwNoAF2BL9C/v
         asyw==
X-Gm-Message-State: ABuFfohGGHdTgJClzCJ38BF2SSoHT+zRbp7TPH5Dp8GmsMgFyHLtu4NB
        8zfKBXHobDAfKnsM85wpDY++8Q==
X-Google-Smtp-Source: ACcGV61ALrxn+66qbx/HnwmpzhLsNk3ijDPj4khLZzoAOfWXhz4vaRA8VVdQZn/PYU9T5hkEFbb3WA==
X-Received: by 2002:a50:b085:: with SMTP id j5-v6mr1141226edd.294.1538637976289;
        Thu, 04 Oct 2018 00:26:16 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id m25-v6sm1247693edc.86.2018.10.04.00.26.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Oct 2018 00:26:15 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     hlitz@ucsc.edu, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: guarantee that backpointer is respected on writer stall
Date:   Thu,  4 Oct 2018 09:26:08 +0200
Message-Id: <1538637968-28032-1-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pblk's write buffer must guarantee that it respects the device's
constrains for reads (i.e., mw_cunits). This is done by maintaining a
backpointer that updates the L2P table as entries wrap up, making them
point to the media instead of pointing to the write buffer.

This mechanism can race in case that the write thread stalls, as the
write pointer will protect the last written entry, thus disregarding the
read constrains.

This patch adds an extra check on wrap up, making sure that the
threshold is respected at all times, preventing new entries to overwrite
committed data, also in case of write thread stall.

Reported-by: Heiner Litz <hlitz@ucsc.edu>
Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c | 5 +++--
 drivers/lightnvm/pblk-rb.c   | 9 +++++++--
 drivers/lightnvm/pblk.h      | 8 +++++++-
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index e3573880dbda..deaeb4649294 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -193,8 +193,9 @@ static int pblk_rwb_init(struct pblk *pblk)
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
 	unsigned long buffer_size;
-	int pgs_in_buffer;
+	int pgs_in_buffer, threshold;
 
+	threshold = geo->mw_cunits * geo->all_luns;
 	pgs_in_buffer = (max(geo->mw_cunits, geo->ws_opt) + geo->ws_opt)
 								* geo->all_luns;
 
@@ -203,7 +204,7 @@ static int pblk_rwb_init(struct pblk *pblk)
 	else
 		buffer_size = pgs_in_buffer;
 
-	return pblk_rb_init(&pblk->rwb, buffer_size, geo->csecs);
+	return pblk_rb_init(&pblk->rwb, buffer_size, threshold, geo->csecs);
 }
 
 /* Minimum pages needed within a lun */
diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index f653faa6a9ed..b1f4b51783f4 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -56,7 +56,8 @@ static unsigned int pblk_rb_calculate_size(unsigned int nr_entries)
  * allocated and their size must be a power of two
  * (Documentation/core-api/circular-buffers.rst)
  */
-int pblk_rb_init(struct pblk_rb *rb, unsigned int size, unsigned int seg_size)
+int pblk_rb_init(struct pblk_rb *rb, unsigned int size, unsigned int threshold,
+		 unsigned int seg_size)
 {
 	struct pblk *pblk = container_of(rb, struct pblk, rwb);
 	struct pblk_rb_entry *entries;
@@ -79,6 +80,7 @@ int pblk_rb_init(struct pblk_rb *rb, unsigned int size, unsigned int seg_size)
 	rb->seg_size = (1 << power_seg_sz);
 	rb->nr_entries = (1 << power_size);
 	rb->mem = rb->subm = rb->sync = rb->l2p_update = 0;
+	rb->back_thres = threshold;
 	rb->flush_point = EMPTY_ENTRY;
 
 	spin_lock_init(&rb->w_lock);
@@ -404,11 +406,14 @@ static int __pblk_rb_may_write(struct pblk_rb *rb, unsigned int nr_entries,
 {
 	unsigned int mem;
 	unsigned int sync;
+	unsigned int threshold;
 
 	sync = READ_ONCE(rb->sync);
 	mem = READ_ONCE(rb->mem);
 
-	if (pblk_rb_ring_space(rb, mem, sync, rb->nr_entries) < nr_entries)
+	threshold = nr_entries + rb->back_thres;
+
+	if (pblk_rb_ring_space(rb, mem, sync, rb->nr_entries) < threshold)
 		return 0;
 
 	if (pblk_rb_update_l2p(rb, nr_entries, mem, sync))
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 34c9c1dbeed9..c1665e39829d 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -203,6 +203,11 @@ struct pblk_rb {
 					 * will be 4KB
 					 */
 
+	unsigned int back_thres;	/* Threshold that shall be maintained by
+					 * the backpointer in order to respect
+					 * geo->mw_cunits on a per chunk basis
+					 */
+
 	struct list_head pages;		/* List of data pages */
 
 	spinlock_t w_lock;		/* Write lock */
@@ -734,7 +739,8 @@ struct pblk_line_ws {
 /*
  * pblk ring buffer operations
  */
-int pblk_rb_init(struct pblk_rb *rb, unsigned int size, unsigned int seg_sz);
+int pblk_rb_init(struct pblk_rb *rb, unsigned int size, unsigned int threshold,
+		 unsigned int seg_sz);
 int pblk_rb_may_write_user(struct pblk_rb *rb, struct bio *bio,
 			   unsigned int nr_entries, unsigned int *pos);
 int pblk_rb_may_write_gc(struct pblk_rb *rb, unsigned int nr_entries,
-- 
2.7.4

