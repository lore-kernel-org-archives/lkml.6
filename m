Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E223CC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6A5222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550041643;
	bh=3+q+Tu+4VWfNrTHRGcJyKF/ED1ALh3pDG7z5p+hp0q8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=UzFECnUKpMxk2JE0zbb9HR2IFdwC4sVT3OolWXyB1RENw1y0hd3Xu82u5bs3LPK4C
	 4e60PZltD4evgta/KsNqaD0fiBc8c4vNTm3VJvy1rWoyTHhtONGO2WC5ezKAEwfKEK
	 jRfpyfrlP9hQY4MNtiYbkyWAYMHEM3p+h4RIPr6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732817AbfBMHHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:07:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:59690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726940AbfBMHHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:07:21 -0500
Received: from localhost.localdomain (unknown [125.119.100.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD9CE21904;
        Wed, 13 Feb 2019 07:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550041640;
        bh=3+q+Tu+4VWfNrTHRGcJyKF/ED1ALh3pDG7z5p+hp0q8=;
        h=From:To:Cc:Subject:Date:From;
        b=OhL3cGJW8i/9kLhZhEyBW4G4J0Qba3GudtUJecYKs1Mvoztsl9SXhsbJaND7DXub3
         In194bT1Eju389Xj/miVE6goRnTbDw+1/BzkWHGJHypvPBKPhtGhJf47NmKApMcLRN
         USn3ZFhpte0SAiTMLhMFD78YTcs2fyXLRy9AT23s=
From:   guoren@kernel.org
To:     torvalds@linux-foundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, ren_guo@c-sky.com
Subject: [GIT PULL V3] csky fixes for v5.0-rc6
Date:   Wed, 13 Feb 2019 15:07:08 +0800
Message-Id: <1550041628-19985-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is third version of pull-request from csky, we removed all patches of drivers.

Best Regards
 Guo Ren

The following changes since commit d13937116f1e82bf508a6325111b322c30c85eb9:

  Linux 5.0-rc6 (2019-02-10 14:42:20 -0800)

are available in the git repository at:

  git@github.com:c-sky/csky-linux.git tags/csky-for-linus-5.0-rc6

for you to fetch changes up to 131aee8b9807bc98379fa5a0270389dbc7dcec90:

  csky: Fixup dead loop in show_stack (2019-02-13 09:48:14 +0800)

----------------------------------------------------------------
arch/csky patches for 5.0-rc6

Here is some fixup patches for 5.0-rc6:

Guo Ren (5):
      csky: Fixup _PAGE_GLOBAL bit for 610 tlb entry
      csky: Fixup wrong pt_regs size
      csky: coding convention: Use task_stack_page
      csky: Fixup io-range page attribute for mmap("/dev/mem")
      csky: Fixup dead loop in show_stack

----------------------------------------------------------------
Guo Ren (5):
      csky: Fixup _PAGE_GLOBAL bit for 610 tlb entry
      csky: Fixup wrong pt_regs size
      csky: coding convention: Use task_stack_page
      csky: Fixup io-range page attribute for mmap("/dev/mem")
      csky: Fixup dead loop in show_stack

 arch/csky/include/asm/pgtable.h   |  9 +++++++--
 arch/csky/include/asm/processor.h |  4 ++--
 arch/csky/kernel/dumpstack.c      |  4 ++++
 arch/csky/kernel/ptrace.c         |  3 ++-
 arch/csky/kernel/smp.c            |  3 ++-
 arch/csky/mm/ioremap.c            | 14 ++++++++++++++
 6 files changed, 31 insertions(+), 6 deletions(-)
