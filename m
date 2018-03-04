Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932374AbeCDMLE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 07:11:04 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41776 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752453AbeCDMKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 07:10:23 -0500
X-Google-Smtp-Source: AG47ELskcwRQEGG3cfrBccT3DbH5p57yykAtEjLE7Uf06mlwNTvJIhdzGDobkuQkmdUHHwit8efWHA==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 1/3] irq/irq_sim: explicitly pull in slab.h
Date: Sun,  4 Mar 2018 13:10:16 +0100
Message-Id: <20180304121018.640-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180304121018.640-1-brgl@bgdev.pl>
References: <20180304121018.640-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're calling kfree() in the irq_sim code but slab.h is pulled in
indirectly via irq.h. Include it explicitly.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
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
 
-- 
2.16.1
