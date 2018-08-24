Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EDDC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B3021581
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B3021581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbeHXLaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 07:30:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56965 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbeHXLaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 07:30:11 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7O7tX5h3564735
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 24 Aug 2018 00:55:33 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7O7tWex3564727;
        Fri, 24 Aug 2018 00:55:32 -0700
Date:   Fri, 24 Aug 2018 00:55:32 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vlastimil Babka <tipbot@zytor.com>
Message-ID: <tip-4b81eae3d37dee69231592182e1e34706f149a6e@git.kernel.org>
Cc:     tglx@linutronix.de, dave.hansen@intel.com, mingo@kernel.org,
        ak@linux.intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mhocko@suse.com, vbabka@suse.cz, torvalds@linux-foundation.org
Reply-To: linux-kernel@vger.kernel.org, mhocko@suse.com,
          torvalds@linux-foundation.org, vbabka@suse.cz, hpa@zytor.com,
          ak@linux.intel.com, mingo@kernel.org, dave.hansen@intel.com,
          tglx@linutronix.de
In-Reply-To: <966571f0-9d7f-43dc-92c6-a10eec7a1254@suse.cz>
References: <966571f0-9d7f-43dc-92c6-a10eec7a1254@suse.cz>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/speculation/l1tf: Suggest what to do on
 systems with too much RAM
Git-Commit-ID: 4b81eae3d37dee69231592182e1e34706f149a6e
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

Commit-ID:  4b81eae3d37dee69231592182e1e34706f149a6e
Gitweb:     https://git.kernel.org/tip/4b81eae3d37dee69231592182e1e34706f149a6e
Author:     Vlastimil Babka <vbabka@suse.cz>
AuthorDate: Thu, 23 Aug 2018 16:21:29 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 24 Aug 2018 09:51:14 +0200

x86/speculation/l1tf: Suggest what to do on systems with too much RAM

Two users have reported [1] that they have an "extremely unlikely" system
with more than MAX_PA/2 memory and L1TF mitigation is not effective.

Make the warning more helpful by suggesting the proper mem=X kernel boot
parameter to make it effective and a link to the L1TF document to help
decide if the mitigation is worth the unusable RAM.

[1] https://bugzilla.suse.com/show_bug.cgi?id=1105536

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/966571f0-9d7f-43dc-92c6-a10eec7a1254@suse.cz
---
 arch/x86/kernel/cpu/bugs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index cb4a16292aa7..5c32b5006738 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -702,6 +702,10 @@ static void __init l1tf_select_mitigation(void)
 	half_pa = (u64)l1tf_pfn_limit() << PAGE_SHIFT;
 	if (e820__mapped_any(half_pa, ULLONG_MAX - half_pa, E820_TYPE_RAM)) {
 		pr_warn("System has more than MAX_PA/2 memory. L1TF mitigation not effective.\n");
+		pr_info("You may make it effective by booting the kernel with mem=%llu parameter.\n",
+				half_pa);
+		pr_info("However, doing so will make a part of your RAM unusable.\n");
+		pr_info("Reading Documentation/admin-guide/l1tf.rst might help you decide.\n");
 		return;
 	}
 
