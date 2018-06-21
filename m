Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2496FC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0DF420836
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m19o5M/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0DF420836
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933414AbeFUQXc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 12:23:32 -0400
Received: from mail-yb0-f202.google.com ([209.85.213.202]:34159 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933357AbeFUQXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 12:23:30 -0400
Received: by mail-yb0-f202.google.com with SMTP id w128-v6so2100622ybe.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 09:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=wSqpAvMK4bLXSGTihP+dScsLTs1sgucIQXGx8TyntWw=;
        b=m19o5M/p1gBxmq6kprjIQN6gkIRApGNKTOojPMaxF8g/TI/vwdDeqrHIiKaQ/j3vqY
         rSfsPpiw/rgCKo/k6DiPwlZVEazKLRR8ZFvaEa5AeG5lIkLi9QjlbT+TzpiMKCTET2Us
         7+j1B+qZLAQUjrfxMDz7O9CXLH66bjWRb2+7RJkGlW7AQJAzh4VLfLcAN/WAD/+5il1j
         3m8/ujBSqmGNDMTL4ofEBBM/lCdBkh21tZQhHPUKvdqF+XEG5nEANUbkgr6LKLejccEq
         /O+NuOPzjUciIN51pBqV9JcO9FQM2+vUfpH7P0o8DHcTYDAqobUsFoIu3mof5MvIfljM
         Ebxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=wSqpAvMK4bLXSGTihP+dScsLTs1sgucIQXGx8TyntWw=;
        b=OQf4O4wNkbqmfeFMqBU2HIBknz58m+djia0pH7+YjU/qFReOLluBLj8ocnYt4j+g19
         18MWgcAjaDyvY1CwrqUTwnhdRT3lRwOZ0pBjziqkquhdn0J6PQqfLdOqu5AmmhNNv0C4
         HP8rOEa2WE02ob3GNVvlTBP++VP73E+6ONA/YYZa9sHNpJ1gAGrVWwoaTcwP2W0/M/0S
         dDIMKKHBuMqO/5/Tlv3zkaXJU76J3w4kk5f9GjdEF2cSWqmR8ie++Iy1gHy1YL8j0Odf
         UfB/4UkNtKA7F0Vt+xM3AIgjhg4WBpR3e/UaWZfnJYDVY1lvXN1CWdYgyFiFUtV6YJfF
         zrTg==
X-Gm-Message-State: APt69E0ZxjefuIiFv49njC06npccnRcXXHaTYa3Q/zG7pg6hSk/9z8Hm
        VQBNY+UbFTJOL/u2LLsWTRMmI+xViyNWcbgL5O4=
X-Google-Smtp-Source: ADUXVKKt1xlIWI8OMNmkkjtA95KoRmgG2veb5dsrnYTT+7Za8jOSNXsC+We2nmgwDXlg0/WYeKkZ3z4mh9otQBiD1gE=
MIME-Version: 1.0
X-Received: by 2002:a81:c541:: with SMTP id o1-v6mr8179946ywj.7.1529598209579;
 Thu, 21 Jun 2018 09:23:29 -0700 (PDT)
Date:   Thu, 21 Jun 2018 09:23:21 -0700
Message-Id: <20180621162324.36656-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v6 0/3] extern inline native_save_fl for paravirt
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     mingo@redhat.com, tglx@linutronix.de
Cc:     akpm@linux-foundation.org, hpa@zytor.com,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, virtualization@lists.linux-foundation.org,
        astrachan@google.com, manojgupta@google.com, ghackmann@google.com,
        sedat.dilek@gmail.com, tstellar@redhat.com, keescook@google.com,
        yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        linux-kbuild@vger.kernel.org, geert@linux-m68k.org,
        will.deacon@arm.com, mawilcox@microsoft.com, arnd@arndb.de,
        rientjes@google.com, acme@redhat.com, pombredanne@nexb.com,
        aryabinin@virtuozzo.com, kstewart@linuxfoundation.org,
        boris.ostrovsky@oracle.com, jan.kiszka@siemens.com,
        rostedt@goodmis.org, kirill.shutemov@linux.intel.com,
        ard.biesheuvel@linaro.org, akataria@vmware.com,
        brijesh.singh@amd.com, caoj.fnst@cn.fujitsu.com,
        gregkh@linuxfoundation.org, jarkko.sakkinen@linux.intel.com,
        jgross@suse.com, jpoimboe@redhat.com, mka@chromium.org,
        ndesaulniers@google.com, thomas.lendacky@amd.com, tweek@google.com,
        mjg59@google.com, joe@perches.com,
        andrea.parri@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

paravirt depends on a custom calling convention (callee saved), but
expects this from a static inline function that it then forces to be
outlined. This is problematic because different compilers or flags can
then add a stack guard that violates the calling conventions.

Uses extern inline with the out-of-line definition in assembly to
prevent compilers from adding stack guards to the outlined version.

Other parts of the codebase overwrite KBUILD_CFLAGS, which is *extremely
problematic* for extern inline, as the sematics are completely the
opposite depending on what C standard is used.
http://blahg.josefsipek.net/?p=529

Changes since v5:
  Reworded commits to include Juergen's ack and switch a Suggested-by
  for Reviewed-by tag. No code changes.

Changes since v4:
  Take Arnd's and hpa's suggestions properly feature detect gnu_inline
  attribute to support gcc 4.1.

Changes since v3:
  Take Joe's suggestion to hoist __inline__ and __inline out of
  conditional block.

Changes since v2:
  Take hpa's _ASM_ARG patch into the set in order to simplify cross
  32b/64b x86 assembly and rebase my final patch to use it.  Apply
  Sedat's typo fix to commit message and sign off on it. Take Joe's
  suggestion to simplify __inline__ and __inline. Add Arnd to list of
  folks who made helpful suggestions.

Changes since v1:
  Prefer gnu_inline function attribute instead of explicitly setting C
  standard compiler flag in problematic Makefiles. We should instead
  carefully evaluate if those Makefiles should be overwriting
  KBUILD_CFLAGS at all. Dropped the previous first two patches and added
  a new first patch.


*** BLURB HERE ***

H. Peter Anvin (1):
  x86/asm: add _ASM_ARG* constants for argument registers to <asm/asm.h>

Nick Desaulniers (2):
  compiler-gcc.h: add gnu_inline to all inline declarations
  x86: paravirt: make native_save_fl extern inline

 arch/x86/include/asm/asm.h      | 59 +++++++++++++++++++++++++++++++++
 arch/x86/include/asm/irqflags.h |  2 +-
 arch/x86/kernel/Makefile        |  1 +
 arch/x86/kernel/irqflags.S      | 26 +++++++++++++++
 include/linux/compiler-gcc.h    | 29 ++++++++++++----
 5 files changed, 109 insertions(+), 8 deletions(-)
 create mode 100644 arch/x86/kernel/irqflags.S

-- 
2.18.0.rc2.346.g013aa6912e-goog

