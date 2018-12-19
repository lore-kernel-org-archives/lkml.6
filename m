Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF3DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66AB2218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbeLSSYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 13:24:07 -0500
Received: from foss.arm.com ([217.140.101.70]:41272 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727232AbeLSSYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 13:24:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55F1CA78;
        Wed, 19 Dec 2018 10:24:06 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 36AFC3F59C;
        Wed, 19 Dec 2018 10:24:04 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     cai@gmx.us, daniel.lezcano@linaro.org,
        linux-arm-kernel@lists.infradead.org, longman@redhat.com,
        marc.zyngier@arm.com, mark.rutland@arm.com, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, dietmar.eggemann@arm.com
Subject: [PATCH 0/2] System-wide mute of hotplug lockdep during init
Date:   Wed, 19 Dec 2018 18:23:14 +0000
Message-Id: <1545243796-23224-1-git-send-email-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In [1] Peter had a suggestion to broadly mute hotplug lockdep warnings during
init instead of going after every single warning and wrapping them with
cpus_read_{lock, unlock}(). This is implemented in [PATCH 1/2].

[PATCH 2/2] is a logical follow-up as [PATCH 1/2] is the generalized version
of the reverted patch.

[1]: https://lore.kernel.org/lkml/1543877121-4098-1-git-send-email-cai@gmx.us/#t

Valentin Schneider (2):
  cpu/hotplug: Mute hotplug lockdep during init
  Revert "sched/core: Take the hotplug lock in sched_init_smp()"

 kernel/cpu.c        | 9 +++++++++
 kernel/sched/core.c | 5 +----
 2 files changed, 10 insertions(+), 4 deletions(-)

--
2.7.4

