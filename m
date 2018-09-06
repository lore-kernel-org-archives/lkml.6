Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471AAC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F040D2077C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F040D2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbeIFRPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:15:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58419 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbeIFRPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:15:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86CdqBW295310
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 05:39:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86Cdq4r295307;
        Thu, 6 Sep 2018 05:39:52 -0700
Date:   Thu, 6 Sep 2018 05:39:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Juergen Gross <tipbot@zytor.com>
Message-ID: <tip-4f2d7af70256b258a6a5729a1d33d5ecb2330f8f@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
        jgross@suse.com, tglx@linutronix.de
Reply-To: jgross@suse.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com
In-Reply-To: <20180905053634.13648-1-jgross@suse.com>
References: <20180905053634.13648-1-jgross@suse.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/paravirt] x86/xen: Make xen_reservation_lock static
Git-Commit-ID: 4f2d7af70256b258a6a5729a1d33d5ecb2330f8f
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

Commit-ID:  4f2d7af70256b258a6a5729a1d33d5ecb2330f8f
Gitweb:     https://git.kernel.org/tip/4f2d7af70256b258a6a5729a1d33d5ecb2330f8f
Author:     Juergen Gross <jgross@suse.com>
AuthorDate: Wed, 5 Sep 2018 07:36:34 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 6 Sep 2018 14:37:37 +0200

x86/xen: Make xen_reservation_lock static

No users outside of that file.

Fixes: f030aade9165 ("x86/xen: Move pv specific parts of arch/x86/xen/mmu.c to mmu_pv.c")
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: xen-devel@lists.xenproject.org
Cc: boris.ostrovsky@oracle.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/20180905053634.13648-1-jgross@suse.com

---
 arch/x86/xen/mmu_pv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index bf30fa03582e..7ada9e489f65 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -104,7 +104,7 @@ static pud_t level3_user_vsyscall[PTRS_PER_PUD] __page_aligned_bss;
  * Protects atomic reservation decrease/increase against concurrent increases.
  * Also protects non-atomic updates of current_pages and balloon lists.
  */
-DEFINE_SPINLOCK(xen_reservation_lock);
+static DEFINE_SPINLOCK(xen_reservation_lock);
 
 /*
  * Note about cr3 (pagetable base) values:
