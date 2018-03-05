Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934346AbeCEKsa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 05:48:30 -0500
Received: from mail.bootlin.com ([62.4.15.54]:52947 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933135AbeCEKsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 05:48:25 -0500
Date: Mon, 5 Mar 2018 11:48:13 +0100
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        Stefan Chulski <stefanc@marvell.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, ymarkman@marvell.com, mw@semihalf.com
Subject: Re: [PATCH net-next 1/5] net: mvpp2: use the same buffer pool for
 all ports
Message-ID: <20180305104813.GI1156@kwain>
References: <20180302154044.25204-1-antoine.tenart@bootlin.com>
 <20180302154044.25204-2-antoine.tenart@bootlin.com>
 <20180302170159.258bcdbc@windsurf.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180302170159.258bcdbc@windsurf.lan>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Fri, Mar 02, 2018 at 05:01:59PM +0100, Thomas Petazzoni wrote:
> On Fri,  2 Mar 2018 16:40:40 +0100, Antoine Tenart wrote:
> > +static struct {
> > +	int pkt_size;
> > +	int buf_num;
> > +} mvpp2_pools[MVPP2_BM_POOLS_NUM];
> 
> Any reason for not doing:
> 
> } mvpp2_pools[MVPP2_BM_POOLS_NUM] = {
> 	[MVPP2_BM_SHORT] = {
> 		.pkt_size = MVPP2_BM_SHORT_PKT_SIZE,
> 		.buf_num = MVPP2_BM_SHORT_BUF_NUM
> 	},
> 	[MVPP2_BM_LONG] = {
> 		.pkt_size = MVPP2_BM_LONG_PKT_SIZE,
> 		.buf_num = MVPP2_BM_LONG_BUF_NUM,
> 	},
> };
> 
> And get rid of:
> 
> > +static void mvpp2_setup_bm_pool(void)
> > +{
> > +	/* Short pool */
> > +	mvpp2_pools[MVPP2_BM_SHORT].buf_num  = MVPP2_BM_SHORT_BUF_NUM;
> > +	mvpp2_pools[MVPP2_BM_SHORT].pkt_size = MVPP2_BM_SHORT_PKT_SIZE;
> > +
> > +	/* Long pool */
> > +	mvpp2_pools[MVPP2_BM_LONG].buf_num  = MVPP2_BM_LONG_BUF_NUM;
> > +	mvpp2_pools[MVPP2_BM_LONG].pkt_size = MVPP2_BM_LONG_PKT_SIZE;
> > +}
> 
>  ?

I wanted to do this, but it's no possible as MVPP2_BM_SHORT_PKT_SIZE and
MVPP2_BM_LONG_PKT_SIZE use a core definition which expands at some point
to __max(...) which has to be called from within a function.

That's why I kept mvpp2_setup_bm_pool().

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
