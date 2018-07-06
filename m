Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAADC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC2C22BC8
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A9ZwDUqj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC2C22BC8
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753860AbeGFVuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 17:50:12 -0400
Received: from mail-yw0-f201.google.com ([209.85.161.201]:55534 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753612AbeGFVuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 17:50:11 -0400
Received: by mail-yw0-f201.google.com with SMTP id a200-v6so11637851ywh.22
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 14:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=mPhO1/Nh9RvuUdZfzZcAOylrPAiR7tlRWz+5DT0sjMw=;
        b=A9ZwDUqjzkB11a0Oisdg1wF9Nt7yAZ0/bLCDL/0cWNMdItPBFknN+sQgXcdufJIZnu
         KLHRPylTuYB3+MUUU06KMwHhYAK/8GHey8qcvjwHVMZWoCWyYe3YjGTX/FQNZx76A0Q9
         RI2aicqZRWnVgmkOwSjcJ7lZEqjahlqkk4/2AX5nhh/HyquTK/Fq+CavuXnBPQj6ri4O
         e4vBPj9MfE4Di+5Wj84t9ZW/1AX94FWel7tnpoH52NyNEKxVIt5YPhjSl3MSyEgkq/Ce
         Vl8Qr9HItKfaPu70Jn5F5JBbiNsGGfE5E63U4TefvmbGsDrxrdDSQ4tja3xRrac24E3H
         8xbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=mPhO1/Nh9RvuUdZfzZcAOylrPAiR7tlRWz+5DT0sjMw=;
        b=Mx+lR6YRlSvNKlMIVE88avuEPRewyIOITnK2Y+oe5nVCMw298m5XAbdXYOcQh2tlDf
         wTOU6JmSiZ9gMRfSgPYcIgt0xOpm2bZtPYJYU0INp/B70GFR+8TP27xZHKs2KhKYS4G1
         Ss1doupHE431w0DUfKcNJ1J+i/ENmsiX3eCmq8Bi1YLfKb2sXq3iS40uFIJ4UMK1XPSJ
         MFBDwAiXCLkBk51RjUrZb95OsV2Wboj84umy8FtMIt0csqkOHNQX01AqaK2HGGhYfE/k
         +MfRk9Gvb4F+8xPcsiTxncDx7yHh/NrFCM/B054u+QQMOy5wneMhlaspCMzHIKBy/j9H
         b5bw==
X-Gm-Message-State: APt69E2H36GavRW2yv+xAethwo7H6rSaIcf3UehKPqNl5Eys4u4D+/aA
        10IWRzsCCFMbLvwaiT3tnPtOEAv60A==
X-Google-Smtp-Source: AAOMgpeYbNomC8dchMK/Ev1185RVk+4oR7RbHBUEuHqZbLyAdsVFL2ki7Ixe2OoE9UvsLEdaDKVwAlsQ0g==
MIME-Version: 1.0
X-Received: by 2002:a25:8610:: with SMTP id y16-v6mr3824457ybk.20.1530913810379;
 Fri, 06 Jul 2018 14:50:10 -0700 (PDT)
Date:   Fri,  6 Jul 2018 23:50:03 +0200
Message-Id: <20180706215003.156702-1-jannh@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH] x86/mtrr: don't copy out-of-bounds data in mtrr_write
From:   Jann Horn <jannh@google.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, jannh@google.com
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't access the provided buffer out of bounds - this can cause a kernel
out-of-bounds read when invoked through sys_splice() or other things that
use kernel_write()/__kernel_write().

Fixes: 7f8ec5a4f01a ("x86/mtrr: Convert to use strncpy_from_user() helper")
Signed-off-by: Jann Horn <jannh@google.com>
---
 arch/x86/kernel/cpu/mtrr/if.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mtrr/if.c b/arch/x86/kernel/cpu/mtrr/if.c
index 4021d3859499..40eee6cc4124 100644
--- a/arch/x86/kernel/cpu/mtrr/if.c
+++ b/arch/x86/kernel/cpu/mtrr/if.c
@@ -106,7 +106,8 @@ mtrr_write(struct file *file, const char __user *buf, size_t len, loff_t * ppos)
 
 	memset(line, 0, LINE_SIZE);
 
-	length = strncpy_from_user(line, buf, LINE_SIZE - 1);
+	len = min_t(size_t, len, LINE_SIZE - 1);
+	length = strncpy_from_user(line, buf, len);
 	if (length < 0)
 		return length;
 
-- 
2.18.0.203.gfac676dfb9-goog

