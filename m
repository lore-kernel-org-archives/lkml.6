Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934633AbeEWT1Z (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 15:27:25 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:33858 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934289AbeEWT1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 15:27:20 -0400
Date: Wed, 23 May 2018 15:27:17 -0400 (EDT)
Message-Id: <20180523.152717.320840011665325518.davem@davemloft.net>
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, arunp@broadcom.com, andrew@lunn.ch,
        rjui@broadcom.com, sbranden@broadcom.com, jonmason@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: broadcom: Fix bcm_write_exp()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180523000450.9384-1-f.fainelli@gmail.com>
References: <20180523000450.9384-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Tue, 22 May 2018 17:04:49 -0700

> On newer PHYs, we need to select the expansion register to write with
> setting bits [11:8] to 0xf. This was done correctly by bcm7xxx.c prior
> to being migrated to generic code under bcm-phy-lib.c which
> unfortunately used the older implementation from the BCM54xx days.
> 
> Fix this by creating an inline stub: bcm_write_exp_sel() which adds the
> correct value (MII_BCM54XX_EXP_SEL_ER) and update both the Cygnus PHY
> and BCM7xxx PHY drivers which require setting these bits.
> 
> broadcom.c is unchanged because some PHYs even use a different selector
> method, so let them specify it directly (e.g: SerDes secondary selector).
> 
> Fixes: a1cba5613edf ("net: phy: Add Broadcom phy library for common interfaces")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> David, please also queue this one up for -stable, thanks!

Applied and queued up for -stable, thanks Florian.
