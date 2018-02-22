Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932080AbeBVLXp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 06:23:45 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:38794 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753659AbeBVLXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 06:23:44 -0500
Message-Id: <20180222110804.587011608@linutronix.de>
User-Agent: quilt/0.63-1
Date: Thu, 22 Feb 2018 12:08:04 +0100
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Yuriy Vostrikov <delamonpansie@gmail.com>
Subject: [patch 0/3] genirq/x86: Cure CPU hotplug vector accounting woes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yuriy reported suspend/resume issues related to the irq vector management.

They turned out to be an accounting issue related to CPU hot unplug where
vectors which are allocated on unplugged CPUs are dropped from the
accounting because not started interrupts are not force migrated.

The following patch series addresses the issues and makes accounting work
correctly again.

Thanks,

	tglx
