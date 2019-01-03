Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58225C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B4D72184B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=yehs2007@zoho.com header.b="TWfhuCyn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbfACIeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 03:34:03 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25482 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfACIeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 03:34:02 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1546504437; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=YGNOU6o14I6GTVg+6WUsMMouNHQk+skca2nvf5gsnzeMJVJqw0/vGTT4i/RegKfM7hyJAhQ8nkwDsr8TQwc/CGzDnjHCUxguCYuUxAq7C+E8LvA222PlQylBK0AsA+UBC1Ei1Yvy2uJujl0jjjyfJmOca+iA1gd5jKf2F3Oqe38=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1546504437; h=Cc:Date:From:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=AaMjv5WPbSe3HlhnR3ynjCjoc6GHdluN4WYLbfJCURI=; 
        b=NDC5DcCnLwfUfGuiLebZIk6DbrXx+efEjoVclb685xkt3NAwqMDRXtfFXaHVeoreld9xOc4GP1B4QSNajRuKCdH9uJ4SrSMvHYWFqPHSP2eG2cOgDrkeklgbx+aQHCBegTar18qjKYF7XKq+kLYXmkFRdx90QQykMOUSVsQGLzc=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=yehs2007@zoho.com;
        dmarc=pass header.from=<yehs2007@zoho.com> header.from=<yehs2007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=dev3zHtJuFUgW8zYVFzvL+yScA2vb/D9ODc9fViIWbO2uRmoSEynyTFQCGQBfIQGu8ewfJhkAYMh
    nc5cQqpD147ngdudrAgsHZVLyIf2pgtj8MOsZ+dqXJd1VTpNhYBR  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1546504437;
        s=default; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id; l=2630;
        bh=AaMjv5WPbSe3HlhnR3ynjCjoc6GHdluN4WYLbfJCURI=;
        b=TWfhuCynzBwWQ/7DO9rEa9F+g0CASEK/Lecg+K2MOD4vIzS1OughjqDWh6UKwQRc
        8wWQwnP7QLLpi2GpcmYNVo8rKnbzwEEjqs43LKgoPlPHcLFIlBNYfTzAJDSp2hvJNs+
        8wihb2oMSfLZpEifPCSjNeQP6UnPJK53lMuOjfPg=
Received: from YEHS1XR956R00D1.lenovo.com (106.38.1.115 [106.38.1.115]) by mx.zohomail.com
        with SMTPS id 1546504434607730.8898948258417; Thu, 3 Jan 2019 00:33:54 -0800 (PST)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     snitzer@redhat.com
Cc:     agk@redhat.com, hch@lst.de, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, chengnt@lenovo.com,
        Huaisheng Ye <yehs1@lenovo.com>
Subject: [PATCH 1/2] dm-writecache: remove unused size to writecache_flush_region
Date:   Thu,  3 Jan 2019 16:33:46 +0800
Message-Id: <20190103083346.8732-1-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

writecache_flush_region doesn't use size to calculate flush region.
That uses _set_bits to mark the region in dirty_bitmap directly.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
---
 drivers/md/dm-writecache.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 2d50eec..2d8e0c0 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -418,7 +418,7 @@ static void writecache_flush_all_metadata(struct dm_writecache *wc)
 		memset(wc->dirty_bitmap, -1, wc->dirty_bitmap_size);
 }
 
-static void writecache_flush_region(struct dm_writecache *wc, void *ptr, size_t size)
+static void writecache_flush_region(struct dm_writecache *wc, void *ptr)
 {
 	if (!WC_MODE_PMEM(wc))
 		__set_bit(((char *)ptr - (char *)wc->memory_map) / BITMAP_GRANULARITY,
@@ -657,7 +657,7 @@ static void writecache_free_entry(struct dm_writecache *wc, struct wc_entry *e)
 	writecache_unlink(wc, e);
 	writecache_add_to_freelist(wc, e);
 	clear_seq_count(wc, e);
-	writecache_flush_region(wc, memory_entry(wc, e), sizeof(struct wc_memory_entry));
+	writecache_flush_region(wc, memory_entry(wc, e));
 	if (unlikely(waitqueue_active(&wc->freelist_wait)))
 		wake_up(&wc->freelist_wait);
 }
@@ -687,9 +687,9 @@ static void writecache_poison_lists(struct dm_writecache *wc)
 
 static void writecache_flush_entry(struct dm_writecache *wc, struct wc_entry *e)
 {
-	writecache_flush_region(wc, memory_entry(wc, e), sizeof(struct wc_memory_entry));
+	writecache_flush_region(wc, memory_entry(wc, e));
 	if (WC_MODE_PMEM(wc))
-		writecache_flush_region(wc, memory_data(wc, e), wc->block_size);
+		writecache_flush_region(wc, memory_data(wc, e));
 }
 
 static bool writecache_entry_is_committed(struct dm_writecache *wc, struct wc_entry *e)
@@ -733,7 +733,7 @@ static void writecache_flush(struct dm_writecache *wc)
 
 	wc->seq_count++;
 	pmem_assign(sb(wc)->seq_count, cpu_to_le64(wc->seq_count));
-	writecache_flush_region(wc, &sb(wc)->seq_count, sizeof sb(wc)->seq_count);
+	writecache_flush_region(wc, &sb(wc)->seq_count);
 	writecache_commit_flushed(wc);
 
 	wc->overwrote_committed = false;
@@ -1757,7 +1757,7 @@ static int init_memory(struct dm_writecache *wc)
 	writecache_flush_all_metadata(wc);
 	writecache_commit_flushed(wc);
 	pmem_assign(sb(wc)->magic, cpu_to_le32(MEMORY_SUPERBLOCK_MAGIC));
-	writecache_flush_region(wc, &sb(wc)->magic, sizeof sb(wc)->magic);
+	writecache_flush_region(wc, &sb(wc)->magic);
 	writecache_commit_flushed(wc);
 
 	return 0;
-- 
1.8.3.1


