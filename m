Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752109AbeCYTX0 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 15:23:26 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:37201 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751150AbeCYTXX (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Sun, 25 Mar 2018 15:23:23 -0400
From: Davidlohr Bueso <dave@stgolabs.net>
To: peterz@infradead.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH -next 0/3] update some static key users to modern api
Date: Sun, 25 Mar 2018 12:10:53 -0700
Message-Id: <20180325191056.24598-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed a few users in the kernel calling stale static key api. Patches
are straightforward; note that the irqchip was also changed to not use
refcounting functions as it only 'disables' the feature.

Thanks!

Davidlohr Bueso (3):
  i2c: update i2c_trace_msg static key to modern api
  drivers/irqchip: update supports_deactivate static key to modern api
  sched/core: update preempt_notifier_key to modern api

 drivers/i2c/i2c-core-base.c  | 12 ++++++------
 drivers/irqchip/irq-gic-v3.c | 20 ++++++++++----------
 drivers/irqchip/irq-gic.c    | 22 +++++++++++-----------
 kernel/sched/core.c          | 12 ++++++------
 4 files changed, 33 insertions(+), 33 deletions(-)

-- 
2.13.6
