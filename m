Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBA3C64EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC34A206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC34A206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbeJCCTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:19:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55151 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbeJCCTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 22:19:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w92JXquf2076605
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 Oct 2018 12:33:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w92JXqY02076602;
        Tue, 2 Oct 2018 12:33:52 -0700
Date:   Tue, 2 Oct 2018 12:33:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mike Travis <tipbot@zytor.com>
Message-ID: <tip-20a8378aa9dd108a01cb0e695599f5257a885c4b@git.kernel.org>
Cc:     rajvi.jingar@intel.com, peterz@infradead.org, mingo@kernel.org,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, rja@hpe.com, hedi.berriche@hpe.com,
        bp@alien8.de, sivanich@hpe.com, russ.anderson@hpe.com,
        pasha.tatashin@oracle.com, gxm.linux.kernel@gmail.com,
        hpa@zytor.com, mike.travis@hpe.com, douly.fnst@cn.fujitsu.com,
        tglx@linutronix.de, len.brown@intel.com,
        linux-kernel@vger.kernel.org, dimitri.sivanich@hpe.com
Reply-To: gregkh@linuxfoundation.org, kstewart@linuxfoundation.org,
          pombredanne@nexb.com, sivanich@hpe.com, bp@alien8.de,
          hedi.berriche@hpe.com, rja@hpe.com, rajvi.jingar@intel.com,
          peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de,
          len.brown@intel.com, dimitri.sivanich@hpe.com,
          linux-kernel@vger.kernel.org, russ.anderson@hpe.com,
          gxm.linux.kernel@gmail.com, pasha.tatashin@oracle.com,
          hpa@zytor.com, douly.fnst@cn.fujitsu.com, mike.travis@hpe.com
In-Reply-To: <20181002180144.801700401@stormcage.americas.sgi.com>
References: <20181002180144.801700401@stormcage.americas.sgi.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/platform/uv: Provide is_early_uv_system()
Git-Commit-ID: 20a8378aa9dd108a01cb0e695599f5257a885c4b
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

Commit-ID:  20a8378aa9dd108a01cb0e695599f5257a885c4b
Gitweb:     https://git.kernel.org/tip/20a8378aa9dd108a01cb0e695599f5257a885c4b
Author:     Mike Travis <mike.travis@hpe.com>
AuthorDate: Tue, 2 Oct 2018 13:01:45 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 2 Oct 2018 21:29:16 +0200

x86/platform/uv: Provide is_early_uv_system()

Introduce is_early_uv_system() which uses efi.uv_systab to decide early
in the boot process whether the kernel runs on a UV system.

This is needed to skip other early setup/init code that might break
the UV platform if done too early such as before necessary ACPI tables
parsing takes place.

Suggested-by: Hedi Berriche <hedi.berriche@hpe.com>
Signed-off-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Russ Anderson <rja@hpe.com>
Reviewed-by: Dimitri Sivanich <sivanich@hpe.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Russ Anderson <russ.anderson@hpe.com>
Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Xiaoming Gao <gxm.linux.kernel@gmail.com>
Cc: Rajvi Jingar <rajvi.jingar@intel.com>
Link: https://lkml.kernel.org/r/20181002180144.801700401@stormcage.americas.sgi.com

---
 arch/x86/include/asm/uv/uv.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/uv/uv.h b/arch/x86/include/asm/uv/uv.h
index a80c0673798f..e60c45fd3679 100644
--- a/arch/x86/include/asm/uv/uv.h
+++ b/arch/x86/include/asm/uv/uv.h
@@ -10,8 +10,13 @@ struct cpumask;
 struct mm_struct;
 
 #ifdef CONFIG_X86_UV
+#include <linux/efi.h>
 
 extern enum uv_system_type get_uv_system_type(void);
+static inline bool is_early_uv_system(void)
+{
+	return !((efi.uv_systab == EFI_INVALID_TABLE_ADDR) || !efi.uv_systab);
+}
 extern int is_uv_system(void);
 extern int is_uv_hubless(void);
 extern void uv_cpu_init(void);
@@ -23,6 +28,7 @@ extern const struct cpumask *uv_flush_tlb_others(const struct cpumask *cpumask,
 #else	/* X86_UV */
 
 static inline enum uv_system_type get_uv_system_type(void) { return UV_NONE; }
+static inline bool is_early_uv_system(void)	{ return 0; }
 static inline int is_uv_system(void)	{ return 0; }
 static inline int is_uv_hubless(void)	{ return 0; }
 static inline void uv_cpu_init(void)	{ }
