Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B37C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5A920656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbfANKfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:35:39 -0500
Received: from foss.arm.com ([217.140.101.70]:58448 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbfANKfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:35:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A20F580D;
        Mon, 14 Jan 2019 02:35:38 -0800 (PST)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.196.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92E6F3F5BD;
        Mon, 14 Jan 2019 02:35:37 -0800 (PST)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v2 0/2] Spectre-v2 detection fixes
Date:   Mon, 14 Jan 2019 10:35:26 +0000
Message-Id: <20190114103528.52931-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches, now built on top of Jeremy's sysfs series, tweak
the way we detect the Spectre-v2 vulnerability by switching from a
blacklist to a whitelist, making sure we correctly detect unmitigated
systems.

We further improve things by relying on firmware to tell us about CPUs
that are part of an affected system, but that are not affected
themselves (big-little type).

For convenience, I've pushed out a branch containing both Jeremy's v3
series and these patches at [1].

[1] git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git arm64/spectre-sysfs

Marc Zyngier (2):
  arm64: Advertise mitigation of Spectre-v2, or lack thereof
  arm64: Use firmware to detect CPUs that are not affected by Spectre-v2

 arch/arm64/kernel/cpu_errata.c | 141 +++++++++++++++++----------------
 1 file changed, 73 insertions(+), 68 deletions(-)

-- 
2.20.1

