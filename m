Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbeCZVV6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 17:21:58 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:53695 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751805AbeCZVV5 (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Mon, 26 Mar 2018 17:21:57 -0400
From: Davidlohr Bueso <dave@stgolabs.net>
To: peterz@infradead.org, mingo@kernel.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH v2 -next 0/6] update static key users to modern api
Date: Mon, 26 Mar 2018 14:09:23 -0700
Message-Id: <20180326210929.5244-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v1:
  - added the 'static' keyword where it belongs.
  - added networking and x86-perf patches. Unlike the first three,
    these these use the global/extern variants.

Hi,

I noticed a few users in the kernel calling stale static key api. Patches
are straightforward; note that the irqchip was also changed to not use
refcounting functions as it only 'disables' the feature.

Applies on today's -next. Compile-tested.

Thanks!

Davidlohr Bueso (6):
  drivers/i2c: Update i2c_trace_msg static key to modern api
  drivers/irqchip: Update supports_deactivate static key to modern api
  sched/core: Update preempt_notifier_key to modern api
  perf,x86: Update rdpmc_always_available static key to modern api
  net/ipv4: Update ip_tunnel_metadata_cnt static key to modern api
  net/sock: Update memalloc_socks static key to modern api

 arch/x86/events/core.c             |  6 +++---
 arch/x86/include/asm/mmu_context.h |  5 +++--
 drivers/i2c/i2c-core-base.c        | 13 +++++++------
 drivers/irqchip/irq-gic-v3.c       | 20 ++++++++++----------
 drivers/irqchip/irq-gic.c          | 22 +++++++++++-----------
 include/net/ip_tunnels.h           |  4 ++--
 include/net/sock.h                 |  4 ++--
 kernel/sched/core.c                | 12 ++++++------
 net/core/sock.c                    |  8 ++++----
 net/ipv4/ip_tunnel_core.c          |  6 +++---
 10 files changed, 51 insertions(+), 49 deletions(-)

-- 
2.13.6
