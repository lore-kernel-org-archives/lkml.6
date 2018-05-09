Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933634AbeEIBel (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 21:34:41 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:46509 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933576AbeEIBed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 21:34:33 -0400
X-Google-Smtp-Source: AB8JxZpqB5spnt8gZ0KEnndPfFJmdEynRyjXHiQbKTGgru5xFKm2oxH3/sjfW1Ow1Z4A0H63CSS1gA==
From: Kent Overstreet <kent.overstreet@gmail.com>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@kernel.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 10/10] block: Add sysfs entry for fua support
Date: Tue,  8 May 2018 21:33:58 -0400
Message-Id: <20180509013358.16399-11-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180509013358.16399-1-kent.overstreet@gmail.com>
References: <20180509013358.16399-1-kent.overstreet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 block/blk-sysfs.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index cbea895a55..d6dd7d8198 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -497,6 +497,11 @@ static ssize_t queue_wc_store(struct request_queue *q, const char *page,
 	return count;
 }
 
+static ssize_t queue_fua_show(struct request_queue *q, char *page)
+{
+	return sprintf(page, "%u\n", test_bit(QUEUE_FLAG_FUA, &q->queue_flags));
+}
+
 static ssize_t queue_dax_show(struct request_queue *q, char *page)
 {
 	return queue_var_show(blk_queue_dax(q), page);
@@ -665,6 +670,11 @@ static struct queue_sysfs_entry queue_wc_entry = {
 	.store = queue_wc_store,
 };
 
+static struct queue_sysfs_entry queue_fua_entry = {
+	.attr = {.name = "fua", .mode = S_IRUGO },
+	.show = queue_fua_show,
+};
+
 static struct queue_sysfs_entry queue_dax_entry = {
 	.attr = {.name = "dax", .mode = S_IRUGO },
 	.show = queue_dax_show,
@@ -714,6 +724,7 @@ static struct attribute *default_attrs[] = {
 	&queue_random_entry.attr,
 	&queue_poll_entry.attr,
 	&queue_wc_entry.attr,
+	&queue_fua_entry.attr,
 	&queue_dax_entry.attr,
 	&queue_wb_lat_entry.attr,
 	&queue_poll_delay_entry.attr,
-- 
2.17.0
