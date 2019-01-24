Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F49C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 145A721903
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358528;
	bh=jjOlSfLFp6/FX18aFSWfEqMqsbB6lviXJuNPjm6bLUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hMMNmRfr0mfwcn52KlRpETMt19mC9Nom5QbAUKJkRCgJnhS5cbeESxAmpmdOsZ19m
	 kFG6VcUpGNmitoq8pombyMOmF88T8BthjzN2Dd0JYP7oOdpoSvgbfaQnQdYqovmMQS
	 Bd2C1KdZHi8ruJHsCeim92cvEXwmOy9sx2UPwIUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732347AbfAXTfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:35:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:35254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732329AbfAXTfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:35:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F1B7218D4;
        Thu, 24 Jan 2019 19:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358521;
        bh=jjOlSfLFp6/FX18aFSWfEqMqsbB6lviXJuNPjm6bLUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Frw1wZVAj/YI5m0X1N0De7QE2qhNPBHEec1ia9WcQv3pErlHbANEZZJQODKh+Qq76
         Ohvmj2EMprbDoEuVFatdArShc2wjFFpNxPar2fOwst/8RvRKGUfvPU5u/slPV6b2Ne
         tkfOqEjPU31EAzfe/9OW1TPlFMP2KoHMqsHyxkFQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sedat Dilek <sedat.dilek@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Joe Perches <joe@perches.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        YiFei Zhu <zhuyifei1999@gmail.com>, linux-efi@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 038/106] efi/libstub: Disable some warnings for x86{,_64}
Date:   Thu, 24 Jan 2019 20:19:55 +0100
Message-Id: <20190124190208.841187965@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190206.342411005@linuxfoundation.org>
References: <20190124190206.342411005@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 3db5e0ba8b8f4aee631d7ee04b7a11c56cfdc213 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
-- 
2.19.1



