Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05B5C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89BF720675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388674AbeLQSQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:16:57 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48719 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbeLQSQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:16:56 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBHIGR0W2560067
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 Dec 2018 10:16:27 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBHIGR9V2560064;
        Mon, 17 Dec 2018 10:16:27 -0800
Date:   Mon, 17 Dec 2018 10:16:27 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Heinrich Schuchardt <tipbot@zytor.com>
Message-ID: <tip-793423cf07e51e3185b8680167115813589c057d@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, riel@surriel.com,
        peterz@infradead.org, cai@gmx.us, torvalds@linux-foundation.org,
        mingo@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        ard.biesheuvel@linaro.org, xypron.glpk@gmx.de,
        linux-kernel@vger.kernel.org, luto@kernel.org
Reply-To: cai@gmx.us, torvalds@linux-foundation.org, mingo@kernel.org,
          bp@alien8.de, dave.hansen@linux.intel.com, xypron.glpk@gmx.de,
          ard.biesheuvel@linaro.org, linux-kernel@vger.kernel.org,
          luto@kernel.org, tglx@linutronix.de, riel@surriel.com,
          hpa@zytor.com, peterz@infradead.org
In-Reply-To: <20181217180214.9436-3-ard.biesheuvel@linaro.org>
References: <20181217180214.9436-3-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/urgent] efi: Align 'efi_guid_t' to 64 bits
Git-Commit-ID: 793423cf07e51e3185b8680167115813589c057d
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

Commit-ID:  793423cf07e51e3185b8680167115813589c057d
Gitweb:     https://git.kernel.org/tip/793423cf07e51e3185b8680167115813589c057d
Author:     Heinrich Schuchardt <xypron.glpk@gmx.de>
AuthorDate: Mon, 17 Dec 2018 19:02:14 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Dec 2018 19:12:48 +0100

efi: Align 'efi_guid_t' to 64 bits

The UEFI Specification Version 2.7 Errata A defines:

  "EFI_GUID
  128-bit buffer containing a unique identifier value.
  Unless otherwise specified, aligned on a 64-bit boundary."

Before this patch efi_guid_t was only 8-bit aligned.

Note that this could potentially trigger alignment faults during
EFI runtime services calls on 32-bit ARM, given that it does not
permit load/store double or load/store multiple instructions to
operate on memory addresses that are not 32-bit aligned.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: <stable@vger.kernel.org> # v4.9+, or earlier if possible
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Qian Cai <cai@gmx.us>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20181217180214.9436-3-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/efi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 100ce4a4aff6..e6480c805932 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -48,7 +48,7 @@ typedef u16 efi_char16_t;		/* UNICODE character */
 typedef u64 efi_physical_addr_t;
 typedef void *efi_handle_t;
 
-typedef guid_t efi_guid_t;
+typedef guid_t efi_guid_t __aligned(8);
 
 #define EFI_GUID(a,b,c,d0,d1,d2,d3,d4,d5,d6,d7) \
 	GUID_INIT(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)
