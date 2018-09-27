Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025DFC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC2C121566
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:04:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2C121566
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbeI0XXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:23:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52321 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728381AbeI0XXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:23:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8RH4O4T101729
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Sep 2018 10:04:24 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8RH4OPk101724;
        Thu, 27 Sep 2018 10:04:24 -0700
Date:   Thu, 27 Sep 2018 10:04:24 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Pu Wen <tipbot@zytor.com>
Message-ID: <tip-b7a5cb4f220e78490735b2b984ad29b7d8e612a9@git.kernel.org>
Cc:     hpa@zytor.com, puwen@hygon.cn, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@suse.de, mingo@kernel.org
Reply-To: hpa@zytor.com, puwen@hygon.cn, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, bp@suse.de, mingo@kernel.org
In-Reply-To: <487d8078708baedaf63eb00a82251e228b58f1c2.1537885177.git.puwen@hygon.cn>
References: <487d8078708baedaf63eb00a82251e228b58f1c2.1537885177.git.puwen@hygon.cn>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/amd_nb: Check vendor in AMD-only functions
Git-Commit-ID: b7a5cb4f220e78490735b2b984ad29b7d8e612a9
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

Commit-ID:  b7a5cb4f220e78490735b2b984ad29b7d8e612a9
Gitweb:     https://git.kernel.org/tip/b7a5cb4f220e78490735b2b984ad29b7d8e612a9
Author:     Pu Wen <puwen@hygon.cn>
AuthorDate: Tue, 25 Sep 2018 22:45:01 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 27 Sep 2018 18:28:58 +0200

x86/amd_nb: Check vendor in AMD-only functions

Exit early in functions which are meant to run on AMD only but which get
run on different vendor (VMs, etc).

 [ bp: rewrite commit message. ]

Signed-off-by: Pu Wen <puwen@hygon.cn>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: bhelgaas@google.com
Cc: tglx@linutronix.de
Cc: mingo@redhat.com
Cc: hpa@zytor.com
Cc: x86@kernel.org
Cc: thomas.lendacky@amd.com
Cc: helgaas@kernel.org
Link: https://lkml.kernel.org/r/487d8078708baedaf63eb00a82251e228b58f1c2.1537885177.git.puwen@hygon.cn
---
 arch/x86/include/asm/amd_nb.h | 3 +++
 arch/x86/kernel/amd_nb.c      | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index fddb6d26239f..1ae4e5791afa 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -103,6 +103,9 @@ static inline u16 amd_pci_dev_to_node_id(struct pci_dev *pdev)
 
 static inline bool amd_gart_present(void)
 {
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+		return false;
+
 	/* GART present only on Fam15h, upto model 0fh */
 	if (boot_cpu_data.x86 == 0xf || boot_cpu_data.x86 == 0x10 ||
 	    (boot_cpu_data.x86 == 0x15 && boot_cpu_data.x86_model < 0x10))
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index b481b95bd8f6..b51c6b183a35 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -264,6 +264,10 @@ bool __init early_is_amd_nb(u32 device)
 	const struct pci_device_id *id;
 	u32 vendor = device & 0xffff;
 
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
+		return false;
+
 	device >>= 16;
 	for (id = amd_nb_misc_ids; id->vendor; id++)
 		if (vendor == id->vendor && device == id->device)
