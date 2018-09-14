Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E0FC070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B1C20861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zje1zK3B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5B1C20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbeINNwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:52:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33186 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbeINNwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:52:38 -0400
Received: by mail-pf1-f194.google.com with SMTP id d4-v6so3991461pfn.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 01:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qmk9tdmyCNAX0uYS98kxHvRp3zsest+IBqTfinGmuMM=;
        b=Zje1zK3Bnbi+aIOYb0gSn4xU3rKqZP088NnH6u+iImR/bexjjon0SHWVGeZxDU3dQH
         icV4e+hlASBIOkWVmYGpY97Iyjn0rMWqiz85PWCQP8LCz48B4jp2KswkxpRHZYz5weJL
         pZ62Z9RnnzLFp/7yXjrJXkps+yzpOvZxgMPUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qmk9tdmyCNAX0uYS98kxHvRp3zsest+IBqTfinGmuMM=;
        b=fFcX+qH96WZD0FQoWl/+Q6C1aMuMqd8IiUVFRbv9a9y9JCBrZI540mUHWkjJlnCyjz
         d/fcXOLmy1C1P7R4aXSOqd7MNdC7AaPFFnADFlu6Orz+eNve5ORpJGf5kmdkU1tLTeTN
         bMI0p+xWyEop+ihTvnwawciShX8MqxCpF8VTD+aZAu3ZIbh3ft7JViYVtWuhj8oOTG1a
         i/mp8n2GUfaMyQeSVG283s2jY9WJEQbBQwCK/F7ufHmOtJK/7r5De6xYRxMNCW1ngGgp
         0fj46BkxiuZ1FgKBjRL2+VTDC/ltmmCqnKes/jLai2IBd3ZERTJfhTbDmD5/dFWVYLs4
         Hccw==
X-Gm-Message-State: APzg51CjG6uj/ifzJrElLIi0vvq/CeQjw7n3bnWYm6IFBKHF2CIOK0yG
        L+NQ92SkwIz4ztj8MvJ7ttkEAg==
X-Google-Smtp-Source: ANB0VdaiUCuoDIkBDZAu8gLthUdTIyL/KRvGnlLXWG3da+9eT2zKr6CpjBhaanFvmwP9dd6jAL13Aw==
X-Received: by 2002:a63:3587:: with SMTP id c129-v6mr10749967pga.290.1536914352128;
        Fri, 14 Sep 2018 01:39:12 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([49.207.60.83])
        by smtp.gmail.com with ESMTPSA id c1-v6sm11664289pfg.25.2018.09.14.01.39.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Sep 2018 01:39:11 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 1/3] mips: Add __NR_syscalls macro in uapi/asm/unistd.h
Date:   Fri, 14 Sep 2018 14:08:32 +0530
Message-Id: <1536914314-5026-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536914314-5026-1-git-send-email-firoz.khan@linaro.org>
References: <1536914314-5026-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NR_syscalls macro holds the number of system call exist in MIPS
architecture. This macro is currently not a part of uapi/asm/unistd.h
file. The purpose of this macro is We have to change the value of
NR_syscalls, if we add or delete a system call.

One of the patch in this patch series has a script which will generate
a uapi header based on syscall.tbl file. The syscall.tbl file contains
the number of system call information. So we have two option to update
NR_syscalls value.

1. Update NR_syscalls in uapi/asm/unistd.h manually by counting the
   no.of system calls. No need to update NR_syscalls until we either
   add a new system call or delete an existing system call.

2. We can keep this feature it above mentioned script, that'll
   count the number of syscalls and keep it in a generated file.
   In this case we don't need to explicitly update NR_syscalls
   in asm/unistd.h file.

The 2nd option will be the recommended one. While __NR_syscalls
isn't strictly part of the uapi, having it as part of the generated
header to simplifies the implementation.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/mips/include/uapi/asm/unistd.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/uapi/asm/unistd.h b/arch/mips/include/uapi/asm/unistd.h
index f25dd1d..f8bab34 100644
--- a/arch/mips/include/uapi/asm/unistd.h
+++ b/arch/mips/include/uapi/asm/unistd.h
@@ -390,17 +390,17 @@
 #define __NR_statx			(__NR_Linux + 366)
 #define __NR_rseq			(__NR_Linux + 367)
 #define __NR_io_pgetevents		(__NR_Linux + 368)
-
+#define __NR_syscalls                   368
 
 /*
  * Offset of the last Linux o32 flavoured syscall
  */
-#define __NR_Linux_syscalls		368
+#define __NR_Linux_syscalls             __NR_syscalls
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
 #define __NR_O32_Linux			4000
-#define __NR_O32_Linux_syscalls		368
+#define __NR_O32_Linux_syscalls         __NR_syscalls
 
 #if _MIPS_SIM == _MIPS_SIM_ABI64
 
@@ -737,16 +737,17 @@
 #define __NR_statx			(__NR_Linux + 326)
 #define __NR_rseq			(__NR_Linux + 327)
 #define __NR_io_pgetevents		(__NR_Linux + 328)
+#define __NR_syscalls                   328
 
 /*
  * Offset of the last Linux 64-bit flavoured syscall
  */
-#define __NR_Linux_syscalls		328
+#define __NR_Linux_syscalls		__NR_syscalls
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
 
 #define __NR_64_Linux			5000
-#define __NR_64_Linux_syscalls		328
+#define __NR_64_Linux_syscalls		__NR_syscalls
 
 #if _MIPS_SIM == _MIPS_SIM_NABI32
 
@@ -1087,15 +1088,16 @@
 #define __NR_statx			(__NR_Linux + 330)
 #define __NR_rseq			(__NR_Linux + 331)
 #define __NR_io_pgetevents		(__NR_Linux + 332)
+#define __NR_syscalls                   332
 
 /*
  * Offset of the last N32 flavoured syscall
  */
-#define __NR_Linux_syscalls		332
+#define __NR_Linux_syscalls		__NR_syscalls
 
 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
 
 #define __NR_N32_Linux			6000
-#define __NR_N32_Linux_syscalls		332
+#define __NR_N32_Linux_syscalls		__NR_syscalls
 
 #endif /* _UAPI_ASM_UNISTD_H */
-- 
1.9.1

