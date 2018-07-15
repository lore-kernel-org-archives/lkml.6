Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061FFECDFB3
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3C520870
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD3C520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbeGPADr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 20:03:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47991 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbeGPADr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 20:03:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6FNcpW3922773
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 15 Jul 2018 16:38:51 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6FNcoNf922770;
        Sun, 15 Jul 2018 16:38:50 -0700
Date:   Sun, 15 Jul 2018 16:38:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sai Praneeth <tipbot@zytor.com>
Message-ID: <tip-f5dcc214aae29a68b37b2b4183f7171724e7b02d@git.kernel.org>
Cc:     sai.praneeth.prakhya@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        ard.biesheuvel@linaro.org, mingo@kernel.org, tglx@linutronix.de,
        peterz@infradead.org
Reply-To: peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
          ard.biesheuvel@linaro.org, linux-kernel@vger.kernel.org,
          torvalds@linux-foundation.org, sai.praneeth.prakhya@intel.com,
          hpa@zytor.com
In-Reply-To: <20180711094040.12506-6-ard.biesheuvel@linaro.org>
References: <20180711094040.12506-6-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi: Remove the declaration of efi_late_init() as
 the function is unused
Git-Commit-ID: f5dcc214aae29a68b37b2b4183f7171724e7b02d
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

Commit-ID:  f5dcc214aae29a68b37b2b4183f7171724e7b02d
Gitweb:     https://git.kernel.org/tip/f5dcc214aae29a68b37b2b4183f7171724e7b02d
Author:     Sai Praneeth <sai.praneeth.prakhya@intel.com>
AuthorDate: Wed, 11 Jul 2018 11:40:37 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 16 Jul 2018 00:43:12 +0200

efi: Remove the declaration of efi_late_init() as the function is unused

The following commit:

  7b0a911478c74 ("efi/x86: Move the EFI BGRT init code to early init code")

... removed the implementation and all the references to
efi_late_init() but the function is still declared at
include/linux/efi.h.

Hence, remove the unnecessary declaration.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180711094040.12506-6-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/efi.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 8ba0cdd244b2..e190652f5ef9 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -988,14 +988,12 @@ extern void efi_memmap_walk (efi_freemem_callback_t callback, void *arg);
 extern void efi_gettimeofday (struct timespec64 *ts);
 extern void efi_enter_virtual_mode (void);	/* switch EFI to virtual mode, if possible */
 #ifdef CONFIG_X86
-extern void efi_late_init(void);
 extern void efi_free_boot_services(void);
 extern efi_status_t efi_query_variable_store(u32 attributes,
 					     unsigned long size,
 					     bool nonblocking);
 extern void efi_find_mirror(void);
 #else
-static inline void efi_late_init(void) {}
 static inline void efi_free_boot_services(void) {}
 
 static inline efi_status_t efi_query_variable_store(u32 attributes,
