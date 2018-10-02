Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B36C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6548D20652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6548D20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbeJBSKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:10:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46667 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbeJBSKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:10:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w92BRqnq1937362
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 Oct 2018 04:27:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w92BRpKo1937359;
        Tue, 2 Oct 2018 04:27:51 -0700
Date:   Tue, 2 Oct 2018 04:27:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yi Sun <tipbot@zytor.com>
Message-ID: <tip-10d02e13385ce1e90abb49ef1e9a366a5d968157@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        sthemmin@microsoft.com, haiyangz@microsoft.com,
        mikelley@microsoft.com, yi.y.sun@linux.intel.com,
        kys@microsoft.com, tglx@linutronix.de
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org,
          sthemmin@microsoft.com, mingo@kernel.org, haiyangz@microsoft.com,
          mikelley@microsoft.com, kys@microsoft.com, tglx@linutronix.de,
          yi.y.sun@linux.intel.com
In-Reply-To: <1538028104-114050-2-git-send-email-yi.y.sun@linux.intel.com>
References: <1538028104-114050-2-git-send-email-yi.y.sun@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/hyperv] x86/hyperv: Add GUEST_IDLE_MSR support
Git-Commit-ID: 10d02e13385ce1e90abb49ef1e9a366a5d968157
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

Commit-ID:  10d02e13385ce1e90abb49ef1e9a366a5d968157
Gitweb:     https://git.kernel.org/tip/10d02e13385ce1e90abb49ef1e9a366a5d968157
Author:     Yi Sun <yi.y.sun@linux.intel.com>
AuthorDate: Thu, 27 Sep 2018 14:01:43 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 2 Oct 2018 13:21:52 +0200

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
index 00e01d215f74..4139f7650fe5 100644
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
