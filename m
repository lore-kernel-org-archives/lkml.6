Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFA9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C5C206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qtqDt0yW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730374AbeLNRQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:16:18 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35282 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730359AbeLNRQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:16:17 -0500
Received: by mail-pg1-f194.google.com with SMTP id s198so2987756pgs.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 09:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sCRWYoNU0VkVJ/z3jhqejq2doYZrQjVc/bE8fLkqY2M=;
        b=qtqDt0yWn90HRTU+TjV+hv+Nm4vyH6Oihs6UoQLIHJzjQGDbObJpGMIW9v+FkBaVLR
         Uj8Mr9R6Rg0Sz1w7z3mYjuvKfxqj1KpIz5MHIF71R3JSGS6DuFPN+gh6/j1qi+lTThBZ
         bUtMX2GGllNQNpMM1hWDtA8Jb3e/DqguXh/VMkUbYokl1bHIab0fSzpccYMg5XIsFgtL
         cwNrvkofLgF/3zHa+CdOYBv8XhaIjPY6MX6VtZTlE9YX5+0piu/xcN/kY9kPUOGsU1hx
         /NMZB+XqLjN8gHVlZLBzkM9TnJZ0KARCM0+BSoqoytH9MUyVZtILnhGsikxNDrCX2BIa
         cXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sCRWYoNU0VkVJ/z3jhqejq2doYZrQjVc/bE8fLkqY2M=;
        b=byNz5ZegbR9UNEKixEULG2L9cZC1+wm4462AiDJUQawGzLSCehpcPJrXpYYn+rmxJX
         1a8ucDfjj+IUPHXnwSnsoRZKenq/uNGrLaeY3x0193OwVJoiXDbGwHZ6KdCEz4i0Nhoz
         Mbe3k5B6zPkYxey+8ZaGBLUVGlnrLvJd/zCgCdw9ardzGNjf7Vk6zr+OyMg+HPnXloa2
         3mrGcVaEnFYlYyhotr72n2d2o1ZRW8Jq+2LaMmLrowlMEulYck2ck5HllpV5KlxGY7HS
         1iWpRd0/2dFYMIRKwfZTLhYHXCyOarfi3xvbyPGupKFXdEI9BJkLlzRt82GzhYf5fM6d
         6yJA==
X-Gm-Message-State: AA+aEWbFybmfnidxZzRR390k3F55BwcpM7zlmk/Q79yhTmV0qmJ6WceY
        rKMXR716cxXnyz/Q7baU7IBiYA==
X-Google-Smtp-Source: AFSGD/WwBkLtx/2+rsJz8EKva+zOAw3UYuj7OIEVEXnn41gItTDoWAgGJfWYfZ3NqfogZ0YiSy18Ow==
X-Received: by 2002:a63:b34f:: with SMTP id x15mr3471723pgt.243.1544807776049;
        Fri, 14 Dec 2018 09:16:16 -0800 (PST)
Received: from surenb0.mtv.corp.google.com ([2620:0:1000:1612:3320:4357:47df:276b])
        by smtp.googlemail.com with ESMTPSA id g185sm7605761pfc.174.2018.12.14.09.16.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 09:16:14 -0800 (PST)
From:   Suren Baghdasaryan <surenb@google.com>
To:     gregkh@linuxfoundation.org
Cc:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        axboe@kernel.dk, dennis@kernel.org, dennisszhou@gmail.com,
        mingo@redhat.com, peterz@infradead.org, akpm@linux-foundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH 2/6] kernel: cgroup: add poll file operation
Date:   Fri, 14 Dec 2018 09:15:04 -0800
Message-Id: <20181214171508.7791-3-surenb@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
In-Reply-To: <20181214171508.7791-1-surenb@google.com>
References: <20181214171508.7791-1-surenb@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Weiner <hannes@cmpxchg.org>

Cgroup has a standardized poll/notification mechanism for waking all
pollers on all fds when a filesystem node changes. To allow polling
for custom events, add a .poll callback that can override the default.

This is in preparation for pollable cgroup pressure files which have
per-fd trigger configurations.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/cgroup-defs.h |  4 ++++
 kernel/cgroup/cgroup.c      | 12 ++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 5e1694fe035b..6f9ea8601421 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -32,6 +32,7 @@ struct kernfs_node;
 struct kernfs_ops;
 struct kernfs_open_file;
 struct seq_file;
+struct poll_table_struct;
 
 #define MAX_CGROUP_TYPE_NAMELEN 32
 #define MAX_CGROUP_ROOT_NAMELEN 64
@@ -573,6 +574,9 @@ struct cftype {
 	ssize_t (*write)(struct kernfs_open_file *of,
 			 char *buf, size_t nbytes, loff_t off);
 
+	__poll_t (*poll)(struct kernfs_open_file *of,
+			 struct poll_table_struct *pt);
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lock_class_key	lockdep_key;
 #endif
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 6aaf5dd5383b..ffcd7483b8ee 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3499,6 +3499,16 @@ static ssize_t cgroup_file_write(struct kernfs_open_file *of, char *buf,
 	return ret ?: nbytes;
 }
 
+static __poll_t cgroup_file_poll(struct kernfs_open_file *of, poll_table *pt)
+{
+	struct cftype *cft = of->kn->priv;
+
+	if (cft->poll)
+		return cft->poll(of, pt);
+
+	return kernfs_generic_poll(of, pt);
+}
+
 static void *cgroup_seqfile_start(struct seq_file *seq, loff_t *ppos)
 {
 	return seq_cft(seq)->seq_start(seq, ppos);
@@ -3537,6 +3547,7 @@ static struct kernfs_ops cgroup_kf_single_ops = {
 	.open			= cgroup_file_open,
 	.release		= cgroup_file_release,
 	.write			= cgroup_file_write,
+	.poll			= cgroup_file_poll,
 	.seq_show		= cgroup_seqfile_show,
 };
 
@@ -3545,6 +3556,7 @@ static struct kernfs_ops cgroup_kf_ops = {
 	.open			= cgroup_file_open,
 	.release		= cgroup_file_release,
 	.write			= cgroup_file_write,
+	.poll			= cgroup_file_poll,
 	.seq_start		= cgroup_seqfile_start,
 	.seq_next		= cgroup_seqfile_next,
 	.seq_stop		= cgroup_seqfile_stop,
-- 
2.20.0.405.gbc1bbc6f85-goog

