Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB240C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79EF3218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fk5JPnoa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbfABPXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 10:23:24 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40182 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbfABPXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 10:23:23 -0500
Received: by mail-pg1-f193.google.com with SMTP id z10so14715598pgp.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 07:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mMRokCY/raY2LNrxQGirT+z5+67SxfwcWVjXUGq++20=;
        b=Fk5JPnoa43ZAMOoROs3/MgOGEYdke+QfovbM6qLNS0ep4LXOLq75VCOpfQj+38JUei
         dbunkDECImjeKAS+4YNXOerk1qZvDgagMnjyaqvXYhAsPYLO5ZVTAqqhjJFOJ97rsxfq
         dnMfcfH5ERKK0NNokA5i8/KscYXKPsBhOshjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mMRokCY/raY2LNrxQGirT+z5+67SxfwcWVjXUGq++20=;
        b=ORw0xf+0qDcgZnrU6EfTrFmn95LZEY4o/TNVDyIGPmd91A5GbgDwHsMAk8qeV0P+oK
         dSeKBDtVtF5fQLDzfKrFFEeQekdx+/Kq2fNyyUhvlzG0rEJtw+zEOCj3nA49PcVRWPHK
         ie4PwpiZsPbOk+RR+vU/LyIgFs3Zqz+Gli0rgOoVj4nhAHV3HgAnhrEpLFjQbcD3J06M
         e3Tr9trpbf89Ds0AcccPNB7By1iaGX/nSw2SsySYufh8KuvgQD31Tvkc9qnwA+kEHth8
         rdK9rwnwqrUgln4ToERnzmyIR6dbYw1atQGETLCTWFBEeWyWQd4+oSdImS8DC0Qq+hCq
         XtzA==
X-Gm-Message-State: AJcUukdag5HvZkHstSwODfrpRDMKIP9KdDLoB4DFZvr/F8AQH2dWrKNf
        kXcqSRso9uO824Cfbfzb3z/dOQ==
X-Google-Smtp-Source: ALg8bN6crO7+6P6JsUv97aJ6EN0MMIm0xJhfWNtSly9RXU0NrNbhVX5ZDJZuUltbnlC7JwSCF5VwKA==
X-Received: by 2002:a63:a401:: with SMTP id c1mr13898268pgf.403.1546442602346;
        Wed, 02 Jan 2019 07:23:22 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id m20sm67719647pgv.93.2019.01.02.07.23.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jan 2019 07:23:21 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        linux-ia64@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 1/2] ia64: remove nargs from __SYSCALL
Date:   Wed,  2 Jan 2019 20:52:46 +0530
Message-Id: <1546442567-20637-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546442567-20637-1-git-send-email-firoz.khan@linaro.org>
References: <1546442567-20637-1-git-send-email-firoz.khan@linaro.org>
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
 arch/ia64/kernel/entry.S                | 2 +-
 arch/ia64/kernel/syscalls/syscalltbl.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/ia64/kernel/entry.S b/arch/ia64/kernel/entry.S
index a9992be..204b56d 100644
--- a/arch/ia64/kernel/entry.S
+++ b/arch/ia64/kernel/entry.S
@@ -1426,7 +1426,7 @@ END(ftrace_stub)
 
 #endif /* CONFIG_FUNCTION_TRACER */
 
-#define __SYSCALL(nr, entry, nargs) data8 entry
+#define __SYSCALL(nr, entry)	data8 entry
 	.rodata
 	.align 8
 	.globl sys_call_table
diff --git a/arch/ia64/kernel/syscalls/syscalltbl.sh b/arch/ia64/kernel/syscalls/syscalltbl.sh
index 85d78d9..904b8e6 100644
--- a/arch/ia64/kernel/syscalls/syscalltbl.sh
+++ b/arch/ia64/kernel/syscalls/syscalltbl.sh
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

