Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF72C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2772420850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2772420850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbeLCVBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:01:52 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49609 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeLCVBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:01:52 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wB3L1UG4594332
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 3 Dec 2018 13:01:30 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wB3L1UD9594328;
        Mon, 3 Dec 2018 13:01:30 -0800
Date:   Mon, 3 Dec 2018 13:01:30 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-e08e32119b944f519664451bfb342a25b4045ead@git.kernel.org>
Cc:     mingo@kernel.org, jroedel@suse.de, riel@surriel.com,
        tglx@linutronix.de, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com, x86@kernel.org,
        dave.hansen@linux.intel.com, bigeasy@linutronix.de,
        jannh@google.com, bp@suse.de, mingo@redhat.com, rkrcmar@redhat.com,
        luto@kernel.org, hpa@zytor.com, Jason@zx2c4.com
Reply-To: rkrcmar@redhat.com, luto@kernel.org, mingo@redhat.com,
          hpa@zytor.com, Jason@zx2c4.com, bigeasy@linutronix.de,
          jannh@google.com, dave.hansen@linux.intel.com, bp@suse.de,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          kvm@vger.kernel.org, pbonzini@redhat.com, x86@kernel.org,
          jroedel@suse.de, mingo@kernel.org, riel@surriel.com
In-Reply-To: <20181128222035.2996-3-bigeasy@linutronix.de>
References: <20181128222035.2996-3-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/fpu] x86/process/32: Remove asm/math_emu.h include
Git-Commit-ID: e08e32119b944f519664451bfb342a25b4045ead
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

Commit-ID:  e08e32119b944f519664451bfb342a25b4045ead
Gitweb:     https://git.kernel.org/tip/e08e32119b944f519664451bfb342a25b4045ead
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Wed, 28 Nov 2018 23:20:08 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 3 Dec 2018 18:51:16 +0100

x86/process/32: Remove asm/math_emu.h include

The math_emu.h header files contains the definition of struct
math_emu_info which is not used in this file.

Remove the asm/math_emu.h include.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Rik van Riel <riel@surriel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kvm ML <kvm@vger.kernel.org>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20181128222035.2996-3-bigeasy@linutronix.de
---
 arch/x86/kernel/process_32.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index d3e593eb189f..575654db463e 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -44,9 +44,6 @@
 #include <asm/processor.h>
 #include <asm/fpu/internal.h>
 #include <asm/desc.h>
-#ifdef CONFIG_MATH_EMULATION
-#include <asm/math_emu.h>
-#endif
 
 #include <linux/err.h>
 
