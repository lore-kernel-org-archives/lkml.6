Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0271C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 05:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D8B20873
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 05:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549861716;
	bh=XBP0XEbmdzDEtxcs/VJsypaPlzs7Rb2d5EvDFk8j6pM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=oPfhDB9R32t8tCukI4mro96UfUi3UU2434zK/1fz+pa7bQrMnKHYBjkocBInPRRCC
	 aGu1HmXx/2LDMu6LJbNMKuB1d30Nq8NJ/W9XRgTvb/Ek3UbILR9MxoXS4pFHXFbFmQ
	 aEtE4/dLMk1LE1aq6t8ZNa0Vm7feF1aYQ1Y62Hm0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbfBKFIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 00:08:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:34884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfBKFIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 00:08:31 -0500
Received: from localhost.localdomain (unknown [122.234.59.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06D5B20873;
        Mon, 11 Feb 2019 05:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549861711;
        bh=XBP0XEbmdzDEtxcs/VJsypaPlzs7Rb2d5EvDFk8j6pM=;
        h=From:To:Cc:Subject:Date:From;
        b=DW+8wL3C/7C1VpfSRK6ejxiWbEjwThEcCFfGmtx5qWyVAyl7NIQSMxAMmJEVAPQhL
         h13NyQ6DYTE5TBcCFd93aapTV2hL0pc85BB9OAJqk8inYiadGZy2cNDeJ9gu9bhfTC
         TYVLzhSx6u6r+mwEWnW8q+DgvDZ1Ffbdai3u003U=
From:   guoren@kernel.org
To:     torvalds@linux-foundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, ren_guo@c-sky.com
Subject: [GIT PULL] csky fixes for v5.0-rc6
Date:   Mon, 11 Feb 2019 13:08:19 +0800
Message-Id: <1549861699-11875-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d13937116f1e82bf508a6325111b322c30c85eb9:

  Linux 5.0-rc6 (2019-02-10 14:42:20 -0800)

are available in the git repository at:

  git@github.com:c-sky/csky-linux.git tags/csky-for-linus-5.0-rc6

for you to fetch changes up to 757dc82a87669b1967faf89c6586c20a9aea2f6b:

  csky: Fixup dead loop in show_stack (2019-02-11 10:47:27 +0800)

----------------------------------------------------------------
arch/csky patches for 5.0-rc6

Here is some fixup patches for 5.0-rc6:

Guo Ren (12):
      irqchip/csky: Support csky,dh7k SOC intc driver
      dt-bindings: csky,apb-intc: Add dh7k SOC support
      csky: Fixup _PAGE_GLOBAL bit for 610 tlb entry
      irqchip/csky: Optimize remove unnecessary loop irq handle
      irqchip/irq-csky-mpintc: Add triger type and priority
      dt-bindings: interrupt-controller: Update csky mpintc
      csky: Fixup wrong pt_regs size
      csky: coding convention: Use task_stack_page
      dt-bindings: csky,apb-intc: Add vector irq mode
      irqchip/csky: Add support-vector-irq for apb-intc
      csky: Fixup io-range page attribute for mmap("/dev/mem")
      csky: Fixup dead loop in show_stack

Signed-off-by: Guo Ren <ren_guo@c-sky.com>

----------------------------------------------------------------
Guo Ren (12):
      irqchip/csky: Support csky,dh7k SOC intc driver
      dt-bindings: csky,apb-intc: Add dh7k SOC support
      csky: Fixup _PAGE_GLOBAL bit for 610 tlb entry
      irqchip/csky: Optimize remove unnecessary loop irq handle
      irqchip/irq-csky-mpintc: Add triger type and priority
      dt-bindings: interrupt-controller: Update csky mpintc
      csky: Fixup wrong pt_regs size
      csky: coding convention: Use task_stack_page
      dt-bindings: csky,apb-intc: Add vector irq mode
      irqchip/csky: Add support-vector-irq for apb-intc
      csky: Fixup io-range page attribute for mmap("/dev/mem")
      csky: Fixup dead loop in show_stack

 .../interrupt-controller/csky,apb-intc.txt         |   4 +
 .../bindings/interrupt-controller/csky,mpintc.txt  |  21 ++-
 arch/csky/include/asm/pgtable.h                    |   9 +-
 arch/csky/include/asm/processor.h                  |   4 +-
 arch/csky/kernel/dumpstack.c                       |   4 +
 arch/csky/kernel/ptrace.c                          |   3 +-
 arch/csky/kernel/smp.c                             |   3 +-
 arch/csky/mm/ioremap.c                             |  14 ++
 drivers/irqchip/irq-csky-apb-intc.c                | 151 +++++++++++++++++----
 drivers/irqchip/irq-csky-mpintc.c                  | 113 ++++++++++++++-
 10 files changed, 279 insertions(+), 47 deletions(-)
