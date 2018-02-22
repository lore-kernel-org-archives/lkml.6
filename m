Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751749AbeBVUju (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 15:39:50 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:51798 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751363AbeBVUhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 15:37:03 -0500
Date: Thu, 22 Feb 2018 15:37:00 -0500 (EST)
Message-Id: <20180222.153700.511110622471984196.davem@davemloft.net>
To: arnd@arndb.de
Cc: andrew@lunn.ch, vivien.didelot@savoirfairelinux.com,
        f.fainelli@gmail.com, brandon.streiff@ni.com, richardcochran@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dsa: ptp; mark dummy helpers as 'inline'
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180222114459.1272945-1-arnd@arndb.de>
References: <20180222114459.1272945-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 22 Feb 2018 12:44:40 +0100

> Declaring a static function in a header leads to a warning every
> time that header gets included without the function being used:
> 
> In file included from drivers/net/dsa/mv88e6xxx/chip.c:42:
> drivers/net/dsa/mv88e6xxx/ptp.h:92:13: error: 'mv88e6xxx_hwtstamp_work' defined but not used [-Werror=unused-function]
>  static long mv88e6xxx_hwtstamp_work(struct ptp_clock_info *ptp)
> In file included from drivers/net/dsa/mv88e6xxx/chip.c:38:
> drivers/net/dsa/mv88e6xxx/global2.h:355:12: error: 'mv88e6xxx_g2_wait' defined but not used [-Werror=unused-function]
>  static int mv88e6xxx_g2_wait(struct mv88e6xxx_chip *chip, int reg, u16 mask)
>             ^~~~~~~~~~~~~~~~~
> drivers/net/dsa/mv88e6xxx/global2.h:350:12: error: 'mv88e6xxx_g2_update' defined but not used [-Werror=unused-function]
>  static int mv88e6xxx_g2_update(struct mv88e6xxx_chip *chip, int reg, u16 update)
>             ^~~~~~~~~~~~~~~~~~~
> drivers/net/dsa/mv88e6xxx/global2.h:345:12: error: 'mv88e6xxx_g2_write' defined but not used [-Werror=unused-function]
>  static int mv88e6xxx_g2_write(struct mv88e6xxx_chip *chip, int reg, u16 val)
>             ^~~~~~~~~~~~~~~~~~
> drivers/net/dsa/mv88e6xxx/global2.h:340:12: error: 'mv88e6xxx_g2_read' defined but not used [-Werror=unused-function]
>  static int mv88e6xxx_g2_read(struct mv88e6xxx_chip *chip, int reg, u16 *val)
> 
> This marks all such functions in dsa inline to make sure we don't warn
> about them.
> 
> Fixes: c6fe0ad2c349 ("net: dsa: mv88e6xxx: add rx/tx timestamping support")
> Fixes: 0d632c3d6fe3 ("net: dsa: mv88e6xxx: add accessors for PTP/TAI registers")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks Arnd.
