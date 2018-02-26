Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751791AbeBZXBh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 18:01:37 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39761 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751165AbeBZXBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 18:01:35 -0500
X-Google-Smtp-Source: AG47ELuUVotO5oD6W39Te2Aww4HhBlJxFrvckQXRjInRpkJRLQ1j+PLoqdaePXP1y5OC4tgRDpHy8g==
Date: Mon, 26 Feb 2018 15:01:33 -0800
From: Omar Sandoval <osandov@osandov.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Josef Bacik <jbacik@fb.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] nbd: fix return value in error handling path
Message-ID: <20180226230133.GA12208@vader.DHCP.thefacebook.com>
References: <20180212171450.GA31668@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212171450.GA31668@embeddedgus>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 11:14:55AM -0600, Gustavo A. R. Silva wrote:
> It seems that the proper value to return in this particular case is the
> one contained into variable new_index instead of ret.
> 
> Addresses-Coverity-ID: 1465148 ("Copy-paste error")
> Fixes: e46c7287b1c2 ("nbd: add a basic netlink interface")

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/block/nbd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 5f2a424..86258b0 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1591,7 +1591,7 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
>  			if (new_index < 0) {
>  				mutex_unlock(&nbd_index_mutex);
>  				printk(KERN_ERR "nbd: failed to add new device\n");
> -				return ret;
> +				return new_index;
>  			}
>  			nbd = idr_find(&nbd_index_idr, new_index);
>  		}
> -- 
> 2.7.4
> 
