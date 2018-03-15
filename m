Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751478AbeCOE6A (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 00:58:00 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:45178 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750715AbeCOE56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 00:57:58 -0400
Date: Thu, 15 Mar 2018 15:58:05 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: Nicolas Pitre <nico@fluxnic.net>
cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH 06/47] net: smsc: remove m32r specific smc91x
 configuration
In-Reply-To: <nycvar.YSQ.7.76.1803141144200.28583@knanqh.ubzr>
Message-ID: <alpine.LNX.2.21.1803151556420.19@nippy.intranet>
References: <20180314153603.3127932-1-arnd@arndb.de> <20180314153603.3127932-7-arnd@arndb.de> <nycvar.YSQ.7.76.1803141144200.28583@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Mar 2018, Nicolas Pitre wrote:

> On Wed, 14 Mar 2018, Arnd Bergmann wrote:
> 
> > The m32r architecture is getting removed, so this part can be
> > cleaned up as well.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Nicolas Pitre <nico@fluxnic.net>
> 
> > ---
> >  drivers/net/ethernet/smsc/Kconfig  |  4 ++--
> >  drivers/net/ethernet/smsc/smc91x.h | 26 --------------------------
> >  2 files changed, 2 insertions(+), 28 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/smsc/Kconfig b/drivers/net/ethernet/smsc/Kconfig
> > index 4c2f612e4414..1c2b6663f7ce 100644
> > --- a/drivers/net/ethernet/smsc/Kconfig
> > +++ b/drivers/net/ethernet/smsc/Kconfig
> > @@ -37,8 +37,8 @@ config SMC91X
> >  	select CRC32
> >  	select MII
> >  	depends on !OF || GPIOLIB
> > -	depends on ARM || ARM64 || ATARI_ETHERNAT || BLACKFIN || COLDFIRE || \
> > -		   M32R || MIPS || MN10300 || NIOS2 || SUPERH || XTENSA || H8300
> > +	depends on ARM || ARM64 || ATARI_ETHERNAT || COLDFIRE || \
> > +		   MIPS || NIOS2 || SUPERH || XTENSA || H8300
> >  	---help---
> >  	  This is a driver for SMC's 91x series of Ethernet chipsets,
> >  	  including the SMC91C94 and the SMC91C111. Say Y if you want it
> > diff --git a/drivers/net/ethernet/smsc/smc91x.h b/drivers/net/ethernet/smsc/smc91x.h
> > index 08b17adf0a65..b337ee97e0c0 100644
> > --- a/drivers/net/ethernet/smsc/smc91x.h
> > +++ b/drivers/net/ethernet/smsc/smc91x.h
> > @@ -144,32 +144,6 @@ static inline void _SMC_outw_align4(u16 val, void __iomem *ioaddr, int reg,
> >  
> >  #define SMC_IRQ_FLAGS		(0)
> >  
> > -#elif   defined(CONFIG_M32R)
> > -
> > -#define SMC_CAN_USE_8BIT	0
> > -#define SMC_CAN_USE_16BIT	1
> > -#define SMC_CAN_USE_32BIT	0
> > -
> > -#define SMC_inb(a, r)		inb(((u32)a) + (r))
> > -#define SMC_inw(a, r)		inw(((u32)a) + (r))
> > -#define SMC_outb(v, a, r)	outb(v, ((u32)a) + (r))
> > -#define SMC_outw(lp, v, a, r)	outw(v, ((u32)a) + (r))
> > -#define SMC_insw(a, r, p, l)	insw(((u32)a) + (r), p, l)
> > -#define SMC_outsw(a, r, p, l)	outsw(((u32)a) + (r), p, l)
> > -
> > -#define SMC_IRQ_FLAGS		(0)
> > -
> > -#define RPC_LSA_DEFAULT		RPC_LED_TX_RX
> > -#define RPC_LSB_DEFAULT		RPC_LED_100_10
> > -
> > -#elif defined(CONFIG_MN10300)

MN103 is a separate architecture, unrelated to M32R afaict...

-- 

> > -
> > -/*
> > - * MN10300/AM33 configuration
> > - */
> > -
> > -#include <unit/smc91111.h>
> > -
> >  #elif defined(CONFIG_ATARI)
> >  
> >  #define SMC_CAN_USE_8BIT        1
> > -- 
> > 2.9.0
> > 
> > 
> 
