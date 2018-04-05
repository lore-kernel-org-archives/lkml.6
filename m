Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751392AbeDEU3A convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 16:29:00 -0400
Received: from muru.com ([72.249.23.125]:35408 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751274AbeDEU27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 16:28:59 -0400
Date: Thu, 5 Apr 2018 13:28:56 -0700
From: Tony Lindgren <tony@atomide.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: mapphone-mdm6600: add gpiolib dependency
Message-ID: <20180405202856.GK5700@atomide.com>
References: <20180404102733.3747591-1-arnd@arndb.de>
 <20180404115614.o5h5k6h4hmpjxaed@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180404115614.o5h5k6h4hmpjxaed@earth.universe>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [180404 11:57]:
> Hi,
> 
> On Wed, Apr 04, 2018 at 12:27:19PM +0200, Arnd Bergmann wrote:
> > Without gpiolib, the gpiod_get_array_value_cansleep() is an empty stub,
> > so gcc notices that the resulting array is never initialized:
> > 
> > drivers/phy/motorola/phy-mapphone-mdm6600.c: In function 'phy_mdm6600_status':
> > drivers/phy/motorola/phy-mapphone-mdm6600.c:188:16: error: 'values[0]' is used uninitialized in this function [-Werror=uninitialized]
> >    val |= values[i] << i;
> >           ~~~~~~^~~
> > drivers/phy/motorola/phy-mapphone-mdm6600.c:188:16: error: 'values[1]' is used uninitialized in this function [-Werror=uninitialized]
> > drivers/phy/motorola/phy-mapphone-mdm6600.c:188:16: error: 'values[2]' is used uninitialized in this function [-Werror=uninitialized]
> > cc1: all warnings being treated as errors
> > 
> > With gpiolib enabled, this can't happen and we don't get the warning, so
> > let's just add a Kconfig dependency for it.
> > 
> > Fixes: 5d1ebbda0318 ("phy: mapphone-mdm6600: Add USB PHY driver for MDM6600 on Droid 4")
> > Cc: Tony Lindgren <tony@atomide.com>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

Acked-by: Tony Lindgren <tony@atomide.com>
