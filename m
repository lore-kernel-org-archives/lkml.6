Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5FBC282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0A92082F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549960240;
	bh=L0K06OoDz9rT7X1aeDERGP6HACg3dtMN+7qU4OVipc4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=G9NfmLlk4J0Gu4D72s2KZP3uh1VIkm2XS7GkAAYKxD7qe8WnHh3wivB/OVUer26F7
	 sDMpzFbWTl1WJjJk7DgXM3LuJdXWcscHWACIRME3Xdww33I/ZMqCmqJgWRgjmkKodA
	 RthljuDobW/uLgyM/uN9goiMR3OienzKrNhhIhwQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbfBLIae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:30:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:34662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728274AbfBLIad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:30:33 -0500
Received: from localhost.localdomain (unknown [122.234.59.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED4742082F;
        Tue, 12 Feb 2019 08:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549960232;
        bh=L0K06OoDz9rT7X1aeDERGP6HACg3dtMN+7qU4OVipc4=;
        h=From:To:Cc:Subject:Date:From;
        b=UM8MTLVFvsghyW4el53LgD3wvf8uXVAyPCAiYCZxnHDlCt0gcJ/HRNrVdbOHQ7zIh
         0/EhakmZPVvhjIJmtLLRENUsPWb7I+9szlJFDQTpb9CrU1YRVU/HE9//fB0mGBS6Am
         Csn050QoImbcxN4+XF6tN1AKePNxyMB1e8gEVU3A=
From:   guoren@kernel.org
To:     torvalds@linux-foundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, ren_guo@c-sky.com
Subject: [GIT PULL V2] csky fixes for v5.0-rc6
Date:   Tue, 12 Feb 2019 16:30:25 +0800
Message-Id: <1549960225-23253-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d13937116f1e82bf508a6325111b322c30c85eb9:

  Linux 5.0-rc6 (2019-02-10 14:42:20 -0800)

are available in the git repository at:

  git@github.com:c-sky/csky-linux.git tags/csky-for-linus-5.0-rc6

for you to fetch changes up to 749e649084d0acb8c5d28c0ec502d9cc023bff86:

  csky: Fixup dead loop in show_stack (2019-02-12 10:25:37 +0800)

----------------------------------------------------------------
arch/csky patches for 5.0-rc6

Here is some fixup patches for 5.0-rc6:

Guo Ren (10):
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
Guo Ren (10):
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

 .../interrupt-controller/csky,apb-intc.txt         |   3 +
 .../bindings/interrupt-controller/csky,mpintc.txt  |  21 +++-
 arch/csky/include/asm/pgtable.h                    |   9 +-
 arch/csky/include/asm/processor.h                  |   4 +-
 arch/csky/kernel/dumpstack.c                       |   4 +
 arch/csky/kernel/ptrace.c                          |   3 +-
 arch/csky/kernel/smp.c                             |   3 +-
 arch/csky/mm/ioremap.c                             |  14 +++
 drivers/irqchip/irq-csky-apb-intc.c                |  59 +++++++----
 drivers/irqchip/irq-csky-mpintc.c                  | 113 +++++++++++++++++++--
 10 files changed, 196 insertions(+), 37 deletions(-)
