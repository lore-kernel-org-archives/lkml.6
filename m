Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87655C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B8B2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B4UwTkHZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B8B2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbeH2AHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 20:07:54 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:51959 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbeH2AHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 20:07:54 -0400
Received: by mail-yw1-f73.google.com with SMTP id v14-v6so1236920ywv.18
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 13:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DP44jcAgzuzqx7PHBEa6TDm8OXgTeIVsp9I+xoY7/bI=;
        b=B4UwTkHZTkeDgTmI/PpAKAdNykiSnMgeZ3uKvfRjsi5EFarAXBLfDDEAJf+L9H56gP
         jyDOJ5QgmXUEs8C+uPejd+E/Qet4PKfA1BIMytlmnjaI6ieklWPMO6ifqtgHYG9DllYx
         DMKx056VxPH5f3f/AxXb1wSq5CuHYGPqhX6To6BOSvSSu1As52Sj4zqtmiFYskZQAEhP
         vpEUtMMcW3mirwTgWMxzT11Du4X9qpnEw+daas6oeCn341xK7rUPNYwI/K56HOdLnAXk
         FqLVGakW9YXy1jvkyWSi8kzH15fGN/Wz3Sa/ZVxukr5Sz8uON7inpUdtSfiCZlKmTg1M
         PnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DP44jcAgzuzqx7PHBEa6TDm8OXgTeIVsp9I+xoY7/bI=;
        b=a0EaU29KXOZDM8SPbmTUAhIxEDF/HOJKNjqMxa4txHeO+HC+o4FT6BRPPYq5q6EZ+x
         +wlIe6jig12xEEk4tjymNeDrQmbRNQXJ7gdzxa+xk56Bn5nZQgaj3KAjTGk94zckH6ae
         xFlB5WYzKKlDSClOl13Ny3IPnMe1W95B3L9oIILPBsEYte2MMg9WfkLyeVd8YgBpXuu2
         298L5WS457Pvc+RKrgcU5F1AMJdN2gBrRrbXZ6vxli6uFW/uaGBRmuhh/M7qiPTmu2UF
         fSycrizRbwSsdoxRTrW8AfNqgDqfWopDVZ6K0JroW1vYAWSCRJZAM6vIlNJrzyAvZStj
         T1yQ==
X-Gm-Message-State: APzg51BkkdVBIWxoWlXq3N8j8OaEnZXEECZDeLkcDATF7Y8LP9bJe3tU
        2dOeugTh766q+OlWHmCtdnrQMKIrVA==
X-Google-Smtp-Source: ANB0VdYRRKjW6Xy066i0t+5UAUY5Alw2DPai9CaTWVSNQtMc0GQLt2tszvXKov3cosPeKNZMSUEJpKYoXg==
X-Received: by 2002:a81:4401:: with SMTP id r1-v6mr908847ywa.85.1535487278839;
 Tue, 28 Aug 2018 13:14:38 -0700 (PDT)
Date:   Tue, 28 Aug 2018 22:14:14 +0200
Message-Id: <20180828201421.157735-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH v3 0/7] x86: BUG() on #GP / kernel #PF in uaccess
From:   Jann Horn <jannh@google.com>
To:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        kernel-hardening@lists.openwall.com, jannh@google.com
Cc:     linux-kernel@vger.kernel.org, dvyukov@google.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the third version of "[RFC PATCH 1/2] x86: WARN() when uaccess
helpers fault on kernel addresses".

Changes since v2:
 - patch 1: avoid unnecessary branch on return value and split up the
   checks (Borislav Petkov)
 - patch 5: really plumb the error code through to the handlers (Andy)
 - patch 6: whitelist exact_copy_from_user(), at least for now - the
   alternative would be a somewhat complicated refactor (Kees Cook)

Expanding on the change in patch 6:
I believe that for now, whitelisting exact_copy_from_user() is
acceptable, since there aren't many places that call ksys_mount() under
KERNEL_DS.
I very much dislike copy_mount_options()/exact_copy_from_user() and want
to do something about that code at some point - in particular because it
currently silently truncates mount options, which seems like a bad idea
security-wise
(https://github.com/libfuse/libfuse/commit/34c62ee90c69) -, but I don't
want to block this series on that.

I hope that exact_copy_from_user() was the only place that does this
kind of thing under KERNEL_DS - if there might be more places like this,
it may be necessary for now to change the "return true;" in
bogus_uaccess() to "WARN(1, ...); return false;" for now, and make it a
"return true" later. Does anyone have opinions on this?

This time I've actually also boot-tested a build with vmapped stack, not
just a KASAN build. (It's annoying that those are mutually exclusive...)
Kees, I hope you can cleanly boot with this series applied now?


See patch 6/7 ("x86: BUG() when uaccess helpers fault on kernel
addresses") for a description of the motivation for this series.

Patches 1 and 2 are cleanups that I did while working on this
series, but the series doesn't depend on them. (I first thought these
cleanups were necessary for the rest of the series, then noticed that
they actually aren't, but decided to keep them since cleanups are good
anyway.)

Patches 3, 4 and 5 are prep work; 4 and 5 are loosely based on code
from the v1 patch. They've changed quite a bit though.

Patch 6 is the main semantic change.

Patch 7 is a small testcase for verifying that patch 6 works.

Jann Horn (7):
  x86: refactor kprobes_fault() like kprobe_exceptions_notify()
  x86: inline kprobe_exceptions_notify() into do_general_protection()
  x86: stop calling fixup_exception() from kprobe_fault_handler()
  x86: introduce _ASM_EXTABLE_UA for uaccess fixups
  x86: plumb error code and fault address through to fault handlers
  x86: BUG() when uaccess helpers fault on kernel addresses
  lkdtm: test copy_to_user() on bad kernel pointer under KERNEL_DS

 arch/x86/include/asm/asm.h          |  10 ++-
 arch/x86/include/asm/extable.h      |   3 +-
 arch/x86/include/asm/fpu/internal.h |   2 +-
 arch/x86/include/asm/futex.h        |   6 +-
 arch/x86/include/asm/ptrace.h       |   2 +
 arch/x86/include/asm/uaccess.h      |  22 ++---
 arch/x86/kernel/cpu/mcheck/mce.c    |   2 +-
 arch/x86/kernel/kprobes/core.c      |  38 +--------
 arch/x86/kernel/traps.c             |  16 +++-
 arch/x86/lib/checksum_32.S          |   4 +-
 arch/x86/lib/copy_user_64.S         |  90 ++++++++++----------
 arch/x86/lib/csum-copy_64.S         |   8 +-
 arch/x86/lib/getuser.S              |  12 +--
 arch/x86/lib/putuser.S              |  10 +--
 arch/x86/lib/usercopy_32.c          | 126 ++++++++++++++--------------
 arch/x86/lib/usercopy_64.c          |   4 +-
 arch/x86/mm/extable.c               | 114 +++++++++++++++++++++----
 arch/x86/mm/fault.c                 |  26 +++---
 drivers/misc/lkdtm/core.c           |   1 +
 drivers/misc/lkdtm/lkdtm.h          |   1 +
 drivers/misc/lkdtm/usercopy.c       |  13 +++
 fs/namespace.c                      |   2 +
 include/linux/sched.h               |   6 ++
 mm/maccess.c                        |   6 ++
 24 files changed, 314 insertions(+), 210 deletions(-)

-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

