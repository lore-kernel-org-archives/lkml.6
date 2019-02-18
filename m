Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB01C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B35421848
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrfRk6BJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731129AbfBRNe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:34:59 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35352 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728394AbfBRNe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:34:58 -0500
Received: by mail-qt1-f196.google.com with SMTP id p48so19149498qtk.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 05:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iZCEbqvuPYM0o/t1tOYvQQXOc9SYnrV6rRZnbJJG2Jw=;
        b=qrfRk6BJJMSr4pSUysZmywbtT4SwpoXaRLmbkG1uewg/6rXYpa1H5ch3eTcKpmFpsv
         YVd+pVpk0jnkzdVyyppQfmZId/fMnvBSeTIhYOvKTyKCnsduldZsjjrbHWS7T8dGdGa7
         440mUWeDR/+kefgB6F7f9MxUPxFpbxyKJIZQix2hvw48sGdGj3coECQ4jgvaIdrsJkoN
         s26fA33TSHBbIIdC7romiJXREvykhEBy84duWnn0JvIi2vbmHdcfuPwBdX2WPRJZugmV
         v/2ve1MfltfjaIN+wdELavPQ16qExIwCzSv69bMmsl7vmXZd1ffIxxWxIZsQsc7Qnuo4
         kOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iZCEbqvuPYM0o/t1tOYvQQXOc9SYnrV6rRZnbJJG2Jw=;
        b=YvvPAFj8RDm+XGro+vU2YZMaT1UBUPUpgjBqqMxQ1o+W1Px4cEz5h6g0YTKqhAlzOP
         6gB8VIgc2UfJbRNucifg9N6ymAX+Au/MmTsJQJhem/sxTFiZjmVPmy6gIQLfx7Qds6+U
         /RBslYDW3F2RvWw6N2PyauqwlJBQzD0E1Tdys8LA7oJUpjlgHY+mpr4XKea1EpDUeRFc
         eZbwD1oMocdzmjQn0NSdgkTYR1eaWcCrM0eP5/Wyax6YzKbvOqI/1kE9NFVnuQnxHWgQ
         jfpzN4wT4Pbj/O36l9IkBrnKGZh3OpOAlsfJW/LQSDhJk5AXqHHDspO5O2w0e2sGJ29H
         eIgQ==
X-Gm-Message-State: AHQUAuYaihe+QlRVhQ8SfPi6KMIMTwyaiIymTYPdQvzPO0B25T/p+WDu
        bEq088kGzn/UEuCq6KV1eJAhvth5L70=
X-Google-Smtp-Source: AHgI3IbNc7mYOzAA+R3hLHfCaPA/TCBsu5XUytNsU2GKEVdWFtwtdrUb7fZXS2MVMQAIxPhlaLfMTg==
X-Received: by 2002:ac8:29b7:: with SMTP id 52mr18119587qts.266.1550496897948;
        Mon, 18 Feb 2019 05:34:57 -0800 (PST)
Received: from nessie.verizon.net (pool-100-15-144-194.washdc.fios.verizon.net. [100.15.144.194])
        by smtp.gmail.com with ESMTPSA id k62sm7212821qte.86.2019.02.18.05.34.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 05:34:57 -0800 (PST)
From:   Dan Robertson <danlrobertson89@gmail.com>
X-Google-Original-From: Dan Robertson <dan@dlrobertson.com>
To:     kieran.bingham@ideasonboard.com, jan.kiszka@siemens.com,
        linux-kernel@vger.kernel.org
Cc:     Dan Robertson <dan@dlrobertson.com>
Subject: [PATCH 1/1] scripts/gdb: fix linux constants
Date:   Mon, 18 Feb 2019 13:25:12 +0000
Message-Id: <20190218132512.19988-2-dan@dlrobertson.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218132512.19988-1-dan@dlrobertson.com>
References: <07923abd-117d-2a33-2700-7db0840eacad@ideasonboard.com>
 <20190218132512.19988-1-dan@dlrobertson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux constants MS_RDONLY, MS_SYNCHRONOUS, MS_MANDLOCK, MS_DIRSYNC,
MS_NOATIME, and MS_NODIRATIME were previously defined in linux/fs.h.
Following e262e32d6bde0f77fb0c95d977482fc872c51996 the constants are
now defined in uapi/linux/mount.h. The new location of the defined
constants needs to be included in constants.py template in order for the
correct constants to be generated.

Fixes: e262e32d6bde ("vfs: Suppress MS_* flag defs within the kernel unless explicitly enabled")
Signed-off-by: Dan Robertson <dan@dlrobertson.com>
---
 scripts/gdb/linux/constants.py.in | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
index 7aad82406422..6c164761d986 100644
--- a/scripts/gdb/linux/constants.py.in
+++ b/scripts/gdb/linux/constants.py.in
@@ -12,9 +12,9 @@
  *
  */
 
-#include <linux/fs.h>
 #include <linux/mount.h>
 #include <linux/of_fdt.h>
+#include <uapi/linux/mount.h>
 
 /* We need to stringify expanded macros so that they can be parsed */
 
@@ -36,7 +36,7 @@
 
 import gdb
 
-/* linux/fs.h */
+/* uapi/linux/mount.h */
 LX_VALUE(MS_RDONLY)
 LX_VALUE(MS_SYNCHRONOUS)
 LX_VALUE(MS_MANDLOCK)
-- 
2.20.1

