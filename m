Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932355AbeBVMtA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 07:49:00 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:34000 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753719AbeBVMs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 07:48:58 -0500
Date: Thu, 22 Feb 2018 13:48:41 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Brandon Streiff <brandon.streiff@ni.com>,
        Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dsa: ptp; mark dummy helpers as 'inline'
Message-ID: <20180222124841.GA23008@lunn.ch>
References: <20180222114459.1272945-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222114459.1272945-1-arnd@arndb.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 12:44:40PM +0100, Arnd Bergmann wrote:
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

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
