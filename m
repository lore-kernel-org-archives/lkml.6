Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3EEC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E4A217D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfBDHWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 02:22:51 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59349 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfBDHWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 02:22:51 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x147LxOX329548
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 3 Feb 2019 23:21:59 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x147LxAX329545;
        Sun, 3 Feb 2019 23:21:59 -0800
Date:   Sun, 3 Feb 2019 23:21:59 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sai Praneeth Prakhya <tipbot@zytor.com>
Message-ID: <tip-8fe55212aacfce9b7718de7964b3a3096ec30919@git.kernel.org>
Cc:     jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bjorn.andersson@linaro.org, hpa@zytor.com,
        agraf@suse.de, takahiro.akashi@linaro.org,
        ard.biesheuvel@linaro.org, mingo@kernel.org, bp@alien8.de,
        matt@codeblueprint.co.uk, pjones@redhat.com,
        leif.lindholm@linaro.org, sai.praneeth.prakhya@intel.com,
        xypron.glpk@gmx.de, torvalds@linux-foundation.org,
        lee.jones@linaro.org, peterz@infradead.org
Reply-To: lee.jones@linaro.org, xypron.glpk@gmx.de,
          torvalds@linux-foundation.org, peterz@infradead.org,
          matt@codeblueprint.co.uk, bp@alien8.de, leif.lindholm@linaro.org,
          pjones@redhat.com, sai.praneeth.prakhya@intel.com,
          takahiro.akashi@linaro.org, agraf@suse.de,
          bjorn.andersson@linaro.org, hpa@zytor.com, mingo@kernel.org,
          ard.biesheuvel@linaro.org, jhugo@codeaurora.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <20190202094119.13230-2-ard.biesheuvel@linaro.org>
References: <20190202094119.13230-2-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] x86/efi: Mark can_free_region() as an __init
 function
Git-Commit-ID: 8fe55212aacfce9b7718de7964b3a3096ec30919
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

Commit-ID:  8fe55212aacfce9b7718de7964b3a3096ec30919
Gitweb:     https://git.kernel.org/tip/8fe55212aacfce9b7718de7964b3a3096ec30919
Author:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
AuthorDate: Sat, 2 Feb 2019 10:41:10 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 4 Feb 2019 08:19:22 +0100

x86/efi: Mark can_free_region() as an __init function

can_free_region() is called only once during boot, by
efi_reserve_boot_services().

Hence, mark it as an __init function.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Alexander Graf <agraf@suse.de>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jeffrey Hugo <jhugo@codeaurora.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Leif Lindholm <leif.lindholm@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Jones <pjones@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20190202094119.13230-2-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/platform/efi/quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 17456a1d3f04..9ce85e605052 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -304,7 +304,7 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
  * - Not within any part of the kernel
  * - Not the BIOS reserved area (E820_TYPE_RESERVED, E820_TYPE_NVS, etc)
  */
-static bool can_free_region(u64 start, u64 size)
+static __init bool can_free_region(u64 start, u64 size)
 {
 	if (start + size > __pa_symbol(_text) && start <= __pa_symbol(_end))
 		return false;
