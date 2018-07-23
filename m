Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638B2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15CCE20880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15CCE20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388593AbeGWNu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:50:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51200 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388390AbeGWNsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:48:07 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3FA27C8D;
        Mon, 23 Jul 2018 12:47:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 097/107] x86/bugs: Rename SSBD_NO to SSB_NO
Date:   Mon, 23 Jul 2018 14:42:31 +0200
Message-Id: <20180723122418.368068011@linuxfoundation.org>
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

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit 240da953fcc6a9008c92fae5b1f727ee5ed167ab upstream

The "336996 Speculative Execution Side Channel Mitigations" from
May defines this as SSB_NO, hence lets sync-up.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/include/asm/msr-index.h |    2 +-
 arch/x86/kernel/cpu/common.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -58,7 +58,7 @@
 #define MSR_IA32_ARCH_CAPABILITIES	0x0000010a
 #define ARCH_CAP_RDCL_NO		(1 << 0)   /* Not susceptible to Meltdown */
 #define ARCH_CAP_IBRS_ALL		(1 << 1)   /* Enhanced IBRS support */
-#define ARCH_CAP_SSBD_NO		(1 << 4)   /*
+#define ARCH_CAP_SSB_NO			(1 << 4)   /*
 						    * Not susceptible to Speculative Store Bypass
 						    * attack, so no Speculative Store Bypass
 						    * control required.
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -881,7 +881,7 @@ static void __init cpu_set_bug_bits(stru
 		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, ia32_cap);
 
 	if (!x86_match_cpu(cpu_no_spec_store_bypass) &&
-	   !(ia32_cap & ARCH_CAP_SSBD_NO))
+	   !(ia32_cap & ARCH_CAP_SSB_NO))
 		setup_force_cpu_bug(X86_BUG_SPEC_STORE_BYPASS);
 
 	if (x86_match_cpu(cpu_no_speculation))


