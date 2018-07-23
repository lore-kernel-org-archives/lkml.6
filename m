Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4DDECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 219EB20685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:45:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 219EB20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388298AbeGWNqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:46:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50464 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388007AbeGWNqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:46:44 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 40CE2A95;
        Mon, 23 Jul 2018 12:43:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        gnomes@lxorguk.ukuu.org.uk, ak@linux.intel.com,
        ashok.raj@intel.com, dave.hansen@intel.com, karahmed@amazon.de,
        arjan@linux.intel.com, torvalds@linux-foundation.org,
        peterz@infradead.org, bp@alien8.de, pbonzini@redhat.com,
        tim.c.chen@linux.intel.com,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>, gregkh@linux-foundation.org
Subject: [PATCH 4.4 021/107] x86/cpufeatures: Add AMD feature bits for Speculation Control
Date:   Mon, 23 Jul 2018 14:41:15 +0200
Message-Id: <20180723122413.940808822@linuxfoundation.org>
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

From: David Woodhouse <dwmw@amazon.co.uk>

(cherry picked from commit 5d10cbc91d9eb5537998b65608441b592eec65e7)

AMD exposes the PRED_CMD/SPEC_CTRL MSRs slightly differently to Intel.
See http://lkml.kernel.org/r/2b3e25cc-286d-8bd0-aeaf-9ac4aae39de8@amd.com

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: ak@linux.intel.com
Cc: ashok.raj@intel.com
Cc: dave.hansen@intel.com
Cc: karahmed@amazon.de
Cc: arjan@linux.intel.com
Cc: torvalds@linux-foundation.org
Cc: peterz@infradead.org
Cc: bp@alien8.de
Cc: pbonzini@redhat.com
Cc: tim.c.chen@linux.intel.com
Cc: gregkh@linux-foundation.org
Link: https://lkml.kernel.org/r/1516896855-7642-4-git-send-email-dwmw@amazon.co.uk
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/include/asm/cpufeatures.h |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -251,6 +251,9 @@
 
 /* AMD-defined CPU features, CPUID level 0x80000008 (ebx), word 13 */
 #define X86_FEATURE_CLZERO	(13*32+0) /* CLZERO instruction */
+#define X86_FEATURE_AMD_PRED_CMD (13*32+12) /* Prediction Command MSR (AMD) */
+#define X86_FEATURE_AMD_SPEC_CTRL (13*32+14) /* Speculation Control MSR only (AMD) */
+#define X86_FEATURE_AMD_STIBP	(13*32+15) /* Single Thread Indirect Branch Predictors (AMD) */
 
 /* Thermal and Power Management Leaf, CPUID level 0x00000006 (eax), word 14 */
 #define X86_FEATURE_DTHERM	(14*32+ 0) /* Digital Thermal Sensor */


