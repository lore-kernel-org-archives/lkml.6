Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97347C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E7B21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:04:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E7B21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbeJIWVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:21:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53571 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJIWVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:21:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w99F3iK91081989
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 9 Oct 2018 08:03:44 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w99F3ivn1081986;
        Tue, 9 Oct 2018 08:03:44 -0700
Date:   Tue, 9 Oct 2018 08:03:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-5b0c2cac54d44ea40d5c5aec7cbf14353b2a903e@git.kernel.org>
Cc:     jannh@google.com, sean.j.christopherson@intel.com, hpa@zytor.com,
        luto@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org
Reply-To: jannh@google.com, hpa@zytor.com, sean.j.christopherson@intel.com,
          luto@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          peterz@infradead.org
In-Reply-To: <20180928160225.FFD44B8D@viggo.jf.intel.com>
References: <20180928160225.FFD44B8D@viggo.jf.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm: Add clarifying comments for user addr space
Git-Commit-ID: 5b0c2cac54d44ea40d5c5aec7cbf14353b2a903e
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

Commit-ID:  5b0c2cac54d44ea40d5c5aec7cbf14353b2a903e
Gitweb:     https://git.kernel.org/tip/5b0c2cac54d44ea40d5c5aec7cbf14353b2a903e
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Fri, 28 Sep 2018 09:02:25 -0700
Committer:  Peter Zijlstra <peterz@infradead.org>
CommitDate: Tue, 9 Oct 2018 16:51:16 +0200

x86/mm: Add clarifying comments for user addr space

The SMAP and Reserved checking do not have nice comments.  Add
some to clarify and make it match everything else.

Cc: x86@kernel.org
Cc: Jann Horn <jannh@google.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180928160225.FFD44B8D@viggo.jf.intel.com
---
 arch/x86/mm/fault.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 0d1f5d39fc63..1d838701a5f7 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1276,9 +1276,17 @@ void do_user_addr_fault(struct pt_regs *regs,
 	if (unlikely(kprobes_fault(regs)))
 		return;
 
+	/*
+	 * Reserved bits are never expected to be set on
+	 * entries in the user portion of the page tables.
+	 */
 	if (unlikely(hw_error_code & X86_PF_RSVD))
 		pgtable_bad(regs, hw_error_code, address);
 
+	/*
+	 * Check for invalid kernel (supervisor) access to user
+	 * pages in the user address space.
+	 */
 	if (unlikely(smap_violation(hw_error_code, regs))) {
 		bad_area_nosemaphore(regs, hw_error_code, address, NULL);
 		return;
