Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B9AC07E85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6274320850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6274320850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbeLCVEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:04:35 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50411 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeLCVEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:04:34 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wB3L3Ea3594664
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 3 Dec 2018 13:03:14 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wB3L3E1C594661;
        Mon, 3 Dec 2018 13:03:14 -0800
Date:   Mon, 3 Dec 2018 13:03:14 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-6637401c35b2f327a35d27f44bda05e327f2f017@git.kernel.org>
Cc:     jannh@google.com, hpa@zytor.com, bigeasy@linutronix.de,
        x86@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        mingo@redhat.com, bp@suse.de, riel@surriel.com,
        dave.hansen@linux.intel.com, mingo@kernel.org, Jason@zx2c4.com,
        rkrcmar@redhat.com, kvm@vger.kernel.org, luto@kernel.org,
        pbonzini@redhat.com
Reply-To: jannh@google.com, hpa@zytor.com, bigeasy@linutronix.de,
          x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
          mingo@redhat.com, bp@suse.de, riel@surriel.com,
          dave.hansen@linux.intel.com, mingo@kernel.org, Jason@zx2c4.com,
          luto@kernel.org, rkrcmar@redhat.com, kvm@vger.kernel.org,
          pbonzini@redhat.com
In-Reply-To: <20181128222035.2996-6-bigeasy@linutronix.de>
References: <20181128222035.2996-6-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/fpu] x86/fpu: Add might_fault() to user_insn()
Git-Commit-ID: 6637401c35b2f327a35d27f44bda05e327f2f017
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

Commit-ID:  6637401c35b2f327a35d27f44bda05e327f2f017
Gitweb:     https://git.kernel.org/tip/6637401c35b2f327a35d27f44bda05e327f2f017
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Wed, 28 Nov 2018 23:20:11 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 3 Dec 2018 19:15:32 +0100

x86/fpu: Add might_fault() to user_insn()

Every user of user_insn() passes an user memory pointer to this macro.

Add might_fault() to user_insn() so we can spot users which are using
this macro in sections where page faulting is not allowed.

 [ bp: Space it out to make it more visible. ]

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Rik van Riel <riel@surriel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kvm ML <kvm@vger.kernel.org>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20181128222035.2996-6-bigeasy@linutronix.de
---
 arch/x86/include/asm/fpu/internal.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 69dcdf195b61..fa2c93cb42a2 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -106,6 +106,9 @@ extern void fpstate_sanitize_xstate(struct fpu *fpu);
 #define user_insn(insn, output, input...)				\
 ({									\
 	int err;							\
+									\
+	might_fault();							\
+									\
 	asm volatile(ASM_STAC "\n"					\
 		     "1:" #insn "\n\t"					\
 		     "2: " ASM_CLAC "\n"				\
