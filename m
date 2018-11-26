Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F9DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A99320817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwsamLLt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A99320817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbeK0Bbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:31:33 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35517 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeK0Bbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 20:31:32 -0500
Received: by mail-pg1-f194.google.com with SMTP id s198so6266359pgs.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 06:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Tc9/HM7ZycuFbB3IFNwvRj7R8Fg2ugfxq/QhzjjzQJI=;
        b=HwsamLLtubC2sJniuMalLmC+1T/STMnRSQWV6wf6D+JP3TE2NKlGjo15oiNXSZmxTJ
         vVFEw9JaXdfuxGeMOeAQiwX6/U9TJBv/DEtyvJsucVZzrAUOhwgHVfRbccvApQESCIqJ
         Nvi6UosDydQ9cbWzfDeW6KTBUpJleuOrR6SmvnAqgxuS+HoiNNpwyKoG0TrBQZSMxolG
         T2T7UIUlKV+Z1X+YnoGNdWVriPpoOP0ak7M0hyb3QxuNsQHSTh/AQp9IHZCDeohwaufj
         TI7Mx4d2IT+6l6/LRQ9l+S5Cz9XB5bznOX5ctREYZP0h3D1H7kpJ3lQUrhmKrjLdgF7b
         R3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Tc9/HM7ZycuFbB3IFNwvRj7R8Fg2ugfxq/QhzjjzQJI=;
        b=ljq1D00Sw1E66p8/vTOFa5aFWzhZddZh7XjrSorTVctvDtDF7ibBzgyIemHJp1+fU/
         iChMg566m54GcpCFvVYb5/7a+umwsGw1zpQ03rPdpJ8cQ23Xfn+kjGPFbvgp9P6KUYOc
         u4PDpuG7svt+mFExivIi4I3yq6LXh3bUMl7pTU8xjfETZc17laaFkR3QYP0gBi46GC9i
         WAyk4vmYZUrO20pOuzgjKg1qeWkiP4HuHDLcMrv/a27tEgC9j1U0SZhMzI/ZwSyh4hJk
         3mIyWbNnm+l2xzOvlYzCXNt2caW4+dQSogq+va1PW/I0nId77SmeVvvAW9IHpbyaCH+v
         rRIA==
X-Gm-Message-State: AGRZ1gIri0L3LsPx7KFRFVen4UWAiqSmUhHgH1k8xY6LeGUxdes8AKrn
        MhwaK7t4lliTDb6FEMRCZluuhHCPj2o=
X-Google-Smtp-Source: AJdET5c+7gMx5/jh7soYEzCfd+ughL13wQtE4MVcDjEbym1OKTFW/jujFjw83xmWtgFG1NITqp4mOQ==
X-Received: by 2002:aa7:8354:: with SMTP id z20mr27836415pfm.81.1543243034054;
        Mon, 26 Nov 2018 06:37:14 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id f67sm581026pfc.141.2018.11.26.06.37.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 06:37:13 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     tj@kernel.org, akpm@linux-foundation.org, linux@rasmusvillemoes.dk
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] async: remove some duplicated includes
Date:   Mon, 26 Nov 2018 09:37:10 -0500
Message-Id: <20181126143710.31409-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

we include workqueue.h twice.It's unnecessary,so
just remove them.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 kernel/async.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/async.c b/kernel/async.c
index a893d6170944..4932e9193fa3 100644
--- a/kernel/async.c
+++ b/kernel/async.c
@@ -55,7 +55,6 @@ asynchronous and synchronous parts of the kernel.
 #include <linux/wait.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/workqueue.h>
 
 #include "workqueue_internal.h"
 
-- 
2.17.0

