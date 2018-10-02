Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9452DC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1F7206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1F7206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbeJBRER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 13:04:17 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:36345 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbeJBRER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 13:04:17 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MryCb-1fLtpz0K9t-00nyyp; Tue, 02 Oct 2018 12:21:02 +0200
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MryCb-1fLtpz0K9t-00nyyp; Tue, 02 Oct 2018 12:21:02 +0200
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Andrei Vagin <avagin@openvz.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Laurent Vivier <laurent@vivier.eu>
Subject: [RFC v2 v2 1/1] ns: add binfmt_misc to the mount namespace
Date:   Tue,  2 Oct 2018 12:20:54 +0200
Message-Id: <20181002102054.13245-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181002102054.13245-1-laurent@vivier.eu>
References: <20181002102054.13245-1-laurent@vivier.eu>
X-Provags-ID: V03:K1:slzPAs5FR0m6kno6KEb/tSCGFOgAG9cOUBUi/VxqlYN9GsNgaeu
 BGQ7LeB1Fn0tE6cB71ZVwf0hakJllSgH4WiBXTnfMj9ZB8fsDeSGz5Fhpywsz4ehTfTuB19
 2rF6yi5S3GVNdBTtjEMMsGWunEADOU2dee91WFIcQGyqHIGbC8x4MHnqpZFT2LncRd++q48
 KqWHQIDIs3YDGo3Ed3iTA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2bUjj1/TDxA=:WE0SUVwPxZzElAy/6jb0qJ
 mrqBcqa9SqGf30gF7bvuzLZzFCXv1W7a0wMS3bNZIwZio53PVK1StbZvPIEVGUK1ua+whkrhL
 lOCeD3toXXjYeFVXiVWdKg8RVUdN7EflgzUJkq3gaGs8cI6ccD7HpqhfkeAoMVG86sq460CjV
 bGjYzUc3UWgZwUJNGFYrfDc9NOf6wur9oSPZKEvoNum24paLZO8KKx+2pyeFijGvHDGWqnf2M
 0VxBDe1RuK/CokcyDDQHrdm2aFFIr5hvEaQ4jU2aL0ac50W5fVnCNCLqjdnA+/3Cf7jO75Ma7
 UhGko8l6Mq1zoAP+LQ93P3inGxtmSsmCL9NJ7tCNsliaaCV7LVTeDvr1KwLrKeRc5mSr+1tCw
 5K0HMKxarLrIW9Bo0X4CJR+jB15Da69k0xcbGlC5cfB78mTPe6FrAxM05xb/qeDYVM+FB9z0D
 zD/pruYTaK+2CrUMlQQfL7g7qSEzMr0J7xu7MvH2O4hl2jFoCd+EOmWq181YCKX97c8VR4SGk
 4goB0GmLeCmD3hlsMP017nQaT+ucOlqW8Vl/4Q3j7oLbrUEi+UWluLn3FrmodxIHJ9otWa9II
 +eTmkH+t13JyZUQeXV9uP13Z/KQr23x40spcPSf6/YLWcK2DCNHu/q83TCrVenkoVhQMhLCGF
 2xgr344vz87nUNOboJmwVUrnV2Wnw7RTLXLn1jgP5hAAB3WaB9q/rT63+LbFuDocW+Uw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows to have a different binftm_misc configuration
in each container we mount binfmt_misc filesystem with mount namespace
enabled.

A container started without the CLONE_NEWNS will use the host binfmt_misc
configuration, otherwise the container starts with an empty binfmt_misc
interpreters list.

For instance, using "unshare" we can start a chroot of an another
architecture and configure the binfmt_misc interpreted without being root
to run the binaries in this chroot.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 fs/binfmt_misc.c | 50 +++++++++++++++++++++++++-----------------------
 fs/mount.h       |  8 ++++++++
 fs/namespace.c   |  6 ++++++
 3 files changed, 40 insertions(+), 24 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index aa4a7a23ff99..ecb14776c759 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -25,6 +25,7 @@
 #include <linux/syscalls.h>
 #include <linux/fs.h>
 #include <linux/uaccess.h>
+#include <mount.h>
 
 #include "internal.h"
 
@@ -38,9 +39,6 @@ enum {
 	VERBOSE_STATUS = 1 /* make it zero to save 400 bytes kernel memory */
 };
 
-static LIST_HEAD(entries);
-static int enabled = 1;
-
 enum {Enabled, Magic};
 #define MISC_FMT_PRESERVE_ARGV0 (1 << 31)
 #define MISC_FMT_OPEN_BINARY (1 << 30)
@@ -60,10 +58,7 @@ typedef struct {
 	struct file *interp_file;
 } Node;
 
-static DEFINE_RWLOCK(entries_lock);
 static struct file_system_type bm_fs_type;
-static struct vfsmount *bm_mnt;
-static int entry_count;
 
 /*
  * Max length of the register string.  Determined by:
@@ -91,7 +86,7 @@ static Node *check_file(struct linux_binprm *bprm)
 	struct list_head *l;
 
 	/* Walk all the registered handlers. */
-	list_for_each(l, &entries) {
+	list_for_each(l, &binfmt_ns(entries)) {
 		Node *e = list_entry(l, Node, list);
 		char *s;
 		int j;
@@ -135,15 +130,15 @@ static int load_misc_binary(struct linux_binprm *bprm)
 	int fd_binary = -1;
 
 	retval = -ENOEXEC;
-	if (!enabled)
+	if (!binfmt_ns(enabled))
 		return retval;
 
 	/* to keep locking time low, we copy the interpreter string */
-	read_lock(&entries_lock);
+	read_lock(&binfmt_ns(entries_lock));
 	fmt = check_file(bprm);
 	if (fmt)
 		dget(fmt->dentry);
-	read_unlock(&entries_lock);
+	read_unlock(&binfmt_ns(entries_lock));
 	if (!fmt)
 		return retval;
 
@@ -613,15 +608,15 @@ static void kill_node(Node *e)
 {
 	struct dentry *dentry;
 
-	write_lock(&entries_lock);
+	write_lock(&binfmt_ns(entries_lock));
 	list_del_init(&e->list);
-	write_unlock(&entries_lock);
+	write_unlock(&binfmt_ns(entries_lock));
 
 	dentry = e->dentry;
 	drop_nlink(d_inode(dentry));
 	d_drop(dentry);
 	dput(dentry);
-	simple_release_fs(&bm_mnt, &entry_count);
+	simple_release_fs(&binfmt_ns(bm_mnt), &binfmt_ns(entry_count));
 }
 
 /* /<entry> */
@@ -716,7 +711,8 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 	if (!inode)
 		goto out2;
 
-	err = simple_pin_fs(&bm_fs_type, &bm_mnt, &entry_count);
+	err = simple_pin_fs(&bm_fs_type, &binfmt_ns(bm_mnt),
+			    &binfmt_ns(entry_count));
 	if (err) {
 		iput(inode);
 		inode = NULL;
@@ -730,7 +726,8 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 		if (IS_ERR(f)) {
 			err = PTR_ERR(f);
 			pr_notice("register: failed to install interpreter file %s\n", e->interpreter);
-			simple_release_fs(&bm_mnt, &entry_count);
+			simple_release_fs(&binfmt_ns(bm_mnt),
+					  &binfmt_ns(entry_count));
 			iput(inode);
 			inode = NULL;
 			goto out2;
@@ -743,9 +740,9 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 	inode->i_fop = &bm_entry_operations;
 
 	d_instantiate(dentry, inode);
-	write_lock(&entries_lock);
-	list_add(&e->list, &entries);
-	write_unlock(&entries_lock);
+	write_lock(&binfmt_ns(entries_lock));
+	list_add(&e->list, &binfmt_ns(entries));
+	write_unlock(&binfmt_ns(entries_lock));
 
 	err = 0;
 out2:
@@ -770,7 +767,7 @@ static const struct file_operations bm_register_operations = {
 static ssize_t
 bm_status_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
 {
-	char *s = enabled ? "enabled\n" : "disabled\n";
+	char *s = binfmt_ns(enabled) ? "enabled\n" : "disabled\n";
 
 	return simple_read_from_buffer(buf, nbytes, ppos, s, strlen(s));
 }
@@ -784,19 +781,20 @@ static ssize_t bm_status_write(struct file *file, const char __user *buffer,
 	switch (res) {
 	case 1:
 		/* Disable all handlers. */
-		enabled = 0;
+		binfmt_ns(enabled) = 0;
 		break;
 	case 2:
 		/* Enable all handlers. */
-		enabled = 1;
+		binfmt_ns(enabled) = 1;
 		break;
 	case 3:
 		/* Delete all handlers. */
 		root = file_inode(file)->i_sb->s_root;
 		inode_lock(d_inode(root));
 
-		while (!list_empty(&entries))
-			kill_node(list_first_entry(&entries, Node, list));
+		while (!list_empty(&binfmt_ns(entries)))
+			kill_node(list_first_entry(&binfmt_ns(entries),
+						   Node, list));
 
 		inode_unlock(d_inode(root));
 		break;
@@ -838,7 +836,10 @@ static int bm_fill_super(struct super_block *sb, void *data, int silent)
 static struct dentry *bm_mount(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data)
 {
-	return mount_single(fs_type, flags, data, bm_fill_super);
+	struct mnt_namespace *mnt_ns = current->nsproxy->mnt_ns;
+
+	return mount_ns(fs_type, flags, data, mnt_ns, mnt_ns->user_ns,
+			bm_fill_super);
 }
 
 static struct linux_binfmt misc_format = {
@@ -849,6 +850,7 @@ static struct linux_binfmt misc_format = {
 static struct file_system_type bm_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "binfmt_misc",
+	.fs_flags	= FS_USERNS_MOUNT,
 	.mount		= bm_mount,
 	.kill_sb	= kill_litter_super,
 };
diff --git a/fs/mount.h b/fs/mount.h
index f39bc9da4d73..f03b35141440 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -17,6 +17,12 @@ struct mnt_namespace {
 	u64 event;
 	unsigned int		mounts; /* # of mounts in the namespace */
 	unsigned int		pending_mounts;
+	/* binfmt misc */
+	struct list_head entries;
+	rwlock_t entries_lock;
+	int enabled;
+	struct vfsmount *bm_mnt;
+	int entry_count;
 } __randomize_layout;
 
 struct mnt_pcp {
@@ -72,6 +78,8 @@ struct mount {
 	struct dentry *mnt_ex_mountpoint;
 } __randomize_layout;
 
+#define binfmt_ns(a) (current->nsproxy->mnt_ns->a)
+
 #define MNT_NS_INTERNAL ERR_PTR(-EINVAL) /* distinct from any mnt_namespace */
 
 static inline struct mount *real_mount(struct vfsmount *mnt)
diff --git a/fs/namespace.c b/fs/namespace.c
index 99186556f8d3..f92b8371228d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2850,6 +2850,12 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns)
 	new_ns->ucounts = ucounts;
 	new_ns->mounts = 0;
 	new_ns->pending_mounts = 0;
+	/* binfmt_misc */
+	INIT_LIST_HEAD(&new_ns->entries);
+	new_ns->enabled = 1;
+	rwlock_init(&new_ns->entries_lock);
+	new_ns->bm_mnt = NULL;
+	new_ns->entry_count = 0;
 	return new_ns;
 }
 
-- 
2.17.1

