Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D529C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AB8E218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j20YsKHG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbfAXVPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 16:15:49 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39942 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbfAXVPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 16:15:46 -0500
Received: by mail-pl1-f196.google.com with SMTP id u18so3470155plq.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 13:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hQMXtShjYz4LIok46DuN+DSpcNGcRKZs3McroLRrGJw=;
        b=j20YsKHGwaT+e7qtfX+pJMn7EqgnnAg98DHCtEKAcNNAthLRLG8JE/6hRv7KyQ5Iiz
         g0cQdc6pIJoSNiXlKr5WinqrLgPEyyyT3ueTy2KBOv5V7YP+cZAFTlF+rB9CIxSpQJxG
         r43vq8LUoKlLqhCQAloIuMQU+cSFgagDdDNtqJu/3gx84lgakSYZqN2brhiwObjRTIf1
         X++KVwfttX10Q5Dwj4X55d7C4wtHOvzDch/8RmJjhBu2y0rDPFeIHjbFfjE540Fv/dvd
         jBcaZipg2xsJp2QnwLiTyYtSLmwgKypskSEK4EcIDc/gjPZnGZm3zMY3OayW//GIfrhe
         DCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hQMXtShjYz4LIok46DuN+DSpcNGcRKZs3McroLRrGJw=;
        b=CSKk5rdCXhFoU3n0Amu6PIvMs/N3ApesBnKE/ak8OKhZs1HuSQ1RwIyw5evqCA2qoo
         x0bietaAqht6VZ/7fA2U3Kxml8Cb0u+HCCKDs/AMhadKn51paOp+EUCnfyZ7f7umbLZp
         Z89M0I9BG2JRXjQz38NmoIhbo+iHUK7zscIZZZ4vmS3CvaQCTCCE0j2LZFbsAdACJcjD
         KYB2fnpbic5UJOvjJpieqp6SGZcyF1fyRiHwZXcMbgdhXKLQT+Wd+D4Xn7cs6mCQUsvc
         GRXxgVc1IPzRZG4NjJOaDBbJH/nK/GuaB4quxu6jrjezfN+H9dilr0JvBakwy+kK7hK/
         3lDA==
X-Gm-Message-State: AJcUukfSY6hhORSAqlDpsPp20y0JEjFOd+yjxhzIYO2An2gKME4n76EH
        +TBfkBAXP4xh4mAw7VCaiUdWjg==
X-Google-Smtp-Source: ALg8bN7nCufI9BYh2GZ0ogHwAUMbkmGJZbvBktdzlwXxc4JpxluUrMJcb20Y/QlbwgK+in4KOP50ww==
X-Received: by 2002:a17:902:d697:: with SMTP id v23mr8003217ply.261.1548364545767;
        Thu, 24 Jan 2019 13:15:45 -0800 (PST)
Received: from surenb0.mtv.corp.google.com ([2620:0:1000:1612:3320:4357:47df:276b])
        by smtp.googlemail.com with ESMTPSA id j197sm29626418pgc.76.2019.01.24.13.15.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 13:15:45 -0800 (PST)
From:   Suren Baghdasaryan <surenb@google.com>
To:     gregkh@linuxfoundation.org
Cc:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        axboe@kernel.dk, dennis@kernel.org, dennisszhou@gmail.com,
        mingo@redhat.com, peterz@infradead.org, akpm@linux-foundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v3 2/5] kernel: cgroup: add poll file operation
Date:   Thu, 24 Jan 2019 13:15:15 -0800
Message-Id: <20190124211518.244221-3-surenb@google.com>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
In-Reply-To: <20190124211518.244221-1-surenb@google.com>
References: <20190124211518.244221-1-surenb@google.com>
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
index 8fcbae1b8db0..aad3babef007 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -32,6 +32,7 @@ struct kernfs_node;
 struct kernfs_ops;
 struct kernfs_open_file;
 struct seq_file;
+struct poll_table_struct;
 
 #define MAX_CGROUP_TYPE_NAMELEN 32
 #define MAX_CGROUP_ROOT_NAMELEN 64
@@ -574,6 +575,9 @@ struct cftype {
 	ssize_t (*write)(struct kernfs_open_file *of,
 			 char *buf, size_t nbytes, loff_t off);
 
+	__poll_t (*poll)(struct kernfs_open_file *of,
+			 struct poll_table_struct *pt);
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lock_class_key	lockdep_key;
 #endif
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index f31bd61c9466..e8cd12c6a553 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3533,6 +3533,16 @@ static ssize_t cgroup_file_write(struct kernfs_open_file *of, char *buf,
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
@@ -3571,6 +3581,7 @@ static struct kernfs_ops cgroup_kf_single_ops = {
 	.open			= cgroup_file_open,
 	.release		= cgroup_file_release,
 	.write			= cgroup_file_write,
+	.poll			= cgroup_file_poll,
 	.seq_show		= cgroup_seqfile_show,
 };
 
@@ -3579,6 +3590,7 @@ static struct kernfs_ops cgroup_kf_ops = {
 	.open			= cgroup_file_open,
 	.release		= cgroup_file_release,
 	.write			= cgroup_file_write,
+	.poll			= cgroup_file_poll,
 	.seq_start		= cgroup_seqfile_start,
 	.seq_next		= cgroup_seqfile_next,
 	.seq_stop		= cgroup_seqfile_stop,
-- 
2.20.1.321.g9e740568ce-goog

