Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D10C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97E220B6F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:46:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E97E220B6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732556AbeHNPdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:33:22 -0400
Received: from mail1.windriver.com ([147.11.146.13]:51335 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731841AbeHNPdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:33:22 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w7ECk9hm016415
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 14 Aug 2018 05:46:09 -0700 (PDT)
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.399.0; Tue, 14 Aug 2018 05:46:08 -0700
From:   <zhe.he@windriver.com>
To:     <jason.wessel@windriver.com>, <daniel.thompson@linaro.org>,
        <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <kgdb-bugreport@lists.sourceforge.net>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <zhe.he@windriver.com>
Subject: [PATCH v2 2/2] kgdboc: Change printk to the right fashion
Date:   Tue, 14 Aug 2018 20:46:01 +0800
Message-ID: <1534250761-824-2-git-send-email-zhe.he@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534250761-824-1-git-send-email-zhe.he@windriver.com>
References: <1534250761-824-1-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

pr_* is preferred according to scripts/checkpatch.pl.

Cc: stable@vger.kernel.org
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
v2:
- Split printk cleanups into a single patch
- Add cc to stable@vger.kernel.org

 drivers/tty/serial/kgdboc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 206f8c2..0003d6c 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -136,7 +136,7 @@ static int kgdboc_option_setup(char *opt)
 	}
 
 	if (strlen(opt) >= MAX_CONFIG_LEN) {
-		printk(KERN_ERR "kgdboc: config string too long\n");
+		pr_err("kgdboc: config string too long\n");
 		return -ENOSPC;
 	}
 	strcpy(config, opt);
@@ -253,7 +253,7 @@ static int param_set_kgdboc_var(const char *kmessage,
 	int len = strlen(kmessage);
 
 	if (len >= MAX_CONFIG_LEN) {
-		printk(KERN_ERR "kgdboc: config string too long\n");
+		pr_err("kgdboc: config string too long\n");
 		return -ENOSPC;
 	}
 
@@ -264,8 +264,7 @@ static int param_set_kgdboc_var(const char *kmessage,
 	}
 
 	if (kgdb_connected) {
-		printk(KERN_ERR
-		       "kgdboc: Cannot reconfigure while KGDB is connected.\n");
+		pr_err("kgdboc: Cannot reconfigure while KGDB is connected.\n");
 
 		return -EBUSY;
 	}
-- 
2.7.4

