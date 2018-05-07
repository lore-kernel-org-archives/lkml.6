Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751952AbeEGC4C (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 22:56:02 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:55129 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751852AbeEGC4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 22:56:00 -0400
X-ME-Sender: <xms:QMDvWlK50pk1HQz_NcB3F1Px5FHu7worHS2lI11afIa8p1LcLrKggg>
Date: Mon, 7 May 2018 12:55:56 +1000
From: "Tobin C. Harding" <tobin@apporbit.com>
To: Andrea Greco <andrea.greco.gapmilano@gmail.com>
Cc: m.grzeschik@pengutronix.de, Andrea Greco <a.greco@4sigma.it>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] arcnet: com20020: Fixup missing SLOWARB bit
Message-ID: <20180507025556.GG4197@eros>
References: <20180505213754.8400-1-andrea.greco.gapmilano@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180505213754.8400-1-andrea.greco.gapmilano@gmail.com>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 05, 2018 at 11:37:54PM +0200, Andrea Greco wrote:
> From: Andrea Greco <a.greco@4sigma.it>
> 
> If com20020 clock is major of 40Mhz SLOWARB bit is requested.
> 
> Signed-off-by: Andrea Greco <a.greco@4sigma.it>
> ---
>  drivers/net/arcnet/com20020.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/arcnet/com20020.c b/drivers/net/arcnet/com20020.c
> index f09ea77dd6a8..abd32ed8ec9b 100644
> --- a/drivers/net/arcnet/com20020.c
> +++ b/drivers/net/arcnet/com20020.c
> @@ -102,6 +102,10 @@ int com20020_check(struct net_device *dev)
>  	lp->setup = lp->clockm ? 0 : (lp->clockp << 1);
>  	lp->setup2 = (lp->clockm << 4) | 8;
>  
> +	// If clock is major of 40Mhz, SLOWARB bit must be set

/* C89 style comments please :) */


Hope this helps,
Tobin.
