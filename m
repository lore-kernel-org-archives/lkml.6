Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EE1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD3220865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwyDhxLR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD3220865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbeK0BPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:15:41 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39913 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbeK0BPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 20:15:41 -0500
Received: by mail-pf1-f196.google.com with SMTP id c72so6648031pfc.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 06:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=e8MKGo1wN3pepfQZAhlTM/v0u8YmzB6zSqmP2Wm/QeU=;
        b=QwyDhxLR+2AtMjVlZzZ784FNoDKRkrxopf6gQRWFHD1qgvGLjb0mTChpsBpH1RCe1h
         TfpNe6W82+A5pkT0UWYs8yEOCIf0UmXAOLF6fQbLZFkIwpM2BpbtXWAn+XyYfGknzPxp
         DjW7NE0Mxa3l89S3chHTJinX6AX3Gp8HB1U1UjNCrtde8qU+ngLqvWAYE9DkxtmX1292
         6qGQRHD6ffG0WAa0i1x1ufVyljFUmU9XFTBdi2E0hCRs8+ikuUkSmgZ0VqpgErsZtrnc
         Tur6IcOkwqBqcBMGEwH2tpS8pKJ9iOWwrmTKW4RxK9shGqmuNlP8Bb8QMgMnvvBQO4z0
         /KhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e8MKGo1wN3pepfQZAhlTM/v0u8YmzB6zSqmP2Wm/QeU=;
        b=Hw+Qo0GxubCvgCtLKC6FovhRQ+9YEFAq2+X70Fqk5YxgflwXZHTNYcSxs59sqFXxKs
         UccTih6Jsphk4dA/k3EiQjT5KUAlhfXAD0kfgdOOxn38Awf/aG1Nr6Ah0/6mQsNHM2Ay
         EeZMTQ9ne0UA3Ad66Lns5lEkGHihX6D163n70BninN5A2+MR2hde/dk2UHvOUuC3pEeX
         YVmcN2LGvuQl+jlYN986VUhfrGhoLyAItteKgO7zpF+307FdT2BFzTO168phVdAWfSTc
         qbtTU7IZ0Cn4BHVbTwaFWvnNybZZS2D4nTIB8Uo/hYn+aEm1X6R/pn0R2C5oVnHadJw2
         sZQw==
X-Gm-Message-State: AGRZ1gKcxHTn3WkOLbiLa4MPPZuEBcY4bOMbKSZity/vciKWrEg5AkjY
        71rpmrxyojyMTEinymWQA1gVZIUBf/U=
X-Google-Smtp-Source: AJdET5fiHcOdNUfmL04ayyDZp3QK2jVHNramR2MyiYAdM1i78SfZykF+GLWFemzlod9CqPHX19JeQg==
X-Received: by 2002:a62:f54f:: with SMTP id n76mr28207348pfh.59.1543242084737;
        Mon, 26 Nov 2018 06:21:24 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id c67sm563575pfg.170.2018.11.26.06.21.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 06:21:23 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     jeyu@kernel.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] module: remove some duplicated includes
Date:   Mon, 26 Nov 2018 09:21:16 -0500
Message-Id: <20181126142116.31090-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We include elf.h twice in module.c. It's unnecessary.
hence just remove them.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 kernel/module.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/module.c b/kernel/module.c
index 49a405891587..438641fc4096 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -28,7 +28,6 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
-#include <linux/elf.h>
 #include <linux/proc_fs.h>
 #include <linux/security.h>
 #include <linux/seq_file.h>
-- 
2.17.0

