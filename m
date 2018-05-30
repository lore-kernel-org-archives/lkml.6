Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932093AbeE3RWT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 13:22:19 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:44838 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbeE3RWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 13:22:17 -0400
Date: Wed, 30 May 2018 13:22:13 -0400 (EDT)
Message-Id: <20180530.132213.1979006919259696824.davem@davemloft.net>
To: arnd@arndb.de
Cc: grygorii.strashko@ti.com, nsekhar@ti.com, f.fainelli@gmail.com,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: davinci: fix building davinci mdio code without
 CONFIG_OF
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180528155059.2736080-1-arnd@arndb.de>
References: <20180528155059.2736080-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 28 May 2018 17:50:20 +0200

> Test-building this driver on targets without CONFIG_OF revealed a build
> failure:
> 
> drivers/net/ethernet/ti/davinci_mdio.c: In function 'davinci_mdio_probe':
> drivers/net/ethernet/ti/davinci_mdio.c:380:9: error: implicit declaration of function 'davinci_mdio_probe_dt'; did you mean 'davinci_mdio_probe'? [-Werror=implicit-function-declaration]
> 
> This adjusts the #ifdef logic in the driver to make it build in
> all configurations.
> 
> Fixes: 2652113ff043 ("net: ethernet: ti: Allow most drivers with COMPILE_TEST")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to net-next.
