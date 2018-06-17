Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2C0C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 05:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 275E12086A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 05:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiAgENSV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 275E12086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753137AbeFQFMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 01:12:13 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34018 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbeFQFMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 01:12:10 -0400
Received: by mail-pl0-f67.google.com with SMTP id g20-v6so7346789plq.1;
        Sat, 16 Jun 2018 22:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8CR6LN2ME8wAYyJjwenexwwZITdcsn6dUhuLKZ/Drxk=;
        b=YiAgENSVX5d+6b5IErAXSzMtGUeNWzcol6ElmZba9Z8ioFoygLGfKoEQ2bgMsEdnym
         ms5NVrwTNHG3FlVOhi72KNV1/Eitok9kkWgSwk/cpGH0HHFCMLAdZ/aztETFP4BK5wBm
         ocNNpNfLzQpeG9Qt8fLaHVUzzlzyQjO5ERuyM5hUEjIuGaf5gaIF0ejJTl4EbismU3vk
         RBW0PvRIiq0BelqxlStz06Dng0A3yQhd0Rpuu7cxY/D2S2bQ5zrcBKlnAeOSPXIGiCJZ
         xeGtIXTogi0EJR2TT65J+RnzMQ9EWWSEpkc/gpuv455Uqu5Tng2Hu5fQQ8whiGIB36Gb
         VRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8CR6LN2ME8wAYyJjwenexwwZITdcsn6dUhuLKZ/Drxk=;
        b=pJPYuegIliOj/xN93f77W562OEbLRgJ06Sq5UHiqzWLOLRbuTxtfxFLUUHJCWbtLoY
         +KZEFh6gIjjvwFKXdQ0NLFPDToWdZPGcXFgnfRchvkUgUZsLYocXzW2m5l/8YkjPTYQk
         H+iRD866MoZUPwANELF8XrgwOOTMCocYV5SzDlho0tAfnH5o3sK/LYww9VI/haWytM7o
         1eH7ENN/GUaC1MtuNiw5gdDrXqY7wyo9BP78ZvK4UKSz4+FwHZajnwvt9ZzGQpGLIkwc
         HetD+yLni//FlcaCYOL8qTfSfnYevGpjpWKCBqpXUlW0qfRZxVGGTwiW+94TaAYrFQK7
         5O5Q==
X-Gm-Message-State: APt69E1Zh7f06eXA8Z6rfgPV20ata+ep1sn9I4sAYBvNlnqGBwm2bj8u
        J+2ujEE97nDtCOb3CsUK5xvkbA==
X-Google-Smtp-Source: ADUXVKJVtEFiWrGtRSJNTL43G7pSxp5LXqtD/i4FBr3uCc1Ul7Onp7kg+scuuhcbw/iMDUpanKUaPQ==
X-Received: by 2002:a17:902:5402:: with SMTP id d2-v6mr4600481pli.38.1529212329602;
        Sat, 16 Jun 2018 22:12:09 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-67-170-212-194.hsd1.ca.comcast.net. [67.170.212.194])
        by smtp.gmail.com with ESMTPSA id h27-v6sm28354594pfk.160.2018.06.16.22.12.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Jun 2018 22:12:09 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     arnd@arndb.de, tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, y2038@lists.linaro.org
Subject: [PATCH 1/3] time: Introduce struct __kernel_itimerspec
Date:   Sat, 16 Jun 2018 22:11:42 -0700
Message-Id: <20180617051144.29756-2-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180617051144.29756-1-deepa.kernel@gmail.com>
References: <20180617051144.29756-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct itimerspec is not y2038-safe.
Introduce a new struct __kernel_itimerspec based on the
kernel internal y2038-safe struct itimerspec64.

The definition of struct __kernel_itimerspec includes two
struct __kernel_timespec.
And, since struct __kernel_timespec has the same representation in native
and compat modes, so does struct __kernel_itimerspec. This helps have a
common entry point for syscalls using struct __kernel_itimerspec.

New y2038-safe syscalls will use this new type. Since most of the new
syscalls are just an update to the native syscalls with the type update,
place the new definition under CONFIG_64BIT_TIME. This helps
architectures that do not support the above config to keep using the
old definition of struct itimerspec.
Also change the get/put_itimerspec64 to use struct__kernel_itimerspec.
This will help 32 bit architectures to use the new syscalls when
architectures select CONFIG_64BIT_TIME.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 include/linux/time.h      | 4 ++--
 include/linux/time64.h    | 1 +
 include/uapi/linux/time.h | 7 +++++++
 kernel/time/time.c        | 4 ++--
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/time.h b/include/linux/time.h
index aed74463592d..27d83fd2ae61 100644
--- a/include/linux/time.h
+++ b/include/linux/time.h
@@ -14,9 +14,9 @@ int get_timespec64(struct timespec64 *ts,
 int put_timespec64(const struct timespec64 *ts,
 		struct __kernel_timespec __user *uts);
 int get_itimerspec64(struct itimerspec64 *it,
-			const struct itimerspec __user *uit);
+			const struct __kernel_itimerspec __user *uit);
 int put_itimerspec64(const struct itimerspec64 *it,
-			struct itimerspec __user *uit);
+			struct __kernel_itimerspec __user *uit);
 
 extern time64_t mktime64(const unsigned int year, const unsigned int mon,
 			const unsigned int day, const unsigned int hour,
diff --git a/include/linux/time64.h b/include/linux/time64.h
index 0a7b2f79cec7..05634afba0db 100644
--- a/include/linux/time64.h
+++ b/include/linux/time64.h
@@ -12,6 +12,7 @@ typedef __u64 timeu64_t;
  */
 #ifndef CONFIG_64BIT_TIME
 #define __kernel_timespec timespec
+#define __kernel_itimerspec itimerspec
 #endif
 
 #include <uapi/linux/time.h>
diff --git a/include/uapi/linux/time.h b/include/uapi/linux/time.h
index fcf936656493..6b56a2208be7 100644
--- a/include/uapi/linux/time.h
+++ b/include/uapi/linux/time.h
@@ -49,6 +49,13 @@ struct __kernel_timespec {
 };
 #endif
 
+#ifndef __kernel_itimerspec
+struct __kernel_itimerspec {
+	struct __kernel_timespec it_interval;    /* timer period */
+	struct __kernel_timespec it_value;       /* timer expiration */
+};
+#endif
+
 /*
  * legacy timeval structure, only embedded in structures that
  * traditionally used 'timeval' to pass time intervals (not absolute
diff --git a/kernel/time/time.c b/kernel/time/time.c
index 6fa99213fc72..4e65916e3d13 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -929,7 +929,7 @@ int compat_put_timespec64(const struct timespec64 *ts, void __user *uts)
 EXPORT_SYMBOL_GPL(compat_put_timespec64);
 
 int get_itimerspec64(struct itimerspec64 *it,
-			const struct itimerspec __user *uit)
+			const struct __kernel_itimerspec __user *uit)
 {
 	int ret;
 
@@ -944,7 +944,7 @@ int get_itimerspec64(struct itimerspec64 *it,
 EXPORT_SYMBOL_GPL(get_itimerspec64);
 
 int put_itimerspec64(const struct itimerspec64 *it,
-			struct itimerspec __user *uit)
+			struct __kernel_itimerspec __user *uit)
 {
 	int ret;
 
-- 
2.17.1

