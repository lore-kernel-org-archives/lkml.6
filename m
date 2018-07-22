Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9769EC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 15:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7B920874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 15:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B7B920874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbeGVQQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 12:16:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48611 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729555AbeGVQQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 12:16:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6MFJ4XM3458027
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 22 Jul 2018 08:19:04 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6MFJ2jg3458024;
        Sun, 22 Jul 2018 08:19:02 -0700
Date:   Sun, 22 Jul 2018 08:19:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Brijesh Singh <tipbot@zytor.com>
Message-ID: <tip-9b788f32bee6b0b293a4bdfca4ad4bb0206407fb@git.kernel.org>
Cc:     tglx@linutronix.de, brijesh.singh@amd.com,
        ard.biesheuvel@linaro.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
        hpa@zytor.com, torvalds@linux-foundation.org, peterz@infradead.org
Reply-To: ard.biesheuvel@linaro.org, tglx@linutronix.de,
          brijesh.singh@amd.com, torvalds@linux-foundation.org,
          peterz@infradead.org, thomas.lendacky@amd.com, hpa@zytor.com,
          mingo@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20180720012846.23560-2-ard.biesheuvel@linaro.org>
References: <20180720012846.23560-2-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/urgent] x86/efi: Access EFI MMIO data as unencrypted when
 SEV is active
Git-Commit-ID: 9b788f32bee6b0b293a4bdfca4ad4bb0206407fb
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

Commit-ID:  9b788f32bee6b0b293a4bdfca4ad4bb0206407fb
Gitweb:     https://git.kernel.org/tip/9b788f32bee6b0b293a4bdfca4ad4bb0206407fb
Author:     Brijesh Singh <brijesh.singh@amd.com>
AuthorDate: Fri, 20 Jul 2018 10:28:46 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 22 Jul 2018 14:10:38 +0200

x86/efi: Access EFI MMIO data as unencrypted when SEV is active

SEV guest fails to update the UEFI runtime variables stored in the
flash.

The following commit:

  1379edd59673 ("x86/efi: Access EFI data as encrypted when SEV is active")

unconditionally maps all the UEFI runtime data as 'encrypted' (C=1).

When SEV is active the UEFI runtime data marked as EFI_MEMORY_MAPPED_IO
should be mapped as 'unencrypted' so that both guest and hypervisor can
access the data.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: <stable@vger.kernel.org> # 4.15.x
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Fixes: 1379edd59673 ("x86/efi: Access EFI data as encrypted ...")
Link: http://lkml.kernel.org/r/20180720012846.23560-2-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/platform/efi/efi_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 77873ce700ae..5f2eb3231607 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -417,7 +417,7 @@ static void __init __map_region(efi_memory_desc_t *md, u64 va)
 	if (!(md->attribute & EFI_MEMORY_WB))
 		flags |= _PAGE_PCD;
 
-	if (sev_active())
+	if (sev_active() && md->type != EFI_MEMORY_MAPPED_IO)
 		flags |= _PAGE_ENC;
 
 	pfn = md->phys_addr >> PAGE_SHIFT;
