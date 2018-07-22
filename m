Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082ECECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 15:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B359E20874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 15:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B359E20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbeGVQSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 12:18:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36645 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728599AbeGVQSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 12:18:08 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6MFKbhb3458161
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 22 Jul 2018 08:20:37 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6MFKbBe3458158;
        Sun, 22 Jul 2018 08:20:37 -0700
Date:   Sun, 22 Jul 2018 08:20:37 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-0b767b16d7b634dd62667f224425cef3c78e031c@git.kernel.org>
Cc:     mingo@kernel.org, lukas@wunner.de, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        andriy.shevchenko@linux.intel.com, hpa@zytor.com,
        peterz@infradead.org, ard.biesheuvel@linaro.org,
        torvalds@linux-foundation.org
Reply-To: lukas@wunner.de, mingo@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, hdegoede@redhat.com, hpa@zytor.com,
          peterz@infradead.org, andriy.shevchenko@linux.intel.com,
          ard.biesheuvel@linaro.org, torvalds@linux-foundation.org
In-Reply-To: <20180720014726.24031-4-ard.biesheuvel@linaro.org>
References: <20180720014726.24031-4-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi/x86: Align efi_uga_draw_protocol typedef names
 to convention
Git-Commit-ID: 0b767b16d7b634dd62667f224425cef3c78e031c
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

Commit-ID:  0b767b16d7b634dd62667f224425cef3c78e031c
Gitweb:     https://git.kernel.org/tip/0b767b16d7b634dd62667f224425cef3c78e031c
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Fri, 20 Jul 2018 10:47:20 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 22 Jul 2018 14:13:42 +0200

efi/x86: Align efi_uga_draw_protocol typedef names to convention

The linux-efi subsystem uses typedefs with the _t suffix to declare
data structures that originate in the UEFI spec. Our type mangling
for mixed mode depends on this convention, so rename the UGA drawing
protocols to allow efi_call_proto() to be used with them in a
subsequent patch.

Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180720014726.24031-4-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/boot/compressed/eboot.c |  4 ++--
 arch/x86/boot/compressed/eboot.h | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index c72550783c16..011d5c289449 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -321,7 +321,7 @@ static void setup_quirks(struct boot_params *boot_params)
 static efi_status_t
 setup_uga32(void **uga_handle, unsigned long size, u32 *width, u32 *height)
 {
-	struct efi_uga_draw_protocol *uga = NULL, *first_uga;
+	efi_uga_draw_protocol_t *uga = NULL, *first_uga;
 	efi_guid_t uga_proto = EFI_UGA_PROTOCOL_GUID;
 	unsigned long nr_ugas;
 	u32 *handles = (u32 *)uga_handle;
@@ -366,7 +366,7 @@ setup_uga32(void **uga_handle, unsigned long size, u32 *width, u32 *height)
 static efi_status_t
 setup_uga64(void **uga_handle, unsigned long size, u32 *width, u32 *height)
 {
-	struct efi_uga_draw_protocol *uga = NULL, *first_uga;
+	efi_uga_draw_protocol_t *uga = NULL, *first_uga;
 	efi_guid_t uga_proto = EFI_UGA_PROTOCOL_GUID;
 	unsigned long nr_ugas;
 	u64 *handles = (u64 *)uga_handle;
diff --git a/arch/x86/boot/compressed/eboot.h b/arch/x86/boot/compressed/eboot.h
index e799dc5c6448..8297387c4676 100644
--- a/arch/x86/boot/compressed/eboot.h
+++ b/arch/x86/boot/compressed/eboot.h
@@ -12,22 +12,22 @@
 
 #define DESC_TYPE_CODE_DATA	(1 << 0)
 
-struct efi_uga_draw_protocol_32 {
+typedef struct {
 	u32 get_mode;
 	u32 set_mode;
 	u32 blt;
-};
+} efi_uga_draw_protocol_32_t;
 
-struct efi_uga_draw_protocol_64 {
+typedef struct {
 	u64 get_mode;
 	u64 set_mode;
 	u64 blt;
-};
+} efi_uga_draw_protocol_64_t;
 
-struct efi_uga_draw_protocol {
+typedef struct {
 	void *get_mode;
 	void *set_mode;
 	void *blt;
-};
+} efi_uga_draw_protocol_t;
 
 #endif /* BOOT_COMPRESSED_EBOOT_H */
