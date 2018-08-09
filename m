Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F68BC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5379721C66
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J+zQ35wO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5379721C66
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbeHIHjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 03:39:04 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34756 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbeHIHjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 03:39:03 -0400
Received: by mail-pf1-f194.google.com with SMTP id k19-v6so2269215pfi.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 22:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fPDepwFzDzSU/lSELaWxXQHkxTTfKwoPjvCIwM7BJiA=;
        b=J+zQ35wO42xFZ+++ttHIN6qk6Cn25ALwjhPnQ9SrpqDuRJBWQJRd+rrEi2rs9TOmjJ
         y/Dm/d+ChOtUfV1aYlfl/Rt6LbIuhv3ygO1Syp/RJKVfFh0fCOVh31A1jkqexde0XaEB
         8nX2FVol+BQ2V1tnjbV/Iargj4smpCEwiLfHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fPDepwFzDzSU/lSELaWxXQHkxTTfKwoPjvCIwM7BJiA=;
        b=KxvSdfViuiuKp1CATFBVhBbk+0gr847BrIAeb6QPWZxvL2lTF+Y+zFCIqRJrNHqBAn
         fvhlTXPE/nxrY8avx5KYpl32DDh8d2FwAQa1qiS3PyUNwvNMXdZTO3ySLhl+mYqVvtlf
         H8i9A4ofB3a3hd+jV+wyVlU6TfbNBedM0eddvYRca5r3SbeCvVrtAgnKcKzJzGcUfnKr
         o4VY/aCaDm3rI6LvX440NE+OD0XS7pS8nalLTZ2wOgjErlPm0l0MzdXfvb5NKWryj1Je
         JSzUv69w1V+lLyW3BC/ofDoJYDpBkoXDVq7hs2kklp921TTkjam6dYp4MZdgmjVJKx9y
         hfgA==
X-Gm-Message-State: AOUpUlEye5yIrrtWpWhiu0V2xVc3nspMvwlD1WQhBYp84uZtXRutFRFb
        HuLQU8mOv7bxgG/H3Ef173tgWw==
X-Google-Smtp-Source: AA+uWPwUkIar7iNYuNgdyl81A+du04nbwDy3AGFX1JiIbtyyNG4UALOzdxzYyR0T/IgBj99WpKtt4Q==
X-Received: by 2002:a62:9e5d:: with SMTP id s90-v6mr730176pfd.214.1533791764100;
        Wed, 08 Aug 2018 22:16:04 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id z20-v6sm12863977pfd.99.2018.08.08.22.16.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Aug 2018 22:16:03 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-m68k@lists.linux-m68k.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 2/4] m68k: Replace NR_syscalls macro from asm/unistd.h
Date:   Thu,  9 Aug 2018 10:45:21 +0530
Message-Id: <1533791723-3882-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533791723-3882-1-git-send-email-firoz.khan@linaro.org>
References: <1533791723-3882-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NR_syscalls macro holds the number of system call exist in m68k
architecture. This macro is currently the part of asm/unistd.h file.
We have to change the value of NR_syscalls, if we add or delete a
system call.

One of patch in this patch series has a script which will generate
a uapi header based on syscall.tbl file. The syscall.tbl file
contains the number of system call information. So we have two
option to update NR_syscalls value.

1. Update NR_syscalls in asm/unistd.h manually by counting the
   no.of system calls. No need to update NR_syscalls untill
   we either add a new system call or delete an existing system
   call.

2. We can keep this feature it above mentioned script, that'll
   count the number of syscalls and keep it in a generated file.
   In this case we don't need to explicitly update NR_syscalls
   in asm/unistd.h file.

The 2nd option will be the recommended one. For that, I moved the
NR_syscalls macro from asm/unistd.h to uapi/asm/unistd.h. The macro
name also changed form NR_syscalls to __NR_syscalls for making the
name convention same across all architecture. While __NR_syscalls
isn't strictly part of the uapi, having it as part of the generated
header to simplifies the implementation.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/m68k/68000/entry.S             | 4 ++--
 arch/m68k/coldfire/entry.S          | 2 +-
 arch/m68k/include/asm/unistd.h      | 3 ---
 arch/m68k/include/uapi/asm/unistd.h | 2 ++
 arch/m68k/kernel/entry.S            | 4 ++--
 5 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/m68k/68000/entry.S b/arch/m68k/68000/entry.S
index 259b366..91522e9 100644
--- a/arch/m68k/68000/entry.S
+++ b/arch/m68k/68000/entry.S
@@ -49,7 +49,7 @@ do_trace:
 	addql	#4,%sp
 	movel	%sp@(PT_OFF_ORIG_D0),%d1
 	movel	#-ENOSYS,%d0
-	cmpl	#NR_syscalls,%d1
+	cmpl	#__NR_syscalls,%d1
 	jcc	1f
 	lsl	#2,%d1
 	lea	sys_call_table, %a0
@@ -80,7 +80,7 @@ ENTRY(system_call)
 	movel	%d1,%a2
 	btst	#(TIF_SYSCALL_TRACE%8),%a2@(TINFO_FLAGS+(31-TIF_SYSCALL_TRACE)/8)
 	jne	do_trace
-	cmpl	#NR_syscalls,%d0
+	cmpl	#__NR_syscalls,%d0
 	jcc	badsys
 	lsl	#2,%d0
 	lea	sys_call_table,%a0
diff --git a/arch/m68k/coldfire/entry.S b/arch/m68k/coldfire/entry.S
index 52d312d..efe777d 100644
--- a/arch/m68k/coldfire/entry.S
+++ b/arch/m68k/coldfire/entry.S
@@ -64,7 +64,7 @@ ENTRY(system_call)
 	move	#0x2000,%sr		/* enable intrs again */
 	GET_CURRENT(%d2)
 
-	cmpl	#NR_syscalls,%d0
+	cmpl	#__NR_syscalls,%d0
 	jcc	enosys
 	lea	sys_call_table,%a0
 	lsll	#2,%d0			/* movel %a0@(%d0:l:4),%d3 */
diff --git a/arch/m68k/include/asm/unistd.h b/arch/m68k/include/asm/unistd.h
index 30d0d3f..52111fb 100644
--- a/arch/m68k/include/asm/unistd.h
+++ b/arch/m68k/include/asm/unistd.h
@@ -4,9 +4,6 @@
 
 #include <uapi/asm/unistd.h>
 
-
-#define NR_syscalls		380
-
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_OLD_STAT
 #define __ARCH_WANT_STAT64
diff --git a/arch/m68k/include/uapi/asm/unistd.h b/arch/m68k/include/uapi/asm/unistd.h
index de3054f..b17ae53 100644
--- a/arch/m68k/include/uapi/asm/unistd.h
+++ b/arch/m68k/include/uapi/asm/unistd.h
@@ -387,4 +387,6 @@
 #define __NR_pwritev2		378
 #define __NR_statx		379
 
+#define __NR_syscalls		380
+
 #endif /* _UAPI_ASM_M68K_UNISTD_H_ */
diff --git a/arch/m68k/kernel/entry.S b/arch/m68k/kernel/entry.S
index 97cd3ea..dab0cfd 100644
--- a/arch/m68k/kernel/entry.S
+++ b/arch/m68k/kernel/entry.S
@@ -161,7 +161,7 @@ do_trace_entry:
 	RESTORE_SWITCH_STACK
 	addql	#4,%sp
 	movel	%sp@(PT_OFF_ORIG_D0),%d0
-	cmpl	#NR_syscalls,%d0
+	cmpl	#__NR_syscalls,%d0
 	jcs	syscall
 badsys:
 	movel	#-ENOSYS,%sp@(PT_OFF_D0)
@@ -206,7 +206,7 @@ ENTRY(system_call)
 	| syscall trace?
 	tstb	%a1@(TINFO_FLAGS+2)
 	jmi	do_trace_entry
-	cmpl	#NR_syscalls,%d0
+	cmpl	#__NR_syscalls,%d0
 	jcc	badsys
 syscall:
 	jbsr	@(sys_call_table,%d0:l:4)@(0)
-- 
1.9.1

