Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F16FC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 08:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1022D2171F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 08:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAd4JFYA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbeLOIik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 03:38:40 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35409 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbeLOIik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 03:38:40 -0500
Received: by mail-pg1-f196.google.com with SMTP id s198so3789226pgs.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 00:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZKF7rTp/Hn9JYdXpbRNySs1ekX+o8UXhXsNs8bKO+fo=;
        b=NAd4JFYAeOxQAaeZEJjdHAZBN8Xxa/gbQcDH4CBB6J092pvjcjJDrW7qgrXCE2HeoF
         M9iSwiod+pYB8GvmyuW1C1tkPN5dSkoAITOm+oMVSVVlZzEDj9+6fXwMT0jU/WUt/ksa
         z9LhnNpIe6gaKti/ZbFYiZo8mwF0liXnOnRc4K85pkMdLaXmRwQzy8RRP8yZZyhly7dT
         yrDcrN6rEOhjTrLi1ABDBy90On4Vj03DAvB+Q12A2VKalyp0kOO1zu5rg/f8jjbWyo75
         /stZ1SMJTkFh1XJtIfMAge7sALKyVRMBAXXDWxpesepCNUX51jNJtALjwLmdpWX0Ntbq
         ysDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZKF7rTp/Hn9JYdXpbRNySs1ekX+o8UXhXsNs8bKO+fo=;
        b=tpheWzO9OKVLs6+I+IsCEDngcXn2ME3cijek+5NPfhEOv4tH2kQqGUx7qmTXldOxMx
         9b2saGOPgBM55Kwpk/bBMgn2GOA5TcKgtpJwdZ/Die6F9436QLfZdoNqfBwEjWs5f86V
         4B5pRngm8zw5p+DgBapL69FuuDBmrcQKJ5uppCopf2erVIO+oUm7qlvKvhhKQUQmnL3/
         KTp5rt34rVRbo+fnRPUsFBBs4eYf31kF/eEmqV0pzoFhrA52DFpRCan8i3gMzXlAspJj
         rNn/FCFCzlz8NDu/wW0ab6WfbNAjdrQqGMNAjr/svSjzG7JP2r2sW9Lkao6BpWYZbBDY
         LQnA==
X-Gm-Message-State: AA+aEWbyD34sypdb9uff9ZjRgmTAnmuuixuCaf+4XxVROgsHU1nSJfLX
        DFtttyIDi5VgcgNEOZ669R0=
X-Google-Smtp-Source: AFSGD/UHhLKtXoUg0ScShKtKwzG1+hDcesR/E+f/je4nyE9bTuXITLeykQvWj4x2s/FCQvpdlXbw0w==
X-Received: by 2002:a62:35c7:: with SMTP id c190mr5945618pfa.76.1544863119898;
        Sat, 15 Dec 2018 00:38:39 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id h19sm8549635pfn.114.2018.12.15.00.38.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Dec 2018 00:38:39 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [RESEND] regmap: rbtree: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Sat, 15 Dec 2018 03:38:37 -0500
Message-Id: <20181215083837.26928-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/base/regmap/regcache-rbtree.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/base/regmap/regcache-rbtree.c b/drivers/base/regmap/regcache-rbtree.c
index b1e9aae9a5d0..2e8f0144f9ab 100644
--- a/drivers/base/regmap/regcache-rbtree.c
+++ b/drivers/base/regmap/regcache-rbtree.c
@@ -177,17 +177,7 @@ static int rbtree_show(struct seq_file *s, void *ignored)
 	return 0;
 }
 
-static int rbtree_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, rbtree_show, inode->i_private);
-}
-
-static const struct file_operations rbtree_fops = {
-	.open		= rbtree_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(rbtree);
 
 static void rbtree_debugfs_init(struct regmap *map)
 {
-- 
2.17.0

