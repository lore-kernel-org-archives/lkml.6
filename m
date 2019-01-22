Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974D1C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657E920870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfAVWIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 17:08:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41634 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbfAVWIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 17:08:30 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BD2C537E88;
        Tue, 22 Jan 2019 22:08:29 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-14.phx2.redhat.com [10.3.112.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB6F162525;
        Tue, 22 Jan 2019 22:08:27 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>
Cc:     Eric Paris <eparis@redhat.com>, Steve Grubb <sgrubb@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak105 V1 1/2] audit: clean up AUDITSYSCALL prototypes and stubs
Date:   Tue, 22 Jan 2019 17:07:41 -0500
Message-Id: <782bf5adb2b08369b9f98d3283c520847ea315a1.1548192740.git.rgb@redhat.com>
In-Reply-To: <cover.1548192740.git.rgb@redhat.com>
References: <cover.1548192740.git.rgb@redhat.com>
In-Reply-To: <cover.1548192740.git.rgb@redhat.com>
References: <cover.1548192740.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 22 Jan 2019 22:08:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pull together all the audit syscall watch, mark and tree prototypes and
stubs into the same ifdef.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/audit.h | 64 ++++++++++++++++++++++++++++++----------------------------
 1 file changed, 33 insertions(+), 31 deletions(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index 6ffb70575082..22ef49b76daa 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -267,25 +267,47 @@ extern void audit_log_d_path_exe(struct audit_buffer *ab,
 extern struct tty_struct *audit_get_tty(void);
 extern void audit_put_tty(struct tty_struct *tty);
 
-/* audit watch functions */
+/* audit watch/mark/tree functions */
 #ifdef CONFIG_AUDITSYSCALL
 extern void audit_put_watch(struct audit_watch *watch);
 extern void audit_get_watch(struct audit_watch *watch);
-extern int audit_to_watch(struct audit_krule *krule, char *path, int len, u32 op);
+extern int audit_to_watch(struct audit_krule *krule, char *path, int len,
+			  u32 op);
 extern int audit_add_watch(struct audit_krule *krule, struct list_head **list);
 extern void audit_remove_watch_rule(struct audit_krule *krule);
 extern char *audit_watch_path(struct audit_watch *watch);
-extern int audit_watch_compare(struct audit_watch *watch, unsigned long ino, dev_t dev);
+extern int audit_watch_compare(struct audit_watch *watch, unsigned long ino,
+			       dev_t dev);
 
-extern struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pathname, int len);
+extern struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule,
+						    char *pathname, int len);
 extern char *audit_mark_path(struct audit_fsnotify_mark *mark);
 extern void audit_remove_mark(struct audit_fsnotify_mark *audit_mark);
 extern void audit_remove_mark_rule(struct audit_krule *krule);
-extern int audit_mark_compare(struct audit_fsnotify_mark *mark, unsigned long ino, dev_t dev);
+extern int audit_mark_compare(struct audit_fsnotify_mark *mark,
+			      unsigned long ino, dev_t dev);
 extern int audit_dupe_exe(struct audit_krule *new, struct audit_krule *old);
-extern int audit_exe_compare(struct task_struct *tsk, struct audit_fsnotify_mark *mark);
+extern int audit_exe_compare(struct task_struct *tsk,
+			     struct audit_fsnotify_mark *mark);
 
-#else
+extern struct audit_chunk *audit_tree_lookup(const struct inode *inode);
+extern void audit_put_chunk(struct audit_chunk *chunk);
+extern bool audit_tree_match(struct audit_chunk *chunk,
+			     struct audit_tree *tree);
+extern int audit_make_tree(struct audit_krule *rule, char *pathname, u32 op);
+extern int audit_add_tree_rule(struct audit_krule *rule);
+extern int audit_remove_tree_rule(struct audit_krule *rule);
+extern void audit_trim_trees(void);
+extern int audit_tag_tree(char *old, char *new);
+extern const char *audit_tree_path(struct audit_tree *tree);
+extern void audit_put_tree(struct audit_tree *tree);
+extern void audit_kill_trees(struct audit_context *context);
+
+extern int audit_signal_info(int sig, struct task_struct *t);
+extern void audit_filter_inodes(struct task_struct *tsk,
+				struct audit_context *ctx);
+extern struct list_head *audit_killed_trees(void);
+#else /* CONFIG_AUDITSYSCALL */
 #define audit_put_watch(w) {}
 #define audit_get_watch(w) {}
 #define audit_to_watch(k, p, l, o) (-EINVAL)
@@ -301,21 +323,7 @@ extern void audit_log_d_path_exe(struct audit_buffer *ab,
 #define audit_mark_compare(m, i, d) 0
 #define audit_exe_compare(t, m) (-EINVAL)
 #define audit_dupe_exe(n, o) (-EINVAL)
-#endif /* CONFIG_AUDITSYSCALL */
 
-#ifdef CONFIG_AUDITSYSCALL
-extern struct audit_chunk *audit_tree_lookup(const struct inode *inode);
-extern void audit_put_chunk(struct audit_chunk *chunk);
-extern bool audit_tree_match(struct audit_chunk *chunk, struct audit_tree *tree);
-extern int audit_make_tree(struct audit_krule *rule, char *pathname, u32 op);
-extern int audit_add_tree_rule(struct audit_krule *rule);
-extern int audit_remove_tree_rule(struct audit_krule *rule);
-extern void audit_trim_trees(void);
-extern int audit_tag_tree(char *old, char *new);
-extern const char *audit_tree_path(struct audit_tree *tree);
-extern void audit_put_tree(struct audit_tree *tree);
-extern void audit_kill_trees(struct audit_context *context);
-#else
 #define audit_remove_tree_rule(rule) BUG()
 #define audit_add_tree_rule(rule) -EINVAL
 #define audit_make_tree(rule, str, op) -EINVAL
@@ -324,7 +332,10 @@ extern void audit_log_d_path_exe(struct audit_buffer *ab,
 #define audit_tag_tree(old, new) -EINVAL
 #define audit_tree_path(rule) ""	/* never called */
 #define audit_kill_trees(context) BUG()
-#endif
+
+#define audit_signal_info(s, t) AUDIT_DISABLED
+#define audit_filter_inodes(t, c) AUDIT_DISABLED
+#endif /* CONFIG_AUDITSYSCALL */
 
 extern char *audit_unpack_string(void **bufp, size_t *remain, size_t len);
 
@@ -334,14 +345,5 @@ extern void audit_log_d_path_exe(struct audit_buffer *ab,
 
 extern int audit_filter(int msgtype, unsigned int listtype);
 
-#ifdef CONFIG_AUDITSYSCALL
-extern int audit_signal_info(int sig, struct task_struct *t);
-extern void audit_filter_inodes(struct task_struct *tsk, struct audit_context *ctx);
-extern struct list_head *audit_killed_trees(void);
-#else
-#define audit_signal_info(s,t) AUDIT_DISABLED
-#define audit_filter_inodes(t,c) AUDIT_DISABLED
-#endif
-
 extern void audit_ctl_lock(void);
 extern void audit_ctl_unlock(void);
-- 
1.8.3.1

