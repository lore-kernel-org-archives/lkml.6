Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C516CECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764E020854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuKVlaM9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764E020854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388184AbeGWWov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:44:51 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43650 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388077AbeGWWou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:44:50 -0400
Received: by mail-pl0-f67.google.com with SMTP id o7-v6so765468plk.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 14:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=Ey5r80BOqe2Fd4zBYxzKpvIOZGUYVpItlVHePA/5xUw=;
        b=VuKVlaM9DS/rbAiHjF7njTWIAYuK3e8dJL4tssGHbdDKG0BYWgLR4A+mHd3ZZ2jH4k
         L54Zb1LhzsJNjZYCA6BtRmCrDX6mJbd5uWPOps1KFWe5FF1+mIw0PItYZhv3sZ3eOWRO
         k8fBy7U0epApYptnIA0Qr7O7nKBzT5nZB+ytrW9b+dKVCwVF1gNXv263IUIz8cTDHALe
         K7zQoFUSUdTHo1B1eeNPXskWaKFBW0Vw8UAi7b4WK2pe7soj7yUtAVdErkr89OmsAWSA
         Hz/YL8s0Ix0InF+/TboeWW8Qm8f2puuqvBWXDBAy9AcsF4f3deGtTiAq41sNZXTTRP6y
         Mo/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=Ey5r80BOqe2Fd4zBYxzKpvIOZGUYVpItlVHePA/5xUw=;
        b=aACwrYqgVZkDN5Vp7+YKGxCf83AJqVGdSJQM7qKc7rBkB/dvbwnJccAee+TL6O4ux2
         eUNlIoIvqDr4oIvv+gSpv3PArckU+tKNy7H1MqrBjnR2wRJaHj5B7ezHK8dRJ91LECm6
         xzK3g1RZ1YTnGrTD2mIC8tXtqG6XVThPPCLQ9JEjCafNprVwxQyCpo8SYaeL2h3ICoYd
         hX+TzDsKh63E6Fmjeq15xLIvRoFMZdue/ZaV96LUs5V4tqwDs84sXG+QMVYQzcG6QnSR
         cOc1VyvjQljQZ8EjIi0l4xV10bS3Xo+vLP1Mx93pSdn5OV4NvYiT1TLEJHPyRg2ql+PB
         yVPQ==
X-Gm-Message-State: AOUpUlHr5qgJX0nalpmRujngUWUzKqjl0tbK3Znc8hUphDow+DPFakgi
        lHEdpYsogS2qgsCf98jZYkk=
X-Google-Smtp-Source: AAOMgpdLd+b1T7gDpMaM/tWucZjXHO+zZr2mxJwlnbbSZq9mQzIh4D8ETw0fI1dTcWSCV2NPeYfhVQ==
X-Received: by 2002:a17:902:c85:: with SMTP id 5-v6mr14467999plt.141.1532382101069;
        Mon, 23 Jul 2018 14:41:41 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id g20-v6sm14995454pfo.94.2018.07.23.14.41.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 14:41:40 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] android: binder: Include asm/cacheflush.h after linux/ include files
Date:   Mon, 23 Jul 2018 14:41:38 -0700
Message-Id: <1532382098-12032-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If asm/cacheflush.h is included first, the following build warnings are
seen with sparc32 builds.

In file included from arch/sparc/include/asm/cacheflush.h:11:0,
        from drivers/android/binder.c:54:
arch/sparc/include/asm/cacheflush_32.h:40:37: warning:
	'struct page' declared inside parameter list will not be visible
	outside of this definition or declaration

Moving the asm/ include after linux/ includes solves the problem.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/android/binder.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 95283f3bb51c..1cc2fa16af8b 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -51,7 +51,6 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <asm/cacheflush.h>
 #include <linux/fdtable.h>
 #include <linux/file.h>
 #include <linux/freezer.h>
@@ -73,6 +72,9 @@
 #include <linux/spinlock.h>
 
 #include <uapi/linux/android/binder.h>
+
+#include <asm/cacheflush.h>
+
 #include "binder_alloc.h"
 #include "binder_trace.h"
 
-- 
2.7.4

