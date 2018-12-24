Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D19C64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 23:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E2A21773
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 23:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545693075;
	bh=KEA1MEdm1HVN+LPPDnEgUToBmi58kfNg1vRFLcE8Iig=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=cpQSZBr+SfwzWijFzGOmZskdpu/ckpMDzjaLGCIXaXO3byP+FVv/8MnGGHrN1tEST
	 SfPobPC6+d2gQLW0p2JiBX1rwielZlXcF4rWAbP5/u21YOUIdITz9QdMWymotU2YUb
	 j269CsHO7BZAUeC5zRcUV9kw/e4Z9RCndn+4W+TM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbeLXXLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 18:11:13 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33163 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeLXXLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 18:11:13 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so12648160wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 15:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/sfGGjTj7IDRaxMRuRgTGdU71sTXgJkYHXlgHR8PPEU=;
        b=JTyQnteYxnDpO68OMWTG/riK33IzbobJYDyf6Agwnyz9sIZ/8Fx19Ow9TC4+7ypYDa
         Ho41hNc9mbETdfMCN7NsADLH0xyooIrsotKqbGeYehuIxMX0TrTPsDXQLKK9hukYxZlJ
         BD60sw3VeCqTQCXBp3wgFcaa4/Jw/4+9qNdnUQrtIUUoE2yDNd+slz8gJaZSuvVsenpu
         c/FXgft9vwgGBY5AzQABOnDR9qnSb1oDKnb6aJQXRT+brTh+LZ4AQTePKGc04GMBnlw8
         lnlQlhkpZ4RoeZN1yGKuVHv/RSmjvflM5Fo1oxmIuMWipAZfakJslBPdqKStBjMZUrc4
         nh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=/sfGGjTj7IDRaxMRuRgTGdU71sTXgJkYHXlgHR8PPEU=;
        b=ibaPGzx4WiDIGAPrC2uj4uyFRlpIANwKcS9Hlt1CCa12jw0S+AXTJPcHuRc1LmOATQ
         xaslEoSyE1pEfroxkd/orlB6Ij15W/Afw+tb1NbJ4z62Ad99EFao+bacNH7yQHydh2rE
         Cw3QblHa49yvlmPHdPotUMlgGz0mLI9UzUKLxzcgcHIDV46p/sf6c/I4eqvwxS5mPvTR
         CWScsnB+0GL1cB0yjX7wCEKemXh9KMX+bE5i4BGJ1iBGclVh9fUoFKQcn7w7IBK0YCCS
         DSRV+3iM7HTDIz8HeKcyBvBP3c+oXdUoVQaj6Lg9RXHmZ28Yi8BiWOIqz+A/1PQZO1QQ
         1NqQ==
X-Gm-Message-State: AJcUukeRXFHSLwkztA5vMBVFyLsOSWXdo6dh1muLdCXEOH2JTsra2HUr
        g17N+5QNf7OygNUbPk/I47I=
X-Google-Smtp-Source: ALg8bN4xrr/tCWswbnXUgycekB2gwwPXW9Ihqwdvaq5CcF/Mmkd0xhqshd2KeKERwCUqj9oQt0tFAw==
X-Received: by 2002:a5d:4fcb:: with SMTP id h11mr9351043wrw.139.1545693069757;
        Mon, 24 Dec 2018 15:11:09 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id p5sm13653267wmh.16.2018.12.24.15.11.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Dec 2018 15:11:08 -0800 (PST)
Date:   Tue, 25 Dec 2018 00:11:06 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rik van Riel <riel@surriel.com>
Subject: [GIT PULL] x86/mm changes for v4.21
Message-ID: <20181224231106.GA27438@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-mm-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-for-linus

   # HEAD: 6848ac7ca39a226ede5df7af0efcc4ef0611e99c x86/mm/dump_pagetables: Use DEFINE_SHOW_ATTRIBUTE()

The main changes in this cycle were:

 - Update and clean up x86 fault handling, by Andy Lutomirski.

 - Drop usage of __flush_tlb_all() in kernel_physical_mapping_init() and 
   related fallout, by Dan Williams.

 - CPA cleanups and reorganization by Peter Zijlstra: simplify the flow 
   and remove a few warts.

 - Other misc cleanups.

  out-of-topic modifications in x86-mm-for-linus:
  -------------------------------------------------
  include/asm-generic/5level-fixup.h # 0a9fe8ca844d: x86/mm: Validate kernel_phys
  include/asm-generic/pgtable-nop4d-hack.h# 0a9fe8ca844d: x86/mm: Validate kernel_phys
  include/asm-generic/pgtable-nop4d.h# 0a9fe8ca844d: x86/mm: Validate kernel_phys
  include/asm-generic/pgtable-nopud.h# 0a9fe8ca844d: x86/mm: Validate kernel_phys
  include/asm-generic/pgtable.h      # 4369deaa2f02: generic/pgtable: Introduce s
                                   # 0cebbb60f759: generic/pgtable: Introduce {
                                   # c683c37cd132: generic/pgtable: Make {pmd, 

 Thanks,

	Ingo

------------------>
Andy Lutomirski (12):
      x86/fault: Check user_mode(regs) when avoiding an mmap_sem deadlock
      x86/cpufeatures, x86/fault: Mark SMAP as disabled when configured out
      x86/fault: Fold smap_violation() into do_user_addr_fault()
      x86/fault: Fix SMAP #PF handling buglet for implicit supervisor accesses
      x86/fault: Improve the condition for signalling vs OOPSing
      x86/fault: Make error_code sanitization more robust
      x86/fault: Don't set thread.cr2, etc before OOPSing
      x86/fault: Remove sw_error_code
      x86/fault: Don't try to recover from an implicit supervisor access
      x86/oops: Show the correct CS value in show_regs()
      x86/vsyscall/64: Use X86_PF constants in the simulated #PF error code
      x86/fault: Decode page fault OOPSes better

Dan Williams (5):
      generic/pgtable: Make {pmd, pud}_same() unconditionally available
      generic/pgtable: Introduce {p4d,pgd}_same()
      generic/pgtable: Introduce set_pte_safe()
      x86/mm: Validate kernel_physical_mapping_init() PTE population
      x86/mm: Drop usage of __flush_tlb_all() in kernel_physical_mapping_init()

Ingo Molnar (1):
      x86/fault: Clean up the page fault oops decoder a bit

Peter Zijlstra (9):
      x86/mm/cpa: Add ARRAY and PAGES_ARRAY selftests
      x86/mm/cpa: Add __cpa_addr() helper
      x86/mm/cpa: Make cpa_data::vaddr invariant
      x86/mm/cpa: Simplify the code after making cpa->vaddr invariant
      x86/mm/cpa: Optimize cpa_flush_array() TLB invalidation
      x86/mm/cpa: Make cpa_data::numpages invariant
      x86/mm/cpa: Fold cpa_flush_range() and cpa_flush_array() into a single cpa_flush() function
      x86/mm/cpa: Better use CLFLUSHOPT
      x86/mm/cpa: Rename @addrinarray to @numpages

Waiman Long (1):
      x86/mm/fault: Allow stack access below %rsp

Yangtao Li (1):
      x86/mm/dump_pagetables: Use DEFINE_SHOW_ATTRIBUTE()


 arch/x86/entry/vsyscall/vsyscall_64.c    |   2 +-
 arch/x86/include/asm/disabled-features.h |   8 +-
 arch/x86/include/asm/pgalloc.h           |  27 +++
 arch/x86/kernel/process_64.c             |   5 +-
 arch/x86/mm/debug_pagetables.c           |  58 +------
 arch/x86/mm/fault.c                      | 244 +++++++++++++++++-----------
 arch/x86/mm/init_64.c                    |  30 ++--
 arch/x86/mm/mm_internal.h                |   2 +
 arch/x86/mm/pageattr-test.c              |  31 +++-
 arch/x86/mm/pageattr.c                   | 271 +++++++++++++------------------
 arch/x86/mm/tlb.c                        |   4 +-
 include/asm-generic/5level-fixup.h       |   1 +
 include/asm-generic/pgtable-nop4d-hack.h |   1 +
 include/asm-generic/pgtable-nop4d.h      |   1 +
 include/asm-generic/pgtable-nopud.h      |   1 +
 include/asm-generic/pgtable.h            |  56 ++++++-
 16 files changed, 396 insertions(+), 346 deletions(-)

