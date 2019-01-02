Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059F3C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 16:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E73218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 16:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kDIa2pp8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbfABQDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 11:03:03 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38543 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729748AbfABQDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 11:03:02 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so15349867pfi.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 08:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I/IdQ3gHuHewCarM4j7PXDdAi6DMpS4LLo+6L5+gcGs=;
        b=kDIa2pp81CNW0gXQt57dWazhs3d141LdwbD5f1CWDE0R2Qmn2ENNlcuGkyBlkyN4CI
         wow7Ajc4B4/IeAroWARRpUY0y3mj9XTwBgjGgd26j0InpmJ9vxYnTfkrtXI12xJHXw9c
         EKyWZNE7iuH6RcU2nIgckgXN0Zdxo0Ab3ItmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I/IdQ3gHuHewCarM4j7PXDdAi6DMpS4LLo+6L5+gcGs=;
        b=a9wisP+yWOOLJlY7Ty6UHrPJfwp9v/Y9+8FPmHjbn/sqSrDAlbpYNt1dONqlTBleoG
         5D5YRLB4cHElcnHiKOBESFbtY1h+WtlzT6syVUcNHs5SGpHrMGHlBvSlGlWeePZXJBwZ
         e17aDngRq737POevcPAaLiSURu/gvAFmCy00toGVUkKFDi5b9cNq5vvhffi/7rrGB72a
         vaRdDqdQ1rpB13WCx7px835V8ls5Px6O9XgRGgzFt0UlrANM44UqMZpGx47b1RSSeVnv
         yqALBTlSmAcG6+3ZjJL3ZtqXu9Of0d9vqx8Q6kOlQZVQ1CPBmsRXmf1ZYJSWFU3J+gy+
         KKHw==
X-Gm-Message-State: AA+aEWb/vhQN513IWGvDqHuqAlTn0Ra36lC8dr+pxgl8hSH8gTgBztvx
        mJhnJL5s+e6ReW5a7WlhThPTpA==
X-Google-Smtp-Source: AFSGD/UfAvnR8CL/sapTTiTV+JIPvWB7eKPX+rSH2QQaXe97Xgya7Bk9sQ1C6grIFqrSvlvzFwREpg==
X-Received: by 2002:a62:cf84:: with SMTP id b126mr44515975pfg.98.1546444980916;
        Wed, 02 Jan 2019 08:03:00 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id s2sm104344924pfa.167.2019.01.02.08.02.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jan 2019 08:03:00 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        Matthew Wilcox <willy@infradead.org>,
        linux-parisc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 1/2] parisc: remove nargs from __SYSCALL
Date:   Wed,  2 Jan 2019 21:32:32 +0530
Message-Id: <1546444953-21630-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546444953-21630-1-git-send-email-firoz.khan@linaro.org>
References: <1546444953-21630-1-git-send-email-firoz.khan@linaro.org>
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
 arch/parisc/kernel/syscall.S              | 2 +-
 arch/parisc/kernel/syscalls/syscalltbl.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/parisc/kernel/syscall.S b/arch/parisc/kernel/syscall.S
index 4f77bd9..e843151 100644
--- a/arch/parisc/kernel/syscall.S
+++ b/arch/parisc/kernel/syscall.S
@@ -923,7 +923,7 @@ ENTRY(lws_table)
 END(lws_table)
 	/* End of lws table */
 
-#define __SYSCALL(nr, entry, nargs) ASM_ULONG_INSN entry
+#define __SYSCALL(nr, entry)	ASM_ULONG_INSN entry
 	.align 8
 ENTRY(sys_call_table)
 	.export sys_call_table,data
diff --git a/arch/parisc/kernel/syscalls/syscalltbl.sh b/arch/parisc/kernel/syscalls/syscalltbl.sh
index 45b5bae..f7393a7 100644
--- a/arch/parisc/kernel/syscalls/syscalltbl.sh
+++ b/arch/parisc/kernel/syscalls/syscalltbl.sh
@@ -13,10 +13,10 @@ emit() {
 	t_entry="$3"
 
 	while [ $t_nxt -lt $t_nr ]; do
-		printf "__SYSCALL(%s, sys_ni_syscall, )\n" "${t_nxt}"
+		printf "__SYSCALL(%s,sys_ni_syscall)\n" "${t_nxt}"
 		t_nxt=$((t_nxt+1))
 	done
-	printf "__SYSCALL(%s, %s, )\n" "${t_nxt}" "${t_entry}"
+	printf "__SYSCALL(%s,%s)\n" "${t_nxt}" "${t_entry}"
 }
 
 grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
-- 
1.9.1

