Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF6AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC0B20862
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIWy57oK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC0B20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbeK0Bw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:52:56 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44564 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbeK0Bw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 20:52:56 -0500
Received: by mail-pl1-f196.google.com with SMTP id k8so3344531pls.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 06:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1o8lSwjEPZ3h5U+NDRTqrxZ7R8/P82SB3E1BPnmJZYw=;
        b=fIWy57oKodAje2X98H6wncOfsdZkXRg0NgHWa2aVJUDWMxFbtTGjphi66cBN5FdjHW
         92TzWph7vamNwnw7hSvY2LneTZ9EQU9e6wr+UT5Qf4/eH+m1FueMcG+Doew+d8ojvVO9
         Mfz2dUhhcuZxWyubWSEGO1ZUn0AP2RwKmAc6e6rp7D4hiAk6oIDXcXL4XdxlZJ0lQCf3
         ADnsKRRmTnr0RfEJ/JX9zrR3e+gS4Dg0tJv0uOIqQ/x8rVeTIRe/lfZuafbP6Ipvk1pX
         g2TZfUodPFcecGzuX8qCYMj7bgsQhfz2dlFJ/iavAjS4Ml/g2ze9dtj0NoPIuZMXMkPp
         ENtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1o8lSwjEPZ3h5U+NDRTqrxZ7R8/P82SB3E1BPnmJZYw=;
        b=jJ3BugwbMgBo1wiD22jR1IzvPMvEeMq57cB/WjCpxJH/3+0aIHiQWaezwwun8xsD/i
         +aHpqMbyMHjqTunsbCgm0Ug5J7dEq+6R0bv2M8nj96edGpIQfmjIaZzvnOpzEx1m58i1
         ECvrQt8z5e4VasxiGkMz5Y0lZa3dzTt0dzeRY7r+DKWbwddzu9gT/p4v+Ksswa54M6fL
         GFwmT/7jaqwj6z1wdk7SZ7mXUyb7sLKcxdOYANcp8SNMA45/tPpy3mswI+hVM7gT5+z3
         WRPu51wZfQ+Mf/93ExZEG3egYVNPCfDrc9myGhAbyF4K5HxVxYRH4U4fVh/fCYuevjWv
         HQwQ==
X-Gm-Message-State: AA+aEWYVH9vgVe9/hW1qFmEUZzcN2bo/RhFz6CbVWsAMUudjK8eynF1v
        ZtNQkFkaMSFNN1hnTmcETCw=
X-Google-Smtp-Source: AFSGD/VgKLBKC9Zz0mvLPW0wX8K6N6E5oQFTvzGSytdJ3yDTdynSprQ1RxChdPsNPNfrpZ5SDpj3gA==
X-Received: by 2002:a17:902:5a86:: with SMTP id r6mr27116593pli.301.1543244314745;
        Mon, 26 Nov 2018 06:58:34 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id l19sm2266967pfi.71.2018.11.26.06.58.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 06:58:33 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     paul@paul-moore.com, eparis@redhat.com
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] kernel/audit: remove some duplicated includes
Date:   Mon, 26 Nov 2018 09:58:30 -0500
Message-Id: <20181126145830.31882-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

audit.h and fs.h are included twice.It's unnecessary.
hence just remove them.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 kernel/audit_watch.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 787c7afdf829..8c8b1a87fd2b 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -21,10 +21,8 @@
 
 #include <linux/file.h>
 #include <linux/kernel.h>
-#include <linux/audit.h>
 #include <linux/kthread.h>
 #include <linux/mutex.h>
-#include <linux/fs.h>
 #include <linux/fsnotify_backend.h>
 #include <linux/namei.h>
 #include <linux/netlink.h>
-- 
2.17.0

