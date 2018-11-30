Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E23C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2FF920863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vZEc/CGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2FF920863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbeLABxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:53:24 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40650 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbeLABxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 20:53:24 -0500
Received: by mail-pl1-f195.google.com with SMTP id u18so2908873plq.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 06:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6w/LWjvzd5ziwQooD9fOXYUVsB/B7XtRyy2LAn4jSO8=;
        b=vZEc/CGRe5wPZQ8Dxu/uTXKDZ/MEsbSlkpXECCUDTnlGMPbMFBOPPMcLDoxjDMmj4Z
         MVz3w2lHk7MzAnmMaXBtpOIhGoOhPSmnCRR9Meb6OKlCH3eWeLfkS5GznwZHNKtq4FyC
         2QhhM2mvevmtwRHfNB1FU6M/V/PCa8cwpT7wFPlrVM/XqzJq7tz0/LesEK8ePxbbKzUS
         1Xl4SHIseOr0MzZQh6adrClAi9TwetrxWD/viI5FaDDldeNtBi8MX1DvPjrIWbDOMsYL
         zITwYcMjon0v3Wwp8vsr4Yk7eyLXahvQvQzYFGbUuGGl74l7Ik8qft6KFop9Izdnb9Ya
         gqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6w/LWjvzd5ziwQooD9fOXYUVsB/B7XtRyy2LAn4jSO8=;
        b=k1byr71TOvp3Qdho/q5zdgKiScldP8zUZdvxMvS3jF3mMHsuahJYcqkZ5cF/hFq4zM
         5qGA4bjx2kYyGKLBF59aZ6knXLFDGwYYkWDsdIcaMEmWPlrLI8Y0oRvGtksx1JhJG0d8
         PuBZUQ4GNLQ50oyvRbCTUNqFm7On8okG42VRDEvZaUBRlzZE7dW5vplxgsIRvdtgOubk
         RNI8tU+Jmtc3LD6oNAXznSHPBUAPdRLk5G7Hr9ChDmnp9uuouk2x9EuI+YLQdmc3ONA2
         V6ksqWrYdNqy2NF5+cuJBPF0kRA4M2CAas55OM0VxWKIFIbBTqgTDI7/o0ctcBp2fJ8D
         jIZw==
X-Gm-Message-State: AA+aEWbR5KkkKwrPuXGaPvEpOtqIQ9VpgLXl5pe5FvxONxHMyXh9gFEa
        bux4YEWxSiwdTVushNn9N+Y=
X-Google-Smtp-Source: AFSGD/WXl2U8zZ8gu/miHsQTJlhTGgRrpZV7o3nb8JR6Lfx47REHinKcBqXfNqYoTisBZd5crbQ0Ww==
X-Received: by 2002:a17:902:128c:: with SMTP id g12mr5712834pla.146.1543589032009;
        Fri, 30 Nov 2018 06:43:52 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id j6sm7976452pfg.126.2018.11.30.06.43.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 06:43:51 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     labbott@redhat.com, sumit.semwal@linaro.org,
        gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org
Cc:     devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] staging: android: ion: Remove unused header files
Date:   Fri, 30 Nov 2018 09:43:48 -0500
Message-Id: <20181130144348.2877-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

seq_file.h does not need to be included,so remove it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/staging/android/ion/ion.c             | 1 -
 drivers/staging/android/ion/ion_system_heap.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 99073325b0c0..0d61e9cd0887 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -23,7 +23,6 @@
 #include <linux/mm_types.h>
 #include <linux/rbtree.h>
 #include <linux/sched/task.h>
-#include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/vmalloc.h>
diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
index 548bb02c0ca6..9ce2c0d7ac17 100644
--- a/drivers/staging/android/ion/ion_system_heap.c
+++ b/drivers/staging/android/ion/ion_system_heap.c
@@ -11,7 +11,6 @@
 #include <linux/highmem.h>
 #include <linux/mm.h>
 #include <linux/scatterlist.h>
-#include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include "ion.h"
-- 
2.17.0

