Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B239C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 535DA2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730901AbfBNQRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:17:02 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59439 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbfBNQRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:17:02 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1EGGPux784520
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 14 Feb 2019 08:16:25 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1EGGNJ2784517;
        Thu, 14 Feb 2019 08:16:23 -0800
Date:   Thu, 14 Feb 2019 08:16:23 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Shaokun Zhang <tipbot@zytor.com>
Message-ID: <tip-8e8a3cea7ea5f5458fdf2287713626892e7715f5@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        aryabinin@virtuozzo.com, mingo@redhat.com, tglx@linutronix.de,
        hpa@zytor.com, bp@suse.de, zhangshaokun@hisilicon.com,
        x86@kernel.org
Reply-To: mingo@kernel.org, dave.hansen@linux.intel.com,
          linux-kernel@vger.kernel.org, luto@kernel.org,
          peterz@infradead.org, mingo@redhat.com, aryabinin@virtuozzo.com,
          tglx@linutronix.de, bp@suse.de, hpa@zytor.com, x86@kernel.org,
          zhangshaokun@hisilicon.com
In-Reply-To: <1550136829-49088-1-git-send-email-zhangshaokun@hisilicon.com>
References: <1550136829-49088-1-git-send-email-zhangshaokun@hisilicon.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/mm/dump_pagetables: Remove the unused
 prev_pud variable
Git-Commit-ID: 8e8a3cea7ea5f5458fdf2287713626892e7715f5
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

Commit-ID:  8e8a3cea7ea5f5458fdf2287713626892e7715f5
Gitweb:     https://git.kernel.org/tip/8e8a3cea7ea5f5458fdf2287713626892e7715f5
Author:     Shaokun Zhang <zhangshaokun@hisilicon.com>
AuthorDate: Thu, 14 Feb 2019 17:33:49 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 14 Feb 2019 17:09:43 +0100

x86/mm/dump_pagetables: Remove the unused prev_pud variable

The 'prev_pud' local variable became unused after commit

  04b67022fb6d ("x86/mm/dump_pagetables: Speed up page tables dump for CONFIG_KASAN=y").

Remove it.

Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/1550136829-49088-1-git-send-email-zhangshaokun@hisilicon.com
---
 arch/x86/mm/dump_pagetables.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index e3cdc85ce5b6..ee8f8ab46941 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -444,7 +444,6 @@ static void walk_pud_level(struct seq_file *m, struct pg_state *st, p4d_t addr,
 	int i;
 	pud_t *start, *pud_start;
 	pgprotval_t prot, eff;
-	pud_t *prev_pud = NULL;
 
 	pud_start = start = (pud_t *)p4d_page_vaddr(addr);
 
@@ -462,7 +461,6 @@ static void walk_pud_level(struct seq_file *m, struct pg_state *st, p4d_t addr,
 		} else
 			note_page(m, st, __pgprot(0), 0, 3);
 
-		prev_pud = start;
 		start++;
 	}
 }
