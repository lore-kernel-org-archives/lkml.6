Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC122C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA29020865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwoTnmGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA29020865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbeK0CAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:00:11 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34557 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeK0CAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 21:00:11 -0500
Received: by mail-pg1-f195.google.com with SMTP id 17so6302090pgg.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 07:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NazxSi5ik76oitAq5BSFqqFXY6ul7643OmyaTfEYwRU=;
        b=hwoTnmGee3Btf7f28GKYqCNlxE9Rouhwq3eJqJexjbccvZuJLdLDd11JrfLXzoN3ec
         X8UALgzclkiS1Dd6wZ5JZJtRNAt1Qpwy+0w3NXM0Am3f2984OhkF0tJVruX/eXAZZfy1
         /OhaIMSZzXMcTgKEBnesbfEG7Px/O1GjSJAZyMxcRqMaXfDeaRebw+ym2RxUDvn78Jbz
         AZ7EPf5lpjMSV9yMcpi6E/APEb/+srneaXzwgC8o1wVz5e2XUagi0cHsvB7sIcoLyh0e
         js2iWmf8F95yCN65ZOxrOOG6OXdJFxRhpJ5e/mWDkVNSnxCGY/6yqeBdnZuBe4TCtSJx
         yl6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NazxSi5ik76oitAq5BSFqqFXY6ul7643OmyaTfEYwRU=;
        b=iZMxV9MX3eGil1lPP8qkw2Lb3BTdIrNyULc8a+w9yu9v2dDZStHD4KkKFUOLag/Uu3
         zg/7x7tUpaqEFASBW58FNGAvlMVQZuve+du9+29Ks62EwmGIaKzPEXsZ3rvAE+jlHph5
         NakgdG1ydcQuSKHzQ3SYGGQzvYWiUloI8LNRRJDL0iGvu9v7NwC+6OeddKyQcvnhnURz
         tN2M1mf3QimLy34i3osjNosQvzILAKxpPiOWKt60cskKZC/LCLjtrPnRXK/Xe0unD/1Q
         gk/bRlyJKh8mFYZS5GuTmLrBp1+/Jt4Ej+Ikb4dFMM8p5tqd2ELLAJFlk3LWA7l4eTDC
         4b4Q==
X-Gm-Message-State: AA+aEWYz4wmodRbHJtIi8LlppIl0jOXmxMXqP+4SUgHDb2RMvnmnVa9G
        qxNH6RKCxWOEoNf1OWP8Q8txn94vCD0=
X-Google-Smtp-Source: AFSGD/V236CqI45RAPTm5atyJYsO4DG5asGFo9qFuqx2kNhVWZA8ViVrl/LNt/+mlZPwnYDrXyeBnQ==
X-Received: by 2002:a63:fd0a:: with SMTP id d10mr25687104pgh.164.1543244748153;
        Mon, 26 Nov 2018 07:05:48 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id k137sm820643pfd.56.2018.11.26.07.05.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 07:05:36 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     paul@paul-moore.com, eparis@redhat.com
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] audit/sc: remove some duplicated includes
Date:   Mon, 26 Nov 2018 10:05:23 -0500
Message-Id: <20181126150523.32124-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

audit.h and fs.h are included twice.It's unnecessary.
hence just remove them.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 kernel/auditsc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index b2d1f043f17f..6b6de6e0540e 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -47,7 +47,6 @@
 #include <linux/init.h>
 #include <asm/types.h>
 #include <linux/atomic.h>
-#include <linux/fs.h>
 #include <linux/namei.h>
 #include <linux/mm.h>
 #include <linux/export.h>
@@ -55,7 +54,6 @@
 #include <linux/mount.h>
 #include <linux/socket.h>
 #include <linux/mqueue.h>
-#include <linux/audit.h>
 #include <linux/personality.h>
 #include <linux/time.h>
 #include <linux/netlink.h>
-- 
2.17.0

