Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C23C6787C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 01:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89C620868
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 01:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVv8pjmv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B89C620868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbeJMIlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 04:41:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39613 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbeJMIlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 04:41:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id 61-v6so15152684wrb.6;
        Fri, 12 Oct 2018 18:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zGxy2ubzTBSouwPwQiqQbyQC3qXilAaiz7ydWREdEWs=;
        b=pVv8pjmvnfKzBULvW1FjWjA/0eLniMS7sBP4Z07ynrsB3aJf40BhG+1LzUzVV5lvvq
         CRO4dZ2YZQ/09iG4RE+CNPwPq9/t4nb51mYpd79F3OEObpMnZslXlBkddrvSL3ZeoGOe
         li15Q+b6nKlnToSoeofZzHEo65yvKf3/UPxm9CoTN1sD3EuzuMI2EUgWKYWdlB2V51AU
         Bqsn7adEmIWss+pbwFY2PiaKRpa9kRYKd4cjX0IW0K3fjsARkFq5pGNxtB2WkJoguJhB
         h08HvEXSkTtVAvQgxwamFEk66SHmxifbfyhfqminkRY9aJLAvrdvfSl/eAer+aagWD+0
         M0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zGxy2ubzTBSouwPwQiqQbyQC3qXilAaiz7ydWREdEWs=;
        b=TlxPx5A1XQSzD55WOcnu+SxrB7apkXLvyipRs1jyqEqAA+t5UHtnOsOaqdtnTkHn+6
         f2wt8jtTpM6BaL07qRerRyOcoVgbD7X5Yi9nzOyG0p3tSbsLcIme5F6970Z2/OAAZ2dD
         ghfDywTCLxjMkfRQj0pRmEKFddha2qG959X1fl1VLGL+gd4V8ljOc8nBjW0xvwOxRz+F
         l01ThgZpLwZBJSsG8kfVH6+O5yjqZ6CGqzPc74uHH1H/5cTZbFnSW8NfCKqR+eB2WgQT
         r/7NXnlSafhX0CFYQX87cqruDAqPu6/jDPxzvC4EB1+apLHpEYQoFE+q9Kln9mOyiMMt
         CzVg==
X-Gm-Message-State: ABuFfogGNUNe0U13pi3mh6SKmLPadgClgNnnFgr7K766u+6y8ChT2xVy
        wma3jPmhdRUboXy2+OGMGX8=
X-Google-Smtp-Source: ACcGV62yg3iMnEhQZwuGMGabwQ65R2bFMt29TIZB0gRnxJRvqoT5WJ23fCdxCAjlG59e/3Xa/GriJg==
X-Received: by 2002:adf:8382:: with SMTP id 2-v6mr6790095wre.13.1539392770940;
        Fri, 12 Oct 2018 18:06:10 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id 193-v6sm3270873wmj.21.2018.10.12.18.06.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 18:06:10 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] efi/libstub: Disable some warnings for x86{,_64}
Date:   Fri, 12 Oct 2018 18:03:49 -0700
Message-Id: <20181013010348.6740-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building the kernel with Clang, some disabled warnings appear
because this Makefile overrides KBUILD_CFLAGS for x86{,_64}. Add them to
this list so that the build is clean again.

-Wpointer-sign was disabled for the whole kernel before the beginning
of git history.

-Waddress-of-packed-member was disabled for the whole kernel in
commit bfb38988c51e ("kbuild: clang: Disable 'address-of-packed-member'
warning") and for x86/boot/compressed in commit 20c6c1890455 ("x86/boot:
Disable the address-of-packed-member compiler warning").

-Wgnu was disabled for the whole kernel in commit 61163efae020 ("kbuild:
LLVMLinux: Add Kbuild support for building kernel with Clang") and for
x86/boot/compressed in commit 6c3b56b19730 ("x86/boot: Disable Clang
warnings about GNU extensions").

Link: https://github.com/ClangBuiltLinux/linux/issues/112
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

Nick expressed concern that this Makefile is overwriting KBUILD_CFLAGS
and suggested potentially rewriting the x86 portion of this Makefile to
behave like the arm/arm64 one where problematic flags are filtered out.
While that comes to fruition, it would be nice for this folder to behave
like the rest of the kernel when it comes to this warnings so that the
build is cleaner, thus this patch.

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

