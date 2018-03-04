Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932244AbeCDMKY (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 07:10:24 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35838 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752026AbeCDMKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 07:10:22 -0500
X-Google-Smtp-Source: AG47ELtc9nzM7xApRixHQRuxJ02kQJIHREudk7ThPaDdYZzcsSblJSad2RwPEtzckrXac2QCJ94lIg==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 0/3] irq_sim updates for v4.17
Date: Sun,  4 Mar 2018 13:10:15 +0100
Message-Id: <20180304121018.640-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains changes that have been discussed a while ago with
Marc - irq_sim_init() should return the base of the allocated interrupt
range so that users don't need the irq_sim API to map the interrupt
number to its offset in the array of allocated interrupts.

All external users have already been converted to correctly checking
the return value (rv < 0 opposed to !rv). We can now change the
implementation.

Include a small fix for irq_sim.c in the series as well.

Bartosz Golaszewski (3):
  irq/irq_sim: explicitly pull in slab.h
  irq/irq_sim: modify the return value check for irq_sim_init()
  irq/irq_sim: return the base of the irq range from irq_sim_init()

 kernel/irq/irq_sim.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

-- 
2.16.1
