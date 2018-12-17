Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51D9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D9B2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hmXcmuaD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732394AbeLQKla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 05:41:30 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40569 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbeLQKl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 05:41:29 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so5929722pgp.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 02:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qjj0KbdPyGPLhWFi0hQxVzhzwcqRrlCgAX7ybTH+ePE=;
        b=hmXcmuaDhZ0CcAlynyVIpsXJsLvTnfV0Qt0XU0uZhAH2WL/hrBusGX151JiPMw2ViG
         5/rzLUz41dcdHYEmFfMEmyGe4IAyZIfaLg/JbzndcP+2H1aIEojBM9jvvNVqtbkCCfoM
         0qNn6/c/iJgmb4TgsDVmRR/jyvadAn7lLXmlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qjj0KbdPyGPLhWFi0hQxVzhzwcqRrlCgAX7ybTH+ePE=;
        b=lw1iY6oQ3fYlA0qyvvbUEnvJrzsc11bffUpj+kONkqBtpyy9QM/IxrZewFs75mP9ny
         Rv4RHjNp9w/nxgquOCVZQDa1HtDuABobIm8MyNN+N//FehJHuEiOIxtUBKUWm8VEQ7Ht
         N9yE0sfwJi53IQO7F5JSh8A9oaJkk7bB/Li6zB93+TDpFPDzf076VljQdKMrA4Mue3VZ
         /msJGY2oyCl+Wn5U9mkRm5CZyMb8YFfkgdIzHw12YuqBmO7gV2a8zxMW9N9igH/XnQ3Y
         +Al1fpvKrKyP0CbEa/hvNiihsftQeYtsIbXcpamV769uMhPdxdPYVZ+5zmMhU9511qmU
         Qrjg==
X-Gm-Message-State: AA+aEWZua7slt+BQ0UDeX3yXIxGuXTJxzrWIULqnFk0ZB5XzxeOlvZ2S
        4XdtTeEozWQvIkeT6J1EPLKPtw==
X-Google-Smtp-Source: AFSGD/W9a860LsyGGAHNX80o9Wz9NQ2390cYNt81ClIdchniC+cAXy4DvyDCb5I3xZYQ0hdPY0paOA==
X-Received: by 2002:a63:8e43:: with SMTP id k64mr11656442pge.346.1545043288598;
        Mon, 17 Dec 2018 02:41:28 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id b27sm17224826pfh.113.2018.12.17.02.41.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Dec 2018 02:41:28 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linuxppc-dev@lists.ozlabs.org, sathnaga@linux.vnet.ibm.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Breno Leitao <leitao@debian.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v6 2/5] powerpc: move macro definition from asm/systbl.h
Date:   Mon, 17 Dec 2018 16:10:33 +0530
Message-Id: <1545043236-11649-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545043236-11649-1-git-send-email-firoz.khan@linaro.org>
References: <1545043236-11649-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the macro definition for compat_sys_sigsuspend from
asm/systbl.h to the file which it is getting included.

One of the patch in this patch series is generating uapi
header and syscall table files. In order to come up with
a common implimentation across all architecture, we need
to do this change.

This change will simplify the implementation of system
call table generation script and help to come up a common
implementation across all architecture.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/powerpc/include/asm/systbl.h | 1 -
 arch/powerpc/kernel/systbl.S      | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index 01b5171..c4321b9 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -76,7 +76,6 @@
 SYSCALL_SPU(ssetmask)
 SYSCALL_SPU(setreuid)
 SYSCALL_SPU(setregid)
-#define compat_sys_sigsuspend sys_sigsuspend
 SYS32ONLY(sigsuspend)
 SYSX(sys_ni_syscall,compat_sys_sigpending,sys_sigpending)
 SYSCALL_SPU(sethostname)
diff --git a/arch/powerpc/kernel/systbl.S b/arch/powerpc/kernel/systbl.S
index 919a327..9ff1913 100644
--- a/arch/powerpc/kernel/systbl.S
+++ b/arch/powerpc/kernel/systbl.S
@@ -47,4 +47,5 @@
 .globl sys_call_table
 sys_call_table:
 
+#define compat_sys_sigsuspend	sys_sigsuspend
 #include <asm/systbl.h>
-- 
1.9.1

