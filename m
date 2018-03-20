Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751929AbeCTR4s (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 13:56:48 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53234 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751320AbeCTR4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 13:56:44 -0400
Date: Tue, 20 Mar 2018 18:56:42 +0100
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: Re: [PATCH net-next] net: mvpp2: Don't use dynamic allocs for local
 variables
Message-ID: <20180320175642.GD26989@kwain>
References: <20180320153408.5319-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180320153408.5319-1-maxime.chevallier@bootlin.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Tue, Mar 20, 2018 at 04:34:08PM +0100, Maxime Chevallier wrote:
> @@ -2416,36 +2393,36 @@ static int mvpp2_prs_double_vlan_add(struct mvpp2 *priv, unsigned short tpid1,
>  		}
>  
>  		if (tid >= tid_aux) {
> -			ret = -ERANGE;
> -			goto free_pe;
> +			return -ERANGE;
>  		}

You can remove the brackets here.

> @@ -3833,39 +3804,39 @@ static int mvpp2_prs_mac_da_accept(struct mvpp2_port *port, const u8 *da,

[...]

>  	/* Invalidate the entry if no ports are left enabled */
> -	pmap = mvpp2_prs_tcam_port_map_get(pe);
> +	pmap = mvpp2_prs_tcam_port_map_get(&pe);
>  	if (pmap == 0) {
>  		if (add) {
> -			kfree(pe);
>  			return -EINVAL;
>  		}

And here.

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
