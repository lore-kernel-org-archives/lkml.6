Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752533AbeETBm4 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 21:42:56 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:37766 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752199AbeETBmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 21:42:53 -0400
Date: Sun, 20 May 2018 03:42:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, vivien.didelot@savoirfairelinux.com,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: dsa: b53: Extend platform data to include
 DSA ports
Message-ID: <20180520014250.GB14906@lunn.ch>
References: <20180519225510.23820-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180519225510.23820-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19, 2018 at 03:55:10PM -0700, Florian Fainelli wrote:
> Provide a means for !OF platforms to supply their DSA platform data
> configuration using the dsa_platform_data structure.

Hi Florian

It seems a bit odd adding the header file, but no code. Yes, this will
help simplify the merge dependencies for the ZII boards next cycle,
but can we have the actual code as well?

    Thanks
	Andrew
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  include/linux/platform_data/b53.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/platform_data/b53.h b/include/linux/platform_data/b53.h
> index 69d279c0da96..8eaef2f2b691 100644
> --- a/include/linux/platform_data/b53.h
> +++ b/include/linux/platform_data/b53.h
> @@ -20,8 +20,12 @@
>  #define __B53_H
>  
>  #include <linux/kernel.h>
> +#include <net/dsa.h>
>  
>  struct b53_platform_data {
> +	/* Must be first such that dsa_register_switch() can access it */
> +	struct dsa_chip_data cd;
> +
>  	u32 chip_id;
>  	u16 enabled_ports;
>  
> -- 
> 2.14.1
> 
