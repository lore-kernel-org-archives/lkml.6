Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0991EC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD998208DA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QYmc8T2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD998208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbeH0Wpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:45:50 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:38099 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbeH0Wpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:45:49 -0400
Received: by mail-pf1-f202.google.com with SMTP id e15-v6so15488pfi.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eqpJL+HTAUaly6TthXYPjkvNkyzv1PO/fAC6zdW/LP4=;
        b=QYmc8T2yUkQH5+tuKTLSQ5xRntLwae+jQotcuh9fniFtflY9ybVDubyF7tv/UFzzit
         jP5HzN2cyW5jpYOkeyNjZK2KIKQZLvX3ZcgacdgFjElEW5xQVlaSQ7RT4Bao2Zjh0hrn
         ms0HIGB0KPnZe2YhnNjcL5ebt/UWgZXiD+b9k0r1BPr4Hgtx85YuJhHuCSUYj1nawKlM
         VpbPyfj6tXqDfW5TYB84o+1NuXHvCuAjUMBcvmokHZyX0EJb2uC0ZFdKbBqk27/G4xpz
         QV4NYGeaCyC3RE03SSrlT84RpeIEcRbLqUASg7BPoVJ2b3vJCEU6CDqGdRzuGCAzJHLZ
         uEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eqpJL+HTAUaly6TthXYPjkvNkyzv1PO/fAC6zdW/LP4=;
        b=EWdmSk7ZoSYTLi5DV4d1EfyioZpfWEttTVjMNjAgsKsBb0plUBcIp+BDVNjfYQ9+71
         +47XM3sjZOkqU2zA2gJ/Y7j2TICzCr/Rmt4wlUd69wIZQzBpevIgiEQSRBX3o3oP+L/O
         YBtETfdcu151PGD1a/L3pZqSsmH0Y+jt/Rd1Ik/46NE40CvgIPkTzm+li4IL5caF31Aw
         DWFs5tqlxBsQyUH18E2kZlIAO+TdjOS1x7tONs/N8CXwHhRTF/FznoORMD8/Amx3N2uc
         nPHdOTrnp27diqL7yvckBW1yt/2RaLfsFsNsgk2lXJCfezVmdX5vfUOuVaWqzuF08YGm
         7DnA==
X-Gm-Message-State: APzg51DDqI7UqEMFrNRISMfQ0v18YWz+ncSLcCS9j2Lbf3zmk42GeCYt
        IG7kdJ86r6zOnepdAH2crmAFo+jFJA==
X-Google-Smtp-Source: ANB0VdZ2/PwcEwXqcNrjOb3NgeqNHewW6uRfXlDAuW1Yz16d4zCG1H6YpaY0gP9ZOY0qGsHkkGsqAOOnTw==
X-Received: by 2002:a63:4541:: with SMTP id u1-v6mr5333pgk.104.1535396279373;
 Mon, 27 Aug 2018 11:57:59 -0700 (PDT)
Date:   Mon, 27 Aug 2018 20:56:27 +0200
In-Reply-To: <20180827185631.163506-1-jannh@google.com>
Message-Id: <20180827185631.163506-4-jannh@google.com>
Mime-Version: 1.0
References: <20180827185631.163506-1-jannh@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH v2 3/7] x86: stop calling fixup_exception() from kprobe_fault_handler()
From:   Jann Horn <jannh@google.com>
To:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        kernel-hardening@lists.openwall.com,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, jannh@google.com
Cc:     linux-kernel@vger.kernel.org, dvyukov@google.com,
        linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the call into exception fixup that was added in
commit c28f896634f2 ("[PATCH] kprobes: fix broken fault handling for
x86_64").

On X86, kprobe_fault_handler() is called from two places:
do_general_protection() (for #GP) and kprobes_fault() (for #PF).
In both paths, the fixup_exception() call in the kprobe fault handler is
redundant.

For #GP, fixup_exception() is called immediately before
kprobe_fault_handler() is invoked - if someone wanted to fix up our #GP,
they've already done so, no need to try again. (This assumes that the
kprobe's fault handler isn't going to do something crazy like changing RIP
so that it suddenly points to an instruction that does userspace access.)

For #PF on a kernel address from kernel space, after the kprobe fault
handler has run, we'll go into no_context(), which calls fixup_exception().

Signed-off-by: Jann Horn <jannh@google.com>
---
 arch/x86/kernel/kprobes/core.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 467ac22691b0..7315ac202aad 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1021,13 +1021,6 @@ int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 		if (cur->fault_handler && cur->fault_handler(cur, regs, trapnr))
 			return 1;
 
-		/*
-		 * In case the user-specified fault handler returned
-		 * zero, try to fix up.
-		 */
-		if (fixup_exception(regs, trapnr))
-			return 1;
-
 		/* fixup routine could not handle it. */
 	}
 
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

