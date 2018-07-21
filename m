Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C79FECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135A320858
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRY3LM+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135A320858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbeGUNuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:50:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39435 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729933AbeGUNug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:50:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id g2-v6so9026893pgs.6
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 05:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=puS/rJO8cP0CWWLHNR8DiIC8n1Lb4rPWwazmigLXvkc=;
        b=sRY3LM+rxhmk9f9vDbNJJ8W63uA9eq/KfgSXTCgW6liLw/J08W6PlykLHDfxelzCeD
         1kzB/CQYNHmjoympkhAENv/NJLsg1qDnH4vMRx7ITfC2JUxmi1c9nxXGJYDZEvi8MZjn
         dE7zUeaHZGIiFvaDprf9ezDcBJ7PUIW6thNubschbyKiUUAoiK9+kFjLSOI37UDmhd8Z
         u1h4zJ/e9Hh7sCiMBVpoC0hB6QxRG1PrB9d3MJX3ynqvu8VB5fegZ485zvv3DfyAMNdo
         xldD1MPfvWQc2HNl1wgpg3HDmq/LlFZjaF25TPSyfzPAiGJqf1S34CoYbUNLqGliCDbR
         m7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=puS/rJO8cP0CWWLHNR8DiIC8n1Lb4rPWwazmigLXvkc=;
        b=PN/6uxwwYgfCzSTC43IbsGGrtxEvEA9c7xGH5Cy1EE4GtyHqukTe/tHO7XfoIaHCCa
         acxV+1XTekSo7tNHiNnjSwQd2YoFqt2A4lGy4sTcKhe0T04vBrfZSfjE+QCGvPTHGpZo
         loCjqY4eh3vtWVT5F+yYUyR5/ZFvi0rEeLkIBQVq5Ys9wUxf9PEML9aGr0oSm+ubXD3n
         0uWZNxfhnKEsPjifRqKWZGApIfJz27XiA0XJQdvD2vQqxy3LlpM8VqwLWt1uClGL+DMb
         mzlwz7z2mz9n6kr4k9aMtu8BgjjIb0IeF/hcDAEM4qdEQc1x8swegkJ7DeJPTBJtbvHN
         NflA==
X-Gm-Message-State: AOUpUlExZ1UUJLd1JgmhAwFdyUhHAWAlWiL8RYLbMluQn01C3lX1U/40
        iO6L0bKlJP2zHHO/yB7BSG8=
X-Google-Smtp-Source: AAOMgpdT6MSC8+Y+bBkW5UKyBTaZwv0wmBHA/DDdIiv59st8aDB8WLnZvBDK9AD/2jhvWQpLxIgL3Q==
X-Received: by 2002:a63:fa48:: with SMTP id g8-v6mr5626259pgk.224.1532177876216;
        Sat, 21 Jul 2018 05:57:56 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id d19-v6sm1072542pfe.42.2018.07.21.05.57.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:57:55 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>,
        Simon Que <sque@chromium.org>
Subject: [PATCH 13/20] staging: gasket: gasket_mmap use PAGE_MASK
Date:   Sat, 21 Jul 2018 05:57:04 -0700
Message-Id: <20180721125713.88501-26-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721125713.88501-1-toddpoynor@gmail.com>
References: <20180721125713.88501-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

gasket_mmap use PAGE_MASK, instead of performing math on PAGE_SIZE, for
simplicity and clarity.

Reported-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Simon Que <sque@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 3cf918f9d2604..ae5febec8844c 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1591,7 +1591,7 @@ static int gasket_mmap(struct file *filp, struct vm_area_struct *vma)
 	}
 	driver_desc = gasket_dev->internal_desc->driver_desc;
 
-	if (vma->vm_start & (PAGE_SIZE - 1)) {
+	if (vma->vm_start & ~PAGE_MASK) {
 		gasket_log_error(
 			gasket_dev, "Base address not page-aligned: 0x%p\n",
 			(void *)vma->vm_start);
-- 
2.18.0.233.g985f88cf7e-goog

