Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F4EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327F52177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387561AbfAKPQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:16:27 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53515 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731231AbfAKPQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:16:26 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0BFFxcC704922
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 11 Jan 2019 07:15:59 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0BFFxlx704919;
        Fri, 11 Jan 2019 07:15:59 -0800
Date:   Fri, 11 Jan 2019 07:15:59 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Lianbo Jiang <tipbot@zytor.com>
Message-ID: <tip-65f750e5457aef9a8085a99d613fea0430303e93@git.kernel.org>
Cc:     dyoung@redhat.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        hpa@zytor.com, tglx@linutronix.de, thomas.lendacky@amd.com,
        bhe@redhat.com, mingo@redhat.com, bp@suse.de, x86@kernel.org,
        akpm@linux-foundation.org, lijiang@redhat.com
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
          dyoung@redhat.com, thomas.lendacky@amd.com, bhe@redhat.com,
          hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com,
          akpm@linux-foundation.org, lijiang@redhat.com, bp@suse.de,
          x86@kernel.org
In-Reply-To: <20190110121944.6050-3-lijiang@redhat.com>
References: <20190110121944.6050-3-lijiang@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/kdump] x86/kdump: Export the SME mask to vmcoreinfo
Git-Commit-ID: 65f750e5457aef9a8085a99d613fea0430303e93
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

Commit-ID:  65f750e5457aef9a8085a99d613fea0430303e93
Gitweb:     https://git.kernel.org/tip/65f750e5457aef9a8085a99d613fea0430303e93
Author:     Lianbo Jiang <lijiang@redhat.com>
AuthorDate: Thu, 10 Jan 2019 20:19:44 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Fri, 11 Jan 2019 16:09:25 +0100

x86/kdump: Export the SME mask to vmcoreinfo

On AMD SME machines, makedumpfile tools need to know whether the crashed
kernel was encrypted.

If SME is enabled in the first kernel, the crashed kernel's page table
entries (pgd/pud/pmd/pte) contain the memory encryption mask which
makedumpfile needs to remove in order to obtain the true physical
address.

Export that mask in a vmcoreinfo variable.

 [ bp: Massage commit message and move define at the end of the
   function. ]

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: anderson@redhat.com
Cc: k-hagio@ab.jp.nec.com
Cc: kexec@lists.infradead.org
Cc: linux-doc@vger.kernel.org
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190110121944.6050-3-lijiang@redhat.com
---
 arch/x86/kernel/machine_kexec_64.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 4c8acdfdc5a7..ceba408ea982 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -352,6 +352,8 @@ void machine_kexec(struct kimage *image)
 
 void arch_crash_save_vmcoreinfo(void)
 {
+	u64 sme_mask = sme_me_mask;
+
 	VMCOREINFO_NUMBER(phys_base);
 	VMCOREINFO_SYMBOL(init_top_pgt);
 	vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
@@ -364,6 +366,7 @@ void arch_crash_save_vmcoreinfo(void)
 	vmcoreinfo_append_str("KERNELOFFSET=%lx\n",
 			      kaslr_offset());
 	VMCOREINFO_NUMBER(KERNEL_IMAGE_SIZE);
+	VMCOREINFO_NUMBER(sme_mask);
 }
 
 /* arch-dependent functionality related to kexec file-based syscall */
