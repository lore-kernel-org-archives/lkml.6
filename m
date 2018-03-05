Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932636AbeCECn6 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 21:43:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42546 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932346AbeCECnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 21:43:55 -0500
Subject: Re: [PATCH net V2] virtio-net: re enable XDP_REDIRECT for mergeable
 buffer
To: David Miller <davem@davemloft.net>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        brouer@redhat.com, john.fastabend@gmail.com
References: <1519982954-14360-1-git-send-email-jasowang@redhat.com>
 <20180304.183811.344767417258525977.davem@davemloft.net>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <986bd816-2452-9eca-ec8a-ce267ef49a2d@redhat.com>
Date: Mon, 5 Mar 2018 10:43:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180304.183811.344767417258525977.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年03月05日 07:38, David Miller wrote:
> From: Jason Wang <jasowang@redhat.com>
> Date: Fri,  2 Mar 2018 17:29:14 +0800
>
>> XDP_REDIRECT support for mergeable buffer was removed since commit
>> 7324f5399b06 ("virtio_net: disable XDP_REDIRECT in receive_mergeable()
>> case"). This is because we don't reserve enough tailroom for struct
>> skb_shared_info which breaks XDP assumption. So this patch fixes this
>> by reserving enough tailroom and using fixed size of rx buffer.
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>> Changes from V1:
>> - do not add duplicated tracepoint when redirection fails
> Applied to net-next, thanks Jason.

Hi David,

Consider the change is not large, any chance to make it for -net to keep 
XDP redirection work?

Thanks
