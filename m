Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25437C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 02:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFEAA20868
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 02:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFH0gJQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFEAA20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbeKXNIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 08:08:48 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:42881 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729629AbeKXNIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 08:08:45 -0500
Received: by mail-yw1-f67.google.com with SMTP id x2so5424879ywc.9;
        Fri, 23 Nov 2018 18:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9pg+Er4J0Oi1AGkskDng4P2kVR6Lyc0oMT3zgFqDETI=;
        b=cFH0gJQ3gDR2rmRybvFTqT1D2zvD+bE2dSgwf+bj6S1GJd5dpycBL5Z+dKSONGHQfJ
         qMjOfNdFq0nIlD9Zb99ReMy+Z5DtUN5BO5pyZBqbbelVIX30Rst8i2gc7kJsM2dWZW7c
         nJvONm91ZTkgcLQQNig3w6aKcAIWt503EfmvHc+YZP5cQmu3GMFmosnFW+2uhZ/kOoUK
         IBpA4RHd5q+PDq/kTgyexjctpWvzzFxaOHysXP+HMhRNIijREZyjcjmWKKqWZ9Zv086Q
         QW82sFKH96J9xbl84sjyGLiDcEi3gLwNPXHDnl6JzpoJOrdXLetvKd3tsvGSrkmHmSz2
         iPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9pg+Er4J0Oi1AGkskDng4P2kVR6Lyc0oMT3zgFqDETI=;
        b=RePs7qKbZoGFSlIZQzqsmUO7SjdLTfL4sVghZqP62VypBsa3WxeIEUh9ehjaiPdW4G
         gODVFhSKlJ4rtJGk819ZrCqyKtIfhfsDb/w7rzdbf+AIGSlmtaUYwPtgsdWSPIjp1JIX
         P17XoyaaO2od8icOyAzJTWm8l/4g+S1mKE0Z3heKSOQ87TzCxK85do2xELzOqQpjiNNW
         s+tFLvI14oeo4u078IdDoJw5jCVflvkEXlyydllgp+e9vDoRoprqUyTOEpymCZQkoNna
         cQ6XRgE2T1AemLfQ9Mhnoz4YTOiG350cmxlIXWlKbD7WBuBzCbaaHixTpd1PSGSdTTC3
         kJ0g==
X-Gm-Message-State: AGRZ1gI9krYAT+glyRhSLsfkBxLaTUaqEYaC8TIaWK1BW9AlB5FBpBHe
        dCj+hY15wbdo9MSKYSOrJiHTo0Ui
X-Google-Smtp-Source: AJdET5eST1GLgpJpfN5BErDs4OXlZpn2Sa1IGBAM1+evz3LeypKIlFUk/3JHMa5lXHGRAaOK/ntPDA==
X-Received: by 2002:a81:b209:: with SMTP id q9-v6mr19215324ywh.283.1543026127749;
        Fri, 23 Nov 2018 18:22:07 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-213.hsd1.ca.comcast.net. [98.234.52.213])
        by smtp.gmail.com with ESMTPSA id w1sm6947292ywd.49.2018.11.23.18.22.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 18:22:07 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, viro@zeniv.linux.org.uk, arnd@arndb.de,
        y2038@lists.linaro.org, sparclinux@vger.kernel.org
Subject: [PATCH 4/8] arch: sparc: Override struct __kernel_old_timeval
Date:   Fri, 23 Nov 2018 18:20:31 -0800
Message-Id: <20181124022035.17519-5-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181124022035.17519-1-deepa.kernel@gmail.com>
References: <20181124022035.17519-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct __kernel_old_timeval is supposed to have the same
layout as struct timeval. But, it was inadvarently missed
that __kernel_suseconds has a different definition for
sparc64.
Provide an asm-specific override that fixes it.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/include/uapi/asm/posix_types.h | 10 ++++++++++
 include/uapi/linux/time.h                 |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/arch/sparc/include/uapi/asm/posix_types.h b/arch/sparc/include/uapi/asm/posix_types.h
index fec499d6efb7..f139e0048628 100644
--- a/arch/sparc/include/uapi/asm/posix_types.h
+++ b/arch/sparc/include/uapi/asm/posix_types.h
@@ -19,6 +19,16 @@ typedef unsigned short         __kernel_old_gid_t;
 typedef int		       __kernel_suseconds_t;
 #define __kernel_suseconds_t __kernel_suseconds_t
 
+typedef long		__kernel_long_t;
+typedef unsigned long	__kernel_ulong_t;
+#define __kernel_long_t __kernel_long_t
+
+struct __kernel_old_timeval {
+	__kernel_long_t tv_sec;
+	__kernel_suseconds_t tv_usec;
+};
+#define __kernel_old_timeval __kernel_old_timeval
+
 #else
 /* sparc 32 bit */
 
diff --git a/include/uapi/linux/time.h b/include/uapi/linux/time.h
index 6b56a2208be7..04d5587f30d3 100644
--- a/include/uapi/linux/time.h
+++ b/include/uapi/linux/time.h
@@ -63,10 +63,12 @@ struct __kernel_itimerspec {
  * here, this is probably because it is not y2038 safe and needs to
  * be changed to use another interface.
  */
+#ifndef __kernel_old_timeval
 struct __kernel_old_timeval {
 	__kernel_long_t tv_sec;
 	__kernel_long_t tv_usec;
 };
+#endif
 
 /*
  * The IDs of the various system clocks (for POSIX.1b interval timers):
-- 
2.17.1

