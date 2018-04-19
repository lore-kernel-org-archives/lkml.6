Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752824AbeDSM1f (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 08:27:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751957AbeDSM1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 08:27:34 -0400
Subject: Re: [PATCH v2 net 3/3] virtio_net: sparse annotation fix
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        David Miller <davem@davemloft.net>, Thomas Huth <thuth@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
References: <1524115776-334953-1-git-send-email-mst@redhat.com>
 <1524115776-334953-4-git-send-email-mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8da2c372-6f6f-e5b3-d24c-a44c1b3b6dc1@redhat.com>
Date: Thu, 19 Apr 2018 20:27:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524115776-334953-4-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年04月19日 13:30, Michael S. Tsirkin wrote:
> offloads is a buffer in virtio format, should use
> the __virtio64 tag.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   drivers/net/virtio_net.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index f84fe04..c5b11f2 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -155,7 +155,7 @@ struct control_buf {
>   	u8 promisc;
>   	u8 allmulti;
>   	__virtio16 vid;
> -	u64 offloads;
> +	__virtio64 offloads;
>   };
>   
>   struct virtnet_info {

Acked-by: Jason Wang <jasowang@redhat.com>
