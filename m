Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA99C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE47320868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE47320868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbeLFXoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 18:44:22 -0500
Received: from foss.arm.com ([217.140.101.70]:35884 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbeLFXoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 18:44:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A6511596;
        Thu,  6 Dec 2018 15:44:22 -0800 (PST)
Received: from beelzebub.austin.arm.com (beelzebub.austin.arm.com [10.118.12.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7268E3F5AF;
        Thu,  6 Dec 2018 15:44:21 -0800 (PST)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, marc.zyngier@arm.com,
        suzuki.poulose@arm.com, dave.martin@arm.com,
        shankerd@codeaurora.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, ykaukab@suse.de,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 0/6] add system vulnerability sysfs entries
Date:   Thu,  6 Dec 2018 17:44:02 -0600
Message-Id: <20181206234408.1287689-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Part of this series was originally by Mian Yousaf Kaukab.

Arm64 machines should be displaying a human readable
vulnerability status to speculative execution attacks in
/sys/devices/system/cpu/vulnerabilities 

This series enables that behavior by providing the expected
functions. Those functions expose the cpu errata and feature
states, as well as whether firmware is responding appropriately
to display the overall machine status. This means that in a
heterogeneous machine we will only claim the machine is mitigated
or safe if we are confident all booted cores are safe or
mitigated. Otherwise, we will display unknown or unsafe
depending on how much of the machine configuration can
be assured.

Jeremy Linton (2):
  arm64: add sysfs vulnerability show for meltdown
  arm64: add sysfs vulnerability show for spectre v2

Mian Yousaf Kaukab (4):
  arm64: kpti: move check for non-vulnerable CPUs to a function
  arm64: add sysfs vulnerability show for spectre v1
  arm64: add sysfs vulnerability show for speculative store bypass
  arm64: enable generic CPU vulnerabilites support

 arch/arm64/Kconfig             |   1 +
 arch/arm64/kernel/cpu_errata.c | 110 +++++++++++++++++++++++++++++++--
 arch/arm64/kernel/cpufeature.c |  45 +++++++++++---
 3 files changed, 143 insertions(+), 13 deletions(-)

-- 
2.17.2

