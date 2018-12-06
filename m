Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DDCC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9EC20989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fvJHe6JT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9EC20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbeLFTMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:12:40 -0500
Received: from mail-yb1-f201.google.com ([209.85.219.201]:51475 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeLFTMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:12:40 -0500
Received: by mail-yb1-f201.google.com with SMTP id u25so1584309ybd.18
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 11:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=o34iZPx5gmIP0yDUEY+GPJ7foXDKl8jjPVQ8cyje1D4=;
        b=fvJHe6JTZHPmzrj0wjRTExiG8efcR8FWSUxoUrjwNrvYJv+e1GOvMp2GjXRKzpJHRx
         EKRYKlZ5f9ZpaTP12zEvWWYrPrskm2NVGHcwHVF1Uwmi06P8tEyevVmF0nEGSbEmOHmX
         8igWkXWtNMufqwUogYad+XO3AORi90Jz0F/rrmot07XtkUcB7LOMqGSdsgzyVgz0latp
         oM3T5QjfncwOu4rm/xltfFQPu3VZHyql6NhbZqj2JvUSoNuIgr0JL3881Eij+dlLOQ77
         5TG0Y/03FRpjyRMWYAY857PdKbO1hILobQROMUdHeFOCw99vYIyFa3O44uJtFC27L5MN
         9Wrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=o34iZPx5gmIP0yDUEY+GPJ7foXDKl8jjPVQ8cyje1D4=;
        b=WJR65z+Igun8IXQggdWSNQcS+2482slJzFq0r6KMFbqmWe1614+nthZzO+knQTLqPM
         DzPgMoVLAP1PWRWghFHTrITBefRsLjSf9ZZl+TVnENZfBHdPEu8pjJD9xRnTPdYjRnYf
         OPcQpEtxCXdfp5up1JuOm5mc63qlT3BbhJYBdjUOfhnZg4Gr5vJ/OBrdNFPPW4Arh+qS
         E0xTKdy+KL/ugP87+2d5qWtYWGdtsJ/16GPFqQFhLMIuOyMNqSogyvrFUZB1mKUo7Dx7
         st+tBfqpI++GDotPX/jRV5xSTJay4GWC/reX3roZPaBJ4LELtv+/hajEfzFx9iMOftkn
         skHw==
X-Gm-Message-State: AA+aEWYOREArHOeiBsY4AZUP7sXPq+CpC83/L3seh7ZH9P0Q6q8BwmDm
        5XI2B2TUUY7yiF9P/Dop/ibrP10c9k8BnJ0utd4=
X-Google-Smtp-Source: AFSGD/WjEn9IkUo83/jXzHjzYwjPSEAtXGvXVDH77FdNrbcAxckalPdnDEFn3JmtxwfRMegqAGeaRhB7ZC/udMMQaKI=
X-Received: by 2002:a25:2413:: with SMTP id k19mr1980708ybk.25.1544123559367;
 Thu, 06 Dec 2018 11:12:39 -0800 (PST)
Date:   Thu,  6 Dec 2018 11:12:31 -0800
Message-Id: <20181206191231.192355-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
Subject: [PATCH] x86/vdso: drop implicit common-page-size linker flag
From:   ndesaulniers@google.com
To:     luto@kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        Dmitry Golovin <dima@golovin.in>,
        Bill Wendling <morbo@google.com>, Rui Ueyama <ruiu@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are implied by the target architecture and for x86_64 match the
max-page-size. The default for non-NaCl x86_64 is 0x1000 (4096).

In bfd the common page size is defined as 0x1000 (4096) for non-NaCl
x86_64 targets:

bfd/elf64-x86-64.c:
4998:#define ELF_COMMONPAGESIZE             0x1000

For gold, the common page size is defined as 0x1000 (4096) for non-NaCl
x86_64 targets:

gold/x86_64.cc:
1413:  0x1000, // common_pagesize (overridable by -z common-page-size)
1442:  0x1000, // common_pagesize (overridable by -z common-page-size)

(ELF_COMMONPAGESIZE also defaults to ELF_MAXPAGESIZE when not set
explicitly for a target architecture in bfd/elfxx-target.h, but that's
not relevant for x86_64).

Because it's implied by the target architecture, it's of questionable
use to implement in LLD.  This patch resolves one of the issues towards
using LLD to link an x86_64 kernel.

Fixes commit 2aae950b21e4 ("x86_64: Add vDSO for x86-64 with
gettimeofday/clock_gettime/getcpu")

Link: https://bugs.llvm.org/show_bug.cgi?id=38774
Link: https://github.com/ClangBuiltLinux/linux/issues/31
Cc: Fangrui Song <maskray@google.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Reported-by: Dmitry Golovin <dima@golovin.in>
Reported-by: Bill Wendling <morbo@google.com>
Suggested-by: Dmitry Golovin <dima@golovin.in>
Suggested-by: Rui Ueyama <ruiu@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/x86/entry/vdso/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 141d415a8c80..0624bf2266fd 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -47,7 +47,7 @@ targets += $(vdso_img_sodbg) $(vdso_img-y:%=vdso%.so)
 CPPFLAGS_vdso.lds += -P -C
 
 VDSO_LDFLAGS_vdso.lds = -m elf_x86_64 -soname linux-vdso.so.1 --no-undefined \
-			-z max-page-size=4096 -z common-page-size=4096
+			-z max-page-size=4096
 
 $(obj)/vdso64.so.dbg: $(obj)/vdso.lds $(vobjs) FORCE
 	$(call if_changed,vdso)
@@ -98,7 +98,7 @@ CFLAGS_REMOVE_vvar.o = -pg
 
 CPPFLAGS_vdsox32.lds = $(CPPFLAGS_vdso.lds)
 VDSO_LDFLAGS_vdsox32.lds = -m elf32_x86_64 -soname linux-vdso.so.1 \
-			   -z max-page-size=4096 -z common-page-size=4096
+			   -z max-page-size=4096
 
 # x32-rebranded versions
 vobjx32s-y := $(vobjs-y:.o=-x32.o)
-- 
2.20.0.rc1.387.gf8505762e3-goog

