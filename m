Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932197AbeCLOeM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:34:12 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:59738 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751232AbeCLOeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:34:11 -0400
Date: Mon, 12 Mar 2018 10:34:07 -0400 (EDT)
Message-Id: <20180312.103407.1746384495514020212.davem@davemloft.net>
To: brad.mouring@ni.com
Cc: andrew@lunn.ch, f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, sergei.shtylyov@cogentembedded.com
Subject: Re: [PATCH net v3] net: phy: Tell caller result of phy_change()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180308222303.58267-1-brad.mouring@ni.com>
References: <20180308203157.10855-1-brad.mouring@ni.com>
        <20180308222303.58267-1-brad.mouring@ni.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brad Mouring <brad.mouring@ni.com>
Date: Thu, 8 Mar 2018 16:23:03 -0600

> In 664fcf123a30e (net: phy: Threaded interrupts allow some simplification)
> the phy_interrupt system was changed to use a traditional threaded
> interrupt scheme instead of a workqueue approach.
> 
> With this change, the phy status check moved into phy_change, which
> did not report back to the caller whether or not the interrupt was
> handled. This means that, in the case of a shared phy interrupt,
> only the first phydev's interrupt registers are checked (since
> phy_interrupt() would always return IRQ_HANDLED). This leads to
> interrupt storms when it is a secondary device that's actually the
> interrupt source.
> 
> Signed-off-by: Brad Mouring <brad.mouring@ni.com>

Applied and queued up for -stable, thanks.
