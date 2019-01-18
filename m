Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38383C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3FD20657
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wtk0C9C7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbfARTca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 14:32:30 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41076 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbfARTc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 14:32:29 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so16404836wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 11:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JEy6vjUwhMLY3IDrSmGc5CQ9J4/ajqDzpGdw0oSmYls=;
        b=Wtk0C9C7zcqFZiXFyedpdWSQB2zm3IIf0MMzxbZcdaEsPIuX2Oj6qa45ZzF1VB4tf5
         HKlOd4h644Pehj1+nafIIo/Yvplhw0V7hJ8lnyT2+RyebvcqsHy/IdBUSF9rEe0OkZzg
         G8in9lXC7VgCjJ+E5Ag85NcRt6pElIv8+whOd8iGCyZizCR/HP3jbxgoEn2XIh/MwzYK
         pKhtPZ/O5MsA1aJvktgUaPrLe+vHiHLXSlBC7tZynhBawX40El9u9sUBQM9kJyOELWHk
         t2A81x6hg5nljNgpeBFkTRE1k82tNmGNdHWQ2DcDOhuTPGOhzXMOJObwaZGMP/lgMlvE
         z4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=JEy6vjUwhMLY3IDrSmGc5CQ9J4/ajqDzpGdw0oSmYls=;
        b=q9V1SP9AbBMIN+ciPWFrV+G1nyKHC48UsXkdkJlMA6M136HQvUzVgiEcyEGRflDoke
         ipmx8Sb8YKqBI1QqVFFTKC/fPu4JUElfg5QoqoqrGAqwwCqYwUGdnH+2LdqXXJUeLgXK
         fdDTi986BVkRTHBewnVQR0y9oXh4/tXOgm8HknKlLoacGipkEoewEfXEA9PZoddeT+9A
         Ma37IM79ZnxZCV/PG1VT+OVUWtF+C7tKb3xcPw8wYb3iiDx+BfnuGjZUmVvo5hygZOfL
         Qjr3kW4oVKU+ruH6ZAkXRCWRSzbyAEONXKZuLx6Sbc63bgww39gFX6v6yvecXIWPU0XY
         D1Pg==
X-Gm-Message-State: AJcUukct5G6d8wGKNwaT+yb2ml4mdlEnrQ1IKWMz6dEEPU5GJHrPP6CX
        uvdlMx2Gr7Zosdf0WLnUylk=
X-Google-Smtp-Source: ALg8bN5HI/qQMYkrHaZldQ9b2L/gPh4JuIorQ7YNqjDBDaIuKGS/ud1QZqqbtRTHeIymLBlhrF5tqQ==
X-Received: by 2002:adf:e8c1:: with SMTP id k1mr17035130wrn.104.1547839947269;
        Fri, 18 Jan 2019 11:32:27 -0800 (PST)
Received: from macbookpro.malat.net ([2a01:e34:ee1e:860:6f23:82e6:aa2d:bbd1])
        by smtp.gmail.com with ESMTPSA id q14sm69628358wrw.39.2019.01.18.11.32.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 11:32:25 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 2E4E01142393; Fri, 18 Jan 2019 20:32:24 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] writeback: tracing: Copy only up to 31 characters in strncpy() calls
Date:   Fri, 18 Jan 2019 20:32:00 +0100
Message-Id: <20190118193200.32691-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the past an attempt was made to remove a set of warnings triggered by
gcc 8.x and W=1 by changing calls to strncpy() into strlcpy(). This was
rejected as one of the desired behavior is to keep initializing the rest
of the destination string whenever the source string is less than the
size.

However the code makes it clear that this is not a desired behavior to
copy the entire 32 characters into the destination buffer, since it is
expected that the string is NUL terminated. So change the maximum number
of characters to be copied to be the size of the destination buffer
minus 1.

Break long lines and make this patch go through `checkpatch --strict` with
no errors.

This commit removes the following warnings:

  include/trace/events/writeback.h:69:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
  include/trace/events/writeback.h:99:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
  include/trace/events/writeback.h:179:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
  include/trace/events/writeback.h:223:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
  include/trace/events/writeback.h:277:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
  include/trace/events/writeback.h:299:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
  include/trace/events/writeback.h:324:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
  include/trace/events/writeback.h:375:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
  include/trace/events/writeback.h:586:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
  include/trace/events/writeback.h:660:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]

Cc: Nick Desaulniers <nick.desaulniers@gmail.com>
Link: https://lore.kernel.org/patchwork/patch/910830/
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 include/trace/events/writeback.h | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 32db72c7c055..7bc58980f84f 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -67,7 +67,8 @@ TRACE_EVENT(writeback_dirty_page,
 
 	TP_fast_assign(
 		strncpy(__entry->name,
-			mapping ? dev_name(inode_to_bdi(mapping->host)->dev) : "(unknown)", 32);
+			mapping ? dev_name(inode_to_bdi(mapping->host)->dev) :
+			"(unknown)", sizeof(__entry->name) - 1);
 		__entry->ino = mapping ? mapping->host->i_ino : 0;
 		__entry->index = page->index;
 	),
@@ -97,7 +98,8 @@ DECLARE_EVENT_CLASS(writeback_dirty_inode_template,
 
 		/* may be called for files on pseudo FSes w/ unregistered bdi */
 		strncpy(__entry->name,
-			bdi->dev ? dev_name(bdi->dev) : "(unknown)", 32);
+			bdi->dev ? dev_name(bdi->dev) : "(unknown)",
+			sizeof(__entry->name) - 1);
 		__entry->ino		= inode->i_ino;
 		__entry->state		= inode->i_state;
 		__entry->flags		= flags;
@@ -177,7 +179,8 @@ DECLARE_EVENT_CLASS(writeback_write_inode_template,
 
 	TP_fast_assign(
 		strncpy(__entry->name,
-			dev_name(inode_to_bdi(inode)->dev), 32);
+			dev_name(inode_to_bdi(inode)->dev),
+			sizeof(__entry->name) - 1);
 		__entry->ino		= inode->i_ino;
 		__entry->sync_mode	= wbc->sync_mode;
 		__entry->cgroup_ino	= __trace_wbc_assign_cgroup(wbc);
@@ -221,7 +224,8 @@ DECLARE_EVENT_CLASS(writeback_work_class,
 	),
 	TP_fast_assign(
 		strncpy(__entry->name,
-			wb->bdi->dev ? dev_name(wb->bdi->dev) : "(unknown)", 32);
+			wb->bdi->dev ? dev_name(wb->bdi->dev) : "(unknown)",
+			sizeof(__entry->name) - 1);
 		__entry->nr_pages = work->nr_pages;
 		__entry->sb_dev = work->sb ? work->sb->s_dev : 0;
 		__entry->sync_mode = work->sync_mode;
@@ -274,7 +278,8 @@ DECLARE_EVENT_CLASS(writeback_class,
 		__field(unsigned int, cgroup_ino)
 	),
 	TP_fast_assign(
-		strncpy(__entry->name, dev_name(wb->bdi->dev), 32);
+		strncpy(__entry->name, dev_name(wb->bdi->dev),
+			sizeof(__entry->name) - 1);
 		__entry->cgroup_ino = __trace_wb_assign_cgroup(wb);
 	),
 	TP_printk("bdi %s: cgroup_ino=%u",
@@ -296,7 +301,8 @@ TRACE_EVENT(writeback_bdi_register,
 		__array(char, name, 32)
 	),
 	TP_fast_assign(
-		strncpy(__entry->name, dev_name(bdi->dev), 32);
+		strncpy(__entry->name, dev_name(bdi->dev),
+			sizeof(__entry->name) - 1);
 	),
 	TP_printk("bdi %s",
 		__entry->name
@@ -321,7 +327,8 @@ DECLARE_EVENT_CLASS(wbc_class,
 	),
 
 	TP_fast_assign(
-		strncpy(__entry->name, dev_name(bdi->dev), 32);
+		strncpy(__entry->name, dev_name(bdi->dev),
+			sizeof(__entry->name) - 1);
 		__entry->nr_to_write	= wbc->nr_to_write;
 		__entry->pages_skipped	= wbc->pages_skipped;
 		__entry->sync_mode	= wbc->sync_mode;
@@ -372,7 +379,8 @@ TRACE_EVENT(writeback_queue_io,
 	),
 	TP_fast_assign(
 		unsigned long *older_than_this = work->older_than_this;
-		strncpy(__entry->name, dev_name(wb->bdi->dev), 32);
+		strncpy(__entry->name, dev_name(wb->bdi->dev),
+			sizeof(__entry->name) - 1);
 		__entry->older	= older_than_this ?  *older_than_this : 0;
 		__entry->age	= older_than_this ?
 				  (jiffies - *older_than_this) * 1000 / HZ : -1;
@@ -584,7 +592,8 @@ TRACE_EVENT(writeback_sb_inodes_requeue,
 
 	TP_fast_assign(
 		strncpy(__entry->name,
-		        dev_name(inode_to_bdi(inode)->dev), 32);
+			dev_name(inode_to_bdi(inode)->dev),
+			sizeof(__entry->name) - 1);
 		__entry->ino		= inode->i_ino;
 		__entry->state		= inode->i_state;
 		__entry->dirtied_when	= inode->dirtied_when;
@@ -658,7 +667,8 @@ DECLARE_EVENT_CLASS(writeback_single_inode_template,
 
 	TP_fast_assign(
 		strncpy(__entry->name,
-			dev_name(inode_to_bdi(inode)->dev), 32);
+			dev_name(inode_to_bdi(inode)->dev),
+			sizeof(__entry->name) - 1);
 		__entry->ino		= inode->i_ino;
 		__entry->state		= inode->i_state;
 		__entry->dirtied_when	= inode->dirtied_when;
-- 
2.19.2

