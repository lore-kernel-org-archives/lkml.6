Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BC2ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 907D62064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 907D62064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbeJSWUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 18:20:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:54908 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727473AbeJSWUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 18:20:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2018 07:13:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,400,1534834800"; 
   d="scan'208";a="83941619"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga006.jf.intel.com with ESMTP; 19 Oct 2018 07:13:47 -0700
Subject: [PATCH] x86/mm: kill stray kernel fault handling comment
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, ebiederm@xmission.com,
        x86@kernel.org, jannh@google.com, sean.j.christopherson@intel.com,
        tglx@linutronix.de, luto@kernel.org, mingo@kernel.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Fri, 19 Oct 2018 07:08:42 -0700
Message-Id: <20181019140842.12F929FA@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I originally tried to send this a couple days ago, but does not
appear to have made it to LKML.  Sorry if it's a duplicate.

--

From: Dave Hansen <dave.hansen@linux.intel.com>

I originally had matching user and kernel comments, but the kernel
one got improved.  Some errant conflict resolution kicked the commment
somewhere wrong.  Kill it.

Fixes: aa37c51b94 ("x86/mm: Break out user address space handling")
Reported-by: Eric W. Biederman <ebiederm@xmission.com>
Cc: x86@kernel.org
Cc: Jann Horn <jannh@google.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/mm/fault.c |    1 -
 1 file changed, 1 deletion(-)

diff -puN arch/x86/mm/fault.c~x86-mm-kill-stray-kernel-fault-handling-comment arch/x86/mm/fault.c
--- a/arch/x86/mm/fault.c~x86-mm-kill-stray-kernel-fault-handling-comment	2018-10-19 07:06:22.954631596 -0700
+++ b/arch/x86/mm/fault.c	2018-10-19 07:06:22.959631596 -0700
@@ -963,7 +963,6 @@ bad_area_access_error(struct pt_regs *re
 		__bad_area(regs, error_code, address, vma, SEGV_ACCERR);
 }
 
-/* Handle faults in the kernel portion of the address space */
 static void
 do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 	  u32 *pkey, unsigned int fault)
_
