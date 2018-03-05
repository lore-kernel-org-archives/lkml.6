Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932721AbeCEClp (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 21:41:45 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39192 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932448AbeCEClm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 21:41:42 -0500
Subject: Re: [PATCH net V2] virtio-net: re enable XDP_REDIRECT for mergeable
 buffer
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, brouer@redhat.com,
        john.fastabend@gmail.com
References: <1519982954-14360-1-git-send-email-jasowang@redhat.com>
 <20180302193104-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <abf2cb49-64bd-16ce-23e1-53aa719243d0@redhat.com>
Date: Mon, 5 Mar 2018 10:41:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180302193104-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年03月03日 01:36, Michael S. Tsirkin wrote:
> On Fri, Mar 02, 2018 at 05:29:14PM +0800, Jason Wang wrote:
>> XDP_REDIRECT support for mergeable buffer was removed since commit
>> 7324f5399b06 ("virtio_net: disable XDP_REDIRECT in receive_mergeable()
>> case"). This is because we don't reserve enough tailroom for struct
>> skb_shared_info which breaks XDP assumption. So this patch fixes this
>> by reserving enough tailroom and using fixed size of rx buffer.
>>
>> Signed-off-by: Jason Wang<jasowang@redhat.com>
> Acked-by: Michael S. Tsirkin<mst@redhat.com>
>
> I think the next incremental step is to look at splitting
> out fast path XDP processing to a separate set of functions.
>

Let me try (probably after 1.1 stuffs).

Thanks
