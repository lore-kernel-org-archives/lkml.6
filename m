Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965180AbeEYJFj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:05:39 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54997 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965078AbeEYJFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:05:38 -0400
From: Anna-Maria Gleixner <anna-maria@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, bigeasy@linutronix.de, paulmck@linux.vnet.ibm.com,
        ebiederm@xmission.com, Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: [PATCH v2 0/2] rtmutex wait_lock is irq safe
Date: Fri, 25 May 2018 11:05:05 +0200
Message-Id: <20180525090507.22248-1-anna-maria@linutronix.de>
X-Mailer: git-send-email 2.15.1
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit b4abf91047cf ("rtmutex: Make wait_lock irq safe") the rtmutex
wait_lock is irq safe. Therefore the irqsave/restore in kernel/signal is no
longer required (see Patch 2/2). During discussions about v1 of this patch,
Eric Biederman noticed, that there is a no longer valid rcu_read_unlock()
documentation.

Therefore sending a short queue: fixing first the documentation of
rcu_read_unlock() and afterwards removing irqsave/restore in kernel/signal.

v1..v2:

 - Add new patch updating rcu documentation as suggested by Eric Biederman
 - Udpate commit message of kernel/signal patch

Thanks,

	Anna-Maria


Anna-Maria Gleixner (2):
  rcu: Update documentation of rcu_read_unlock()
  signal: Remove no longer required irqsave/restore

 include/linux/rcupdate.h |  4 +---
 kernel/signal.c          | 24 +++++++-----------------
 2 files changed, 8 insertions(+), 20 deletions(-)

-- 
2.15.1
