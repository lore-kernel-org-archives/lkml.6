Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C672EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9057120663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sHAPDlzf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9057120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbeK0EVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:21:05 -0500
Received: from mail-it1-f201.google.com ([209.85.166.201]:54825 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbeK0EVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:21:05 -0500
Received: by mail-it1-f201.google.com with SMTP id v3so23703639itf.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 09:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hTRssr8EggBR6XE/i8hBHQD6Z1TBxrR9NysC2XVjA48=;
        b=sHAPDlzfjrkDNxqOgVAY+MIias9AjygBbJetxZvF8nuAXHEuMTL4uzTblBIgaLGAV7
         Pu7w3RcBlHw6r0eHD4N5yOFZVbOvQpYcWb4t9QDqLlC3hZCUetMFubN3eIs8wdwizfI8
         wvqQC5K7oiqyMtvwgcLi+N/BugLrD6xGf+Xka6Y75kGLA/PwxXdTcR6ogSBCAmQqFOzJ
         kZ9NTQBJLbOYRogVVRDjExRgCXhBFKLaQp85HVWeRHYzHrAEAEgGriHFWD9uf80aOChs
         7q5XHy9TvZSGhCuX4k2Bgoxdb/nRUlnc/RFWWPlzPthQgDAl5EWn5Agdv8IWQSLB7ivh
         G1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hTRssr8EggBR6XE/i8hBHQD6Z1TBxrR9NysC2XVjA48=;
        b=s2kBUGIm8sN4hTploSCcQPlWPISx5rGdzKZ4sdGuLZ7QaTyJCKko3+qUmq3dz2ZYvZ
         sHRqDKiQRB4iDGY9kxvdswqJr2vSn5pb6utFeJl0QeK/x6R2TCMyvg6cxVkCFN0JOgf0
         4ED7T/6JgGXSJ9di6Vw27rBHjVDn0hQWfaN1bW6D/THntjn+jkGrnSm7ec90h0jEKGpo
         S0FK6pSrBB+7zf2Q1UGAKDSWYYk7I6qJYLVoBH5QPDP+ddl9CbWwE11BG+bWEH9Oqavj
         NLnxwq8ywEGwW9aX4bZ0RRwsBdh/NCQ5ophyOTGzuJuAPwa8GKMu+cjTJtoBZqzivwvE
         Og3g==
X-Gm-Message-State: AA+aEWYiDF65jXHHI/aMoHM4Jp4BMd3yjLVlYCAYTJy3nO4qjcJ/JZvJ
        nZqs4IOwe5B0kBvxPFBox4A4IeYWvzM=
X-Google-Smtp-Source: AFSGD/WGfnLffnTR2GAbrzFOO63sKw37JkXE1k5GhdmHWeVbMq+wi+w3QsPbhZIRqluK0QVmAY8lE3cTcUM=
X-Received: by 2002:a24:946:: with SMTP id 67mr12533808itm.28.1543253178020;
 Mon, 26 Nov 2018 09:26:18 -0800 (PST)
Date:   Mon, 26 Nov 2018 18:26:07 +0100
Message-Id: <20181126172607.125782-1-rburny@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
Subject: [PATCH] fs: Make /proc/sys inodes be owned by global root.
From:   Radoslaw Burny <rburny@google.com>
To:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Seth Forshee <seth.forshee@canonical.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jsperbeck@google.com, Radoslaw Burny <rburny@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to a recent commit (d151ddc00498 - fs: Update i_[ug]id_(read|write)
to translate relative to s_user_ns), inodes under /proc/sys have -1
written to their i_uid/i_gid members if a containing userns does not
have entries for root in the uid/gid_map.

This wouldn't normally matter, because these values are not used for
access checks. However, a later change (0bd23d09b874 - Don't modify
inodes with a uid or gid unknown to the vfs) changes the kernel to
prevent opens for write if the i_uid/i_gid field in the inode is -1,
even if the /proc/sys-specific access checks would otherwise pass.

This causes a problem: in a userns without root mapping, even the
namespace creator cannot write to e.g. /proc/sys/kernel/shmmax.
This change fixes the problem by overriding i_uid/i_gid back to
GLOBAL_ROOT_UID/GID.

Tested: Used a repro program that creates a user namespace without any
mapping and stat'ed /proc/$PID/root/proc/sys/kernel/shmmax from outside.
Before the change, it shows uid/gid of 65534, with the change it's 0.

Signed-off-by: Radoslaw Burny <rburny@google.com>
---
 fs/proc/proc_sysctl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index c5cbbdff3c3d..67379a389658 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -499,6 +499,10 @@ static struct inode *proc_sys_make_inode(struct super_block *sb,
 
 	if (root->set_ownership)
 		root->set_ownership(head, table, &inode->i_uid, &inode->i_gid);
+	else {
+		inode->i_uid = GLOBAL_ROOT_UID;
+		inode->i_gid = GLOBAL_ROOT_GID;
+	}
 
 out:
 	return inode;
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

