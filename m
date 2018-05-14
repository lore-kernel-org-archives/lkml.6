Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752477AbeENHpD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 03:45:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58035 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752104AbeENHpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 03:45:00 -0400
Date: Mon, 14 May 2018 00:44:37 -0700
From: tip-bot for Yazen Ghannam <tipbot@zytor.com>
Message-ID: <tip-742632d237ce180439ab4af31e9891df0df81233@git.kernel.org>
Cc: ard.biesheuvel@linaro.org, yazen.ghannam@amd.com,
        torvalds@linux-foundation.org, matt@codeblueprint.co.uk,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, peterz@infradead.org,
        hpa@zytor.com, mingo@kernel.org
Reply-To: hpa@zytor.com, mingo@kernel.org, matt@codeblueprint.co.uk,
        ard.biesheuvel@linaro.org, yazen.ghannam@amd.com,
        torvalds@linux-foundation.org, peterz@infradead.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <20180504060003.19618-4-ard.biesheuvel@linaro.org>
References: <20180504060003.19618-4-ard.biesheuvel@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi: Fix IA32/X64 Processor Error Record definition
Git-Commit-ID: 742632d237ce180439ab4af31e9891df0df81233
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  742632d237ce180439ab4af31e9891df0df81233
Gitweb:     https://git.kernel.org/tip/742632d237ce180439ab4af31e9891df0df81233
Author:     Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate: Fri, 4 May 2018 07:59:49 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 08:57:47 +0200

efi: Fix IA32/X64 Processor Error Record definition

Based on UEFI 2.7 Table 255. Processor Error Record, the "Local APIC_ID"
field is 8 bytes but Linux defines this field as 1 byte.

Fix this in the struct cper_sec_proc_ia definition.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180504060003.19618-4-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/cper.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cper.h b/include/linux/cper.h
index d14ef4e77c8a..4b5f8459b403 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -381,7 +381,7 @@ struct cper_sec_proc_generic {
 /* IA32/X64 Processor Error Section */
 struct cper_sec_proc_ia {
 	__u64	validation_bits;
-	__u8	lapic_id;
+	__u64	lapic_id;
 	__u8	cpuid[48];
 };
 
