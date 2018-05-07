Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753140AbeEGUme (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 16:42:34 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43962 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753101AbeEGUmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 16:42:32 -0400
X-Google-Smtp-Source: AB8JxZoZNL3PjDxDYXV390neH0MEOWxJjff+Im3SaaGTbZo851SxS19cwEsvH2jYt9aHBLDEe1D1Iw==
Subject: Re: [ovs-dev] [PATCH] openvswitch: fix internal_dev_xmit()'s return
 type
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-kernel@vger.kernel.org
Cc: dev@openvswitch.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
References: <20180424131747.4711-1-luc.vanoostenryck@gmail.com>
From: Gregory Rose <gvrose8192@gmail.com>
Message-ID: <aae66673-68c7-c798-08f8-5c13678723f3@gmail.com>
Date: Mon, 7 May 2018 13:42:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424131747.4711-1-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/2018 6:17 AM, Luc Van Oostenryck wrote:
> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, but the implementation in this
> driver returns an 'int'.
>
> Fix this by returning 'netdev_tx_t' in this driver too.
>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>   net/openvswitch/vport-internal_dev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/openvswitch/vport-internal_dev.c b/net/openvswitch/vport-internal_dev.c
> index bb95c43aa..3ea55618e 100644
> --- a/net/openvswitch/vport-internal_dev.c
> +++ b/net/openvswitch/vport-internal_dev.c
> @@ -43,7 +43,7 @@ static struct internal_dev *internal_dev_priv(struct net_device *netdev)
>   }
>   
>   /* Called with rcu_read_lock_bh. */
> -static int internal_dev_xmit(struct sk_buff *skb, struct net_device *netdev)
> +static netdev_tx_t internal_dev_xmit(struct sk_buff *skb, struct net_device *netdev)
>   {
>   	int len, err;
>   

LGTM

Reviewed-by: Greg Rose <gvrose8192@gmail.com>
