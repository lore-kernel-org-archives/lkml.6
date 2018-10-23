Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CDEC67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 12:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C822120652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 12:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/eQuaBD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C822120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbeJWUwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 16:52:33 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51148 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727503AbeJWUwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 16:52:33 -0400
Received: by mail-wm1-f67.google.com with SMTP id i8-v6so1577857wmg.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 05:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=91W81f/SLym6NrkfFTvb+j+sbRNKUJIpCw9ZmAoLiEM=;
        b=Z/eQuaBDByKQ+Y7e2U3aoJUQyIlq71JVtD9FYZ1Z4nx/fvwRRjZ5IG+VtRRQwvwdTc
         7qWZM+qzNmH4A0SwVK0/a8pms7LYbEJ9prKvrxlgeWPIRPxjP8UrjbR9CGdXdG0wosla
         EpI+q+Tyo4uEnE8XCYb6EG9VqeqCL1fngggJ81QvuDMwakC70jb+MmmhU3PSBGVasB3c
         McRUdwvhbvqL3XpziTWRHNIlioon9Ah+z3GntEmGdu39IQgl4bNPwo/QCMfgzggbw8SE
         o3PEWaERwQt4mG/t66bDCQeAMsIjDeW0yuG3RpcLGksRvrP1FcjeueDZB48Fn0H9oK2/
         38eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=91W81f/SLym6NrkfFTvb+j+sbRNKUJIpCw9ZmAoLiEM=;
        b=I5vBwhRrqdyQQDk4pKJgia1JZvGnLzCDICyDKqB0pEdLF1hZxgStspVDirpCuY8Fr1
         DqKF96pUWo78my0p7hka0AXszejS9MXzrcUT918GiovhLMR1qPSYF5KNbN2yrzzljEzi
         dPbCz/QWVD0PoM+OiWXKPcvr4GXSXLciUDmrLKDCZH0sQaaOZMF45ae15e1RDFCHBvzO
         FSOO4TZw6X+9ZCA3n3AvP/7UEeeP7UnOQQZ3x6vyNAUARSw6uARyVRQB/3L2hkVQziFf
         8p9kmPLTGbhXyTpaBO6n0WnP42F9LDgzZOPcbg/YIFUV9NaM4I9E2Fr2s42KbZZK7dSG
         /I0w==
X-Gm-Message-State: ABuFfoiRfZna+o5kBDCueHYj5gnP9nzQ3Wqg3gIRBrjLJsnmmb4dDElW
        YehC8aeMC7nwiMAp0sz1V+I=
X-Google-Smtp-Source: ACcGV61MIHBvhtaxf25mlgPJdZ+wsYQnPs6szb1klubhDcVBqjp+DZ4jYSvvUVVk+1ZLoeCMg71Ijg==
X-Received: by 2002:a1c:845:: with SMTP id 66-v6mr21458607wmi.61.1540297754761;
        Tue, 23 Oct 2018 05:29:14 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id i13-v6sm1373484wrn.62.2018.10.23.05.29.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 05:29:14 -0700 (PDT)
Date:   Tue, 23 Oct 2018 14:29:11 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/pti changes for v4.20
Message-ID: <20181023122911.GA48335@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-pti-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-pti-for-linus

   # HEAD: bb4b3b7762735cdaba5a40fd94c9303d9ffa147a x86/speculation: Propagate information about RSB filling mitigation to sysfs

The main changes:

 - Make the IBPB barrier more strict and add STIBP support (Jiri Kosina)

 - Micro-optimize and clean up the entry code (Andy Lutomirski)

 - ... plus misc other fixes.

 Thanks,

	Ingo

  out-of-topic modifications in x86-pti-for-linus:
  --------------------------------------------------
  include/linux/ptrace.h             # dbfe2953f63c: x86/speculation: Apply IBPB 
  kernel/cpu.c                       # 53c613fe6349: x86/speculation: Enable cros
  kernel/ptrace.c                    # dbfe2953f63c: x86/speculation: Apply IBPB 

------------------>
Andy Lutomirski (3):
      x86/entry/64: Document idtentry
      x86/entry/64: Use the TSS sp2 slot for SYSCALL/SYSRET scratch space
      x86/pti/64: Remove the SYSCALL64 entry trampoline

Jiri Kosina (3):
      x86/speculation: Apply IBPB more strictly to avoid cross-process data leak
      x86/speculation: Enable cross-hyperthread spectre v2 STIBP mitigation
      x86/speculation: Propagate information about RSB filling mitigation to sysfs

Zhenzhong Duan (1):
      x86/speculation: Add RETPOLINE_AMD support to the inline asm CALL_NOSPEC variant

zhong jiang (1):
      x86/CPU: Fix unused variable warning when !CONFIG_IA32_EMULATION


 arch/x86/entry/entry_64.S             | 117 +++++++++++++---------------------
 arch/x86/include/asm/cpu_entry_area.h |   2 -
 arch/x86/include/asm/nospec-branch.h  |  17 +++--
 arch/x86/include/asm/processor.h      |   6 ++
 arch/x86/include/asm/sections.h       |   1 -
 arch/x86/kernel/asm-offsets.c         |   5 +-
 arch/x86/kernel/cpu/bugs.c            |  58 +++++++++++++++--
 arch/x86/kernel/cpu/common.c          |  16 +----
 arch/x86/kernel/kprobes/core.c        |  10 +--
 arch/x86/kernel/process_64.c          |   2 -
 arch/x86/kernel/traps.c               |   4 ++
 arch/x86/kernel/vmlinux.lds.S         |  10 ---
 arch/x86/mm/cpu_entry_area.c          |  36 -----------
 arch/x86/mm/pti.c                     |  33 +++++++++-
 arch/x86/mm/tlb.c                     |  31 +++++----
 arch/x86/xen/xen-asm_64.S             |   8 ++-
 include/linux/ptrace.h                |  21 +++++-
 kernel/cpu.c                          |  11 +++-
 kernel/ptrace.c                       |  10 +++
 19 files changed, 222 insertions(+), 176 deletions(-)

