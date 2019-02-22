Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22105C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F329D2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfBVSFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:05:02 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38146 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727510AbfBVSFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:05:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6FED15AB;
        Fri, 22 Feb 2019 10:04:59 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 32DC43F5C1;
        Fri, 22 Feb 2019 10:04:58 -0800 (PST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-arch@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andrew.murray@arm.com, arnd@arndb.de,
        catalin.marinas@arm.com, geert@linux-m68k.org, palmer@sifive.com,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 0/3] Ensure inX() is ordered wrt delay() routines
Date:   Fri, 22 Feb 2019 18:04:51 +0000
Message-Id: <20190222180454.5992-1-will.deacon@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is version two of the patches I previously posted here:

  https://lore.kernel.org/lkml/20190211174544.4302-1-will.deacon@arm.com/T/#u

Changes since v2 include:

  * Incorporate riscv changes from Palmer
  * Update macro definitions as suggested by Geert
  * Extend to cover non-port reads via __io_ar() as well

Feedback welcome,

Will

--->8

Will Deacon (3):
  asm-generic/io: Pass result of I/O accessor to __io_[p]ar()
  riscv: io: Update __io_[p]ar() macros to take an argument
  arm64: io: Hook up __io_par() for inX() ordering

 arch/arm64/include/asm/io.h |  1 +
 arch/riscv/include/asm/io.h | 36 ++++++++++++++++++------------------
 include/asm-generic/io.h    | 20 ++++++++++----------
 3 files changed, 29 insertions(+), 28 deletions(-)

-- 
2.11.0

