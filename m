Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D65C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F36208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GHJyePU/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F36208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbeH0Wpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:45:40 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:41385 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbeH0Wpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:45:40 -0400
Received: by mail-vk0-f73.google.com with SMTP id d189-v6so7824vka.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CrPdBBcwk99epHml2S6cYfO/WlQ+fyiLt/9ijCXrSp8=;
        b=GHJyePU/W1cgX7K2kXjdOhpfYW0kXt0IJEE3ZIzKjlx9TKdTonrWPqQa6wWXNYngRu
         OL7yTaMGxh9Rfe7RaBMnaWaWVz+nny17tAZzSvSza55SElPCcfSHaebSpOAigGU1R8MU
         1UpdJsp4VRacTgFNGyqmZL7VmyQ3C53eYFHyPuD8pktVOw+uQLI5OBzxFlMjiBynpOEu
         QNG8Ewr0bF5sHY5MfXDPskvd6pBXu+uP45K5mlWilQCMu3V+GY/vm6ZS83BIeGYAW6XG
         tj3scn3OpQbT8M+L27H/r9LiA8jwknDZEHFpWShd9WBdVSiPu7+N+dETyn9mZOav9aD5
         PGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CrPdBBcwk99epHml2S6cYfO/WlQ+fyiLt/9ijCXrSp8=;
        b=cG1WZGi3i59HMABQA0nmEMhz/lxAK+u75RuqvrzeY65aKE2208eUk8kF+WWvf5urNB
         tE0uNpAApBpCfRsgsO9qRwPIzU5pPGGYvfVA4NVQ/aGJb7SBzAvq92mrRwcd8KKaP55L
         lc/l/iCuRIMUcOxNsiM87zWNoMuIZtK5qD+bUMOV4uDNbIPzIYkKZH4iCcoTZ2oBJc69
         VlvNz3qWF8QWDLpn9msGmIBAiv4bytOBoO5XbkoumP8H7XHZycRzgwGFLam2OJNbMXqR
         lXid5X+OhSyPN0TychU43bkl7eowmItthNiUATYyDEtp4SPYOUGCqO4XfdQgblLEK8s/
         zqKQ==
X-Gm-Message-State: APzg51AHVSdXZIJ0Aa/LyJRdqb6cwQ9IwgJxUN5e7yyTRLP89Vd00DQ9
        9YrRcIhTYMw2VAqz/rXUztSQbr1Bag==
X-Google-Smtp-Source: ANB0VdZffx48GvmurdIBDcdVHjoRie0ANsXOY3r4p+c5X7C02zbGBbhD/QMB/ZzLfqPcB8MDPotDhhiwvA==
X-Received: by 2002:a9f:3812:: with SMTP id p18-v6mr7493785uad.103.1535396270277;
 Mon, 27 Aug 2018 11:57:50 -0700 (PDT)
Date:   Mon, 27 Aug 2018 20:56:24 +0200
Message-Id: <20180827185631.163506-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH v2 0/7] x86: BUG() on #GP / kernel #PF in uaccess
From:   Jann Horn <jannh@google.com>
To:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        kernel-hardening@lists.openwall.com,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, jannh@google.com
Cc:     linux-kernel@vger.kernel.org, dvyukov@google.com,
        linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second version of "[RFC PATCH 1/2] x86: WARN() when uaccess
helpers fault on kernel addresses".

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
 arch/x86/mm/extable.c               | 104 +++++++++++++++++++----
 arch/x86/mm/fault.c                 |  21 ++---
 drivers/misc/lkdtm/core.c           |   1 +
 drivers/misc/lkdtm/lkdtm.h          |   1 +
 drivers/misc/lkdtm/usercopy.c       |  13 +++
 include/linux/sched.h               |   6 ++
 mm/maccess.c                        |   6 ++
 23 files changed, 297 insertions(+), 210 deletions(-)

-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

