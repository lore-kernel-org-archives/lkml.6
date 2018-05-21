Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752858AbeEUOck (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 10:32:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36562 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752766AbeEUOcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 10:32:39 -0400
Date: Mon, 21 May 2018 17:32:38 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 06/12] tuntap: enable premmption early
Message-ID: <20180521173230-mutt-send-email-mst@kernel.org>
References: <1526893473-20128-1-git-send-email-jasowang@redhat.com>
 <1526893473-20128-7-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526893473-20128-7-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 05:04:27PM +0800, Jason Wang wrote:
> Signed-off-by: Jason Wang <jasowang@redhat.com>

typo in subject

> ---
>  drivers/net/tun.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 44d4f3d..24ecd82 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1697,6 +1697,8 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>  			goto err_xdp;
>  		}
>  	}
> +	rcu_read_unlock();
> +	preempt_enable();
>  
>  	skb = build_skb(buf, buflen);
>  	if (!skb) {
> @@ -1710,9 +1712,6 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>  	get_page(alloc_frag->page);
>  	alloc_frag->offset += buflen;
>  
> -	rcu_read_unlock();
> -	preempt_enable();
> -
>  	return skb;
>  
>  err_redirect:
> -- 
> 2.7.4
