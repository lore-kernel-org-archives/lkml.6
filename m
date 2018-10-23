Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D535CC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789B62075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eamLta3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 789B62075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbeJWTiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 15:38:06 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40236 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeJWTiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 15:38:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id b203-v6so1344706wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 04:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=fUiPn4dPwl3opyNTUO6CIPAnA4Do3UK5isbOHbqBsmw=;
        b=eamLta3DT+bK6zFzrpC+4az/uq3vjdDjNHVYBnIsmOnZaafuBvyBUMTKVDYbwMQ7bZ
         bOUJmbYJ6wL9jFWaPcXdzgHngHZnqJHDOE/9yN7fsA9XUIRm5LMEbJTGkVEhcQlRGVZz
         EOTTLMh0Kh9Y/TrRdwlT4Rh5nV9OEBiRpKsK7S93tWnsJJwziYMDf1Usmx6ZCN2Cs7v9
         J0ytvhAY3/h/qFIWKkP3sb9tKk660W38fprRkX4PQfts/Hy+r6fYoR2f/xlm7o5Ejs1V
         3DN+VWU5yjnWVAY94SEfadaRFSn0YIYhHiXPbhZFOiPGapUIHAyebj5/jFk8pBJIrcTI
         GxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=fUiPn4dPwl3opyNTUO6CIPAnA4Do3UK5isbOHbqBsmw=;
        b=Fq7tMLmh2zBJZPod6aR/7BQ5Hda0c69CT45qDrC1g1eFx1CwYzHND4xUpHEIHiDjlJ
         ZF1XR/QvTYuuWFiudjDC11c9BqZlFVsZFQvkYOxbtNpE49dPTHNYVwiJUiGVR9ByT0dx
         u5osQ0yYR/N3Q4uVCASzTwUQiljnra3ZdWLYrgz/MFrrPwjigc4qpXrjjSe9hl58Oa9+
         ROBSA6lSiBR+DXu7vtBBQEoCPtpFqFJ/xqgJXHwiSabGZeEXzyKtmW6Cauj6t1lWs8nB
         9ZwhIIrPjC9illGPvSt6Rkq/UxfCn+aseHWW7o1+uc4pCaPd7Jk0pvSYxhGj4efcjlTE
         p8lA==
X-Gm-Message-State: AGRZ1gIq9jKkfAYC+nLCg6c1qcCS+ZyWbBi+SyFZU7qdmJbnCjx8XLCY
        iNzeBP2GIm/jjYggo1BdV30=
X-Google-Smtp-Source: AJdET5cmse27v1Dks5bpGa+qwjinPEFXjCOAJ9OJXHbZ6FjKJ9qfcJoeokmjQ1GBqtoMzyv58Ft2uQ==
X-Received: by 2002:a1c:824b:: with SMTP id e72-v6mr19966135wmd.92.1540293303931;
        Tue, 23 Oct 2018 04:15:03 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id o13sm1016857wrx.53.2018.10.23.04.15.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 04:15:03 -0700 (PDT)
Date:   Tue, 23 Oct 2018 13:15:01 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/asm changes for v4.20
Message-ID: <20181023111501.GA114423@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-asm-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-for-linus

   # HEAD: ec3a94188df7d28b374868d9a2a0face910e62ab x86/fsgsbase/64: Clean up various details

The main changes in this cycle were the fsgsbase related preparatory 
patches from Chang S. Bae - but there's also an optimized 
memcpy_flushcache() and a cleanup for the __cmpxchg_double() assembly 
glue.

 Thanks,

	Ingo

------------------>
Andy Lutomirski (1):
      x86/fsgsbase/64: Fix ptrace() to read the FS/GS base accurately

Chang S. Bae (7):
      x86/fsgsbase/64: Introduce FS/GS base helper functions
      x86/fsgsbase/64: Make ptrace use the new FS/GS base helpers
      x86/fsgsbase/64: Convert the ELF core dump code to the new FSGSBASE helpers
      x86/fsgsbase/64: Factor out FS/GS segment loading from __switch_to()
      x86/segments/64: Rename the GDT PER_CPU entry to CPU_NUMBER
      x86/vdso: Introduce helper functions for CPU and node number
      x86/vdso: Initialize the CPU/node NR segment descriptor earlier

Ingo Molnar (2):
      x86/segments: Introduce the 'CPUNODE' naming to better document the segment limit CPU/node NR trick
      x86/fsgsbase/64: Clean up various details

Mikulas Patocka (1):
      x86/asm: Optimize memcpy_flushcache()

Uros Bizjak (1):
      x86/asm: Use CC_SET()/CC_OUT() in __cmpxchg_double()


 arch/x86/entry/vdso/vgetcpu.c    |   8 +-
 arch/x86/entry/vdso/vma.c        |  38 +-------
 arch/x86/include/asm/cmpxchg.h   |  10 ++-
 arch/x86/include/asm/elf.h       |   6 +-
 arch/x86/include/asm/fsgsbase.h  |  49 +++++++++++
 arch/x86/include/asm/segment.h   |  46 +++++++++-
 arch/x86/include/asm/string_64.h |  20 ++++-
 arch/x86/include/asm/vgtod.h     |  26 ------
 arch/x86/kernel/cpu/common.c     |  24 +++++
 arch/x86/kernel/process_64.c     | 183 ++++++++++++++++++++++++++++++---------
 arch/x86/kernel/ptrace.c         |  28 ++----
 arch/x86/lib/usercopy_64.c       |   4 +-
 12 files changed, 299 insertions(+), 143 deletions(-)
 create mode 100644 arch/x86/include/asm/fsgsbase.h

