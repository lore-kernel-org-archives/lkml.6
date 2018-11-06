Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FF0C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E1282081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vc5em9/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E1282081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388909AbeKGAFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:05:04 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34998 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388897AbeKGAFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:05:04 -0500
Received: by mail-pl1-f196.google.com with SMTP id n4-v6so6308469plp.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 06:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SFU/Z5qoWTfk9A6p33abSYOx6uOlq53OHyZ9STh41bs=;
        b=Vc5em9/nXIzzjBhEcBnEZR/6i0qu6qCOM+da4aYJXOK+UgmFEYBaIvwx6JxqBJDlBb
         gxczpqaP/26+MyA0JveRXw0tsLfxMlt1NkjQqT7bEaAzI7Z4sJNHuaotI73DB6aVtZfh
         gjWf10DTo08E8b6FOui3GjKzXJNgUqad8WC37XlxDXfMzXfLFhAhTXNSJUtGiu84FE5N
         BmcvNlmiMS6uHHHmIKansTGOLUn/se2nXzffMM2Z7rLqSklsEGDiURZuPFCgd7v3tm5s
         G2/bjvzEhAsFV3e+CoktW+OEMUMHfHxYwIpl/izb4WiPCn92q2eDQ8HsaND59mB7uRg7
         9SJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SFU/Z5qoWTfk9A6p33abSYOx6uOlq53OHyZ9STh41bs=;
        b=ULWn6te6M9p4T1j999/s6bdmdyLzzxi9LoUibuPefUxX7SY0ftp4Vl1ew0VOuUu3YM
         5zQW4j6l2NPHImECDOBjTUx5qjS7W/zR7+1refoFY5UuV8fwiT1lQg3vueiR6Ioct8nh
         kmH3LLEivIcV+C4PPieVhoqMa3vt34g+TKrCcen0I9o4Wz+QYJUGaas2Zlfw0bXVbAz1
         sbbFIxsIvT1he1XAO8ZKuNSLJKojXCfjHyGy0g+VLU68KZ821DDiwy6UQ1IuZmEBiX6k
         jgNN72VVLnk+uMKt3seNgRZCD/BG0ExWbTf1wvjzPZw+6B4Z8SGpSwsgC4CiYbKDRm+I
         Z5Mw==
X-Gm-Message-State: AGRZ1gJAtY8DWOwWl/wYdHChNhUTQb9Z4tapfgpp7OTpvjm6NW7Jr9LZ
        Ok8/Q1D3A/Rq2k9H6ah4rfw=
X-Google-Smtp-Source: AJdET5fydtralHS9H673Op+hIecAiP5w6xNVsn/OrsGUAjISukUnOQSIuLRb6n1WmmhD4eiAWUebmg==
X-Received: by 2002:a17:902:20ca:: with SMTP id v10-v6mr27077351plg.182.1541515172906;
        Tue, 06 Nov 2018 06:39:32 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id b75-v6sm55261913pfe.148.2018.11.06.06.39.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 06:39:32 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] powerpc/vas: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Tue,  6 Nov 2018 09:39:30 -0500
Message-Id: <20181106143930.8604-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/powerpc/platforms/powernv/vas-debug.c | 28 ++++------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/vas-debug.c b/arch/powerpc/platforms/powernv/vas-debug.c
index 4f7276ebdf9c..4d3929fbc08f 100644
--- a/arch/powerpc/platforms/powernv/vas-debug.c
+++ b/arch/powerpc/platforms/powernv/vas-debug.c
@@ -30,7 +30,7 @@ static char *cop_to_str(int cop)
 	}
 }
 
-static int info_dbg_show(struct seq_file *s, void *private)
+static int info_show(struct seq_file *s, void *private)
 {
 	struct vas_window *window = s->private;
 
@@ -49,17 +49,7 @@ static int info_dbg_show(struct seq_file *s, void *private)
 	return 0;
 }
 
-static int info_dbg_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, info_dbg_show, inode->i_private);
-}
-
-static const struct file_operations info_fops = {
-	.open		= info_dbg_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(info);
 
 static inline void print_reg(struct seq_file *s, struct vas_window *win,
 			char *name, u32 reg)
@@ -67,7 +57,7 @@ static inline void print_reg(struct seq_file *s, struct vas_window *win,
 	seq_printf(s, "0x%016llx %s\n", read_hvwc_reg(win, name, reg), name);
 }
 
-static int hvwc_dbg_show(struct seq_file *s, void *private)
+static int hvwc_show(struct seq_file *s, void *private)
 {
 	struct vas_window *window = s->private;
 
@@ -115,17 +105,7 @@ static int hvwc_dbg_show(struct seq_file *s, void *private)
 	return 0;
 }
 
-static int hvwc_dbg_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, hvwc_dbg_show, inode->i_private);
-}
-
-static const struct file_operations hvwc_fops = {
-	.open		= hvwc_dbg_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(hvwc);
 
 void vas_window_free_dbgdir(struct vas_window *window)
 {
-- 
2.17.0

