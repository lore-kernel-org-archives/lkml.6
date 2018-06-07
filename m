Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 0po1Id9AGVtRZgAAmS7hNA
	; Thu, 07 Jun 2018 14:29:48 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6B2C56063F; Thu,  7 Jun 2018 14:29:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7E8D3608CD;
	Thu,  7 Jun 2018 14:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7E8D3608CD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933744AbeFGO3i (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:29:38 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40223 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933706AbeFGO32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:29:28 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbz-0005Zl-UA; Thu, 07 Jun 2018 15:10:00 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvay-0002ja-NL; Thu, 07 Jun 2018 15:08:56 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, dave.hansen@intel.com,
        gregkh@linux-foundation.org, ak@linux.intel.com,
        gnomes@lxorguk.ukuu.org.uk, arjan@linux.intel.com,
        torvalds@linux-foundation.org,
        "Thomas Gleixner" <tglx@linutronix.de>, karahmed@amazon.de,
        tim.c.chen@linux.intel.com, pbonzini@redhat.com,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, bp@alien8.de,
        "David Woodhouse" <dwmw@amazon.co.uk>, ashok.raj@intel.com,
        peterz@infradead.org
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.589453943@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 043/410] x86/msr: Add definitions for new speculation
 control MSRs
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

commit 1e340c60d0dd3ae07b5bedc16a0469c14b9f3410 upstream.

Add MSR and bit definitions for SPEC_CTRL, PRED_CMD and ARCH_CAPABILITIES.

See Intel's 336996-Speculative-Execution-Side-Channel-Mitigations.pdf

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Link: https://lkml.kernel.org/r/1516896855-7642-5-git-send-email-dwmw@amazon.co.uk
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/uapi/asm/msr-index.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/arch/x86/include/uapi/asm/msr-index.h
+++ b/arch/x86/include/uapi/asm/msr-index.h
@@ -32,6 +32,13 @@
 #define EFER_FFXSR		(1<<_EFER_FFXSR)
 
 /* Intel MSRs. Some also available on other CPUs */
+#define MSR_IA32_SPEC_CTRL		0x00000048 /* Speculation Control */
+#define SPEC_CTRL_IBRS			(1 << 0)   /* Indirect Branch Restricted Speculation */
+#define SPEC_CTRL_STIBP			(1 << 1)   /* Single Thread Indirect Branch Predictors */
+
+#define MSR_IA32_PRED_CMD		0x00000049 /* Prediction Command */
+#define PRED_CMD_IBPB			(1 << 0)   /* Indirect Branch Prediction Barrier */
+
 #define MSR_IA32_PERFCTR0		0x000000c1
 #define MSR_IA32_PERFCTR1		0x000000c2
 #define MSR_FSB_FREQ			0x000000cd
@@ -46,6 +53,11 @@
 
 #define MSR_PLATFORM_INFO		0x000000ce
 #define MSR_MTRRcap			0x000000fe
+
+#define MSR_IA32_ARCH_CAPABILITIES	0x0000010a
+#define ARCH_CAP_RDCL_NO		(1 << 0)   /* Not susceptible to Meltdown */
+#define ARCH_CAP_IBRS_ALL		(1 << 1)   /* Enhanced IBRS support */
+
 #define MSR_IA32_BBL_CR_CTL		0x00000119
 #define MSR_IA32_BBL_CR_CTL3		0x0000011e
 
