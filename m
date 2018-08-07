Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32661C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9A22172E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF9A22172E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389156AbeHGUaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 16:30:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:48548 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725881AbeHGUaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 16:30:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5C9D4ACCD;
        Tue,  7 Aug 2018 18:15:00 +0000 (UTC)
From:   Mian Yousaf Kaukab <ykaukab@suse.de>
To:     will.deacon@arm.com, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robert.richter@cavium.com, cwu@amperecomputing.com,
        Mian Yousaf Kaukab <ykaukab@suse.de>
Subject: [PATCH 0/6] arm64: add support for generic cpu vulnerabilities
Date:   Tue,  7 Aug 2018 20:14:13 +0200
Message-Id: <20180807181419.15690-1-ykaukab@suse.de>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GENERIC_CPU_VULNERABILITIES provide a common way to figure out if a
system is affected by vulnerabilities like meltdown and other variants
of spectre. This small series adds support for it in arm64.

Thank you,

Best regards,
Yousaf

Mian Yousaf Kaukab (6):
  arm64: kpti: move check for non-vulnerable CPUs to a function
  arm64: add sysfs vulnerability show for meltdown
  arm64: add sysfs vulnerability show for spectre v1
  arm64: add sysfs vulnerability show for spectre v2
  arm64: add sysfs vulnerability show for speculative store bypass
  arm64: enable generic CPU vulnerabilites support

 arch/arm64/Kconfig                  |  1 +
 arch/arm64/include/asm/cpufeature.h | 16 +++++++
 arch/arm64/kernel/cpu_errata.c      | 84 ++++++++++++++++++++++++++++++++++++-
 arch/arm64/kernel/cpufeature.c      |  9 +---
 4 files changed, 101 insertions(+), 9 deletions(-)

-- 
2.11.0

