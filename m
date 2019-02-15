Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADACC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02EED222A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733048AbfBOPGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:06:04 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42397 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfBOPGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:06:03 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1FF5Xml1226341
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 15 Feb 2019 07:05:33 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1FF5Wth1226336;
        Fri, 15 Feb 2019 07:05:32 -0800
Date:   Fri, 15 Feb 2019 07:05:32 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Hedi Berriche <tipbot@zytor.com>
Message-ID: <tip-8945d96f7b3ead56e053ac79b8f7b0de98a30bfe@git.kernel.org>
Cc:     linux-efi@vger.kernel.org, ard.biesheuvel@linaro.org, rja@hpe.com,
        mike.travis@hpe.com, bhsharma@redhat.com, mingo@redhat.com,
        mingo@kernel.org, bp@suse.de, x86@kernel.org, sivanich@hpe.com,
        hpa@zytor.com, tglx@linutronix.de, steve.wahl@hpe.com,
        linux-kernel@vger.kernel.org, andy@infradead.org,
        hedi.berriche@hpe.com, dvhart@infradead.org
Reply-To: mingo@kernel.org, bp@suse.de, x86@kernel.org, sivanich@hpe.com,
          hpa@zytor.com, linux-efi@vger.kernel.org,
          ard.biesheuvel@linaro.org, rja@hpe.com, mike.travis@hpe.com,
          bhsharma@redhat.com, mingo@redhat.com, steve.wahl@hpe.com,
          andy@infradead.org, hedi.berriche@hpe.com,
          linux-kernel@vger.kernel.org, dvhart@infradead.org,
          tglx@linutronix.de
In-Reply-To: <20190213193413.25560-4-hedi.berriche@hpe.com>
References: <20190213193413.25560-4-hedi.berriche@hpe.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/uv] x86/platform/UV: Use efi_enabled() instead of
 test_bit()
Git-Commit-ID: 8945d96f7b3ead56e053ac79b8f7b0de98a30bfe
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

Commit-ID:  8945d96f7b3ead56e053ac79b8f7b0de98a30bfe
Gitweb:     https://git.kernel.org/tip/8945d96f7b3ead56e053ac79b8f7b0de98a30bfe
Author:     Hedi Berriche <hedi.berriche@hpe.com>
AuthorDate: Wed, 13 Feb 2019 19:34:12 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Fri, 15 Feb 2019 15:15:18 +0100

x86/platform/UV: Use efi_enabled() instead of test_bit()

Use ad hoc efi_enabled() instead of fiddling with test_bit().

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
Link: https://lkml.kernel.org/r/20190213193413.25560-4-hedi.berriche@hpe.com
---
 arch/x86/platform/uv/bios_uv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/uv/bios_uv.c b/arch/x86/platform/uv/bios_uv.c
index 91e3d5285836..38a2e3431fc6 100644
--- a/arch/x86/platform/uv/bios_uv.c
+++ b/arch/x86/platform/uv/bios_uv.c
@@ -44,7 +44,7 @@ s64 uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3, u64 a4, u64 a5)
 	 * If EFI_OLD_MEMMAP is set, we need to fall back to using our old EFI
 	 * callback method, which uses efi_call() directly, with the kernel page tables:
 	 */
-	if (unlikely(test_bit(EFI_OLD_MEMMAP, &efi.flags)))
+	if (unlikely(efi_enabled(EFI_OLD_MEMMAP)))
 		ret = efi_call((void *)__va(tab->function), (u64)which, a1, a2, a3, a4, a5);
 	else
 		ret = efi_call_virt_pointer(tab, function, (u64)which, a1, a2, a3, a4, a5);
