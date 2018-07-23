Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088C1ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A984220685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:46:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A984220685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388810AbeGWNrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:47:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50670 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388007AbeGWNrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:47:06 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B03A5C83;
        Mon, 23 Jul 2018 12:44:00 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joe Konno <joe.konno@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, arjan@linux.intel.com,
        bp@alien8.de, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, dwmw2@infradead.org,
        dwmw@amazon.co.uk, hpa@zytor.com, jpoimboe@redhat.com,
        linux-tip-commits@vger.kernel.org, luto@kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 035/107] x86/speculation: Add <asm/msr-index.h> dependency
Date:   Mon, 23 Jul 2018 14:41:29 +0200
Message-Id: <20180723122414.631160685@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122413.003644357@linuxfoundation.org>
References: <20180723122413.003644357@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit ea00f301285ea2f07393678cd2b6057878320c9d upstream.

Joe Konno reported a compile failure resulting from using an MSR
without inclusion of <asm/msr-index.h>, and while the current code builds
fine (by accident) this needs fixing for future patches.

Reported-by: Joe Konno <joe.konno@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: arjan@linux.intel.com
Cc: bp@alien8.de
Cc: dan.j.williams@intel.com
Cc: dave.hansen@linux.intel.com
Cc: dwmw2@infradead.org
Cc: dwmw@amazon.co.uk
Cc: gregkh@linuxfoundation.org
Cc: hpa@zytor.com
Cc: jpoimboe@redhat.com
Cc: linux-tip-commits@vger.kernel.org
Cc: luto@kernel.org
Fixes: 20ffa1caecca ("x86/speculation: Add basic IBPB (Indirect Branch Prediction Barrier) support")
Link: http://lkml.kernel.org/r/20180213132819.GJ25201@hirez.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/include/asm/nospec-branch.h |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -6,6 +6,7 @@
 #include <asm/alternative.h>
 #include <asm/alternative-asm.h>
 #include <asm/cpufeatures.h>
+#include <asm/msr-index.h>
 
 /*
  * Fill the CPU return stack buffer.


