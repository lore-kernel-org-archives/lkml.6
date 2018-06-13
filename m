Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D367AC5CFF1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC092086D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEpR8qCa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC092086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935090AbeFMBPV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 21:15:21 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39390 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754136AbeFMBPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 21:15:20 -0400
Received: by mail-pl0-f67.google.com with SMTP id f1-v6so495541plt.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 18:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LEiLxHnuXzrJZRR0BP5WDLf653G6R2kAVSdzwr1fE6Y=;
        b=KEpR8qCa2m0jNqTlc2olPsiFSv6XOk6TBrs5mYz5uoJZRCZ2YP+wpoiYsmxNRS1GJo
         GeboVCVO13TZxUUePj/4Nbdwcn6CXRRlWqF2Cz7yqqK7bKaUrZQ2B+E4BffZQ3AJNMpD
         hWp8Pu4A8IRGBPiddksM8SRl5uREJdXOhv0k4ycaHLW3YoA/A7/jkdj1frhlglXrA3Ch
         RC1d6CAKMHz3HF410UK4bZ6yFKZZskuLdiSfl6wqIxmId8U7VcSK50nRwMUc0nl8z3yi
         OTmvCPXoM48xjtiIrUz/n7WSrN/crucHYg7SDUcVO6P/2w75jFZWejD/r2nTyJTV60Xr
         JCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LEiLxHnuXzrJZRR0BP5WDLf653G6R2kAVSdzwr1fE6Y=;
        b=q7de7JbwLeVIuuDIbfroty3VyiuHpLuwpMD4a+NS/CQ+JWGD7HWU+G94lGFlIjR4Wj
         HBblo92apgljSmAZeYN9SOvQ/iYdwPJNB8Ax71gaPzcHAMuWVvpH/t6Ybf07D74nkcvJ
         UWhSOzYmD10im8UFszcCJxza3tRRXbV4SC6D2QrclXfPFHE7rAKtNBQpJYccHELs+trK
         VC7ZN2WZDxeQ9iLH0/f2VbkMHKyfWRYuu0J2I6dFT0FE6g0xwYwhsU7z7BycMQ300b/D
         tpMUmKopWf7UcD2JpFN8EwXDxd92MDNDf+rIkVNDIenDlkLbGvIH4+9RkLohdt+tUii6
         MUwQ==
X-Gm-Message-State: APt69E3X/L5T/XZgpL2NBa35qIZm+0/oPGsOQhtb20PdGeAhNrchjgkY
        erGD4ttHnvolb7z8+ArYG+U=
X-Google-Smtp-Source: ADUXVKIHyeTm2b6bYcv87hWl/0gnKsrmOwGSAbJHdgA8R8MMl6LnL7OaQBZKtnzfZwF3rOLQZq7Ohw==
X-Received: by 2002:a17:902:24e:: with SMTP id 72-v6mr2800665plc.87.1528852519854;
        Tue, 12 Jun 2018 18:15:19 -0700 (PDT)
Received: from localhost ([221.218.170.123])
        by smtp.gmail.com with ESMTPSA id 29-v6sm2105327pfp.24.2018.06.12.18.15.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 18:15:19 -0700 (PDT)
From:   Peng Donglin <dolinux.peng@gmail.com>
To:     catalin.marinas@arm.com, will.deacon@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Donglin <dolinux.peng@gmail.com>
Subject: [PATCH 1/2] ARM: dump: Convert to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Wed, 13 Jun 2018 09:11:55 +0800
Message-Id: <b55024472e101a33b3d6b098aa2ce23c5b5dd6f7.1528819790.git.dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1528819790.git.dolinux.peng@gmail.com>
References: <cover.1528819790.git.dolinux.peng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
---
 arch/arm/mm/ptdump_debugfs.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/arm/mm/ptdump_debugfs.c b/arch/arm/mm/ptdump_debugfs.c
index be8d87b..79002fe 100644
--- a/arch/arm/mm/ptdump_debugfs.c
+++ b/arch/arm/mm/ptdump_debugfs.c
@@ -11,18 +11,7 @@ static int ptdump_show(struct seq_file *m, void *v)
 	ptdump_walk_pgd(m, info);
 	return 0;
 }
-
-static int ptdump_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ptdump_show, inode->i_private);
-}
-
-static const struct file_operations ptdump_fops = {
-	.open		= ptdump_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(ptdump);
 
 int ptdump_debugfs_register(struct ptdump_info *info, const char *name)
 {
-- 
2.7.4

