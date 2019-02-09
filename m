Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B525EC169C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A4120855
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfBIAr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:47:29 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58566 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbfBIAr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:47:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A612A78;
        Fri,  8 Feb 2019 16:47:28 -0800 (PST)
Received: from beelzebub.austin.arm.com (beelzebub.austin.arm.com [10.118.12.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 681083F719;
        Fri,  8 Feb 2019 16:47:27 -0800 (PST)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, catalin.marinas@arm.com, will.deacon@arm.com,
        mark.rutland@arm.com, robert.moore@intel.com,
        erik.schmauss@intel.com, rafael.j.wysocki@intel.com,
        lenb@kernel.org, Jeremy Linton <jeremy.linton@arm.com>
Subject: [RFC  0/3] arm64: SPE ACPI enablement
Date:   Fri,  8 Feb 2019 18:47:15 -0600
Message-Id: <20190209004718.3292087-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enables the Arm Statistical
Profiling Extension (SPE) on ACPI platforms.

This is possible because ACPI 6.3 uses a previously
reserved field in the MADT to store the SPE interrupt
number, similarly to how the normal PMU is
described. If a consistent valid interrupt exists
across all the cores in the system, a platform
device is registered. That then triggers the SPE module,
which runs as normal.

Jeremy Linton (3):
  ACPICA: ACPI 6.3: Add MADT/GICC/SPE extension.
  arm_pmu: acpi: spe: Add initial MADT/SPE probing
  perf: arm_spe: Enable ACPI/Platform automatic module loading

 arch/arm64/include/asm/acpi.h |  4 +++
 drivers/perf/arm_pmu_acpi.c   | 67 +++++++++++++++++++++++++++++++++++
 drivers/perf/arm_spe_pmu.c    | 11 ++++--
 include/acpi/actbl2.h         |  5 +--
 4 files changed, 83 insertions(+), 4 deletions(-)

-- 
2.17.2

