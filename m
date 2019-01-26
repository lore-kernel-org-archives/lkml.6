Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC69C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 512CC217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbfAZKQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 05:16:21 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43383 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfAZKQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 05:16:21 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0QAFuGC515004
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 26 Jan 2019 02:15:56 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0QAFu26515001;
        Sat, 26 Jan 2019 02:15:56 -0800
Date:   Sat, 26 Jan 2019 02:15:56 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Gustavo A. R. Silva" <tipbot@zytor.com>
Message-ID: <tip-89da3446294a8b811b28a4807e74e7ee7044d49f@git.kernel.org>
Cc:     x86@kernel.org, bp@suse.de, tglx@linutronix.de,
        gustavo@embeddedor.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, hpa@zytor.com, mingo@redhat.com,
        keescook@chromium.org
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org,
          gustavo@embeddedor.com, tglx@linutronix.de, bp@suse.de,
          x86@kernel.org, keescook@chromium.org, mingo@redhat.com,
          hpa@zytor.com
In-Reply-To: <20190125205520.GA9602@embeddedor>
References: <20190125205520.GA9602@embeddedor>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/insn-eval: Mark expected switch-case
 fall-through
Git-Commit-ID: 89da3446294a8b811b28a4807e74e7ee7044d49f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  89da3446294a8b811b28a4807e74e7ee7044d49f
Gitweb:     https://git.kernel.org/tip/89da3446294a8b811b28a4807e74e7ee7044d49f
Author:     Gustavo A. R. Silva <gustavo@embeddedor.com>
AuthorDate: Fri, 25 Jan 2019 14:55:20 -0600
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sat, 26 Jan 2019 10:46:42 +0100

x86/insn-eval: Mark expected switch-case fall-through

In preparation to enable -Wimplicit-fallthrough by default, mark
switch-case statements where fall-through is intentional, explicitly.

Thus fix the following warning:

  arch/x86/lib/insn-eval.c: In function ‘resolve_default_seg’:
  arch/x86/lib/insn-eval.c:179:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
     if (insn->addr_bytes == 2)
        ^
  arch/x86/lib/insn-eval.c:182:2: note: here
    case -EDOM:
    ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This is part of the ongoing efforts to enable -Wimplicit-fallthrough by
default.

 [ bp: Massage commit message. ]

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190125205520.GA9602@embeddedor
---
 arch/x86/lib/insn-eval.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index 9119d8e41f1f..cf00ab6c6621 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -179,6 +179,8 @@ static int resolve_default_seg(struct insn *insn, struct pt_regs *regs, int off)
 		if (insn->addr_bytes == 2)
 			return -EINVAL;
 
+		/* fall through */
+
 	case -EDOM:
 	case offsetof(struct pt_regs, bx):
 	case offsetof(struct pt_regs, si):
