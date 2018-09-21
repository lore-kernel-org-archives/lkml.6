Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC52C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1FF621566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1FF621566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391097AbeIUWXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:23:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49758 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390076AbeIUWXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:23:00 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2D72E12BBB;
        Fri, 21 Sep 2018 16:33:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 73FC3309138F;
        Fri, 21 Sep 2018 16:33:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 23/34] vfs: Remove kern_mount_data() [ver #12]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        ebiederm@xmission.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
Date:   Fri, 21 Sep 2018 17:33:18 +0100
Message-ID: <153754759870.17872.3144316394384775981.stgit@warthog.procyon.org.uk>
In-Reply-To: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
References: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 21 Sep 2018 16:33:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kern_mount_data() isn't used any more so remove it.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/namespace.c     |    7 -------
 include/linux/fs.h |    1 -
 2 files changed, 8 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index d841ba5568d9..156261d03c12 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3328,13 +3328,6 @@ struct vfsmount *kern_mount(struct file_system_type *type)
 }
 EXPORT_SYMBOL_GPL(kern_mount);
 
-struct vfsmount *kern_mount_data(struct file_system_type *type,
-				 void *data, size_t data_size)
-{
-	return vfs_kern_mount(type, SB_KERNMOUNT, type->name, data, data_size);
-}
-EXPORT_SYMBOL_GPL(kern_mount_data);
-
 /*
  * Move a mount from one place to another.
  * In combination with open_tree(OPEN_TREE_CLONE [| AT_RECURSIVE]) it can be
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4c3c388646bc..14e08020890f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2232,7 +2232,6 @@ mount_pseudo(struct file_system_type *fs_type, char *name,
 extern int register_filesystem(struct file_system_type *);
 extern int unregister_filesystem(struct file_system_type *);
 extern struct vfsmount *kern_mount(struct file_system_type *);
-extern struct vfsmount *kern_mount_data(struct file_system_type *, void *, size_t);
 extern void kern_unmount(struct vfsmount *mnt);
 extern int may_umount_tree(struct vfsmount *);
 extern int may_umount(struct vfsmount *);

