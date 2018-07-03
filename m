Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20147C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE892087C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kovGOE95"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE892087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932857AbeGCFpN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 01:45:13 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41571 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932778AbeGCFpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 01:45:11 -0400
Received: by mail-pl0-f65.google.com with SMTP id w8-v6so456926ply.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 22:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zWSQmObS54WYCOwnij14pXa5G0XaIWArfoHWFe6y/WE=;
        b=kovGOE95PGKRso3ZGVpF9VDwjjIQ11rS+tLywpBb0aOP3iaKnKoiFCbWk2opxJpmyv
         O5A5o6w6fpxkaCLOYOM0iA5pmSk9c32LSNKE+I2dwFnGSxiUidJF7ReDvnHjWNaQIdPH
         is1SpnrPy4zh6Sxet8iGugJZzPMV+v1RR7LG+M+PIIOnqGo3KjURSSPKN9isXstwEJda
         qhCZ9cWZEsTyFTskF9fjEKVrqhAXI0ibTajtuFgu0oXspzxmX7y5YWPSlHmMrIzBGuMv
         nf/UV3Yh3ivGLkLJO9P2zWxKimBz+WwzhtXGY3B0yLRjTu3hnelrVfzK7zzoUlQGGr3L
         qeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zWSQmObS54WYCOwnij14pXa5G0XaIWArfoHWFe6y/WE=;
        b=SkBl2xn+DA7wc48z2pCMzjpwzd9kwmFbAHcBBvi3GgiZBFNIOAWXNAjmihHP2vvU3u
         x9zx55xaiSrZ8mncTzV+53PcZNDSk4CncUIz/x9kzWk4v4VxVGY3xlTSc8p5WKOzRBIm
         H4MyQsLhacrCBBWAozXhK1MhusjeALit8Is7QLpqOeclDFxr2QnCAODJeq4lPRk69XY3
         w9808mO/TvIcPvu+If6wMoi5+YxPcdJeE2HQPviSiwndCrmj9DEtBiJTSY5nQyTLwMIi
         mZDql3roLDCrpcD4DVMOLwPJD3jxp/twVFO69k/wyFXUFTaf2YlZVqhlC/GvF+2bB/d1
         eeVQ==
X-Gm-Message-State: APt69E3p20W9Nwrx7z8H7AZQ5cx+C3sdKI7LsGRo7Ou5IpI1QYOm/1Jt
        KbjZ3dIglgKS63p2ZTtvANg=
X-Google-Smtp-Source: ADUXVKK7FmPH7OmERq8P2iq3pzk4XRBrg/gUDdflWVC2f4izljVs8IfxDxTK0RIP/RZeI5D++hVtnA==
X-Received: by 2002:a17:902:bb05:: with SMTP id l5-v6mr28525212pls.246.1530596710962;
        Mon, 02 Jul 2018 22:45:10 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-67-170-212-194.hsd1.ca.comcast.net. [67.170.212.194])
        by smtp.gmail.com with ESMTPSA id h75-v6sm784780pfh.86.2018.07.02.22.45.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 22:45:10 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, y2038@lists.linaro.org, catalin.marinas@arm.com
Subject: [PATCH 1/6] arm64: Make basic compat_* types always available
Date:   Mon,  2 Jul 2018 22:44:17 -0700
Message-Id: <20180703054422.12089-2-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180703054422.12089-1-deepa.kernel@gmail.com>
References: <20180703054422.12089-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we repurpose more compat syscalls to be used in non CONFIG_COMPAT
usecases as part of solving y2038, we need to make these basic types
available unconditionally.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: catalin.marinas@arm.com
---
 arch/arm64/include/asm/compat.h | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index 1a037b94eba1..2dbb179b5dc4 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -16,21 +16,14 @@
 #ifndef __ASM_COMPAT_H
 #define __ASM_COMPAT_H
 #ifdef __KERNEL__
-#ifdef CONFIG_COMPAT
 
-/*
- * Architecture specific compatibility types
- */
 #include <linux/types.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 
-#define COMPAT_USER_HZ		100
-#ifdef __AARCH64EB__
-#define COMPAT_UTS_MACHINE	"armv8b\0\0"
-#else
-#define COMPAT_UTS_MACHINE	"armv8l\0\0"
-#endif
+/*
+ * Architecture specific compatibility types
+ */
 
 typedef u32		compat_size_t;
 typedef s32		compat_ssize_t;
@@ -65,6 +58,15 @@ typedef u32		compat_ulong_t;
 typedef u64		compat_u64;
 typedef u32		compat_uptr_t;
 
+#ifdef CONFIG_COMPAT
+
+#define COMPAT_USER_HZ		100
+#ifdef __AARCH64EB__
+#define COMPAT_UTS_MACHINE	"armv8b\0\0"
+#else
+#define COMPAT_UTS_MACHINE	"armv8l\0\0"
+#endif
+
 struct compat_stat {
 #ifdef __AARCH64EB__
 	short		st_dev;
-- 
2.17.1

