Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27437C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE1132147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmV1Xq3P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbfAGQXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:23:41 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42870 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbfAGQXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:23:41 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so1018565wrx.9;
        Mon, 07 Jan 2019 08:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=ueNybj+ZyUpCeo1lAUe23ANl04I+fO88frt93lziI+s=;
        b=mmV1Xq3PclgbsVQNtWi+rwyj9h2u5RK2u20Qw94ex00SqMEwhK5A9pnB9wCV405R39
         a03g959bCOrEkDwZYvTEZJgxckahJUH16PT6V5YqrQolZQYmM03QFpV8rKCdarl0Nz2Z
         WfylcnDD32Nur33Pw4tchzdYSrUO3Bv0qKPATDPPvB1jj+6bbmJkcDukU6c1eJ8Qe01k
         /1eG/got/SJkAblYayoDLmbi8b/AHmnzUR5ULMOQjSZI8vL7E5flPpzaPlfaXGohs1ft
         2B4kATWSJm5A4tPunI7OFzVg0WnHczVsEX7u9FgVfYJxRpUfQRYzD+92ZLH/HNOFQRGL
         fbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=ueNybj+ZyUpCeo1lAUe23ANl04I+fO88frt93lziI+s=;
        b=hiRE7RGE44SSd3ngOKve1tsczAxFkM8jNI6MKv6j5BbNg5YLRlaq11VF8hER2N4uQ2
         ZypjpI67Pgbr21bAj1IdGTSnYXadiGHIEfob+7Y5tHasX/1zdqRyW51I+C233DgGo/qD
         4QDL4h9C7EXRaHRl9kbDTIAMhdGNDFXbXSZDmcZRJ0XNILfOKHO774eWaS0xE2vrbeYF
         mP7NMj4jeWnuS9+22WV/ud5FfPUcHDlIFB2fBqu8jCTwnUrGqUQIhJruDYP/eflKY/Qi
         0g9X4uuOygCYnUF88IUaMItrcMbPvAj/myS/L0kzBf4YaDR7Pb+UCxb02T/aKZUnZ76i
         yWrw==
X-Gm-Message-State: AJcUukcNY40PNxet26e+XLKEoTt8Z7baUS6vOSDR4xmsBqKb3CRZAkaM
        F/ioYVTrqNvU76vr8cU/Qw==
X-Google-Smtp-Source: ALg8bN5Ry3JaxN7PRztpD2C39Srb6Y4b7mA3/uB/34y2KgClsuvmb3KeDEwM4ESbK/on9fl9/J2alA==
X-Received: by 2002:adf:c7cc:: with SMTP id y12mr54387113wrg.52.1546878219452;
        Mon, 07 Jan 2019 08:23:39 -0800 (PST)
Received: from avx2 (nat-minsk-pool-46-53-201-92.telecom.by. [46.53.201.92])
        by smtp.gmail.com with ESMTPSA id w2sm18285157wrm.69.2019.01.07.08.23.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 08:23:38 -0800 (PST)
Date:   Mon, 7 Jan 2019 19:23:36 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, mateusz.stepien@netrounds.com,
        a.fatoum@pengutronix.de
Subject: [PATCH] proc: fix /proc/net/* after setns(2)
Message-ID: <20190107162336.GA9239@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/proc entries under /proc/net/* can't be cached into dcache
because setns(2) can change current net namespace.

Reported-by: Mateusz Stępień <mateusz.stepien@netrounds.com>
Reported-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Fixes: 1da4d377f943fe4194ffb9fb9c26cc58fad4dd24 ("proc: revalidate misc dentries")
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

	I'm still looking into it because modules can create entries
	under /proc/net/* :-(

 fs/proc/generic.c  |    4 +++-
 fs/proc/internal.h |    1 +
 fs/proc/proc_net.c |   10 ++++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -256,7 +256,7 @@ struct dentry *proc_lookup_de(struct inode *dir, struct dentry *dentry,
 		inode = proc_get_inode(dir->i_sb, de);
 		if (!inode)
 			return ERR_PTR(-ENOMEM);
-		d_set_d_op(dentry, &proc_misc_dentry_ops);
+		d_set_d_op(dentry, de->proc_dops);
 		return d_splice_alias(inode, dentry);
 	}
 	read_unlock(&proc_subdir_lock);
@@ -429,6 +429,8 @@ static struct proc_dir_entry *__proc_create(struct proc_dir_entry **parent,
 	INIT_LIST_HEAD(&ent->pde_openers);
 	proc_set_user(ent, (*parent)->uid, (*parent)->gid);
 
+	ent->proc_dops = &proc_misc_dentry_ops;
+
 out:
 	return ent;
 }
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -44,6 +44,7 @@ struct proc_dir_entry {
 	struct completion *pde_unload_completion;
 	const struct inode_operations *proc_iops;
 	const struct file_operations *proc_fops;
+	const struct dentry_operations *proc_dops;
 	union {
 		const struct seq_operations *seq_ops;
 		int (*single_show)(struct seq_file *, void *);
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -38,6 +38,12 @@ static struct net *get_proc_net(const struct inode *inode)
 	return maybe_get_net(PDE_NET(PDE(inode)));
 }
 
+static void pde_force_lookup(struct proc_dir_entry *pde)
+{
+	// /proc/net/* can be changed under us by setns(CLONE_NEWNET)
+	pde->proc_dops = &simple_dentry_operations;
+}
+
 static int seq_open_net(struct inode *inode, struct file *file)
 {
 	unsigned int state_size = PDE(inode)->state_size;
@@ -90,6 +96,7 @@ struct proc_dir_entry *proc_create_net_data(const char *name, umode_t mode,
 	p = proc_create_reg(name, mode, &parent, data);
 	if (!p)
 		return NULL;
+	pde_force_lookup(p);
 	p->proc_fops = &proc_net_seq_fops;
 	p->seq_ops = ops;
 	p->state_size = state_size;
@@ -133,6 +140,7 @@ struct proc_dir_entry *proc_create_net_data_write(const char *name, umode_t mode
 	p = proc_create_reg(name, mode, &parent, data);
 	if (!p)
 		return NULL;
+	pde_force_lookup(p);
 	p->proc_fops = &proc_net_seq_fops;
 	p->seq_ops = ops;
 	p->state_size = state_size;
@@ -181,6 +189,7 @@ struct proc_dir_entry *proc_create_net_single(const char *name, umode_t mode,
 	p = proc_create_reg(name, mode, &parent, data);
 	if (!p)
 		return NULL;
+	pde_force_lookup(p);
 	p->proc_fops = &proc_net_single_fops;
 	p->single_show = show;
 	return proc_register(parent, p);
@@ -223,6 +232,7 @@ struct proc_dir_entry *proc_create_net_single_write(const char *name, umode_t mo
 	p = proc_create_reg(name, mode, &parent, data);
 	if (!p)
 		return NULL;
+	pde_force_lookup(p);
 	p->proc_fops = &proc_net_single_fops;
 	p->single_show = show;
 	p->write = write;
