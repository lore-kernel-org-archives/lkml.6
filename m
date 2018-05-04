Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751795AbeEDRhg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:37:36 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:36380 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751748AbeEDRhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:37:34 -0400
Date: Fri, 04 May 2018 13:37:33 -0400 (EDT)
Message-Id: <20180504.133733.2169628934964033284.davem@davemloft.net>
To: bigeasy@linutronix.de
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH 1/4] alim15x3: move irq-restore before pci_dev_put()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180504142446.30525-2-bigeasy@linutronix.de>
References: <20180504142446.30525-1-bigeasy@linutronix.de>
        <20180504142446.30525-2-bigeasy@linutronix.de>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Fri,  4 May 2018 16:24:43 +0200

> init_chipset_ali15x3() initializes the chipset during init with disabled
> interrupts. There is no need to keep the interrupts disabled during
> pci_dev_put().
> Move the irq-restore before pci_dev_put() is invoked.
> 
> Side note: The same init is performed in
> drivers/ata/pata_ali.c::ali_init_chipset() without disabled interrupts.
> It looks that the same hardware is supported in the ATA land. Would it
> make sense to remove this driver since it is supported in the other
> subsystem?
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: David S. Miller <davem@davemloft.net>
