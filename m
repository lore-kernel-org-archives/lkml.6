Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08DFC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4F720834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C4F720834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbeLAGFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:05:14 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34902 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbeLAGFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 01:05:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E271C165C;
        Fri, 30 Nov 2018 10:55:00 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D326D3F575;
        Fri, 30 Nov 2018 10:54:59 -0800 (PST)
Date:   Fri, 30 Nov 2018 18:54:57 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 4.20-rc5
Message-ID: <20181130185455.GA24239@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit 2e6e902d185027f8e3cb8b7305238f7e35d6a436:

  Linux 4.20-rc4 (2018-11-25 14:19:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to ea2412dc21cc790335d319181dddc43682aef164:

  ACPI/IORT: Fix iort_get_platform_device_domain() uninitialized pointer value (2018-11-30 17:28:39 +0000)

----------------------------------------------------------------
- Cortex-A76 erratum workaround

- ftrace fix to enable syscall events on arm64

- Fix uninitialised pointer in iort_get_platform_device_domain()

----------------------------------------------------------------
Catalin Marinas (1):
      arm64: Add workaround for Cortex-A76 erratum 1286807

Lorenzo Pieralisi (1):
      ACPI/IORT: Fix iort_get_platform_device_domain() uninitialized pointer value

Masami Hiramatsu (1):
      arm64: ftrace: Fix to enable syscall events on arm64

 Documentation/arm64/silicon-errata.txt |  1 +
 arch/arm64/Kconfig                     | 25 +++++++++++++++++++++++++
 arch/arm64/include/asm/ftrace.h        | 13 +++++++++++++
 arch/arm64/include/asm/tlbflush.h      |  4 ++--
 arch/arm64/kernel/cpu_errata.c         | 20 +++++++++++++++++---
 drivers/acpi/arm64/iort.c              |  2 +-
 6 files changed, 59 insertions(+), 6 deletions(-)

-- 
Catalin
