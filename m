Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934297AbeEWTTD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 15:19:03 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:33700 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934282AbeEWTTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 15:19:02 -0400
Date: Wed, 23 May 2018 15:19:00 -0400 (EDT)
Message-Id: <20180523.151900.1685171518319860725.davem@davemloft.net>
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, jon.mason@broadcom.com, andrew@lunn.ch,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: broadcom: Fix auxiliary control register
 reads
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180522232227.6355-1-f.fainelli@gmail.com>
References: <20180522232227.6355-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Tue, 22 May 2018 16:22:26 -0700

> We are currently doing auxiliary control register reads with the shadow
> register value 0b111 (0x7) which incidentally is also the selector value
> that should be present in bits [2:0]. Fix this by using the appropriate
> selector mask which is defined (MII_BCM54XX_AUXCTL_SHDWSEL_MASK).
> 
> This does not have a functional impact yet because we always access the
> MII_BCM54XX_AUXCTL_SHDWSEL_MISC (0x7) register in the current code.
> This might change at some point though.
> 
> Fixes: 5b4e29005123 ("net: phy: broadcom: add bcm54xx_auxctl_read")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> David, please queue this for -stable as well, thank you!

Applied and queued up for -stable.
