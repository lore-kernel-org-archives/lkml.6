Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EB014C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 19:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A28C2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 19:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j6IAEkez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A28C2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934767AbeFKT6P (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 15:58:15 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34428 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933650AbeFKT6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 15:58:13 -0400
Received: by mail-pl0-f67.google.com with SMTP id g20-v6so12944143plq.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 12:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0AZjJCeLCewPmn+bJ7h9PP7uZdcRlZqeoAFa0Ux4SB0=;
        b=j6IAEkez66CJafcI2waFRXnP7v91wsVDX+lRQ5Fx1Zo7dqff8TUJgL7wp4FO2VkXd/
         g5qnEeUFdrpC/dC0NXuxclXIPCd7bBkYIWOsXb0rBWI4VCMdXmvfVA6PV6XV9xeP3FLY
         gdL4P+ziIcQlTzrzs0qnSPRA/29QAErK9n5L5WFQXDYY+GvLGHg3tpkaLR2gHb3dyyNP
         edZ/T/ZhS1ok5kdpO1tIc8kherUnY/gKwehEo7N+Sv4lC3X02a7fszHrIAHbNgm7g/aI
         ElnAkr/tiJBp84ez0QT2LWTpOh+ziRorzrAkhwCAjhlmBVMyt+t4+/aGplkHLvWQFe3m
         BZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0AZjJCeLCewPmn+bJ7h9PP7uZdcRlZqeoAFa0Ux4SB0=;
        b=FZZW0y7l70URnvJ0TKGvHlEDw9WQONrNjtjZZF7XwoombYQ3K+UMkxoFr8CSiaGYQq
         MlcH0FqS2/s7awKFqx18xkab4RDW7F4JSnXFh8xNA3ZdL1AJISTzvmG5ziYCyLpkl8FP
         eQw0RW9IKqDTkXMx1P2TP80ATEw1Ir/i6Ws16qWBvnrhK6701+fLxNOSn/zbfrHJxmPR
         GfYOGeoB9DixdEHiOjaSqzt6Xx2GwiBOtmOtGTBCyVL8DJkuHxlYN1VLO3F0IvnL/+L2
         wdt4XYTIjnIz8eVTDStkV7QUoI/lM77Lir6d9hw7/iHqByoDnyYFKx1VUPOfU0Ab0zPV
         HihQ==
X-Gm-Message-State: APt69E3KrZqmb1WnM6s7tpPKkiNFdan9F89UuPYtjUjl119Kmgd3jjS5
        bqvfyayVr+qChlW9oFLCmFsdSw==
X-Google-Smtp-Source: ADUXVKK2aBlfRi+OscN/USmFvD2bqiqhmy0NKYrXPPZypfkOaIvhVY/Y6Xfx5NB2PVt6Ms2GbDCKnw==
X-Received: by 2002:a17:902:d20b:: with SMTP id t11-v6mr604542ply.282.1528747092872;
        Mon, 11 Jun 2018 12:58:12 -0700 (PDT)
Received: from astrachan.mtv.corp.google.com ([2620:0:1000:1600:4394:e3d:8eee:a828])
        by smtp.gmail.com with ESMTPSA id z16-v6sm78371773pge.90.2018.06.11.12.58.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 12:58:12 -0700 (PDT)
From:   Alistair Strachan <astrachan@google.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Alistair Strachan <astrachan@google.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: [PATCH] proc: Fix parsing of mount parameters.
Date:   Mon, 11 Jun 2018 12:57:44 -0700
Message-Id: <20180611195744.154962-1-astrachan@google.com>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit e94591d0d90c "proc: Convert proc_mount to use mount_ns"
the parsing of mount parameters for the proc filesystem was broken.

The SB_KERNMOUNT for procfs happens via:

  start_kernel()
    rest_init()
      kernel_thread()
        _do_fork()
           copy_process()
             alloc_pid()
               pid_ns_prepare_proc()
                 kern_mount_data()
                   proc_mount()
                     mount_ns()

In mount_ns(), the kernel calls proc_fill_super() only if the superblock
has not previously been set up (i.e. the first mount reference),
regardless of SB_KERNMOUNT. Because the call to proc_parse_options() had
been moved inside here, and the SB_KERNMOUNT uses no mount options, the
option parser became a no-op.

When userspace later mounted procfs with e.g. hidepid=2, the options
would be ignored.

This change backs out a part of the original cleanup and parses the
procfs mount options at every mount call. Because the options currently
only update the pid_ns for the mount, they are applied for all mounts of
proc by that pid or childen of that pid, instantaneously. This is the
same behavior as the original code.

Fixes: e94591d0d90c ("proc: Convert proc_mount to use mount_ns")
Signed-off-by: Alistair Strachan <astrachan@google.com>
Cc: Seth Forshee <seth.forshee@canonical.com>
Cc: Djalal Harouni <tixxdz@gmail.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kernel-team@android.com
Cc: linux-kernel@vger.kernel.org
---
 fs/proc/inode.c    | 4 ----
 fs/proc/internal.h | 1 -
 fs/proc/root.c     | 5 ++++-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 2cf3b74391ca..bbbbf348be0a 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -492,13 +492,9 @@ struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
 
 int proc_fill_super(struct super_block *s, void *data, int silent)
 {
-	struct pid_namespace *ns = get_pid_ns(s->s_fs_info);
 	struct inode *root_inode;
 	int ret;
 
-	if (!proc_parse_options(data, ns))
-		return -EINVAL;
-
 	/* User space would break if executables or devices appear on proc */
 	s->s_iflags |= SB_I_USERNS_VISIBLE | SB_I_NOEXEC | SB_I_NODEV;
 	s->s_flags |= SB_NODIRATIME | SB_NOSUID | SB_NOEXEC;
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 50cb22a08c2f..89b7e845b000 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -264,7 +264,6 @@ static inline void proc_tty_init(void) {}
  * root.c
  */
 extern struct proc_dir_entry proc_root;
-extern int proc_parse_options(char *options, struct pid_namespace *pid);
 
 extern void proc_self_init(void);
 extern int proc_remount(struct super_block *, int *, char *);
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 61b7340b357a..d40676a5dd6c 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -36,7 +36,7 @@ static const match_table_t tokens = {
 	{Opt_err, NULL},
 };
 
-int proc_parse_options(char *options, struct pid_namespace *pid)
+static int proc_parse_options(char *options, struct pid_namespace *pid)
 {
 	char *p;
 	substring_t args[MAX_OPT_ARGS];
@@ -98,6 +98,9 @@ static struct dentry *proc_mount(struct file_system_type *fs_type,
 		ns = task_active_pid_ns(current);
 	}
 
+	if (!proc_parse_options(data, ns))
+		return ERR_PTR(-EINVAL);
+
 	return mount_ns(fs_type, flags, data, ns, ns->user_ns, proc_fill_super);
 }
 
-- 
2.18.0.rc1.242.g61856ae69a-goog

