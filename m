Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6687C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE2120684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lshLQWrc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE2120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395217AbeKVXq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 18:46:56 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44701 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391150AbeKVXq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 18:46:56 -0500
Received: by mail-pl1-f196.google.com with SMTP id s5-v6so9258021plq.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 05:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nxOOxLheUCjG33KOamsBUmgiVbATibex+BZnh/eKLHE=;
        b=lshLQWrcxS5QKjjes/gbw9+oO4Zp+21+u+i/Hgv1aIZIb1JpvhLulfboUKqmwU1U8K
         ZAL/1XCkcHclDWzw+DzyG8tBfqCRBjPYO82JYzpVQkUUrqiIzA3MPP91Ecu7evenvrFt
         TEn4D8cyu9vYBUQhTbc70rvq9RnXdeTfWn4qBBUGGl5iRENLAuFtiSCQtdeVG2/2y4pw
         MiwgB0Cs9eKP0RcSSHaNSW4IT7UVEPkIrzx3x0oRhSrFk4g2H7mmyV/u0gEjJncUtH/+
         JLw2FfQUW+JluI2SWYMidSMzrXzP8ZQ1rr1/zjbfyaGZcqHcDt+Po2KKacgdCv1FYaOe
         Zd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nxOOxLheUCjG33KOamsBUmgiVbATibex+BZnh/eKLHE=;
        b=l33CTbX3+devfyo98CIDEAoPHTRcLtLlCjudrvP0VeKMxyezRPAO/0G12eKid5/9+q
         BSjuzjCQV7+/QDsTI/M594P4Wsym1M+9EM3S6Nlg9OzxfrfXZZ+0EtUqtuhJXHpL8tAL
         FM+pM13ewQfIVChz51ipSRanSFn6Jj8GdAK02shngjbSiqQDtDCFgFWYkkAwPRIrQKKG
         3rBWSJF3kj/HvrA55Eb4a/lOOmC7eaB4Tkeu29Lm7ye+5n86f8f1+ImzBBO+0MGAPpvZ
         QFCXYaEs2nWy/ZdN4jeKXC4L01gSeo1MZcP+aEQDAV2L9bG/2jkcYe6pQ+tuPMNc8WM1
         myLA==
X-Gm-Message-State: AA+aEWZmQNOhO4zgddgAWEC20Pg0nLkpzXh5dSWL/oc8FJNJ027PjeZp
        eijjcq2qVDF5W+pAJFZjuQU=
X-Google-Smtp-Source: AFSGD/Vff8QKhbhofBJZS+vbKdhhUBjnMdaRprK+aTUFUcdGw37eeXyXU3F2BZ0zMTKnsl6xHQ9mWw==
X-Received: by 2002:a17:902:144:: with SMTP id 62-v6mr10878102plb.142.1542892060080;
        Thu, 22 Nov 2018 05:07:40 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id n13-v6sm74628717pfk.19.2018.11.22.05.07.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 05:07:39 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     ssantosh@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] soc: ti: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Thu, 22 Nov 2018 08:07:36 -0500
Message-Id: <20181122130736.24703-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/soc/ti/knav_dma.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
index e05ab16d9a9e..2a66f36b9fd6 100644
--- a/drivers/soc/ti/knav_dma.c
+++ b/drivers/soc/ti/knav_dma.c
@@ -355,7 +355,7 @@ static void dma_debug_show_devices(struct seq_file *s,
 	}
 }
 
-static int dma_debug_show(struct seq_file *s, void *v)
+static int knav_dma_debug_show(struct seq_file *s, void *v)
 {
 	struct knav_dma_device *dma;
 
@@ -370,17 +370,7 @@ static int dma_debug_show(struct seq_file *s, void *v)
 	return 0;
 }
 
-static int knav_dma_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, dma_debug_show, NULL);
-}
-
-static const struct file_operations knav_dma_debug_ops = {
-	.open		= knav_dma_debug_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(knav_dma_debug);
 
 static int of_channel_match_helper(struct device_node *np, const char *name,
 					const char **dma_instance)
@@ -778,7 +768,7 @@ static int knav_dma_probe(struct platform_device *pdev)
 	}
 
 	debugfs_create_file("knav_dma", S_IFREG | S_IRUGO, NULL, NULL,
-			    &knav_dma_debug_ops);
+			    &knav_dma_debug_fops);
 
 	device_ready = true;
 	return ret;
-- 
2.17.0

