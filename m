Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752052AbeB0ROG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 12:14:06 -0500
Received: from mail.bootlin.com ([62.4.15.54]:33655 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751004AbeB0ROE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 12:14:04 -0500
Date: Tue, 27 Feb 2018 18:13:52 +0100
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: David Miller <davem@davemloft.net>
Cc: antoine.tenart@bootlin.com, ymarkman@marvell.com, mw@semihalf.com,
        stefanc@marvell.com, thomas.petazzoni@free-electrons.com,
        gregory.clement@free-electrons.com, miquel.raynal@free-electrons.com,
        nadavh@marvell.com, maxime.chevallier@bootlin.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: mvpp2: adjust gso stop wake thresholds
Message-ID: <20180227171352.GD21643@kwain>
References: <20180226141427.31536-1-antoine.tenart@bootlin.com>
 <20180226141427.31536-2-antoine.tenart@bootlin.com>
 <20180227.111306.790069240486489244.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180227.111306.790069240486489244.davem@davemloft.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Tue, Feb 27, 2018 at 11:13:06AM -0500, David Miller wrote:
> From: Antoine Tenart <antoine.tenart@bootlin.com>
> > From: Yan Markman <ymarkman@marvell.com>
> > -#define MVPP2_MAX_TSO_SEGS		300
> > +#define MVPP2_MAX_TSO_SEGS		100
> >  #define MVPP2_MAX_SKB_DESCS		(MVPP2_MAX_TSO_SEGS * 2 + MAX_SKB_FRAGS)
> >  
> >  /* Dfault number of RXQs in use */
> > @@ -5810,7 +5810,7 @@ static int mvpp2_txq_init(struct mvpp2_port *port,
> >  		txq_pcpu->tso_headers = NULL;
> >  
> >  		txq_pcpu->stop_threshold = txq->size - MVPP2_MAX_SKB_DESCS;
> > -		txq_pcpu->wake_threshold = txq_pcpu->stop_threshold / 2;
> > +		txq_pcpu->wake_threshold = txq_pcpu->stop_threshold - 100;
> >  
> 
> This number 100 is a magic constant.  If it is related to
> MVPP2_MAX_TSO_SEGS, please use that define.  Otherwise
> define a new one which is descriptive.

I agree. I'll ask Yan about it and update if possible.

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
