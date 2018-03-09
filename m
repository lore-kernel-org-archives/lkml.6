Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751143AbeCIKtG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 05:49:06 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41493 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeCIKtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 05:49:03 -0500
Date: Fri, 9 Mar 2018 02:48:52 -0800
From: tip-bot for Bartosz Golaszewski <tipbot@zytor.com>
Message-ID: <tip-34a866bd45d69754da1979e83a37bec6defc6295@git.kernel.org>
Cc: marc.zyngier@arm.com, mingo@kernel.org, brgl@bgdev.pl,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de
Reply-To: marc.zyngier@arm.com, mingo@kernel.org, brgl@bgdev.pl,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de
In-Reply-To: <20180304121018.640-2-brgl@bgdev.pl>
References: <20180304121018.640-2-brgl@bgdev.pl>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq/irq_sim: Explicitly include slab.h
Git-Commit-ID: 34a866bd45d69754da1979e83a37bec6defc6295
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  34a866bd45d69754da1979e83a37bec6defc6295
Gitweb:     https://git.kernel.org/tip/34a866bd45d69754da1979e83a37bec6defc6295
Author:     Bartosz Golaszewski <brgl@bgdev.pl>
AuthorDate: Sun, 4 Mar 2018 13:10:16 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 9 Mar 2018 11:44:03 +0100

genirq/irq_sim: Explicitly include slab.h

kfree() is used in the irq_sim code but slab.h is pulled in indirectly via
irq.h. Include it explicitly.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Link: https://lkml.kernel.org/r/20180304121018.640-2-brgl@bgdev.pl

---
 kernel/irq/irq_sim.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index 24caabf1a0f7..bd7dc1db6a80 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -7,6 +7,7 @@
  * option) any later version.
  */
 
+#include <linux/slab.h>
 #include <linux/irq_sim.h>
 #include <linux/irq.h>
 
