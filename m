Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46DEC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB042086D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWV3qans"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EB042086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeIGVie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:38:34 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:37935 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbeIGVid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:38:33 -0400
Received: by mail-ua1-f65.google.com with SMTP id o11-v6so12450472uak.5;
        Fri, 07 Sep 2018 09:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iAHGcURZNbVVsKChm/fJy9d3RDB9tCJRXxWas2nNIxw=;
        b=nWV3qansOgL+FO2yVEgUoYBKu1FM9J+vHWLg4itZcn4Tu4Z+3O0YYmvEdq4uyh37VM
         lslu53KJqOOSXARFLjHTWsOsxMI9jKME3rtBSfpiDb7YNIbd74SgIGaxxib854mPln/F
         0fOWI4sw32p2v964L3Aa3gkc/jE3JaYdagiK4KUwgMnroIQ2SnInjWOEHE1Dc2ifMp15
         j0/m/LI8lkOy0SJvtwK+rV2RB/4ScCshBdWbD8UgjDwm1TMtyjE1kgCZQivJ8K+Z6Pd6
         HqEPOncE9lW0VYNzWUbVVSJqZrk0uQJ3r44X+6kuQxLoaAU/1QYJnQvr0XqIMw3TDBf1
         U1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iAHGcURZNbVVsKChm/fJy9d3RDB9tCJRXxWas2nNIxw=;
        b=qfoteAuvM6EhyTS3cZVpIvQpnoLxrRp53j5TCMIXIJScnkPHppdy4xVQLF/HmBriMp
         p+xS3JY2gOVqgevAeKEqfA0zewGCMck3gHlHUJKKXYSyMShOe4j4dfsjpBEBAIMwKu9t
         VqLL7BWBV9pJdsojJY+XS9xTyrcF+KGZIbKlnohXT/0P2QtD9n2ab5hZP3OlFdBOqJt1
         dOVQ444EzAgIjHHq1SbF/eGb5MwsdQ1GvoFRYOo8uRcsZy3cMqaDFgj5tLl7LHsxURa3
         Yz9xx8dH+KijVIaMNm69GjRFEJ5gS23bxDY5i45++ZdSGaTJSt9p++QZOd1x2sWbn2iE
         MjbQ==
X-Gm-Message-State: APzg51CAAKgNseVpvLRBCZZMGVrPQWF6WZXV4sZLzBhdK7+ofGMDDJ2/
        9zsQYDuja/NS+Rf2igL0FTaT1Kg=
X-Google-Smtp-Source: ANB0VdatuTD0VV8/Z4WU1ymKNMtyhshw/J9zD7ByOnr+y6vAapj7kXo5l7MU1oONv/ukZOAOiFBhAA==
X-Received: by 2002:ab0:9c1:: with SMTP id e1-v6mr3190280uah.125.1536339403886;
        Fri, 07 Sep 2018 09:56:43 -0700 (PDT)
Received: from localhost.localdomain (c-71-234-172-214.hsd1.vt.comcast.net. [71.234.172.214])
        by smtp.gmail.com with ESMTPSA id q202-v6sm1039619vke.53.2018.09.07.09.56.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 09:56:42 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org
Subject: [PATCH 2/6] md: convert to kvmalloc
Date:   Fri,  7 Sep 2018 12:56:31 -0400
Message-Id: <20180907165635.8469-3-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.19.0.rc2
In-Reply-To: <20180907165635.8469-1-kent.overstreet@gmail.com>
References: <20180907165635.8469-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code really just wants a big flat buffer, so just do that.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Shaohua Li <shli@kernel.org>
Cc: linux-raid@vger.kernel.org
---
 drivers/md/raid5-ppl.c |  7 ++--
 drivers/md/raid5.c     | 82 +++++++++++++++++++-----------------------
 drivers/md/raid5.h     |  9 ++---
 3 files changed, 45 insertions(+), 53 deletions(-)

diff --git a/drivers/md/raid5-ppl.c b/drivers/md/raid5-ppl.c
index 3a7c363265..5911810101 100644
--- a/drivers/md/raid5-ppl.c
+++ b/drivers/md/raid5-ppl.c
@@ -16,7 +16,6 @@
 #include <linux/blkdev.h>
 #include <linux/slab.h>
 #include <linux/crc32c.h>
-#include <linux/flex_array.h>
 #include <linux/async_tx.h>
 #include <linux/raid/md_p.h>
 #include "md.h"
@@ -165,7 +164,7 @@ ops_run_partial_parity(struct stripe_head *sh, struct raid5_percpu *percpu,
 		       struct dma_async_tx_descriptor *tx)
 {
 	int disks = sh->disks;
-	struct page **srcs = flex_array_get(percpu->scribble, 0);
+	struct page **srcs = percpu->scribble;
 	int count = 0, pd_idx = sh->pd_idx, i;
 	struct async_submit_ctl submit;
 
@@ -196,8 +195,8 @@ ops_run_partial_parity(struct stripe_head *sh, struct raid5_percpu *percpu,
 	}
 
 	init_async_submit(&submit, ASYNC_TX_FENCE|ASYNC_TX_XOR_ZERO_DST, tx,
-			  NULL, sh, flex_array_get(percpu->scribble, 0)
-			  + sizeof(struct page *) * (sh->disks + 2));
+			  NULL, sh, percpu->scribble +
+			  sizeof(struct page *) * (sh->disks + 2));
 
 	if (count == 1)
 		tx = async_memcpy(sh->ppl_page, srcs[0], 0, 0, PAGE_SIZE,
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 2031506a0e..d5603946dc 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -54,7 +54,6 @@
 #include <linux/slab.h>
 #include <linux/ratelimit.h>
 #include <linux/nodemask.h>
-#include <linux/flex_array.h>
 
 #include <trace/events/block.h>
 #include <linux/list_sort.h>
@@ -1399,19 +1398,14 @@ static void ops_complete_compute(void *stripe_head_ref)
 static addr_conv_t *to_addr_conv(struct stripe_head *sh,
 				 struct raid5_percpu *percpu, int i)
 {
-	void *addr;
-
-	addr = flex_array_get(percpu->scribble, i);
-	return addr + sizeof(struct page *) * (sh->disks + 2);
+	return percpu->scribble + i * percpu->scribble_obj_size +
+		sizeof(struct page *) * (sh->disks + 2);
 }
 
 /* return a pointer to the address conversion region of the scribble buffer */
 static struct page **to_addr_page(struct raid5_percpu *percpu, int i)
 {
-	void *addr;
-
-	addr = flex_array_get(percpu->scribble, i);
-	return addr;
+	return percpu->scribble + i * percpu->scribble_obj_size;
 }
 
 static struct dma_async_tx_descriptor *
@@ -2240,21 +2234,23 @@ static int grow_stripes(struct r5conf *conf, int num)
  * calculate over all devices (not just the data blocks), using zeros in place
  * of the P and Q blocks.
  */
-static struct flex_array *scribble_alloc(int num, int cnt, gfp_t flags)
+static int scribble_alloc(struct raid5_percpu *percpu,
+			  int num, int cnt, gfp_t flags)
 {
-	struct flex_array *ret;
-	size_t len;
+	size_t obj_size =
+		sizeof(struct page *) * (num+2) +
+		sizeof(addr_conv_t) * (num+2);
+	void *scribble;
 
-	len = sizeof(struct page *) * (num+2) + sizeof(addr_conv_t) * (num+2);
-	ret = flex_array_alloc(len, cnt, flags);
-	if (!ret)
-		return NULL;
-	/* always prealloc all elements, so no locking is required */
-	if (flex_array_prealloc(ret, 0, cnt, flags)) {
-		flex_array_free(ret);
-		return NULL;
-	}
-	return ret;
+	scribble = kvmalloc_array(cnt, obj_size, flags);
+	if (!scribble)
+		return -ENOMEM;
+
+	kvfree(percpu->scribble);
+
+	percpu->scribble = scribble;
+	percpu->scribble_obj_size = obj_size;
+	return 0;
 }
 
 static int resize_chunks(struct r5conf *conf, int new_disks, int new_sectors)
@@ -2272,23 +2268,18 @@ static int resize_chunks(struct r5conf *conf, int new_disks, int new_sectors)
 		return 0;
 	mddev_suspend(conf->mddev);
 	get_online_cpus();
+
 	for_each_present_cpu(cpu) {
 		struct raid5_percpu *percpu;
-		struct flex_array *scribble;
 
 		percpu = per_cpu_ptr(conf->percpu, cpu);
-		scribble = scribble_alloc(new_disks,
-					  new_sectors / STRIPE_SECTORS,
-					  GFP_NOIO);
-
-		if (scribble) {
-			flex_array_free(percpu->scribble);
-			percpu->scribble = scribble;
-		} else {
-			err = -ENOMEM;
+		err = scribble_alloc(percpu, new_disks,
+				     new_sectors / STRIPE_SECTORS,
+				     GFP_NOIO);
+		if (err)
 			break;
-		}
 	}
+
 	put_online_cpus();
 	mddev_resume(conf->mddev);
 	if (!err) {
@@ -6722,25 +6713,26 @@ raid5_size(struct mddev *mddev, sector_t sectors, int raid_disks)
 static void free_scratch_buffer(struct r5conf *conf, struct raid5_percpu *percpu)
 {
 	safe_put_page(percpu->spare_page);
-	if (percpu->scribble)
-		flex_array_free(percpu->scribble);
 	percpu->spare_page = NULL;
+	kvfree(percpu->scribble);
 	percpu->scribble = NULL;
 }
 
 static int alloc_scratch_buffer(struct r5conf *conf, struct raid5_percpu *percpu)
 {
-	if (conf->level == 6 && !percpu->spare_page)
+	if (conf->level == 6 && !percpu->spare_page) {
 		percpu->spare_page = alloc_page(GFP_KERNEL);
-	if (!percpu->scribble)
-		percpu->scribble = scribble_alloc(max(conf->raid_disks,
-						      conf->previous_raid_disks),
-						  max(conf->chunk_sectors,
-						      conf->prev_chunk_sectors)
-						   / STRIPE_SECTORS,
-						  GFP_KERNEL);
-
-	if (!percpu->scribble || (conf->level == 6 && !percpu->spare_page)) {
+		if (!percpu->spare_page)
+			return -ENOMEM;
+	}
+
+	if (scribble_alloc(percpu,
+			   max(conf->raid_disks,
+			       conf->previous_raid_disks),
+			   max(conf->chunk_sectors,
+			       conf->prev_chunk_sectors)
+			   / STRIPE_SECTORS,
+			   GFP_KERNEL)) {
 		free_scratch_buffer(conf, percpu);
 		return -ENOMEM;
 	}
diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index 8474c22412..cf991f1340 100644
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -638,10 +638,11 @@ struct r5conf {
 	/* per cpu variables */
 	struct raid5_percpu {
 		struct page	*spare_page; /* Used when checking P/Q in raid6 */
-		struct flex_array *scribble;   /* space for constructing buffer
-					      * lists and performing address
-					      * conversions
-					      */
+		void		*scribble;  /* space for constructing buffer
+					     * lists and performing address
+					     * conversions
+					     */
+		int scribble_obj_size;
 	} __percpu *percpu;
 	int scribble_disks;
 	int scribble_sectors;
-- 
2.19.0.rc2

