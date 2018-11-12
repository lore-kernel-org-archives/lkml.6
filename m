Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1BDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08EE0223D8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08EE0223D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbeKLVa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 16:30:58 -0500
Received: from foss.arm.com ([217.140.101.70]:34078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728153AbeKLVa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 16:30:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCC5E80D;
        Mon, 12 Nov 2018 03:38:05 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A046F3F5A0;
        Mon, 12 Nov 2018 03:38:04 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org, marc.zyngier@arm.com,
        mingo@kernel.org, Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v4 0/4] Provide core API for NMIs
Date:   Mon, 12 Nov 2018 11:37:51 +0000
Message-Id: <1542022675-20833-1-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series provides a way for irqchips to define some IRQs as NMIs.

As we hope (maybe) to get the arm64 use case for this into next, this
version is simply a rebase of the previous one.

Changes since v3[1]:
- Rebased on v4.20-rc2

Changes since v2[2]:
- Fix ARM build error reported by kbuild bot
- Fix documentation warnings reported by kbuild bot

Changes since v1[3]:
- Rebased to v4.19-rc1
- Fix some coding style issues

Changes since RFC[4]:
- Rebased to v4.18-rc6
- Remove disable_nmi, one should call disable_nmi_nosync instead
- Remove code related to affinity balancing from NMI functions
- Require PERCPU configuration for NMIs

[1] https://lkml.org/lkml/2018/8/31/173
[2] https://lkml.org/lkml/2018/8/28/661
[3] https://lkml.org/lkml/2018/7/24/321
[4] https://lkml.org/lkml/2018/7/9/768

Cheers,

Julien

-->

Julien Thierry (4):
  genirq: Provide basic NMI management for interrupt lines
  genirq: Provide NMI management for percpu_devid interrupts
  genirq: Provide NMI handlers
  irqdesc: Add domain handler for NMIs

 include/linux/interrupt.h |  18 +++
 include/linux/irq.h       |  10 ++
 include/linux/irqdesc.h   |   5 +
 kernel/irq/chip.c         |  54 +++++++
 kernel/irq/debugfs.c      |   6 +-
 kernel/irq/internals.h    |   2 +
 kernel/irq/irqdesc.c      |  35 +++++
 kernel/irq/manage.c       | 377 +++++++++++++++++++++++++++++++++++++++++++++-
 8 files changed, 504 insertions(+), 3 deletions(-)

--
1.9.1
