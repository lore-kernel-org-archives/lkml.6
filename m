Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A23C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1CA22577F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:54:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1CA22577F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964868AbeFYRyL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:54:11 -0400
Received: from foss.arm.com ([217.140.101.70]:35020 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755509AbeFYRyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:54:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B79080D;
        Mon, 25 Jun 2018 10:54:09 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E12C93F5AD;
        Mon, 25 Jun 2018 10:54:08 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 473FE1AE2DA5; Mon, 25 Jun 2018 18:54:46 +0100 (BST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        mathieu.desnoyers@efficios.com, peterz@infradead.org,
        paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com,
        catalin.marinas@arm.com, peter.maydell@linaro.org,
        mark.rutland@arm.com, Will Deacon <will.deacon@arm.com>
Subject: [PATCH 0/3] Support rseq on arm64
Date:   Mon, 25 Jun 2018 18:54:42 +0100
Message-Id: <1529949285-11013-1-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch wires up rseq for native and compat tasks under arm64. Both
have been tested with the selftests and they pass successfully on my Seattle
box.

Cheers,

Will

--->8

Will Deacon (3):
  arm64: rseq: Implement backend rseq calls and select HAVE_RSEQ
  asm-generic: unistd.h: Wire up sys_rseq
  rseq/selftests: Add support for arm64

 arch/arm64/Kconfig                        |   1 +
 arch/arm64/include/asm/unistd.h           |   2 +-
 arch/arm64/include/asm/unistd32.h         |   2 +
 arch/arm64/kernel/entry.S                 |   2 +
 arch/arm64/kernel/ptrace.c                |   2 +
 arch/arm64/kernel/signal.c                |   3 +
 include/uapi/asm-generic/unistd.h         |   4 +-
 tools/testing/selftests/rseq/param_test.c |  20 +
 tools/testing/selftests/rseq/rseq-arm64.h | 594 ++++++++++++++++++++++++++++++
 tools/testing/selftests/rseq/rseq.h       |   2 +
 10 files changed, 630 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/rseq/rseq-arm64.h

-- 
2.1.4

