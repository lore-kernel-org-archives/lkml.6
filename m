Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4D3C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89C120659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oKB4A5+a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfANT4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:56:41 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:34344 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfANT4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:56:40 -0500
Received: by mail-wr1-f53.google.com with SMTP id j2so343766wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 11:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=bgwcwI8G8EMuEsEIrTuFeHQ9mh3c2ML9imd/s+BrKE4=;
        b=oKB4A5+a65fQAh66gXbKwHRQCM7SV4CzcM6zfj6qqKeHvsB0Ow5AcBsvVoXXtRGLev
         S8+HsApP6FCwYY0Rgif7omY7hLbxmYUiGYVhlFv+UkJQsiOupHnjpJxWZ+hoESKqbpeR
         21blAmdaLoVq5F8AejbYmQY8B8ezvPWTZXMTPdqBTHJGqhWSxBaQOWVGvz944a8MbQov
         LT2+9GLmCmhbiVqE35cuxYkhtiFSxOi1tlLNDw5pcyBVWC/0vagW3RHg0M9HsFyvOrya
         5ODXEkAx8DtoCbvSI60bjEeL6aV/sc9ECp79qDbyXwI5dUvdKtaBfAkf6n0lgNSoYwSE
         2XnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bgwcwI8G8EMuEsEIrTuFeHQ9mh3c2ML9imd/s+BrKE4=;
        b=W7tpQZowQQJpgL8ByeH4zGa2JT9B5e/A1IiluLXt4cpcK4a3vMJaXEFv0aKteUmchg
         hiz9SxrdBLpUmu6NpUO/9UUH6/w9SjXi75xakUgSG5tTeZrydwtuWGIfXFmX4ETqtZyS
         ocgP0nIe5Kl5nx4stVJxHkdoB0GZquecj7jKjyhbnIwygaXbgQFfakgoY5F4U54XsHmh
         PEtggxnV3REyYhRBnxrud+o5kAl/hwMpZovF3Greh6XMiMzsAAwJbpcIihkBro6kjbmB
         MsbjVcNGUB+1/hNcp4rYH5hSCeTi63TO8l2TBV6z1nAtgXGj6KlgW03BAsMxlcL365l4
         Cdog==
X-Gm-Message-State: AJcUukez07x98iklcoB5iwTfpQun0723w0Wlmkey950kH5a14O6Zq0aj
        Wz+D1wQzzBul2bCwAhy1kA==
X-Google-Smtp-Source: ALg8bN7I+ni+mgEHZrFPcl73A5u4Zx/J02hWMHShEwAeoj+gHqEsM5dvly6Rblqald/ZAc5a089mLg==
X-Received: by 2002:adf:db01:: with SMTP id s1mr108539wri.214.1547495798857;
        Mon, 14 Jan 2019 11:56:38 -0800 (PST)
Received: from avx2 (nat-minsk-pool-46-53-201-92.telecom.by. [46.53.201.92])
        by smtp.gmail.com with ESMTPSA id g67sm54594139wmd.38.2019.01.14.11.56.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 11:56:37 -0800 (PST)
Date:   Mon, 14 Jan 2019 22:56:35 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, zhangzhikang1@huawei.com
Subject: [PATCH] proc: remove unused argument in proc_pid_lookup()
Message-ID: <20190114195635.GA9372@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhikang Zhang <zhangzhikang1@huawei.com>

[delete "extern" from prototype --adobriyan]

Signed-off-by: Zhikang Zhang <zhangzhikang1@huawei.com>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/base.c     |    2 +-
 fs/proc/internal.h |    2 +-
 fs/proc/root.c     |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3165,7 +3165,7 @@ static struct dentry *proc_pid_instantiate(struct dentry * dentry,
 	return d_splice_alias(inode, dentry);
 }
 
-struct dentry *proc_pid_lookup(struct inode *dir, struct dentry * dentry, unsigned int flags)
+struct dentry *proc_pid_lookup(struct dentry *dentry, unsigned int flags)
 {
 	struct task_struct *task;
 	unsigned tgid;
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -161,7 +161,7 @@ extern struct inode *proc_pid_make_inode(struct super_block *, struct task_struc
 extern void pid_update_inode(struct task_struct *, struct inode *);
 extern int pid_delete_dentry(const struct dentry *);
 extern int proc_pid_readdir(struct file *, struct dir_context *);
-extern struct dentry *proc_pid_lookup(struct inode *, struct dentry *, unsigned int);
+struct dentry *proc_pid_lookup(struct dentry *, unsigned int);
 extern loff_t mem_lseek(struct file *, loff_t, int);
 
 /* Lookups */
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -154,7 +154,7 @@ static int proc_root_getattr(const struct path *path, struct kstat *stat,
 
 static struct dentry *proc_root_lookup(struct inode * dir, struct dentry * dentry, unsigned int flags)
 {
-	if (!proc_pid_lookup(dir, dentry, flags))
+	if (!proc_pid_lookup(dentry, flags))
 		return NULL;
 	
 	return proc_lookup(dir, dentry, flags);
