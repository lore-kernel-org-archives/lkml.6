Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FA2C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A0B21470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A0B21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbeJDPZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:25:35 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60380 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727046AbeJDPZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:25:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 590FF80D;
        Thu,  4 Oct 2018 01:33:27 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BBEF83F5A0;
        Thu,  4 Oct 2018 01:33:25 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, mark.rutland@arm.com, suzuki.poulose@arm.com,
        pelcan@codeaurora.org, shankerd@codeaurora.org
Subject: [PATCH 0/3] arm64: cpufeature: Fix handling of CTR_EL0
Date:   Thu,  4 Oct 2018 09:33:12 +0100
Message-Id: <20181004083315.31174-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series makes sure that we handle the CTR_EL0 field mismatches
properly, especially for the IDC field. Also, skip trapping CTR
accesses on a CPU if it matches the safe value.

Applies on arm64 for-next/core

Suzuki K Poulose (3):
  arm64: cpufeature: ctr: Fix cpu capability check for late CPUs
  arm64: cpufeature: Fix handling of CTR_EL0.IDC field
  arm64: cpufeature: Trap CTR_EL0 access only where it is necessary

 arch/arm64/include/asm/cache.h | 40 ++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/cpu_errata.c | 17 ++++++++++++---
 arch/arm64/kernel/cpufeature.c | 35 +++++++++++++++++++++++++----
 arch/arm64/kernel/cpuinfo.c    | 10 ++++++++-
 4 files changed, 94 insertions(+), 8 deletions(-)

-- 
2.19.0

