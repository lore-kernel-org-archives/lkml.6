Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8E9C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 08:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645282086D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 08:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0Q3IwU2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbeLOI7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 03:59:20 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44305 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbeLOI7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 03:59:19 -0500
Received: by mail-pf1-f194.google.com with SMTP id u6so3966575pfh.11
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 00:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cof2lTq6+cIaLNXvxwnhd//f24bYeL2REcBywtvOYNY=;
        b=h0Q3IwU25MZiUFiieg8wK4rOL1P4kPTrRbkb74dHFgn6G6UumdaQjhXmBjJAyLfvF7
         N3f8MYVC/DIxOPhjGPYXW9G5oRe8tSpdE8cx/Oe5q/Ftnq08LydbN8RCOLN9T/1ew5KI
         8cnEPewTYtfdE3oc1GL7DN+TuKBqa222gwTs6n5gY7TtFyznc4VL2mRKZnhLXMSGF3JM
         gA6z3/OV4qaS6ph3uzh4FQyrTZzHdgE704MTBiyhOI6Ei+axpiu1gaZGPvhQ5ntBJDR/
         g2waZyXCJ2OCaYrffETtCKrTQ/3hCn6T6rnjasaJLGEan/Vxy2YdvryxxcNaNk0EXAB1
         pDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cof2lTq6+cIaLNXvxwnhd//f24bYeL2REcBywtvOYNY=;
        b=rqj0iPcrenWiCbhTpZPXE+UsKg57sMDlADPmBuTchc5qdl+8GC58tnr0klKv0NcOHr
         NwHapk/sXKGxV/yN5j+rPyg55goICG9O+ftlnTbdb1nxSSH6vfh3qaQ2lb0OgLyXMIi5
         nRXNxHYlI4ynoJ36b/+ZdhQDat2w9WnD0JjrwFS67aGe0SDgH0zPlIm1qo3b86Z2Uf4S
         +IK3Oeq9HxO/5JtYqG1733BSHotpvVCU1DOQYS/voGwEDSYIs1mg1PZ8/W4sPc13MXZT
         EK28Vy9t2yvL+AHsU+PVdYhgbMM2ILxGQCgUKQeRxMU17fPlmXlyoSry6fYtDPN5Gnac
         VH7Q==
X-Gm-Message-State: AA+aEWaqziiSb0UFcq5CkiDCMHAluUSzwWuhIXA+azozLpbBrQsa1LFi
        9XW4uVJzNDjaesNmDb1GDTg=
X-Google-Smtp-Source: AFSGD/W45XB05rVcuj0zl+rFSRjaUvNDe9inT0TC/6GOvFrGQxZPtqXYYhyCDl6YmkUwbIDIgt7T0A==
X-Received: by 2002:a63:6ac5:: with SMTP id f188mr2259517pgc.165.1544864359233;
        Sat, 15 Dec 2018 00:59:19 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id e86sm9551876pfb.6.2018.12.15.00.59.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Dec 2018 00:59:18 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     david.kershner@unisys.com, gregkh@linuxfoundation.org,
        keescook@chromium.org
Cc:     sparmaintainer@unisys.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [RESEND] staging: unisys: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Sat, 15 Dec 2018 03:59:12 -0500
Message-Id: <20181215085912.27712-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/staging/unisys/visorhba/visorhba_main.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/staging/unisys/visorhba/visorhba_main.c b/drivers/staging/unisys/visorhba/visorhba_main.c
index 4fc521c51c0e..d0fed63c13a2 100644
--- a/drivers/staging/unisys/visorhba/visorhba_main.c
+++ b/drivers/staging/unisys/visorhba/visorhba_main.c
@@ -681,19 +681,7 @@ static int info_debugfs_show(struct seq_file *seq, void *v)
 
 	return 0;
 }
-
-static int info_debugfs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, info_debugfs_show, inode->i_private);
-}
-
-static const struct file_operations info_debugfs_fops = {
-	.owner = THIS_MODULE,
-	.open = info_debugfs_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(info_debugfs);
 
 /*
  * complete_taskmgmt_command - Complete task management
-- 
2.17.0

