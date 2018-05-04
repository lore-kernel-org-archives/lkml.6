Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751790AbeEDRi7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:38:59 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:36418 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751479AbeEDRi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:38:57 -0400
Date: Fri, 04 May 2018 13:38:56 -0400 (EDT)
Message-Id: <20180504.133856.1141367626604511178.davem@davemloft.net>
To: bigeasy@linutronix.de
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH 3/4] ide: don't disable interrupts during kmap_atomic()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180504142446.30525-4-bigeasy@linutronix.de>
References: <20180504142446.30525-1-bigeasy@linutronix.de>
        <20180504142446.30525-4-bigeasy@linutronix.de>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Fri,  4 May 2018 16:24:45 +0200

> ide_pio_bytes() disables interrupts around kmap_atomic(). This is a
> leftover from the old kmap_atomic() implementation which relied on fixed
> mapping slots, so the caller had to make sure that the same slot could not
> be reused from an interrupting context.
> 
> kmap_atomic() was changed to dynamic slots long ago and commit 1ec9c5ddc17a
> ("include/linux/highmem.h: remove the second argument of k[un]map_atomic()")
> removed the slot assignements, but the callers were not checked for now
> redundant interrupt disabling.
> 
> Remove the conditional interrupt disable.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: David S. Miller <davem@davemloft.net>
