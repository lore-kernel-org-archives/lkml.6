Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C68DC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 02:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A59D20867
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 02:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mb+qpzI7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A59D20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbeLANXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 08:23:25 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35825 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeLANXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 08:23:25 -0500
Received: by mail-pf1-f193.google.com with SMTP id z9so3677063pfi.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 18:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=G9lKEImSCb9h64LAQplK3nSKd69N5Pcfd2raSSqcT90=;
        b=mb+qpzI7w/hOB5fXCN4bqbZYXoubpD6/3jrl7OLxaJwtQE23lt1FdJMtVikJt1S+vK
         2wIqjcS9W3KhF4Zn0b1pz+sDkcg7l+KrAnUfAKsgMtl/0g9s4DSacl6aSSVaU1fCCrpS
         uXONkFJKgDzMbdwqQsrtBfs6hQQdQauMGz+u117E8gHKOlQS8KmrjDRChzdOHDCVDqU6
         D+LOTFrH3sAU/Y4gOrXqoFarzMF1C+mPHSum//lTjIzrSxys+TIjAR+ZcM841g5ZfvIZ
         iifQ3cF5/+pm0EnnZyBQkpGeYCIirJll+cdXOJBDtqcRgJGd4xMDG2Mb5dJyRUQ1p/B0
         KzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G9lKEImSCb9h64LAQplK3nSKd69N5Pcfd2raSSqcT90=;
        b=REtemXHM79kqlr25Yfs/fsTIrKL38+mJ0bEw4+Kck3HRbsYEVcrb4uf3QHdbYiYi7b
         FArAcFQ/WvoJebvOUXziSFJlR6dXmW+zQPkPWMmqCbEDQSlMxNzgOw04U9viboD6h6Rb
         mY8HEjdhZt4oqPiwaay+lnCjAjQn8+1pfWF2KTke7UR43ox1GgQcj1puQ9idL6AzihXF
         BPDh9KhNO6zS8x7sfCMXDfaekUC92GvNcPX5clvT6ybWmxQcbYoutoU9YieV2HApb6K5
         GzuJ2tkfa3sMxxjHq5JsTDhBn2zIq0bkNy1MkRRZxfFomwDRoFbzNaGYfJW2Gu1c/1Ur
         y8Gw==
X-Gm-Message-State: AA+aEWbAxkye+jvwb8C9ptf9N+/GJ9KHhJDYKrY3tceC6jY8U9Td3w/h
        kqrr0JCwxKc50eR8ruG6Qjw=
X-Google-Smtp-Source: AFSGD/UlJYRUCdTFRTHfX/nxbh9EOVPdWb0dT9sYAtFa2d2oznx4uetjUpwM+f4MO7B7s+8hzoUxSA==
X-Received: by 2002:a63:42c1:: with SMTP id p184mr6648274pga.202.1543630323929;
        Fri, 30 Nov 2018 18:12:03 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id d3sm8843511pgl.64.2018.11.30.18.12.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 18:12:03 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     robh@kernel.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] bus: mvebu-mbus: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Fri, 30 Nov 2018 21:12:01 -0500
Message-Id: <20181201021201.5011-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/bus/mvebu-mbus.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 5b2a11a88951..3aaaf484857f 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -470,17 +470,7 @@ static int mvebu_sdram_debug_show(struct seq_file *seq, void *v)
 	return mbus->soc->show_cpu_target(mbus, seq, v);
 }
 
-static int mvebu_sdram_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, mvebu_sdram_debug_show, inode->i_private);
-}
-
-static const struct file_operations mvebu_sdram_debug_fops = {
-	.open = mvebu_sdram_debug_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(mvebu_sdram_debug);
 
 static int mvebu_devs_debug_show(struct seq_file *seq, void *v)
 {
@@ -520,17 +510,7 @@ static int mvebu_devs_debug_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
-static int mvebu_devs_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, mvebu_devs_debug_show, inode->i_private);
-}
-
-static const struct file_operations mvebu_devs_debug_fops = {
-	.open = mvebu_devs_debug_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(mvebu_devs_debug);
 
 /*
  * SoC-specific functions and definitions
-- 
2.17.0

