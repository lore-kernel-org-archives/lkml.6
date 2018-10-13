Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641DDC6787C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 01:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B3D20865
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 01:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQWAEcel"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B3D20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeJMIrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 04:47:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40724 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbeJMIrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 04:47:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id d2-v6so15176914wro.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 18:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JNlecF6JUQ2aysoZ76xeS1MeE5nPd+yN8JVEfzFneEc=;
        b=LQWAEcelkcYijnk5vPULET7E5174A2elP6jSme+NnVQ5LlIQrRXxbr/CpnBI50jpRz
         IEtlNY3mElnOAGyErCbdOfrqlRw+jqPg7Qate/Y6eSBaVxfheF5xGKs2vIUqsH3jv2SK
         OZwVR2/t5XiMr7qWHD6UigApN0VN7H7BhwoAAk2EKkO7e7jHftfHL5LkALIcneDe5x0a
         OmWLDSbQsfo7u1saxpsDVC5nJ0+14qrouOSFu6Yg+khoPtBNgUxGjvv3Uu+3rUn9s21d
         lu1zaY9v5RZyKni8Ny/dQVlwqBx4TYgDpXnzFt2X7jVzvLWPnd81uiLnuqxSW9Cx0SJG
         e4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JNlecF6JUQ2aysoZ76xeS1MeE5nPd+yN8JVEfzFneEc=;
        b=W30e1d2v0Ocgi+H40U+YWDNP63ziltfC84svucM3pEnWr+DsgMkEN/XWQJ6a1P4fq2
         j7u3jnmXvf4veDdpZHVVOUVtHqff+yJHON03uIkBmTj+TH7brtYOajfrw4taBDAXtRSA
         bF9YvqQ2dqQpX14Rqpz0CmsXUs/eRz87PO5ilmxU59bLUh0W8GRhb1VmckmaT8aRGsDY
         wc7fs2hSOZ/ob3Tjii/yFnRZKoFFJECwE976tLiqr0rJAAHIf9861M4rquAXCHwq6aNc
         cQcdUiJUhOqsBIlFhw/9S5Ye7BTBReCLSF/tyBGS8NEfB9Ewyf5O8seaYbbTcSyM9K8f
         hvdA==
X-Gm-Message-State: ABuFfojyDcQnBqLNBhYJXKwyjbsRRL0TeKawA8eAytQCPCmF1lgK4FEL
        U9OuDHsMUVWAuLTevEEKbFQ=
X-Google-Smtp-Source: ACcGV61TOtGtF34xiRbZAGbslMZKPlwgAzYCg7dC+bQnOcDHs0mBkAF4WA/jI9BRPHYN9wEvb+ypeg==
X-Received: by 2002:a5d:548e:: with SMTP id h14-v6mr7063911wrv.316.1539393126855;
        Fri, 12 Oct 2018 18:12:06 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id h13-v6sm2720987wrr.73.2018.10.12.18.12.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 18:12:06 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] x86/boot: Add -Wno-pointer-sign to KBUILD_CFLAGS
Date:   Fri, 12 Oct 2018 18:07:14 -0700
Message-Id: <20181013010713.6999-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling the kernel with Clang, this warning appears even though
it is disabled for the whole kernel because this folder has its own set
of KBUILD_CFLAGS. It was disabled before the beginning of git history.

In file included from arch/x86/boot/compressed/kaslr.c:29:
In file included from arch/x86/boot/compressed/misc.h:21:
In file included from ./include/linux/elf.h:5:
In file included from ./arch/x86/include/asm/elf.h:77:
In file included from ./arch/x86/include/asm/vdso.h:11:
In file included from ./include/linux/mm_types.h:9:
In file included from ./include/linux/spinlock.h:88:
In file included from ./arch/x86/include/asm/spinlock.h:43:
In file included from ./arch/x86/include/asm/qrwlock.h:6:
./include/asm-generic/qrwlock.h:101:53: warning: passing 'u32 *' (aka
'unsigned int *') to parameter of type 'int *' converts between pointers
to integer types with different sign [-Wpointer-sign]
        if (likely(atomic_try_cmpxchg_acquire(&lock->cnts, &cnts, _QW_LOCKED)))
                                                           ^~~~~
./include/linux/compiler.h:76:40: note: expanded from macro 'likely'
# define likely(x)      __builtin_expect(!!(x), 1)
                                            ^
./include/asm-generic/atomic-instrumented.h:69:66: note: passing
argument to parameter 'old' here
static __always_inline bool atomic_try_cmpxchg(atomic_t *v, int *old, int new)
                                                                 ^

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

There has been some discussion around whether KBUILD_CFLAGS should be
overwritten in the folder (few examples linked below). In the meantime,
there is precedent for taking top level disabled warnings and adding
them here, thus this patch.

* https://lore.kernel.org/lkml/CAKwvOdmXcztP542kADhyJYN2=Fk3qyXif_MCs=kqPGE8QtTjvQ@mail.gmail.com/
* https://lore.kernel.org/lkml/56442061-7f55-878d-5b26-7cdd14e901d2@zytor.com/

 arch/x86/boot/compressed/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 28764dacf018..466f66c8a7f8 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -37,6 +37,7 @@ KBUILD_CFLAGS += $(call cc-option,-ffreestanding)
 KBUILD_CFLAGS += $(call cc-option,-fno-stack-protector)
 KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
 KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
+KBUILD_CFLAGS += -Wno-pointer-sign
 
 KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
 GCOV_PROFILE := n
-- 
2.19.1

