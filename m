Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C58C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF282177B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731303AbfBOPEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:04:41 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39267 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfBOPEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:04:41 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1FF4Bhk1224872
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 15 Feb 2019 07:04:11 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1FF4B1b1224620;
        Fri, 15 Feb 2019 07:04:11 -0800
Date:   Fri, 15 Feb 2019 07:04:11 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Hedi Berriche <tipbot@zytor.com>
Message-ID: <tip-30ad3e031d2feae075cd5fd2c443baa2d86c0195@git.kernel.org>
Cc:     linux-efi@vger.kernel.org, rja@hpe.com, x86@kernel.org, bp@suse.de,
        ard.biesheuvel@linaro.org, sivanich@hpe.com, mingo@kernel.org,
        mingo@redhat.com, dvhart@infradead.org, hpa@zytor.com,
        tglx@linutronix.de, bhsharma@redhat.com, mike.travis@hpe.com,
        steve.wahl@hpe.com, linux-kernel@vger.kernel.org,
        andy@infradead.org, hedi.berriche@hpe.com
Reply-To: andy@infradead.org, hedi.berriche@hpe.com, bhsharma@redhat.com,
          tglx@linutronix.de, mike.travis@hpe.com, steve.wahl@hpe.com,
          linux-kernel@vger.kernel.org, sivanich@hpe.com, mingo@kernel.org,
          dvhart@infradead.org, mingo@redhat.com, hpa@zytor.com,
          linux-efi@vger.kernel.org, rja@hpe.com, x86@kernel.org,
          bp@suse.de, ard.biesheuvel@linaro.org
In-Reply-To: <20190213193413.25560-2-hedi.berriche@hpe.com>
References: <20190213193413.25560-2-hedi.berriche@hpe.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/uv] x86/platform/UV: Remove unnecessary #ifdef CONFIG_EFI
Git-Commit-ID: 30ad3e031d2feae075cd5fd2c443baa2d86c0195
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

Commit-ID:  30ad3e031d2feae075cd5fd2c443baa2d86c0195
Gitweb:     https://git.kernel.org/tip/30ad3e031d2feae075cd5fd2c443baa2d86c0195
Author:     Hedi Berriche <hedi.berriche@hpe.com>
AuthorDate: Wed, 13 Feb 2019 19:34:10 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Fri, 15 Feb 2019 15:05:15 +0100

x86/platform/UV: Remove unnecessary #ifdef CONFIG_EFI

CONFIG_EFI is implied by CONFIG_X86_UV and x86/platform/uv/bios_uv.c
requires the latter, get rid of the redundant #ifdef CONFIG_EFI
directives.

Cleanup, no functional changes.

Signed-off-by: Hedi Berriche <hedi.berriche@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Russ Anderson <rja@hpe.com>
Reviewed-by: Dimitri Sivanich <sivanich@hpe.com>
Reviewed-by: Mike Travis <mike.travis@hpe.com>
Cc: Andy Shevchenko <andy@infradead.org>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-efi <linux-efi@vger.kernel.org>
Cc: platform-driver-x86@vger.kernel.org
Cc: Steve Wahl <steve.wahl@hpe.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190213193413.25560-2-hedi.berriche@hpe.com
---
 arch/x86/include/asm/uv/bios.h | 4 ----
 arch/x86/platform/uv/bios_uv.c | 2 --
 2 files changed, 6 deletions(-)

diff --git a/arch/x86/include/asm/uv/bios.h b/arch/x86/include/asm/uv/bios.h
index e652a7cc6186..00d862cfbcbe 100644
--- a/arch/x86/include/asm/uv/bios.h
+++ b/arch/x86/include/asm/uv/bios.h
@@ -151,11 +151,7 @@ extern s64 uv_bios_change_memprotect(u64, u64, enum uv_memprotect);
 extern s64 uv_bios_reserved_page_pa(u64, u64 *, u64 *, u64 *);
 extern int uv_bios_set_legacy_vga_target(bool decode, int domain, int bus);
 
-#ifdef CONFIG_EFI
 extern void uv_bios_init(void);
-#else
-void uv_bios_init(void) { }
-#endif
 
 extern unsigned long sn_rtc_cycles_per_second;
 extern int uv_type;
diff --git a/arch/x86/platform/uv/bios_uv.c b/arch/x86/platform/uv/bios_uv.c
index 4a6a5a26c582..4a61ed2a7bb8 100644
--- a/arch/x86/platform/uv/bios_uv.c
+++ b/arch/x86/platform/uv/bios_uv.c
@@ -188,7 +188,6 @@ int uv_bios_set_legacy_vga_target(bool decode, int domain, int bus)
 }
 EXPORT_SYMBOL_GPL(uv_bios_set_legacy_vga_target);
 
-#ifdef CONFIG_EFI
 void uv_bios_init(void)
 {
 	uv_systab = NULL;
@@ -218,4 +217,3 @@ void uv_bios_init(void)
 	}
 	pr_info("UV: UVsystab: Revision:%x\n", uv_systab->revision);
 }
-#endif
