Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E94C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8B92087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbfBDRJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:09:38 -0500
Received: from foss.arm.com ([217.140.101.70]:58642 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfBDRJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 12:09:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C383EEBD;
        Mon,  4 Feb 2019 09:09:37 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 414C73F589;
        Mon,  4 Feb 2019 09:09:36 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     will.deacon@arm.com, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        suzuki.poulose@arm.com, peterz@infradead.org, tglx@linutronix.de,
        bigeasy@linutronix.de
Subject: [PATCH 0/5] Fix Arm system PMU hotplug issues
Date:   Mon,  4 Feb 2019 17:09:03 +0000
Message-Id: <cover.1549299188.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.20.1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Following the report of a preemption-related bug in arm-cci, it turns
out there's a fair bit of cleaning up to do in this area. I've started
here with the Arm drivers that I'm fairly familiar with - I suspect the
hisi/qcom/xgene ones suffer from similar issues, but it's going to take
me a while longer to figure them out in detail.

Robin.


Robin Murphy (5):
  perf/arm-cci: Fix CPU hotplug race avoidance
  cpu/hotplug: Export __cpuhp_state_add_instance_cpuslocked()
  perf/arm-ccn: Fix CPU hotplug race avoidance
  cpu/hotplug: Add locked variant of cpuhp_state_add_instance()
  perf/arm_dsu: Fix CPU hotplug races

 drivers/perf/arm-cci.c     | 22 ++++++++++++----------
 drivers/perf/arm-ccn.c     | 25 +++++++++++++------------
 drivers/perf/arm_dsu_pmu.c |  8 +++++---
 include/linux/cpuhotplug.h |  6 ++++++
 kernel/cpu.c               |  1 +
 5 files changed, 37 insertions(+), 25 deletions(-)

-- 
2.20.1.dirty

