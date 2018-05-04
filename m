Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751887AbeEDRic (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:38:32 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:36390 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbeEDRiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:38:24 -0400
Date: Fri, 04 May 2018 13:38:23 -0400 (EDT)
Message-Id: <20180504.133823.125565697801860796.davem@davemloft.net>
To: bigeasy@linutronix.de
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH 2/4] ide: Handle irq disabling consistently
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180504142446.30525-3-bigeasy@linutronix.de>
References: <20180504142446.30525-1-bigeasy@linutronix.de>
        <20180504142446.30525-3-bigeasy@linutronix.de>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Fri,  4 May 2018 16:24:44 +0200

> ide_timer_expiry() disables interrupt at function entry when acquiring
> hwif->lock. Before disabling the device interrupt it unlocks hwif->lock,
> but interrupts stay disabled. After the call to disable_irq() interrupts
> are disabled again, which is a pointless exercise.
> 
> After the device irq handler has been invoked with interrupts disabled,
> hwif->lock is acquired again with spin_lock_irq() because the device irq
> handler might have reenabled interrupts. This is not documented and
> confusing for the casual reader.
> 
> Remove the redundant local_irq_disable() and add a comment which explains
> why hwif->lock has to be reacquired with spin_lock_irq().
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: David S. Miller <davem@davemloft.net>
