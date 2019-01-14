Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA2EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1022206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNk62ZMw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfANUEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:04:30 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44119 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfANUEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:04:30 -0500
Received: by mail-wr1-f68.google.com with SMTP id z5so293669wrt.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 12:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=M3/o7kFlKM3bWyY3nMM7Y8tTKfkaELtb0A0mCCKmuyE=;
        b=jNk62ZMwglRvAip6RI0+BHfBKvI9vZyj5ZRKTFcN+9yAI5MutLbjAsmtH6QlHrzcN3
         7fDr3t/O7x02/nkYwVzA11/m0lWoFwF9tfdAVbHVJGIplqPjyyA4jePM4r63BfkHaEUt
         Kv61Fk8vHP2n5LPWPe7Z1M1p2bra/SbI+q+yWJaZ4tF/iWA5caeuy8J7SI85x2Bdf9H/
         Eai6HSn3aYvx7l0epHOqTDWrYZj0w2aEsh/ijNMc70KVkghKV0tHiBWaMSO2Foy3vEav
         aOQN2ieNFou/Y9OIT9U8gpb6ynBBCcSEeYwZi6S2SVpSwXIutRUf1NMGkDqiT0tEQnAe
         cEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=M3/o7kFlKM3bWyY3nMM7Y8tTKfkaELtb0A0mCCKmuyE=;
        b=SJ0iJW+KsqsJEfy/DWaW3tNb1TsAUid/f387hoyNsOYBeOnJN2xJE4StX+PiyF7YRs
         dtG4jTVPvWAPMNtOyhgILHew0I7qfmSKqoCe0LMZUhGUG0uUIgtufWyZYxfGOzjhdnAD
         WOEyKQosyQdGg4Ae0V9BlyDK0U5L7q7wiER3covUNgf0KSi8L03YoOuCXSJndT5cVnFi
         0kOFAur/NyqewiwYGxa5mk0rufVEP5SWbB+2w4ZxG7pmoXWC5t1p7ScxG3D2vHzJat7a
         7yeGYrBZC7roiyP5PCw4jV6kizbul9fS12KgpTHjCguEi2dLxZy993FCUuIsyGrF0uB6
         mLFw==
X-Gm-Message-State: AJcUukfycNSYDd/U3PXqkKzMSidSDpCp10XH1U0JtMzGjBlKZ8xyz1E/
        H5M6jz6hBb1/Lo3BvMUR63Ul8Og=
X-Google-Smtp-Source: ALg8bN6exxDcyTSpfaoVsI+C1dfz9hDw3lMxCRy/5Eu93DcA2Ewyxk3yonp+iwZbhu1gZ6YFCouG+g==
X-Received: by 2002:a5d:6a42:: with SMTP id t2mr165307wrw.50.1547496268022;
        Mon, 14 Jan 2019 12:04:28 -0800 (PST)
Received: from avx2 (nat-minsk-pool-46-53-201-92.telecom.by. [46.53.201.92])
        by smtp.gmail.com with ESMTPSA id t5sm31395847wmd.15.2019.01.14.12.04.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 12:04:27 -0800 (PST)
Date:   Mon, 14 Jan 2019 23:04:23 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] proc: calculate end pointer for /proc/*/* lookup at compile
 time
Message-ID: <20190114200422.GB9680@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compilers like to transform loops like

	for (i = 0; i < n; i++) {
		[use p[i]]
	}

into
	for (p = p0; p < end; p++) {
		...
	}

Do it by hand, so that it results in overall simpler loop
and smaller code.

Space savings:

	$ ./scripts/bloat-o-meter ../vmlinux-001 ../obj/vmlinux
	add/remove: 0/0 grow/shrink: 2/1 up/down: 4/-9 (-5)
	Function                                     old     new   delta
	proc_tid_base_lookup                          17      19      +2
	proc_tgid_base_lookup                         17      19      +2
	proc_pident_lookup                           179     170      -9

Note: this trick bloats readdir, so don't do it :-\

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/base.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2459,11 +2459,10 @@ static struct dentry *proc_pident_instantiate(struct dentry *dentry,
 
 static struct dentry *proc_pident_lookup(struct inode *dir, 
 					 struct dentry *dentry,
-					 const struct pid_entry *ents,
-					 unsigned int nents)
+					 const struct pid_entry *p,
+					 const struct pid_entry *end)
 {
 	struct task_struct *task = get_proc_task(dir);
-	const struct pid_entry *p, *last;
 	struct dentry *res = ERR_PTR(-ENOENT);
 
 	if (!task)
@@ -2473,8 +2472,7 @@ static struct dentry *proc_pident_lookup(struct inode *dir,
 	 * Yes, it does not scale. And it should not. Don't add
 	 * new entries into /proc/<tgid>/ without very good reasons.
 	 */
-	last = &ents[nents];
-	for (p = ents; p < last; p++) {
+	for (; p < end; p++) {
 		if (p->len != dentry->d_name.len)
 			continue;
 		if (!memcmp(dentry->d_name.name, p->name, p->len)) {
@@ -2613,7 +2611,8 @@ static struct dentry *proc_attr_dir_lookup(struct inode *dir,
 				struct dentry *dentry, unsigned int flags)
 {
 	return proc_pident_lookup(dir, dentry,
-				  attr_dir_stuff, ARRAY_SIZE(attr_dir_stuff));
+				  attr_dir_stuff,
+				  attr_dir_stuff + ARRAY_SIZE(attr_dir_stuff));
 }
 
 static const struct inode_operations proc_attr_dir_inode_operations = {
@@ -3049,7 +3048,8 @@ static const struct file_operations proc_tgid_base_operations = {
 static struct dentry *proc_tgid_base_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
 {
 	return proc_pident_lookup(dir, dentry,
-				  tgid_base_stuff, ARRAY_SIZE(tgid_base_stuff));
+				  tgid_base_stuff,
+				  tgid_base_stuff + ARRAY_SIZE(tgid_base_stuff));
 }
 
 static const struct inode_operations proc_tgid_base_inode_operations = {
@@ -3421,7 +3421,8 @@ static int proc_tid_base_readdir(struct file *file, struct dir_context *ctx)
 static struct dentry *proc_tid_base_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
 {
 	return proc_pident_lookup(dir, dentry,
-				  tid_base_stuff, ARRAY_SIZE(tid_base_stuff));
+				  tid_base_stuff,
+				  tid_base_stuff + ARRAY_SIZE(tid_base_stuff));
 }
 
 static const struct file_operations proc_tid_base_operations = {
