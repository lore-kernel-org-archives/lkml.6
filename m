Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1D0C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 12:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B90020C0A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 12:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B90020C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbeJITot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 15:44:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55425 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJITot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 15:44:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w99CRpNf1035250
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 9 Oct 2018 05:27:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w99CRp0Z1035247;
        Tue, 9 Oct 2018 05:27:51 -0700
Date:   Tue, 9 Oct 2018 05:27:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yi Sun <tipbot@zytor.com>
Message-ID: <tip-f726c4620df39055f060537a8ed183c18a2c504b@git.kernel.org>
Cc:     kys@microsoft.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, yi.y.sun@linux.intel.com,
        haiyangz@microsoft.com, mingo@kernel.org, mikelley@microsoft.com,
        sthemmin@microsoft.com, hpa@zytor.com
Reply-To: mingo@kernel.org, mikelley@microsoft.com, sthemmin@microsoft.com,
          hpa@zytor.com, tglx@linutronix.de, kys@microsoft.com,
          haiyangz@microsoft.com, yi.y.sun@linux.intel.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <1538028104-114050-2-git-send-email-yi.y.sun@linux.intel.com>
References: <1538028104-114050-2-git-send-email-yi.y.sun@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/paravirt] x86/hyperv: Add GUEST_IDLE_MSR support
Git-Commit-ID: f726c4620df39055f060537a8ed183c18a2c504b
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

Commit-ID:  f726c4620df39055f060537a8ed183c18a2c504b
Gitweb:     https://git.kernel.org/tip/f726c4620df39055f060537a8ed183c18a2c504b
Author:     Yi Sun <yi.y.sun@linux.intel.com>
AuthorDate: Thu, 27 Sep 2018 14:01:43 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 9 Oct 2018 14:14:49 +0200

x86/hyperv: Add GUEST_IDLE_MSR support

Hyper-V may expose a HV_X64_MSR_GUEST_IDLE MSR via HYPERV_CPUID_FEATURES.

Reading this MSR triggers the host to transition the guest vCPU into an
idle state. This state can be exited via an IPI even if the read in the
guest happened from an interrupt disabled section.

Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Cc: chao.p.peng@intel.com
Cc: chao.gao@intel.com
Cc: isaku.yamahata@intel.com
Cc: tianyu.lan@microsoft.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Link: https://lkml.kernel.org/r/1538028104-114050-2-git-send-email-yi.y.sun@linux.intel.com

---
 arch/x86/include/asm/hyperv-tlfs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index e977b6b3a538..2a2fa170caf1 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -38,6 +38,8 @@
 #define HV_MSR_TIME_REF_COUNT_AVAILABLE		(1 << 1)
 /* Partition reference TSC MSR is available */
 #define HV_MSR_REFERENCE_TSC_AVAILABLE		(1 << 9)
+/* Partition Guest IDLE MSR is available */
+#define HV_X64_MSR_GUEST_IDLE_AVAILABLE		(1 << 10)
 
 /* A partition's reference time stamp counter (TSC) page */
 #define HV_X64_MSR_REFERENCE_TSC		0x40000021
@@ -246,6 +248,9 @@
 #define HV_X64_MSR_STIMER3_CONFIG		0x400000B6
 #define HV_X64_MSR_STIMER3_COUNT		0x400000B7
 
+/* Hyper-V guest idle MSR */
+#define HV_X64_MSR_GUEST_IDLE			0x400000F0
+
 /* Hyper-V guest crash notification MSR's */
 #define HV_X64_MSR_CRASH_P0			0x40000100
 #define HV_X64_MSR_CRASH_P1			0x40000101
