Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754784AbeDCCSh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 22:18:37 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:13008 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754725AbeDCCSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 22:18:36 -0400
X-UUID: ec513e69d1c547e68bea8ac885686feb-20180403
Message-ID: <1522721904.18424.51.camel@mtkswgap22>
Subject: Re: [PATCH net] net: dsa: mt7530: Use NULL instead of plain integer
From: Sean Wang <sean.wang@mediatek.com>
To: Florian Fainelli <f.fainelli@gmail.com>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        open list <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date: Tue, 3 Apr 2018 10:18:24 +0800
In-Reply-To: <20180402232414.19671-1-f.fainelli@gmail.com>
References: <20180402232414.19671-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23760.004
X-TM-AS-Result: No-15.290600-8.000000-10
X-TMASE-MatchedRID: +c13yJDs9034OiVTWoD8RMmB4bNJoA6MjLOy13Cgb4+qvcIF1TcLYBCz
        9g14hIMaUxPAM3J2QaoL6G+1LgVPyzAPG7OdV/f5XP5rFAucBUHzvNxVvAWejd9RlPzeVuQQXGl
        pMstVe4Ra43+J+risUKUS0MnJVHzyTX7PJ/OU3vKDGx/OQ1GV8rHlqZYrZqdI+gtHj7OwNO3DW0
        xVTs41PCxRafCzgzVfdYvI3q/OzLoOpuLrAtPac1w60UwZ9GtI
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.290600-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23760.004
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-04-02 at 16:24 -0700, Florian Fainelli wrote:
> We would be passing 0 instead of NULL as the rsp argument to
> mt7530_fdb_cmd(), fix that.
> 

Acked-by: Sean Wang <sean.wang@mediatek.com>

BTW, does the part of the commit message should be updated with "passing
NULL instead of 0"?


> Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT7530 switch")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/net/dsa/mt7530.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 4e53c5ce23ff..a7f6c0a62fc7 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -917,7 +917,7 @@ mt7530_port_fdb_add(struct dsa_switch *ds, int port,
>  
>  	mutex_lock(&priv->reg_mutex);
>  	mt7530_fdb_write(priv, vid, port_mask, addr, -1, STATIC_ENT);
> -	ret = mt7530_fdb_cmd(priv, MT7530_FDB_WRITE, 0);
> +	ret = mt7530_fdb_cmd(priv, MT7530_FDB_WRITE, NULL);
>  	mutex_unlock(&priv->reg_mutex);
>  
>  	return ret;
> @@ -933,7 +933,7 @@ mt7530_port_fdb_del(struct dsa_switch *ds, int port,
>  
>  	mutex_lock(&priv->reg_mutex);
>  	mt7530_fdb_write(priv, vid, port_mask, addr, -1, STATIC_EMP);
> -	ret = mt7530_fdb_cmd(priv, MT7530_FDB_WRITE, 0);
> +	ret = mt7530_fdb_cmd(priv, MT7530_FDB_WRITE, NULL);
>  	mutex_unlock(&priv->reg_mutex);
>  
>  	return ret;
> @@ -1293,7 +1293,7 @@ mt7530_setup(struct dsa_switch *ds)
>  	}
>  
>  	/* Flush the FDB table */
> -	ret = mt7530_fdb_cmd(priv, MT7530_FDB_FLUSH, 0);
> +	ret = mt7530_fdb_cmd(priv, MT7530_FDB_FLUSH, NULL);
>  	if (ret < 0)
>  		return ret;
>  
