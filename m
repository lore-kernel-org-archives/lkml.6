Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71E8C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9722146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9722146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeK3VJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:09:18 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40923 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeK3VJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 16:09:18 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAU9xlND3262102
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 30 Nov 2018 01:59:47 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAU9xlVd3262099;
        Fri, 30 Nov 2018 01:59:47 -0800
Date:   Fri, 30 Nov 2018 01:59:47 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nathan Chancellor <tipbot@zytor.com>
Message-ID: <tip-3db5e0ba8b8f4aee631d7ee04b7a11c56cfdc213@git.kernel.org>
Cc:     torvalds@linux-foundation.org, julien.thierry@arm.com,
        marc.zyngier@arm.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, zhuyifei1999@gmail.com,
        arend.vanspriel@broadcom.com, matt@codeblueprint.co.uk,
        eric.snowberg@oracle.com, ard.biesheuvel@linaro.org, bp@alien8.de,
        joe@perches.com, peterz@infradead.org, luto@kernel.org,
        jonathanh@nvidia.com, mingo@kernel.org, sedat.dilek@gmail.com,
        sai.praneeth.prakhya@intel.com, bhsharma@redhat.com,
        dave.hansen@intel.com, hpa@zytor.com, natechancellor@gmail.com,
        hdegoede@redhat.com
Reply-To: ard.biesheuvel@linaro.org, bp@alien8.de, luto@kernel.org,
          mingo@kernel.org, jonathanh@nvidia.com, joe@perches.com,
          peterz@infradead.org, bhsharma@redhat.com, dave.hansen@intel.com,
          sai.praneeth.prakhya@intel.com, sedat.dilek@gmail.com,
          natechancellor@gmail.com, hpa@zytor.com, hdegoede@redhat.com,
          torvalds@linux-foundation.org, julien.thierry@arm.com,
          marc.zyngier@arm.com, linux-kernel@vger.kernel.org,
          zhuyifei1999@gmail.com, tglx@linutronix.de,
          matt@codeblueprint.co.uk, arend.vanspriel@broadcom.com,
          eric.snowberg@oracle.com
In-Reply-To: <20181129171230.18699-8-ard.biesheuvel@linaro.org>
References: <20181129171230.18699-8-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi/libstub: Disable some warnings for x86{,_64}
Git-Commit-ID: 3db5e0ba8b8f4aee631d7ee04b7a11c56cfdc213
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

Commit-ID:  3db5e0ba8b8f4aee631d7ee04b7a11c56cfdc213
Gitweb:     https://git.kernel.org/tip/3db5e0ba8b8f4aee631d7ee04b7a11c56cfdc213
Author:     Nathan Chancellor <natechancellor@gmail.com>
AuthorDate: Thu, 29 Nov 2018 18:12:26 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 30 Nov 2018 09:10:31 +0100

efi/libstub: Disable some warnings for x86{,_64}

When building the kernel with Clang, some disabled warnings appear
because this Makefile overrides KBUILD_CFLAGS for x86{,_64}. Add them to
this list so that the build is clean again.

-Wpointer-sign was disabled for the whole kernel before the beginning of Git history.

-Waddress-of-packed-member was disabled for the whole kernel and for
the early boot code in these commits:

  bfb38988c51e ("kbuild: clang: Disable 'address-of-packed-member' warning")
  20c6c1890455 ("x86/boot: Disable the address-of-packed-member compiler warning").

-Wgnu was disabled for the whole kernel and for the early boot code in
these commits:

  61163efae020 ("kbuild: LLVMLinux: Add Kbuild support for building kernel with Clang")
  6c3b56b19730 ("x86/boot: Disable Clang warnings about GNU extensions").

 [ mingo: Made the changelog more readable. ]

Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Joe Perches <joe@perches.com>
Cc: Jon Hunter <jonathanh@nvidia.com>
Cc: Julien Thierry <julien.thierry@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: YiFei Zhu <zhuyifei1999@gmail.com>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20181129171230.18699-8-ard.biesheuvel@linaro.org
Link: https://github.com/ClangBuiltLinux/linux/issues/112
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index c51627660dbb..d9845099635e 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -9,7 +9,10 @@ cflags-$(CONFIG_X86_32)		:= -march=i386
 cflags-$(CONFIG_X86_64)		:= -mcmodel=small
 cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ -O2 \
 				   -fPIC -fno-strict-aliasing -mno-red-zone \
-				   -mno-mmx -mno-sse -fshort-wchar
+				   -mno-mmx -mno-sse -fshort-wchar \
+				   -Wno-pointer-sign \
+				   $(call cc-disable-warning, address-of-packed-member) \
+				   $(call cc-disable-warning, gnu)
 
 # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
 # disable the stackleak plugin
