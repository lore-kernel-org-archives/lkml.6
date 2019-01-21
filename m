Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FB7C282DE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B1820989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BG7Xzotr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbfAUHfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:35:17 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:37830 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728476AbfAUHfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:35:15 -0500
Received: from mailhost.synopsys.com (dc2-mailhost.synopsys.com [10.12.135.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 259FA10C0AC3;
        Sun, 20 Jan 2019 16:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548030472; bh=wXfNAq2KCPBfTxmQY2PhAPmT4Q2wMBxshHfR59RZ08s=;
        h=To:CC:From:Subject:Date:From;
        b=BG7XzotrduAaonklJGFjaElleP1RQPwJEf8zfQBLlHBAjbhT2FqsPyAWASTiF5GuT
         UiNxzOnjIqgAqWuHabC6EHcBF2iuekN4Bucuni21VzayJA7P5Mc/QMsUaxTqQWt+vO
         MulIHpT+h5uSMdJB8ZdraQypRDYDBiOBSAcMKtgyCWhi8HhcETLou4CXem/Seif4VX
         XZnue59d5Eqmm2xcbMzAi+7tmEm3Vsgg1HAhxpDjJyS1m0m8APyHgVDL4n3pQcA/i6
         HfyL/u7s5bnPAxF/P+4Fv3ocZ7U9uL27/0aD1qTL7sNJSVW2uc41uhxW3S+9lWrAF4
         UsRNqQQH4qxFg==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 8D55FA008B;
        Mon, 21 Jan 2019 00:27:44 +0000 (UTC)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.106) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Sun, 20 Jan 2019 16:26:44 -0800
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.103) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.105) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 21 Jan 2019 05:56:45 +0530
Received: from [10.12.196.21] (10.12.196.21) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 21 Jan 2019 05:56:44 +0530
X-Mozilla-News-Host: news://gmane.comp.lib.uclibc.buildroot:119
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
Subject: [GIT PULL] ARC updates for 5.0-rc3
Openpgp: preference=signencrypt
Autocrypt: addr=vgupta@synopsys.com; keydata=
 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
 hhqBJlyU6MVUa6vZNv8E
Message-ID: <0bc45ec8-3470-917b-fff6-6ddffafeda98@synopsys.com>
Date:   Sun, 20 Jan 2019 16:26:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.12.196.21]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

ARC updates for 5.0-rc3 (or rc4, it is likely too late for sunday)

Please pull !

Thx,
-Vineet
------------------------------->
The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.0-rc3

for you to fetch changes up to e6a72b7daeeb521753803550f0ed711152bb2555:

  ARCv2: lib: memeset: fix doing prefetchw outside of buffer (2019-01-17 16:24:39
-0800)

----------------------------------------------------------------
ARC updates for 5.0-rc3

 - Perf support for raw events

 - boot log printing: return stack, action points

 - fix memset to avoid prefetchw bleeding past end of buffer

 - do_page_fault fix for mmap_sem held while returning to userspace

 - other miscll fixes

----------------------------------------------------------------
Eugeniy Paltsev (8):
      ARC: fix __ffs return value to avoid build warnings
      ARC: adjust memblock_reserve of kernel memory
      ARC: perf: map generic branches to correct hardware condition
      ARC: perf: trivial code cleanup
      ARC: perf: introduce Kernel PMU events support
      ARC: perf: move HW events mapping to separate function
      ARC: perf: avoid kernel killing where it is possible
      ARCv2: lib: memeset: fix doing prefetchw outside of buffer

Masahiro Yamada (1):
      arc: remove redundant kernel-space generic-y

Vineet Gupta (5):
      ARCv2: boot log: BPU return stack depth
      ARC: boot log: print Action point details
      ARC: show_regs: lockdep: avoid page allocator...
      ARC: show_regs: lockdep: re-enable preemption
      ARC: mm: do_page_fault fixes #1: relinquish mmap_sem if signal arrives while
handle_mm_fault

 arch/arc/include/asm/Kbuild       |   4 -
 arch/arc/include/asm/arcregs.h    |  12 +-
 arch/arc/include/asm/bitops.h     |   6 +-
 arch/arc/include/asm/perf_event.h |   3 +-
 arch/arc/kernel/perf_event.c      | 241 ++++++++++++++++++++++++++++----------
 arch/arc/kernel/setup.c           |  27 +++--
 arch/arc/kernel/troubleshoot.c    |  30 +++--
 arch/arc/lib/memset-archs.S       |  40 +++++--
 arch/arc/mm/fault.c               |  13 +-
 arch/arc/mm/init.c                |   3 +-
 10 files changed, 276 insertions(+), 103 deletions(-)
