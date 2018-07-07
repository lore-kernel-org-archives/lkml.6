Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBB6C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 05:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B53E224D5
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 05:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eW04J2Ui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B53E224D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753889AbeGGFoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 01:44:38 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39728 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753609AbeGGFnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 01:43:52 -0400
Received: by mail-pl0-f67.google.com with SMTP id s24-v6so3749619plq.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 22:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tFIdsJQgboLo0N40IqaBS2E2+uZyn96KVbZd+cjUIV0=;
        b=eW04J2Ui+9YaseS3qXrfHtZXbH5C1Av5MsydS4a2iEixogxHiIW8Kg3HGMHkPJ0rk6
         HhJiFboJDBTWz6aHGLvRtlTC/7nyT20HX6mL9QePEkVQH5rbg2cZx0ZdKtbgqndrFPic
         D8NzpOTj/rszRI7DsoDek0DGf8VUh82VPQLKCvGtPUgnsx5/+xw/z2u/f/PAGTX/Eap4
         B0VY5ckPzOrtH8IUb5/oPur3w8R8UxDh35U1NX9mHHqW8aHe5mH0f/JY9a/KVayZiRK1
         2gHC8wr5sskGpQkSMhxEXsQxNG9OTJtctNlgtwZl1570ky51TClOfBZNDYZl+ug0a28I
         aJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tFIdsJQgboLo0N40IqaBS2E2+uZyn96KVbZd+cjUIV0=;
        b=J+LcTpthXDY598FEfCLLTZUOYITHcasm41MhHTAa3bWC5JbU0Qm+A3ufgLsbHFYxkv
         /I1RwaSAG8271engD65BMUQghUoLEo0Bw5hdbTfV3LvpFZoGVYOgPNsgQPUWAxlrAwro
         2QAsWddaaeXmfv4BYX7OBCx70YyVD6MA+nr7ysMot9dwRac5QYq7ean4ZzjRuNmDAHnF
         g9LvUqxfwJD3H5GnIZJGoqJFdzfkOzN2CjPY1bn1PXmKXK20GvIHSQoB3860FcVKoNRV
         lFFyUlb7t7ixEjAmO6anDmHi6EPYsiSSLFg5jsKIfyGMtEtEoJgb1NkoJBCD+oeedW4Q
         r7RA==
X-Gm-Message-State: APt69E0fz16VhJy09+gPjaoYlZtpPvLgYcM64phILqdlbaolXL8w9WzP
        veduDIUwDxmYJX0SaGRXCIc=
X-Google-Smtp-Source: AAOMgpdfCInxLI9PdD+UjtQxK5s/wDgypjU0evO/jskaFW7kK4sZXvYuzQ50jrphPsVIkTxFIFSXrw==
X-Received: by 2002:a17:902:8347:: with SMTP id z7-v6mr12972374pln.290.1530942232327;
        Fri, 06 Jul 2018 22:43:52 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-67-170-212-194.hsd1.ca.comcast.net. [67.170.212.194])
        by smtp.gmail.com with ESMTPSA id t192-v6sm16505083pgc.74.2018.07.06.22.43.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 22:43:51 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, y2038@lists.linaro.org
Subject: [PATCH v3 5/7] time: Add struct __kernel_timex
Date:   Fri,  6 Jul 2018 22:42:45 -0700
Message-Id: <20180707054247.19802-6-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180707054247.19802-1-deepa.kernel@gmail.com>
References: <20180707054247.19802-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct timex uses struct timeval internally.
struct timeval is not y2038 safe.
Introduce a new UAPI type struct __kernel_timex
that is y2038 safe.

struct __kernel_timex uses a timeval type that is
similar to struct __kernel_timespec which preserves the
same structure size across 32 bit and 64 bit ABIs.
struct __kernel_timex also restructures other members of the
structure to make the structure the same on 64 bit and 32 bit
architectures.
Note that struct __kernel_timex is the same as struct timex
on a 64 bit architecture.

The above solution is similar to other new y2038 syscalls
that are being introduced: both 32 bit and 64 bit ABIs
have a common entry, and the compat entry supports the old 32 bit
syscall interface.

Alternatives considered were:
1. Add new time type to struct timex that makes use of padded
   bits. This time type could be based on the struct __kernel_timespec.
   modes will use a flag to notify which time structure should be
   used internally.
   This needs some application level changes on both 64 bit and 32 bit
   architectures. Although 64 bit machines could continue to use the
   older timeval structure without any changes.

2. Add a new u8 type to struct timex that makes use of padded bits. This
   can be used to save higher order tv_sec bits. modes will use a flag to
   notify presence of such a type.
   This will need some application level changes on 32 bit architectures.

3. Add a new compat_timex structure that differs in only the size of the
   time type; keep rest of struct timex the same.
   This requires extra syscalls to manage all 3 cases on 64 bit
   architectures. This will not need any application level changes but will
   add more complexity from kernel side.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 include/linux/timex.h      |  7 +++++++
 include/uapi/linux/timex.h | 41 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/include/linux/timex.h b/include/linux/timex.h
index 39c25dbebfe8..7f40e9e42ecc 100644
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -53,6 +53,13 @@
 #ifndef _LINUX_TIMEX_H
 #define _LINUX_TIMEX_H
 
+/* CONFIG_64BIT_TIME enables new 64 bit time_t syscalls in the compat path
+ * and 32-bit emulation.
+ */
+#ifndef CONFIG_64BIT_TIME
+#define __kernel_timex timex
+#endif
+
 #include <uapi/linux/timex.h>
 
 #define ADJ_ADJTIME		0x8000	/* switch between adjtime/adjtimex modes */
diff --git a/include/uapi/linux/timex.h b/include/uapi/linux/timex.h
index 92685d826444..a1c6b73016a5 100644
--- a/include/uapi/linux/timex.h
+++ b/include/uapi/linux/timex.h
@@ -92,6 +92,47 @@ struct timex {
 	int  :32; int  :32; int  :32;
 };
 
+struct __kernel_timex_timeval {
+	__kernel_time64_t       tv_sec;
+	long long		tv_usec;
+};
+
+#ifndef __kernel_timex
+struct __kernel_timex {
+	unsigned int modes;	/* mode selector */
+	int :32;            /* pad */
+	long long offset;	/* time offset (usec) */
+	long long freq;	/* frequency offset (scaled ppm) */
+	long long maxerror;/* maximum error (usec) */
+	long long esterror;/* estimated error (usec) */
+	int status;		/* clock command/status */
+	int :32;            /* pad */
+	long long constant;/* pll time constant */
+	long long precision;/* clock precision (usec) (read only) */
+	long long tolerance;/* clock frequency tolerance (ppm)
+				   * (read only)
+				   */
+	struct __kernel_timex_timeval time;	/* (read only, except for ADJ_SETOFFSET) */
+	long long tick;	/* (modified) usecs between clock ticks */
+
+	long long ppsfreq;/* pps frequency (scaled ppm) (ro) */
+	long long jitter; /* pps jitter (us) (ro) */
+	int shift;              /* interval duration (s) (shift) (ro) */
+	int :32;            /* pad */
+	long long stabil;            /* pps stability (scaled ppm) (ro) */
+	long long jitcnt; /* jitter limit exceeded (ro) */
+	long long calcnt; /* calibration intervals (ro) */
+	long long errcnt; /* calibration errors (ro) */
+	long long stbcnt; /* stability limit exceeded (ro) */
+
+	int tai;		/* TAI offset (ro) */
+
+	int  :32; int  :32; int  :32; int  :32;
+	int  :32; int  :32; int  :32; int  :32;
+	int  :32; int  :32; int  :32;
+};
+#endif
+
 /*
  * Mode codes (timex.mode)
  */
-- 
2.17.1

