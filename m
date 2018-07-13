Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4377CECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E826B208A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:13:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E826B208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbeGMN1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 09:27:39 -0400
Received: from foss.arm.com ([217.140.101.70]:34960 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbeGMN1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 09:27:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93EF080D;
        Fri, 13 Jul 2018 06:13:02 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 664953F318;
        Fri, 13 Jul 2018 06:13:02 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 15AA61AE4D0E; Fri, 13 Jul 2018 14:13:45 +0100 (BST)
Date:   Fri, 13 Jul 2018 14:13:45 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 4.18-rc5
Message-ID: <20180713131344.GH32020@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Catalin's out enjoying the sunshine, so I'm sending the fixes for a couple
of weeks (although there hopefully won't be any more!). Summary is in the
tag, but we've got a revert of a previous fix because it broke the build
with some distro toolchains and a preemption fix when detemining whether
or not the SIMD unit is in use.

Please pull. Thanks,

Will

--->8

The following changes since commit 1e4b044d22517cae7047c99038abb444423243ca:

  Linux 4.18-rc4 (2018-07-08 16:34:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 2fd8eb4ad87104c54800ef3cea498c92eb15c78a:

  arm64: neon: Fix function may_use_simd() return error status (2018-07-11 17:02:02 +0100)

----------------------------------------------------------------
More arm64 fixes:

- Revert back to the 'linux' target for LD, as 'elf' breaks some distributions

- Fix preemption race when testing whether the vector unit is in use or not

----------------------------------------------------------------
Laura Abbott (1):
      Revert "arm64: Use aarch64elf and aarch64elfb emulation mode variants"

Yandong Zhao (1):
      arm64: neon: Fix function may_use_simd() return error status

 arch/arm64/Makefile           |  6 ++++--
 arch/arm64/include/asm/simd.h | 19 +++++++------------
 2 files changed, 11 insertions(+), 14 deletions(-)
