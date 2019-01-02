Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9E7C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C47218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="k1QYKTOq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbfABPMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 10:12:35 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43679 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729934AbfABPMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 10:12:34 -0500
Received: by mail-pf1-f193.google.com with SMTP id w73so15286142pfk.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 07:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vQ8I21RoGZh51XjYrN7+ErT+m6l5lADjiriHH6YnHTE=;
        b=k1QYKTOqYhjca+wchw6SKO6UREz9RYUYJLriIhrieMoz52z6U3hV8q9mZ470sLYafr
         EfaWiQAwBwZ13YeLzWQR2zrrddMAoaIHEiddFjkd7A6S72b4tVdf1LbOejxyiXJrqHYA
         EJxCM2VWE3BUIPwUl6Qg1DO4upU8uOHz4q/Co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vQ8I21RoGZh51XjYrN7+ErT+m6l5lADjiriHH6YnHTE=;
        b=XqFJa6s71EuDMdEQd28NTe1pZRMAWYYkSjb/GHY4msRBDQu5waW3FbhN4w/LfOMueT
         9kT5HI79DdpKQRdOLymTShAQ4rGWVtFcrzv1Rf1HZa1fNxKbjKeovVs8UhQ+QX2g5ndH
         F/Vg/J476NVpsOc9CHGDWSH5KXDiA+waXL5/fxNt4cynZ3uuijl2XEr1EBvjD1JsAF17
         S4cFLp8QMIfFy+VNDRYOGQ2sf/1saZlPtd6tqcCnsleV+pmQGK2vb5SnSE7DBWGgYSjZ
         6F/d4IFv9y3r9vOLOCBm3aDlpJUm8x50PLwMFsoOKa0nD7tbf+8uOjKYYUvUEEDHnlk2
         vkng==
X-Gm-Message-State: AJcUukeSzj9sFjsHbm/LYvVvpHFIv+R8VOb9TpYLzTfIitmh4ezZ9n41
        548NPnlaKTYRCHeouMGGuoWx/Q==
X-Google-Smtp-Source: ALg8bN5ozj30pcOEJG0LNI0Nl6YO6okcHqT3lXEZA/yuLX9S/n8H+28LYDT1KYHJwKs4djFScHIsFg==
X-Received: by 2002:a63:2849:: with SMTP id o70mr13613339pgo.155.1546441953822;
        Wed, 02 Jan 2019 07:12:33 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 125sm94973786pfd.124.2019.01.02.07.12.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jan 2019 07:12:33 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Michal Simek <monstr@monstr.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 1/2] microblaze: remove nargs from __SYSCALL
Date:   Wed,  2 Jan 2019 20:42:03 +0530
Message-Id: <1546441924-20262-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546441924-20262-1-git-send-email-firoz.khan@linaro.org>
References: <1546441924-20262-1-git-send-email-firoz.khan@linaro.org>
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
 arch/microblaze/kernel/syscall_table.S        | 2 +-
 arch/microblaze/kernel/syscalls/syscalltbl.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/microblaze/kernel/syscall_table.S b/arch/microblaze/kernel/syscall_table.S
index ce00664..91ade44 100644
--- a/arch/microblaze/kernel/syscall_table.S
+++ b/arch/microblaze/kernel/syscall_table.S
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
-#define __SYSCALL(nr, entry, nargs) .long entry
+#define __SYSCALL(nr, entry)	.long entry
 ENTRY(sys_call_table)
 #include <asm/syscall_table.h>
 #undef __SYSCALL
diff --git a/arch/microblaze/kernel/syscalls/syscalltbl.sh b/arch/microblaze/kernel/syscalls/syscalltbl.sh
index 85d78d9..904b8e6 100644
--- a/arch/microblaze/kernel/syscalls/syscalltbl.sh
+++ b/arch/microblaze/kernel/syscalls/syscalltbl.sh
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

