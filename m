Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE50CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF7D72063F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="A6LL0kNT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbfABPCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 10:02:41 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36852 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729209AbfABPCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 10:02:38 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so14701179pgm.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 07:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Eat+r8u+VqdJ2gf8pt6fPlnDCgZGxQ4z1YhcFJx2Y5c=;
        b=A6LL0kNTDc7uhzjcydJoLkqNPWL78vHJ5FoZjsqcv2yeaXsxbH2Ha9pQD2DDJA5sxG
         qxEDwJQjV+Ot4GztgC7y0fOfNyBeaOsCFA1EOCB4jLdQ1xkY558yH5Y9wHTFc1xjBIWD
         3tH4tngZEqEy8CID71SG6KnvwuIBKOwl9Zg5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Eat+r8u+VqdJ2gf8pt6fPlnDCgZGxQ4z1YhcFJx2Y5c=;
        b=iz3LRYZUdirCNr8At6lmJLxgO9JAJnxCCjDcETupstJaJ4lYnHUcUEc4x9WiREocPz
         s41KZR1YmFd1Emg8V0PM+mZYMM4P/gXB+tUFMv5uKt3Ng1Q+LDhMVGav8pMl0OC3Ayhk
         jjcmw5+Uc1Veo4DmO+gi68u+4dhCWveawWi7wjSUGB2g25A0h9iIHMMZwf+b2Az6203S
         Kc+pBn6uNxmVh5szWIrcJTl8GjQ9KBPQjfc8Oly5ZyiIRYxuTZoxda6B4CMW9CuzzxsN
         OibvkTjjI8X1hirdrDRoSucyqq3aMZEyyVuanRXqk4YD00/zWw0dd6C7G1MK41+RUcfl
         bLVQ==
X-Gm-Message-State: AJcUukduzUaz0WbVzh+X9KIi3uIcLHMn8XaDuXEmyuJxnC7Xg726esej
        ggZsLbZZLzsmeN6ClXMfGjZnyA==
X-Google-Smtp-Source: ALg8bN6fJUR1lVZw7cXCobT9RCVFx5R5C1+/J2rUe/2qe8jqSkWPssMo3yYlyvGezfgi+gT2W5g7eg==
X-Received: by 2002:a63:9a09:: with SMTP id o9mr13295542pge.94.1546441358109;
        Wed, 02 Jan 2019 07:02:38 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id z14sm66180213pgv.47.2019.01.02.07.02.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jan 2019 07:02:37 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linuxppc-dev@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 1/2] powerpc: remove nargs from __SYSCALL
Date:   Wed,  2 Jan 2019 20:32:03 +0530
Message-Id: <1546441324-19774-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546441324-19774-1-git-send-email-firoz.khan@linaro.org>
References: <1546441324-19774-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __SYSCALL macro's arguments are system call number,
system call entry name and number of arguments for the
system call.

Argument- nargs in __SYSCALL(nr, entry, nargs) is neither
calculated nor used anywhere. So it would be better to
keep the implementaion as  __SYSCALL(nr, entry). This will
unifies the implementation with some other architetures
too.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/powerpc/kernel/syscalls/syscalltbl.sh  | 4 ++--
 arch/powerpc/kernel/systbl.S                | 6 +++---
 arch/powerpc/platforms/cell/spu_callbacks.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/syscalls/syscalltbl.sh b/arch/powerpc/kernel/syscalls/syscalltbl.sh
index fd62049..f7393a7 100644
--- a/arch/powerpc/kernel/syscalls/syscalltbl.sh
+++ b/arch/powerpc/kernel/syscalls/syscalltbl.sh
@@ -13,10 +13,10 @@ emit() {
 	t_entry="$3"
 
 	while [ $t_nxt -lt $t_nr ]; do
-		printf "__SYSCALL(%s,sys_ni_syscall, )\n" "${t_nxt}"
+		printf "__SYSCALL(%s,sys_ni_syscall)\n" "${t_nxt}"
 		t_nxt=$((t_nxt+1))
 	done
-	printf "__SYSCALL(%s,%s, )\n" "${t_nxt}" "${t_entry}"
+	printf "__SYSCALL(%s,%s)\n" "${t_nxt}" "${t_entry}"
 }
 
 grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
diff --git a/arch/powerpc/kernel/systbl.S b/arch/powerpc/kernel/systbl.S
index 23265a2..02f28fa 100644
--- a/arch/powerpc/kernel/systbl.S
+++ b/arch/powerpc/kernel/systbl.S
@@ -25,11 +25,11 @@
 .globl sys_call_table
 sys_call_table:
 #ifdef CONFIG_PPC64
-#define __SYSCALL(nr, entry, nargs) .8byte DOTSYM(entry)
+#define __SYSCALL(nr, entry)	.8byte DOTSYM(entry)
 #include <asm/syscall_table_64.h>
 #undef __SYSCALL
 #else
-#define __SYSCALL(nr, entry, nargs) .long entry
+#define __SYSCALL(nr, entry)	.long entry
 #include <asm/syscall_table_32.h>
 #undef __SYSCALL
 #endif
@@ -38,7 +38,7 @@ sys_call_table:
 .globl compat_sys_call_table
 compat_sys_call_table:
 #define compat_sys_sigsuspend	sys_sigsuspend
-#define __SYSCALL(nr, entry, nargs) .8byte DOTSYM(entry)
+#define __SYSCALL(nr, entry)	.8byte DOTSYM(entry)
 #include <asm/syscall_table_c32.h>
 #undef __SYSCALL
 #endif
diff --git a/arch/powerpc/platforms/cell/spu_callbacks.c b/arch/powerpc/platforms/cell/spu_callbacks.c
index 125f2a5..b5f35cb 100644
--- a/arch/powerpc/platforms/cell/spu_callbacks.c
+++ b/arch/powerpc/platforms/cell/spu_callbacks.c
@@ -34,7 +34,7 @@
  */
 
 static void *spu_syscall_table[] = {
-#define __SYSCALL(nr, entry, nargs) entry,
+#define __SYSCALL(nr, entry)	entry,
 #include <asm/syscall_table_spu.h>
 #undef __SYSCALL
 };
-- 
1.9.1

