Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194E3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFA921780
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEFA921780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732928AbeKOTRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:17:46 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54185 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729006AbeKOTRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 14:17:46 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAF99urv738643
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 15 Nov 2018 01:09:56 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAF99uBd738640;
        Thu, 15 Nov 2018 01:09:56 -0800
Date:   Thu, 15 Nov 2018 01:09:56 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-ef1491e791308317bb9851a0ad380c4a68b58d54@git.kernel.org>
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        peterz@infradead.org, ard.biesheuvel@linaro.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, sai.praneeth.prakhya@intel.com,
        longman@redhat.com, tglx@linutronix.de
Reply-To: torvalds@linux-foundation.org, mingo@kernel.org,
          peterz@infradead.org, hpa@zytor.com, ard.biesheuvel@linaro.org,
          tglx@linutronix.de, longman@redhat.com,
          linux-kernel@vger.kernel.org, sai.praneeth.prakhya@intel.com
In-Reply-To: <20181114175544.12860-2-ard.biesheuvel@linaro.org>
References: <20181114175544.12860-2-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/urgent] efi: Fix debugobjects warning on 'efi_rts_work'
Git-Commit-ID: ef1491e791308317bb9851a0ad380c4a68b58d54
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

Commit-ID:  ef1491e791308317bb9851a0ad380c4a68b58d54
Gitweb:     https://git.kernel.org/tip/ef1491e791308317bb9851a0ad380c4a68b58d54
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Wed, 14 Nov 2018 09:55:40 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 15 Nov 2018 10:04:45 +0100

efi: Fix debugobjects warning on 'efi_rts_work'

The following commit:

  9dbbedaa6171 ("efi: Make efi_rts_work accessible to efi page fault handler")

converted 'efi_rts_work' from an auto variable to a global variable.
However, when submitting the work, INIT_WORK_ONSTACK() was still used,
causing the following complaint from debugobjects:

  ODEBUG: object 00000000ed27b500 is NOT on stack 00000000c7d38760, but annotated.

Change the macro to just INIT_WORK() to eliminate the warning.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Fixes: 9dbbedaa6171 ("efi: Make efi_rts_work accessible to efi page fault handler")
Link: http://lkml.kernel.org/r/20181114175544.12860-2-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/runtime-wrappers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
index a19d845bdb06..8903b9ccfc2b 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -67,7 +67,7 @@ struct efi_runtime_work efi_rts_work;
 	}								\
 									\
 	init_completion(&efi_rts_work.efi_rts_comp);			\
-	INIT_WORK_ONSTACK(&efi_rts_work.work, efi_call_rts);		\
+	INIT_WORK(&efi_rts_work.work, efi_call_rts);			\
 	efi_rts_work.arg1 = _arg1;					\
 	efi_rts_work.arg2 = _arg2;					\
 	efi_rts_work.arg3 = _arg3;					\
