Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 83sqHxF6GVvvNwAAmS7hNA
	; Thu, 07 Jun 2018 18:32:31 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7A0EC6089E; Thu,  7 Jun 2018 18:32:31 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hy84fegm"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E19E8606DD;
	Thu,  7 Jun 2018 18:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E19E8606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936299AbeFGSc2 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:32:28 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36183 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934029AbeFGSc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:32:26 -0400
Received: by mail-pg0-f66.google.com with SMTP id m5-v6so5154233pgd.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FcfgBErQhhqUdwC7MmxzqpQdpQ49HzcC5H0Q4cAOYV4=;
        b=hy84fegmspnEyTkhv9UqP2o7jqyEuLYywYsVJVFv7sj8ZD7xx8d5bjiRGwg4aXyI3w
         h4Ic0if2Wf/dYg7EDzQIBli+rr0HZFDSBA7KP6MeXcQCcXEIqqPB60trHRrQigKjPLU2
         bOKlWtkdzPLSVt009d/DksPDXyS2XZax0beyorF2SFNL8/e8JZr35/RFwj/CiYE6v+vV
         hKu8Y6g0Q1CyC/7N+hI89JFh9SO4CXBu3kBzKTfAdaNPssS74opYC09jtu5dR4+h5BDJ
         dDBLDvhTONVOTfioChXt5c1wPttOafHxrV9P8CQsSJIrnQxQ99+aXst8WwEfQ87w2Oya
         vR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FcfgBErQhhqUdwC7MmxzqpQdpQ49HzcC5H0Q4cAOYV4=;
        b=BkUSJlRxTP9RbLYxI5agKo15J1tksqOkchrd8obayWKECzv8N2u/1zROf5VnYJMW6h
         e29A0i5Cd0nIRKSDboSBJuYNy3D4zFxcYwhAkEQ1dRRZ6Jvq76q9aXJHoQFHji7RBVnM
         gr+BC05BKzC6LvbfJoGgTbY3Xh2Cr1ZexZwXXFLzAKPlAV+h65iEYL8surGcgZvVdl+Z
         6ZIKO+XdpLPP6cKuRn1m+STU1bjiwkQrb1esgFiW1tTc5bEtip8McKdg2gpLCR7qdeNi
         9g2Eace9qrhe5s/U85fusw8KE9t4nJBw1LoLdIFRABcPnKO644CD79QnU5J2ln672f57
         da+A==
X-Gm-Message-State: APt69E0FK/3K60OLy8wPFBmCrh1+1clrSvY6wZDxYbp/ugYzEQaZ2fxF
        ownAtMvrKNAq8VTRJNIqHNmgMA==
X-Google-Smtp-Source: ADUXVKITjeKTGQhVhAokHyvKUHBy8uXhD6S7X59yUw3oAdlM/3RkY1cn4Nx/w7HoiJ6F9oz1A5ZAwQ==
X-Received: by 2002:a62:d2c3:: with SMTP id c186-v6mr2768276pfg.44.1528396345695;
        Thu, 07 Jun 2018 11:32:25 -0700 (PDT)
Received: from ndesaulniers0.svl.corp.google.com ([2620:15c:2a3:1:d33:166f:5b79:14b3])
        by smtp.gmail.com with ESMTPSA id n76-v6sm6932739pfg.98.2018.06.07.11.32.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 11:32:24 -0700 (PDT)
From: Nick Desaulniers <ndesaulniers@google.com>
To: akpm@linux-foundation.org, hpa@zytor.com, mingo@redhat.com,
        tglx@linutronix.de
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
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
        mjg59@google.com, joe@perches.com
Subject: [PATCH v3 0/3] extern inline native_save_fl for paravirt
Date: Thu,  7 Jun 2018 11:32:16 -0700
Message-Id: <20180607183219.192973-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.17.1.1185.g55be947832-goog
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

Changes since v2:
  Take hpa's _ASM_ARG patch into the set in order to simplify cross
  32b/64b x86 assembly.  Apply Sedat's typo fix to commit message and
  sign off on it. Take Joe's sugguestion to simplify __inline__ and
  __inline. Add Arnd to list of folks who made helpful suggestions.

Changes since v1:
  Prefer gnu_inline function attribute instead of explicitly setting C
  standard compiler flag in problematic Makefiles. We should instead
  carefully evaluate if those Makefiles should be overwriting
  KBUILD_CFLAGS at all. Dropped the previous first two patches and added
  a new first patch.

H. Peter Anvin (1):
  x86/asm: add _ASM_ARG* constants for argument registers to <asm/asm.h>

Nick Desaulniers (2):
  compiler-gcc.h: add gnu_inline to all inline declarations
  x86: paravirt: make native_save_fl extern inline

 arch/x86/include/asm/asm.h      | 59 +++++++++++++++++++++++++++++++++
 arch/x86/include/asm/irqflags.h |  2 +-
 arch/x86/kernel/Makefile        |  1 +
 arch/x86/kernel/irqflags.S      | 26 +++++++++++++++
 include/linux/compiler-gcc.h    | 17 ++++++----
 5 files changed, 98 insertions(+), 7 deletions(-)
 create mode 100644 arch/x86/kernel/irqflags.S

-- 
2.17.1.1185.g55be947832-goog
