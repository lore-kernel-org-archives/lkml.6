Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664E0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251CF20851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoSZ60bG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 251CF20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbeKTCIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:08:09 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45815 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729669AbeKTCIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:08:09 -0500
Received: by mail-pf1-f196.google.com with SMTP id g62so11772412pfd.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 07:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nXpJvEWKG+SZyJHLzn2Jw5GXNU/6KZ97BCNXAyf0qpw=;
        b=SoSZ60bGwR1Jbi4L5AzSGaHLlhi6cDYVxnKZ5WNKkAAZUUUVrd7DWYm7eL5O4rwCTJ
         UKLss3+oNG+ngUMVmvw2mZLPpPws+zj131Ya424WKnX7sCeQzEfiDuecuvzXrmZf8mr9
         vKTURTB7n/lqF7R25kCbsTxWsnrwv97S3Jj50QKZpZF02CG1mjl2DfiCP3Q3i/5GWZiQ
         xRzVXQ6sAb74+OK7f/fqsvV2jpQKQmxYUX3xDQNcvPsMIR2u1xY5NNbfywEOyTKlfbbG
         BUQdqRy1oabxx6VYTZlg++Zhegb/StALqdC3lWkknzk6QY1EQFRHPkr9OLIXLb1U5DeF
         hqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nXpJvEWKG+SZyJHLzn2Jw5GXNU/6KZ97BCNXAyf0qpw=;
        b=QWkFPIpB1iOKkazCZ3J7tjLdmobq3AR0Q8/lC9blZwc+kiHix39OtbSmPWJFMZaqgr
         00J/k7nOSZ+k6mGgyKtX1WfmkN7Mgjmad6bQFCW2bS3M57Qo3eQpUGmuy7kEowv4MYm5
         F5E978f0INFxISBN6E7B6mfMqBVUqg1irbezreEDqJT/0TM0A2mMfC9iYUSNvIzX+syw
         /Nja9kAEyQWGPi30P1MPiHGSfMFfbBJ0KJeRJ2fUE5tbSOpkkNBjbB53l1DwdHIpMf/H
         W95H+wilwwoxi7FnyZUWNLFfK9DXJT9/o8AIghh4T0MusU2KWCX2zMWA9MtE76hfsIsH
         FByQ==
X-Gm-Message-State: AGRZ1gLQd/6gmqC6g3isMpTlu2NsSp24K5aPopvBqf3hBLHzBxJrDKhY
        AH4VECqy5yoSE/mrfwcgAQQ=
X-Google-Smtp-Source: AJdET5fyoUrvbhFkZAEVtv95R00Udvqe0c4+O+Tv7KLQB7eWNkpeVe5MnPqFlshU5CSOvz4V3iyM3g==
X-Received: by 2002:a63:8c0d:: with SMTP id m13mr11931375pgd.422.1542642250497;
        Mon, 19 Nov 2018 07:44:10 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id n186sm3769251pfn.137.2018.11.19.07.44.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 07:44:09 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     keescook@chromium.org, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] x86/mm/dump_pagetables: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Mon, 19 Nov 2018 10:43:34 -0500
Message-Id: <20181119154334.18265-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/x86/mm/debug_pagetables.c | 58 ++++------------------------------
 1 file changed, 7 insertions(+), 51 deletions(-)

diff --git a/arch/x86/mm/debug_pagetables.c b/arch/x86/mm/debug_pagetables.c
index 225fe2f0bfec..cd84f067e41d 100644
--- a/arch/x86/mm/debug_pagetables.c
+++ b/arch/x86/mm/debug_pagetables.c
@@ -10,20 +10,9 @@ static int ptdump_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int ptdump_open(struct inode *inode, struct file *filp)
-{
-	return single_open(filp, ptdump_show, NULL);
-}
-
-static const struct file_operations ptdump_fops = {
-	.owner		= THIS_MODULE,
-	.open		= ptdump_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(ptdump);
 
-static int ptdump_show_curknl(struct seq_file *m, void *v)
+static int ptdump_curknl_show(struct seq_file *m, void *v)
 {
 	if (current->mm->pgd) {
 		down_read(&current->mm->mmap_sem);
@@ -33,23 +22,12 @@ static int ptdump_show_curknl(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int ptdump_open_curknl(struct inode *inode, struct file *filp)
-{
-	return single_open(filp, ptdump_show_curknl, NULL);
-}
-
-static const struct file_operations ptdump_curknl_fops = {
-	.owner		= THIS_MODULE,
-	.open		= ptdump_open_curknl,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(ptdump_curknl);
 
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 static struct dentry *pe_curusr;
 
-static int ptdump_show_curusr(struct seq_file *m, void *v)
+static int ptdump_curusr_show(struct seq_file *m, void *v)
 {
 	if (current->mm->pgd) {
 		down_read(&current->mm->mmap_sem);
@@ -59,42 +37,20 @@ static int ptdump_show_curusr(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int ptdump_open_curusr(struct inode *inode, struct file *filp)
-{
-	return single_open(filp, ptdump_show_curusr, NULL);
-}
-
-static const struct file_operations ptdump_curusr_fops = {
-	.owner		= THIS_MODULE,
-	.open		= ptdump_open_curusr,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(ptdump_curusr);
 #endif
 
 #if defined(CONFIG_EFI) && defined(CONFIG_X86_64)
 static struct dentry *pe_efi;
 
-static int ptdump_show_efi(struct seq_file *m, void *v)
+static int ptdump_efi_show(struct seq_file *m, void *v)
 {
 	if (efi_mm.pgd)
 		ptdump_walk_pgd_level_debugfs(m, efi_mm.pgd, false);
 	return 0;
 }
 
-static int ptdump_open_efi(struct inode *inode, struct file *filp)
-{
-	return single_open(filp, ptdump_show_efi, NULL);
-}
-
-static const struct file_operations ptdump_efi_fops = {
-	.owner		= THIS_MODULE,
-	.open		= ptdump_open_efi,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(ptdump_efi);
 #endif
 
 static struct dentry *dir, *pe_knl, *pe_curknl;
-- 
2.17.0

