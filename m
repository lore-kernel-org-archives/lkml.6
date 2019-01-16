Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B43C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF50206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeKacEgW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393258AbfAPNoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:44:05 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35990 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733175AbfAPNoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:44:04 -0500
Received: by mail-wr1-f65.google.com with SMTP id u4so6995431wrp.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 05:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nR5j74lNLuIRnJ+GRiGrvny0HRvN00oWkuZchmQDo1U=;
        b=TeKacEgWjlQ9pRLHAVLLFc/TQMYWhCCE3pReIxShXUqS2eAY7xuL+xcFha/Uhsms16
         XIRmW1jLrCIoPrZq+u0z36UODE6iTzVriZpM5n0cz4V/TXrfqhCyZ9UQVUr3uJbVg2FQ
         GDWcgtUNAZlWaFLRZrSNQy8vQqs3gY171U7yavhxOgJ3rDL3ctRaQi4sToOlt78k7Eg1
         qoLA+DH4TTFlVb8365PI1w7K7M4POqhwkbKIqXZS5MnFhQ5MB56+tLo+v0GvwS78SXpB
         7G21rge5Eez5D623/2ALi4SELhhNF+zcKQuNzpQQmzRSkIUGnJ5n2EFxx34nVFhVKrgO
         aq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nR5j74lNLuIRnJ+GRiGrvny0HRvN00oWkuZchmQDo1U=;
        b=Op3E92Hra3IrLvgP9H48poZkfgTXxtuAfdTMz5RkULx12txJ1VVDvUIr+1gHjWPuvN
         wW5O3QVeK+gOEgU8+2QraCeqsUPwCtg5WY8ny6rVl3GUH3QJ1qOTBMM/ZFAFXrzbHmMB
         dBPtKYyqbKVvaX4IwP1Ja4EHqHwfmWMNTZ1OLfZnA2fObHHazBFbt9Qe3VYIpbRCLk1C
         LTECJxbWaDFec63MRUw3MWOmpI3VKFGzPi+6Ig9k+nsnXZAc1+YIcPp5StBNVmrkaBVM
         wmVKcVnVctNE4DDq+amGuhb2lCbtVdTVSOvg+tLXP9aEjQvxVTryST8x3AL2CrKQ7YbR
         MipQ==
X-Gm-Message-State: AJcUukdRN38fKj/Cg1/lZCznRkU1lAvc6dBesXOwHGwMv/sKzI6gKt1w
        Dfn16vRLKUb/m8CV4SUc/Y2IfBzICOc=
X-Google-Smtp-Source: ALg8bN5gHyx41AUG+b0xIX0AruFkowKvK6R8SEb5a5QypjfCpqD/WP/rd2AhpD8+TGCFnOZTHRONUg==
X-Received: by 2002:adf:8421:: with SMTP id 30mr7881512wrf.153.1547646242113;
        Wed, 16 Jan 2019 05:44:02 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id h62sm28216884wmf.11.2019.01.16.05.44.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 05:44:01 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2] x86/pgtable: Always inline p4d_index
Date:   Wed, 16 Jan 2019 06:41:59 -0700
Message-Id: <20190116134158.344-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181210234538.5405-1-natechancellor@gmail.com>
References: <20181210234538.5405-1-natechancellor@gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building an allyesconfig build with Clang, the kernel fails to link
arch/x86/platform/efi/efi_64.o because of a failed BUILD_BUG_ON:

ld: arch/x86/platform/efi/efi_64.o: in function `efi_sync_low_kernel_mappings':
(.text+0x8e5): undefined reference to `__compiletime_assert_277'

Since there are several BUILD_BUG_ONs in efi_64.c, I isolated it down to
the following:

    BUILD_BUG_ON(p4d_index(EFI_VA_END) != p4d_index(MODULES_END));

After some research, it turns out that there is a new config option
called NO_AUTO_INLINE, which adds '-fno-inline-functions' to
KBUILD_CFLAGS so that the compiler does not auto inline small functions,
which causes this BUILD_BUG_ON to fail because p4d_index is no longer an
integer constant expression.

According to the help text of the config, functions explicitly marked
inline should still be inlined. As it turns out, GCC and Clang both
support '-fno-inline-functions' but Clang only inlines functions when
they are marked with an always inline annotation[1].

Since it's expected that p4d_index should always be inlined so that its
value can be evaluated at build time, mark it as __always_inline.

[1]: https://github.com/llvm/llvm-project/blob/84cecfcb3db7/clang/lib/Frontend/CompilerInvocation.cpp#L638-L657

Link: https://github.com/ClangBuiltLinux/linux/issues/256
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

v1 -> v2:

* Add Nick's Reviewed-by tag.

* Update the GitHub URL to use the official LLVM repository and pin to a
  SHA so that it is always valid, as suggested by Nick.

 arch/x86/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 40616e805292..f78e53382498 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -918,7 +918,7 @@ static inline int p4d_bad(p4d_t p4d)
 }
 #endif  /* CONFIG_PGTABLE_LEVELS > 3 */
 
-static inline unsigned long p4d_index(unsigned long address)
+static __always_inline unsigned long p4d_index(unsigned long address)
 {
 	return (address >> P4D_SHIFT) & (PTRS_PER_P4D - 1);
 }
-- 
2.20.1

