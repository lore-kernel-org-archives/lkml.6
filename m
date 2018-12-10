Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94713C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B8252084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgfxBZBU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B8252084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbeLJXqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 18:46:06 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54018 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbeLJXqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 18:46:06 -0500
Received: by mail-wm1-f68.google.com with SMTP id y1so392852wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 15:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mv5ufnWLxJZ4fXnXEJXRJ6dgjU1RzzdkZk3YwlQVhCA=;
        b=PgfxBZBUTG4gQH3kpGfzGusp37R47AkwkkhXy/JjyJLfLboAnC2Wyxem/3/swDYFR+
         fDj+7zwZoNg4trpKjiufFLt+XDUWyK9hpmU83JJPx/3rnKS0b09O/Yt4AD9MIrs8wQTu
         GDNjUf/vfX8lK+gx1mfuX4gGVh+xvGBz4U/e4mHLspDZDG8zzUUzPJVK4DX36ZHRbqoV
         09hIWoTEp2BP9xxqbBk60xhNEfGZhPrBKM2+yKm0Zk1y5cOo7biorUoUmtfI6WJSSssL
         61AR7Wt8GhWrqjJoV5W1YYMevafBZXoq1GSXS8q45PgyNOhDJrNhgU8nZx39Ef0123wM
         a0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mv5ufnWLxJZ4fXnXEJXRJ6dgjU1RzzdkZk3YwlQVhCA=;
        b=Rq05lLIWZmeofikloMo6xT41MaCLs3bqMOfuZeqMGlaLPFxq5082eiG793a/pzhqsX
         RAuHJd3vVlJku7qW0qGOUmIGtmSupqJSoEoHNsJ7Dkx0QV9CHM7e+sHf+Zn6uSIgO/u7
         ceAbBBeD7r4JrERmLaP6r04Lb1rG+z0ZDPTblwxN6g3+Yt3Pen2WO7dddVPYOX1UK53W
         xwSAAIPfTJGWbd8kwaUIOVkdJ+vMTqJyGrQZG5sI3M5xkwALSLNsKnN4K4kfSiDEFsdt
         x8L8S1ivLo/l9KM/YTWT2iDLw3QfgK6X1tSvpsqE+jQ4c0AoTMGTpeYqJFS+wsxLQvnE
         WPeg==
X-Gm-Message-State: AA+aEWYoK3N8pS2Niz88qVZGQPZ36qyCfQQxbNLJUrizjMn21TTwF0s4
        OAqqOq0X2oa569GqeptIzX8=
X-Google-Smtp-Source: AFSGD/VxzVnXdMxuaYnOCKy3VcYg8CjO07C0D1x+yWFsNh5+teBLV/mAl0DF1bAgpnky0Segpqmi3A==
X-Received: by 2002:a1c:4046:: with SMTP id n67mr288841wma.123.1544485564550;
        Mon, 10 Dec 2018 15:46:04 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id c14sm299879wme.13.2018.12.10.15.46.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 15:46:03 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] x86/pgtable: Always inline p4d_index
Date:   Mon, 10 Dec 2018 16:45:38 -0700
Message-Id: <20181210234538.5405-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
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

[1]: https://github.com/llvm-mirror/clang/blob/master/lib/Frontend/CompilerInvocation.cpp#L637-L656

Link: https://github.com/ClangBuiltLinux/linux/issues/256
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
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
2.20.0

